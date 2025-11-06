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
    
    /**
     * Login với email + password
     * Không query avatar để tránh lỗi
     */
    public Users login(String email, String password) throws SQLException, NoSuchAlgorithmException {
        Users user = null;
        Connection con = DBContext.getConnection();
        PreparedStatement stm = con.prepareStatement(
            "SELECT userID, fullName, email, passwordHash, phone, address, createdAt, roled FROM Users WHERE email=?"
        );
        stm.setString(1, email);
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
                rs.getString("roled"),
                null  // avatarBase64 = null (không cần lúc login)
            );
        }
        con.close();
        return user;
    }
    
    /**
     * Tạo user mới
     * Password được mã hóa bằng Hasher.hash()
     */
    public void create(Users user) throws SQLException, NoSuchAlgorithmException {
        Connection con = DBContext.getConnection();
        PreparedStatement stm = con.prepareStatement(
            "INSERT INTO Users (FullName, Email, PasswordHash, Phone, Address, Roled, AvatarBase64) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?)"
        );
        stm.setString(1, user.getFullName());
        stm.setString(2, user.getEmail());
        stm.setString(3, Hasher.hash(user.getPasswordHash()));
        stm.setString(4, user.getPhone());
        stm.setString(5, user.getAddress());
        stm.setString(6, user.getRoled());
        stm.setString(7, user.getAvatarBase64()); 
        stm.executeUpdate();
        con.close();
    }
    
    /**
     * Cập nhật user
     * Password được mã hóa bằng Hasher.hash()
     */
    public void update(Users user) throws SQLException, NoSuchAlgorithmException {
        Connection con = DBContext.getConnection();
        PreparedStatement stm = con.prepareStatement(
            "UPDATE Users SET FullName=?, Email=?, PasswordHash=?, Phone=?, Address=?, AvatarBase64=? WHERE UserID=?"
        );
        stm.setString(1, user.getFullName());
        stm.setString(2, user.getEmail());
        stm.setString(3, Hasher.hash(user.getPasswordHash()));
        stm.setString(4, user.getPhone());
        stm.setString(5, user.getAddress());
        stm.setString(6, user.getAvatarBase64()); 
        stm.setInt(7, user.getUserID());
        stm.executeUpdate();
        con.close();
    }
}