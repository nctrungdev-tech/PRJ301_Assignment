/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import DAO.OrderFacade;
import DAO.WalletFacade;
import entity.Cart;
import entity.Item;
import entity.OrderDetails;
import entity.Orders;
import entity.Payments;
import entity.Products;
import entity.Shipping;
import entity.Users;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author TLStore
 */
@WebServlet(name = "OrderController", urlPatterns = {"/order"})
public class OrderController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getAttribute("action").toString();

        switch (action) {
            case "index":
                index(request, response);
                break;
            case "order":
                order(request, response);
                break;
            case "update":
                update(request, response);
                break;
            case "revenue":
                revenue(request, response);
                break;
            // Có thể thêm các hành động khác nếu cần

        }
    }

    protected void index(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        OrderFacade of = new OrderFacade();
        List<Orders> list = of.select();
        request.setAttribute("list", list);
        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    }

    protected void order(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        Users user = (Users) session.getAttribute("user");

        OrderFacade ordersFacade = new OrderFacade();
        Orders order = new Orders();
        order.setUserID(user.getUserID());
        order.setTotalPrice(cart.getTotal());

        List<OrderDetails> orderDetails = new ArrayList<>();
        for (Item item : cart.getItems()) {
            OrderDetails detail = new OrderDetails();
            detail.setProductID(item.getId());
            detail.setQuantity(item.getQuantity());
            detail.setPrice(item.getCost());
            orderDetails.add(detail);
        }

        // Get payment method
        String paymentMethod = request.getParameter("payment");
        Payments payment = new Payments();
        payment.setPaymentMethod(paymentMethod);

        // Get shipping details
        Shipping shipping = new Shipping();
        String notes = request.getParameter("notes");
        if (notes == null || notes.trim().isEmpty()) {
            notes = null; // Gán thành null để lưu vào SQL
        }
        shipping.setNotes(notes);
        String shippingToDifferentAddress = request.getParameter("shipping-address");
        if ("on".equals(shippingToDifferentAddress)) {
            // User checked the box, get the new shipping details
            shipping.setUserID(user.getUserID());
            shipping.setReceiverName(request.getParameter("fullName"));
            shipping.setPhone(request.getParameter("phone"));
            shipping.setAddress(request.getParameter("address"));

        } else {
            // Use the user's existing information
            shipping.setUserID(user.getUserID());
            shipping.setReceiverName(user.getFullName());
            shipping.setPhone(user.getPhone());
            shipping.setAddress(user.getAddress());
        }

        try {
            // Check QR Payment balance FIRST (before creating order)
            if ("QR Payment".equals(paymentMethod)) {
                WalletFacade wf = new WalletFacade();
                // Check if user has enough balance
                boolean hasEnoughBalance = wf.deductMoney(user.getUserID(), cart.getTotal());
                
                if (!hasEnoughBalance) {
                    // Insufficient balance - redirect back with error
                    session.setAttribute("paymentError", "insufficient");
                    response.sendRedirect(request.getContextPath() + "/product/checkout.do?paymentError=insufficient");
                    return;
                }
                
                // Deduction successful, but need to rollback if order creation fails
                try {
                    payment.setPaymentStatus("Paid");
                    ordersFacade.createOrder(order, orderDetails, payment, shipping);
                    
                    // Order created successfully - clear cart and redirect with success
                    session.removeAttribute("cart");
                    response.sendRedirect(request.getContextPath() + "/product/index.do?paymentSuccess=true");
                    
                } catch (SQLException orderException) {
                    // Order creation failed - REFUND the money back to wallet
                    System.out.println("=============== ORDER CREATION ERROR ===============");
                    System.out.println("Error Message: " + orderException.getMessage());
                    System.out.println("SQL State: " + orderException.getSQLState());
                    System.out.println("Error Code: " + orderException.getErrorCode());
                    orderException.printStackTrace();
                    System.out.println("===================================================");
                    
                    wf.addMoney(user.getUserID(), cart.getTotal());
                    
                    session.setAttribute("paymentError", "failed");
                    response.sendRedirect(request.getContextPath() + "/product/checkout.do?paymentError=failed");
                }
                
            } else {
                // Other payment methods - create order without deducting wallet
                payment.setPaymentStatus("Pending");
                ordersFacade.createOrder(order, orderDetails, payment, shipping);
                session.removeAttribute("cart");
                response.sendRedirect(request.getContextPath() + "/product/index.do?success=true");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            // Payment failed - redirect with error
            session.setAttribute("paymentError", "failed");
            response.sendRedirect(request.getContextPath() + "/product/checkout.do?paymentError=failed");
        }
    }

    protected void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String orderStatus = request.getParameter("orderStatus");

            OrderFacade of = new OrderFacade();
            of.update(id, orderStatus);

        } catch (Exception e) {
        }
        request.getRequestDispatcher("/order/index.do").forward(request, response);
    }

    protected void revenue(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            
            // Lấy ngày được chọn
            String selectedDateParam = request.getParameter("selectedDate");
            
            OrderFacade orderFacade = new OrderFacade();

            if (selectedDateParam != null && !selectedDateParam.isEmpty()) {
                Date selectedDate = sdf.parse(selectedDateParam);
                
                // Lấy doanh thu của ngày được chọn
                double dailyRevenue = orderFacade.getDailyRevenue(selectedDate);
                
                // Lấy doanh thu 7 ngày (bao gồm ngày được chọn và 6 ngày trước đó)
                List<Double> weeklyRevenue = orderFacade.getWeeklyRevenue(selectedDate);
                List<String> weeklyLabels = orderFacade.getWeeklyLabels(selectedDate);
                
                // Convert to JSON string
                StringBuilder revenueJson = new StringBuilder("[");
                for (int i = 0; i < weeklyRevenue.size(); i++) {
                    if (i > 0) revenueJson.append(",");
                    revenueJson.append(weeklyRevenue.get(i));
                }
                revenueJson.append("]");
                
                StringBuilder labelsJson = new StringBuilder("[");
                for (int i = 0; i < weeklyLabels.size(); i++) {
                    if (i > 0) labelsJson.append(",");
                    labelsJson.append("\"").append(weeklyLabels.get(i)).append("\"");
                }
                labelsJson.append("]");
                
                // Đặt thuộc tính vào request
                request.setAttribute("dailyRevenue", dailyRevenue);
                request.setAttribute("weeklyRevenueJson", revenueJson.toString());
                request.setAttribute("weeklyLabelsJson", labelsJson.toString());
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    }
// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
