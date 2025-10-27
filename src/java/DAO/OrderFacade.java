/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import db.DBContext;
import entity.OrderDetails;
import entity.Orders;
import entity.Payments;
import entity.Shipping;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author VINH HIEN
 */
public class OrderFacade {

    public List<Orders> select() {
        List<Orders> list = new ArrayList<>();
        try {
            Connection con = DBContext.getConnection();
            PreparedStatement stm = con.prepareStatement("select * from Orders");

            ResultSet rs = stm.executeQuery();
            //vì chỉ đọc 1 mẫu tin nên xài if gọn hơn xài while
            while (rs.next()) {
                // doc du lieu vao doi tuong Account
                list.add(new Orders(rs.getInt("orderID"),
                        rs.getInt("userID"),
                        rs.getInt("shippingID"),
                        rs.getDouble("totalPrice"),
                        rs.getString("orderStatus"),
                        rs.getDate("createdAt")));

            }
        } catch (Exception e) {
        }
        //dong ket noi db
        //con.close();
        return list;
    }

    public void update(int id, String orderStatus) throws SQLException {
        // tao ket noi vao db
        Connection con = DBContext.getConnection();
        //tao doi tuong statement
        PreparedStatement stm = con.prepareStatement("update Orders set orderStatus=? where orderID=?");//vi co tham so nen use preparedStatement
        //gan gia tri cho cac tham so
        stm.setString(1, orderStatus);
        stm.setInt(2, id);

        //thuc thi lenh select
        int count = stm.executeUpdate();
        //dong ket noi db
        con.close();

    }

    public void createOrder(Orders order, List<OrderDetails> orderDetails, Payments payment, Shipping shipping) throws SQLException {
        Connection con = DBContext.getConnection();
        try {
            con.setAutoCommit(false); // Bắt đầu giao dịch

            // Save shipping information
            String sqlShipping = "INSERT INTO Shipping (UserID, ReceiverName, Phone, Address, Notes) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pstmtShipping = con.prepareStatement(sqlShipping, PreparedStatement.RETURN_GENERATED_KEYS);
            pstmtShipping.setInt(1, shipping.getUserID());
            pstmtShipping.setString(2, shipping.getReceiverName());
            pstmtShipping.setString(3, shipping.getPhone());
            pstmtShipping.setString(4, shipping.getAddress());
            pstmtShipping.setString(5, shipping.getNotes());
            pstmtShipping.executeUpdate();

            // Get the generated ShippingID
            ResultSet generatedKeys = pstmtShipping.getGeneratedKeys();
            int shippingId = 0;
            if (generatedKeys.next()) {
                shippingId = generatedKeys.getInt(1);
            }
            // Lưu đơn hàng
            String sqlOrder = "INSERT INTO Orders (UserID, ShippingID, TotalPrice, OrderStatus) VALUES (?, ?, ?, ?)";
            PreparedStatement pstmtOrder = con.prepareStatement(sqlOrder, PreparedStatement.RETURN_GENERATED_KEYS);
            pstmtOrder.setInt(1, order.getUserID());
            pstmtOrder.setInt(2, shippingId); // Hoặc gán ShippingID nếu có
            pstmtOrder.setDouble(3, order.getTotalPrice());
            pstmtOrder.setString(4, "Pending");
            pstmtOrder.executeUpdate();

            // Lấy OrderID vừa được tạo
            generatedKeys = pstmtOrder.getGeneratedKeys();
            if (generatedKeys.next()) {
                int orderId = generatedKeys.getInt(1);

                // Lưu chi tiết đơn hàng
                String sqlDetail = "INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price) VALUES (?, ?, ?, ?)";
                PreparedStatement pstmtDetail = con.prepareStatement(sqlDetail);
                for (OrderDetails detail : orderDetails) {
                    pstmtDetail.setInt(1, orderId);
                    pstmtDetail.setInt(2, detail.getProductID());
                    pstmtDetail.setInt(3, detail.getQuantity());
                    pstmtDetail.setDouble(4, detail.getPrice());
                    pstmtDetail.executeUpdate();
                }
                // Lưu thông tin thanh toán
                String sqlPayment = "INSERT INTO Payments (OrderID, PaymentMethod, PaymentStatus) VALUES (?, ?, ?)";
                PreparedStatement pstmtPayment = con.prepareStatement(sqlPayment);
                pstmtPayment.setInt(1, orderId);
                pstmtPayment.setString(2, payment.getPaymentMethod());
                pstmtPayment.setString(3, "Pending"); // Hoặc trạng thái bạn muốn
                pstmtPayment.executeUpdate();
            }

            con.commit(); // Xác nhận giao dịch
        } catch (SQLException e) {
            con.rollback(); // Rollback nếu có lỗi
            throw e;
        } finally {
            con.close(); // Đóng kết nối
        }
    }

    public double getDailyRevenue(Date date) throws SQLException {
        double revenue = 0;
        String sql = "SELECT SUM(totalPrice) FROM Orders WHERE CONVERT(DATE, createdAt) = ?";
        try (Connection con = DBContext.getConnection();
                PreparedStatement pstmt = con.prepareStatement(sql)) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            pstmt.setString(1, sdf.format(date));
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                revenue = rs.getDouble(1);
            }
        }
        return revenue;
    }

    public double getMonthlyRevenue(Date date) throws SQLException {
        double revenue = 0;
        String sql = "SELECT SUM(totalPrice) FROM Orders WHERE MONTH(createdAt) = MONTH(?) AND YEAR(createdAt) = YEAR(?)";
        try (Connection con = DBContext.getConnection();
                PreparedStatement pstmt = con.prepareStatement(sql)) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            pstmt.setString(1, sdf.format(date));

            pstmt.setString(2, sdf.format(date));
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                revenue = rs.getDouble(1);
            }
        }
        return revenue;
    }

    public double getYearlyRevenue(Date date) throws SQLException {
        double revenue = 0;
        String sql = "SELECT SUM(totalPrice) FROM Orders WHERE YEAR(createdAt) = YEAR(?)";
        try (Connection con = DBContext.getConnection();
                PreparedStatement pstmt = con.prepareStatement(sql)) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            pstmt.setString(1, sdf.format(date));
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                revenue = rs.getDouble(1);
            }
        }
        return revenue;
    }

    public List<Double> getWeeklyRevenue(Date date) throws SQLException {
        List<Double> revenueList = new ArrayList<>();
        String sql = "SELECT CAST(createdAt AS DATE) AS order_date, SUM(totalPrice) AS daily_revenue\n"
                + "FROM Orders\n"
                + "WHERE CAST(createdAt AS DATE) BETWEEN DATEADD(DAY, -6, CAST(? AS DATE)) AND CAST(? AS DATE)\n"
                + "GROUP BY CAST(createdAt AS DATE)\n"
                + "ORDER BY order_date DESC;";
        try (Connection con = DBContext.getConnection();
                PreparedStatement pstmt = con.prepareStatement(sql)) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            pstmt.setString(1, sdf.format(date));

            pstmt.setString(2, sdf.format(date));
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                revenueList.add(rs.getDouble("daily_revenue"));
            }
        }
        return revenueList;
    }
}
