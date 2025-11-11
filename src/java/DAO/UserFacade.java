package DAO;

import db.DBContext;
import entity.Users;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import utils.Hasher;

public class UserFacade {

    // ========== LOGIN ==========
    public Users login(String email, String password) throws SQLException, NoSuchAlgorithmException {
        Users user = null;
        Connection con = DBContext.getConnection();

        String hashedPassword = Hasher.hash(password);

        PreparedStatement stm = con.prepareStatement(
            "SELECT userID, fullName, email, passwordHash, phone, address, createdAt, roled " +
            "FROM Users WHERE email=? AND passwordHash=?"
        );
        stm.setString(1, email);
        stm.setString(2, hashedPassword);

        ResultSet rs = stm.executeQuery();
        if (rs.next()) {
            user = new Users(
                rs.getInt("userID"),
                rs.getString("fullName"),
                rs.getString("email"),
                rs.getString("passwordHash"),
                rs.getString("phone"),
                rs.getString("address"),
                rs.getDate("createdAt"),
                rs.getString("roled")
            );
        }

        con.close();
        return user;
    }

    // ========== CREATE ==========
    public void create(Users user) throws SQLException, NoSuchAlgorithmException {
        Connection con = DBContext.getConnection();
        PreparedStatement stm = con.prepareStatement(
            "INSERT INTO Users (FullName, Email, PasswordHash, Phone, Address, Roled) VALUES (?, ?, ?, ?, ?, ?)"
        );
        stm.setString(1, user.getFullName());
        stm.setString(2, user.getEmail());
        stm.setString(3, Hasher.hash(user.getPasswordHash()));
        stm.setString(4, user.getPhone());
        stm.setString(5, user.getAddress());
        stm.setString(6, user.getRoled());
        stm.executeUpdate();
        con.close();
    }

    // ========== UPDATE ==========
    public void update(Users user) throws SQLException, NoSuchAlgorithmException {
        Connection con = DBContext.getConnection();
        PreparedStatement stm = con.prepareStatement(
            "UPDATE Users SET FullName=?, Email=?, PasswordHash=?, Phone=?, Address=? WHERE UserID=?"
        );
        stm.setString(1, user.getFullName());
        stm.setString(2, user.getEmail());
        stm.setString(3, Hasher.hash(user.getPasswordHash()));
        stm.setString(4, user.getPhone());
        stm.setString(5, user.getAddress());
        stm.setInt(6, user.getUserID());
        stm.executeUpdate();
        con.close();
    }

    // ========== SELECT ==========
    public Users select(int userId) throws SQLException {
        Users user = null;
        String sql = "SELECT * FROM Users WHERE userID = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new Users();
                    user.setUserID(rs.getInt("userID"));
                    user.setFullName(rs.getString("fullName"));
                    user.setEmail(rs.getString("email"));
                    user.setPasswordHash(rs.getString("passwordHash"));
                    user.setPhone(rs.getString("phone"));
                    user.setAddress(rs.getString("address"));
                    user.setRoled(rs.getString("roled"));
                }
            }
        }
        return user;
    }
}
