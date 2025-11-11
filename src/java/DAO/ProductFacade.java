/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import db.DBContext;
import entity.Categories;
import entity.Products;
import entity.Users;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author TLStore
 */
public class ProductFacade {

    public List<Products> searchByNameAndCategory(String search, int categoryID) {
    List<Products> list = new ArrayList<>();
    try {
        Connection con = DBContext.getConnection();
        String sql = "SELECT * FROM Products WHERE name LIKE ?";
        if (categoryID > 0) {
            sql += " AND categoryID = ?";
        }

        PreparedStatement stm = con.prepareStatement(sql);
        stm.setString(1, "%" + search + "%");

        if (categoryID > 0) {
            stm.setInt(2, categoryID);
        }

        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
            list.add(new Products(rs.getInt("productId"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getDouble("price"),
                    rs.getInt("stock"),
                    rs.getInt("categoryID"),
                    rs.getString("imageURL"),
                    rs.getDate("createdAt"),
                    rs.getInt("sold"),
                    rs.getInt("discount")));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}


    public List<Products> getProductByCategoryId(int categoryId) {
        List<Products> list = new ArrayList<>();
        try {
            Connection con = DBContext.getConnection();
            PreparedStatement stm = con.prepareStatement("select * from Products where categoryId=?");
            stm.setInt(1, categoryId);
            ResultSet rs = stm.executeQuery();
            //vì chỉ đọc 1 mẫu tin nên xài if gọn hơn xài while
            while (rs.next()) {
                // doc du lieu vao doi tuong Account
                list.add(new Products(rs.getInt("productId"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stock"),
                        rs.getInt("categoryID"),
                        rs.getString("imageURL"),
                        rs.getDate("createdAt"),
                        rs.getInt("sold"),
                        rs.getInt("discount")));
            }
        } catch (Exception e) {
        }
        //dong ket noi db
        //con.close();
        return list;
    }

    public List<Products> getProductStore(int categoryId, double min, double max) {
        List<Products> list = new ArrayList<>();
        try {
            Connection con = DBContext.getConnection();
            PreparedStatement stm = con.prepareStatement("SELECT * FROM Products WHERE categoryId = ? \n"
                    + "							AND (Price * (100-Discount) / 100) > ? \n"
                    + "							AND (Price * (100-Discount) / 100) < ?;");
            stm.setInt(1, categoryId);
            stm.setDouble(2, min);
            stm.setDouble(3, max);
            ResultSet rs = stm.executeQuery();
            //vì chỉ đọc 1 mẫu tin nên xài if gọn hơn xài while
            while (rs.next()) {
                // doc du lieu vao doi tuong Account
                list.add(new Products(rs.getInt("productId"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stock"),
                        rs.getInt("categoryID"),
                        rs.getString("imageURL"),
                        rs.getDate("createdAt"),
                        rs.getInt("sold"),
                        rs.getInt("discount")));
            }
        } catch (Exception e) {
        }
        //dong ket noi db
        //con.close();
        return list;
    }

    public List<Products> getNewProduct() {
        List<Products> list = new ArrayList<>();
        try {
            Connection con = DBContext.getConnection();
            PreparedStatement stm = con.prepareStatement("SELECT TOP 5 * FROM Products ORDER BY CreatedAt DESC");

            ResultSet rs = stm.executeQuery();
            //vì chỉ đọc 1 mẫu tin nên xài if gọn hơn xài while
            while (rs.next()) {
                // doc du lieu vao doi tuong Account
                list.add(new Products(rs.getInt("productId"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stock"),
                        rs.getInt("categoryID"),
                        rs.getString("imageURL"),
                        rs.getDate("createdAt"),
                        rs.getInt("sold"),
                        rs.getInt("discount")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        //dong ket noi db
//        con.close();
        return list;
    }

    public List<Products> getPriceDesc() {
        List<Products> list = new ArrayList<>();
        try {
            Connection con = DBContext.getConnection();
            PreparedStatement stm = con.prepareStatement("SELECT * FROM Products ORDER BY (Price * (100-Discount) / 100) DESC");

            ResultSet rs = stm.executeQuery();
            //vì chỉ đọc 1 mẫu tin nên xài if gọn hơn xài while
            while (rs.next()) {
                // doc du lieu vao doi tuong Account
                list.add(new Products(rs.getInt("productId"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stock"),
                        rs.getInt("categoryID"),
                        rs.getString("imageURL"),
                        rs.getDate("createdAt"),
                        rs.getInt("sold"),
                        rs.getInt("discount")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        //dong ket noi db
//        con.close();
        return list;
    }

    public List<Products> getPriceAsc() {
        List<Products> list = new ArrayList<>();
        try {
            Connection con = DBContext.getConnection();
            PreparedStatement stm = con.prepareStatement("SELECT * FROM Products ORDER BY (Price * (100-Discount) / 100) ASC");

            ResultSet rs = stm.executeQuery();
            //vì chỉ đọc 1 mẫu tin nên xài if gọn hơn xài while
            while (rs.next()) {
                // doc du lieu vao doi tuong Account
                list.add(new Products(rs.getInt("productId"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stock"),
                        rs.getInt("categoryID"),
                        rs.getString("imageURL"),
                        rs.getDate("createdAt"),
                        rs.getInt("sold"),
                        rs.getInt("discount")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        //dong ket noi db
//        con.close();
        return list;
    }

    public Products read(int productId) throws SQLException {
        Products product = null;
        // tao ket noi vao db
        Connection con = DBContext.getConnection();
        //tao doi tuong statement
        PreparedStatement stm = con.prepareStatement("select * from Products where productId =?");
        stm.setInt(1, productId);
        //thuc thi lenh select
        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
            // doc tung dong trong table Brand de vao doi tuong toy
            product = new Products(rs.getInt("productId"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getDouble("price"),
                    rs.getInt("stock"),
                    rs.getInt("categoryID"),
                    rs.getString("imageURL"),
                    rs.getDate("createdAt"),
                    rs.getInt("sold"),
                    rs.getInt("discount"));
        }
        //dong ket noi db
        con.close();
        return product;
    }

    public List<List<Products>> getTop18Sold() {
        List<List<Products>> batches = new ArrayList<>();
        try {
            Connection con = DBContext.getConnection();
            PreparedStatement stm = con.prepareStatement("SELECT TOP 18 * FROM Products ORDER BY sold DESC");

            ResultSet rs = stm.executeQuery();
            List<Products> allProducts = new ArrayList<>();

            while (rs.next()) {
                allProducts.add(new Products(rs.getInt("productId"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stock"),
                        rs.getInt("categoryID"),
                        rs.getString("imageURL"),
                        rs.getDate("createdAt"),
                        rs.getInt("sold"),
                        rs.getInt("discount")));
            }
            // Chia sản phẩm thành 6 khung mỗi khung 3 sản phẩm
            for (int i = 0; i < 6; i++) {
                int start = i * 3; // Tính chỉ số bắt đầu cho mỗi nhóm
                if (start + 3 <= allProducts.size()) {
                    List<Products> batch = allProducts.subList(start, start + 3);
                    batches.add(batch); // Thêm nhóm vào danh sách batches
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return batches;
    }

    public List<Products> select(int page) throws SQLException {
        List<Products> list = null;
        // tao ket noi vao db
        Connection con = DBContext.getConnection();
        //tao doi tuong statement
        PreparedStatement stm = con.prepareStatement("WITH TopProducts AS (\n"
                + "    SELECT TOP 18 * FROM Products ORDER BY sold DESC\n"
                + ")\n"
                + "SELECT * FROM TopProducts \n"
                + "ORDER BY productid \n"
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;");
        int pageSize = 6;
        stm.setInt(1, (page - 1) * pageSize);
        stm.setInt(2, pageSize);

        //thuc thi lenh select
        ResultSet rs = stm.executeQuery();

        list = new ArrayList<>();
        while (rs.next()) {
            // doc tung dong trong table Brand de vao doi tuong toy
            Products product = new Products(rs.getInt("productId"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getDouble("price"),
                    rs.getInt("stock"),
                    rs.getInt("categoryID"),
                    rs.getString("imageURL"),
                    rs.getDate("createdAt"),
                    rs.getInt("sold"),
                    rs.getInt("discount"));

            // them brand vao list
            list.add(product);
        }
        //dong ket noi db
        con.close();
        return list;
    }

    public int count() throws SQLException {
        int row_count = 0;
        // tao ket noi vao db
        Connection con = DBContext.getConnection();
        //tao doi tuong statement
        Statement stm = con.createStatement();// lkhong co tham so nen use Statement
        //thuc thi lenh select
        ResultSet rs = stm.executeQuery("WITH TopProducts AS (\n"
                + "    SELECT TOP 18 * FROM Products ORDER BY sold DESC\n"
                + ")\n"
                + "SELECT COUNT(*) AS row_count FROM TopProducts");
        if (rs.next()) {
            row_count = rs.getInt("row_count");
        }
        //dong ket noi db
        con.close();
        return row_count;
    }
    public List<Products> select() throws SQLException {
        List<Products> list = null;
        // tao ket noi vao db
        Connection con = DBContext.getConnection();
        //tao doi tuong statement
        Statement stm = con.createStatement();// lkhong co tham so nen use Statement
        //thuc thi lenh select
        ResultSet rs = stm.executeQuery("select * from Products");
        list = new ArrayList<>();
        while (rs.next()) {
            Products product = new Products(rs.getInt("productId"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getDouble("price"),
                    rs.getInt("stock"),
                    rs.getInt("categoryID"),
                    rs.getString("imageURL"),
                    rs.getDate("createdAt"),
                    rs.getInt("sold"),
                    rs.getInt("discount"));

            // them brand vao list
            list.add(product);
        }
        //dong ket noi db
        con.close();
        return list;
    }
    public void update(Products product) throws SQLException {
        Connection con = DBContext.getConnection();
        String sql = "UPDATE Products SET name = ?, description = ?, price = ?, stock = ?, categoryID = ?, imageURL = ?, sold = ?, discount = ? WHERE productID = ?";

        try (PreparedStatement stm = con.prepareStatement(sql)) {
            stm.setString(1, product.getName());
            stm.setString(2, product.getDescription());
            stm.setDouble(3, product.getPrice());
            stm.setInt(4, product.getStock());
            stm.setInt(5, product.getCategoryID());
            stm.setString(6, product.getImageURL());
            stm.setInt(7, product.getSold());
            stm.setInt(8, product.getDiscount());
            stm.setInt(9, product.getProductID());

            int count = stm.executeUpdate();

        } finally {
            con.close();
        }
    }

    public void create(Products product) throws SQLException {
        Connection con = DBContext.getConnection();
        PreparedStatement stm = con.prepareStatement("INSERT INTO Products (Name, Description, Price, Stock, CategoryID, ImageURL, Sold, Discount) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");

        stm.setString(1, product.getName());
        stm.setString(2, product.getDescription());
        stm.setDouble(3, product.getPrice());
        stm.setInt(4, product.getStock());
        stm.setInt(5, product.getCategoryID());
        stm.setString(6, product.getImageURL());
        stm.setInt(7, product.getSold());
        stm.setInt(8, product.getDiscount());

        int count = stm.executeUpdate();
        con.close();
    }

    public void delete(int productID) throws SQLException {
        Connection con = DBContext.getConnection();
        PreparedStatement stm = con.prepareStatement("DELETE FROM Products WHERE productID = ?");
        stm.setInt(1, productID);

        int count = stm.executeUpdate();

        con.close();
    }
}
