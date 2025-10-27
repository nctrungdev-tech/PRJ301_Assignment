/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import db.DBContext;
import entity.Users;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import utils.Hasher;

/**
 *
 * @author VINH HIEN
 */
public class UserFacade {
    
    public Users login(String email, String passwordHash) throws SQLException, NoSuchAlgorithmException {
        Users user = null;
        // tao ket noi vao db
        Connection con = DBContext.getConnection();
        //tao doi tuong statement
        PreparedStatement stm = con.prepareStatement("select * from Users where email=? and passwordHash=?");
        stm.setString(1, email);
        stm.setString(2, Hasher.hash(passwordHash));

        //thuc thi lenh select
        ResultSet rs = stm.executeQuery();
        //vì chỉ đọc 1 mẫu tin nên xài if gọn hơn xài while
        if (rs.next()) {
            // doc du lieu vao doi tuong Account
            user = new Users(rs.getInt("userId"),
                    rs.getString("fullname"),
                    rs.getString("email"),
                    rs.getString("passwordHash"),
                    rs.getString("phone"),
                    rs.getString("address"),
                    rs.getDate("createdAt"),
                    rs.getString("roled"));
        }
        //dong ket noi db
        con.close();
        return user;
    }
    
    public void create(Users user) throws SQLException, NoSuchAlgorithmException {

        // tao ket noi vao db
        Connection con = DBContext.getConnection();
        //tao doi tuong statement
        PreparedStatement stm = con.prepareStatement("INSERT INTO Users (FullName, Email, PasswordHash, Phone, Address) VALUES (?, ?, ?, ?, ?)");//vi co tham so nen use preparedStatement
        //gan gia tri cho cac tham so
        stm.setString(1, user.getFullName());
        stm.setString(2, user.getEmail());
        stm.setString(3, Hasher.hash(user.getPasswordHash()));
        
        stm.setString(4, user.getPhone());
        stm.setString(5, user.getAddress());
        
        //thuc thi lenh select
        int count = stm.executeUpdate();
        //dong ket noi db
        con.close();
        
    }
    
    public void update(Users user) throws SQLException, NoSuchAlgorithmException {
        // tao ket noi vao db
        Connection con = DBContext.getConnection();
        //tao doi tuong statement
        PreparedStatement stm = con.prepareStatement("update Users set fullName=?, email=?, passwordHash=?, phone=?, address=? where userID=?");//vi co tham so nen use preparedStatement
        //gan gia tri cho cac tham so
        stm.setString(1, user.getFullName());
        stm.setString(2, user.getEmail());
        stm.setString(3, Hasher.hash(user.getPasswordHash()));
        stm.setString(4, user.getPhone());
        stm.setString(5, user.getAddress());
        stm.setInt(6, user.getUserID());

        //thuc thi lenh select
        int count = stm.executeUpdate();
        //dong ket noi db
        con.close();
        
    }
}
