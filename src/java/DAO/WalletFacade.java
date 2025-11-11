package DAO;

import db.DBContext;
import entity.Wallet;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * @author TLStore
 * DAO for Wallet operations
 */
public class WalletFacade {
    
    /**
     * Get wallet by UserID
     */
    public Wallet getWalletByUserId(int userId) throws SQLException {
        Wallet wallet = null;
        Connection con = DBContext.getConnection();
        PreparedStatement stm = con.prepareStatement(
            "SELECT * FROM Wallets WHERE UserID = ?"
        );
        stm.setInt(1, userId);
        
        ResultSet rs = stm.executeQuery();
        if (rs.next()) {
            wallet = new Wallet(
                rs.getInt("WalletID"),
                rs.getInt("UserID"),
                rs.getDouble("Balance"),
                rs.getDate("LastUpdated")
            );
        }
        
        con.close();
        return wallet;
    }
    
    /**
     * Create wallet for new user
     */
    public void createWallet(int userId) throws SQLException {
        Connection con = DBContext.getConnection();
        PreparedStatement stm = con.prepareStatement(
            "INSERT INTO Wallets (UserID, Balance) VALUES (?, 0)"
        );
        stm.setInt(1, userId);
        stm.executeUpdate();
        con.close();
    }
    
    /**
     * Update wallet balance
     */
    public void updateBalance(int walletId, double newBalance) throws SQLException {
        Connection con = DBContext.getConnection();
        PreparedStatement stm = con.prepareStatement(
            "UPDATE Wallets SET Balance = ?, LastUpdated = GETDATE() WHERE WalletID = ?"
        );
        stm.setDouble(1, newBalance);
        stm.setInt(2, walletId);
        stm.executeUpdate();
        con.close();
    }
    
    /**
     * Add money to wallet (deposit)
     */
    public void addMoney(int userId, double amount) throws SQLException {
        Connection con = DBContext.getConnection();
        
        // Get wallet
        PreparedStatement getWallet = con.prepareStatement(
            "SELECT * FROM Wallets WHERE UserID = ?"
        );
        getWallet.setInt(1, userId);
        ResultSet rs = getWallet.executeQuery();
        
        if (rs.next()) {
            int walletId = rs.getInt("WalletID");
            double currentBalance = rs.getDouble("Balance");
            double newBalance = currentBalance + amount;
            
            // Update balance
            PreparedStatement updateStm = con.prepareStatement(
                "UPDATE Wallets SET Balance = ?, LastUpdated = GETDATE() WHERE WalletID = ?"
            );
            updateStm.setDouble(1, newBalance);
            updateStm.setInt(2, walletId);
            updateStm.executeUpdate();
            
            // Log transaction
            PreparedStatement logStm = con.prepareStatement(
                "INSERT INTO WalletTransactions (WalletID, Amount, TransactionType, Description) VALUES (?, ?, 'Deposit', 'Add money to wallet')"
            );
            logStm.setInt(1, walletId);
            logStm.setDouble(2, amount);
            logStm.executeUpdate();
        }
        
        con.close();
    }
    
    /**
     * Deduct money from wallet (payment)
     */
    public boolean deductMoney(int userId, double amount) throws SQLException {
        Connection con = DBContext.getConnection();
        
        // Get wallet
        PreparedStatement getWallet = con.prepareStatement(
            "SELECT * FROM Wallets WHERE UserID = ?"
        );
        getWallet.setInt(1, userId);
        ResultSet rs = getWallet.executeQuery();
        
        if (rs.next()) {
            int walletId = rs.getInt("WalletID");
            double currentBalance = rs.getDouble("Balance");
            
            // Check if enough balance
            if (currentBalance >= amount) {
                double newBalance = currentBalance - amount;
                
                // Update balance
                PreparedStatement updateStm = con.prepareStatement(
                    "UPDATE Wallets SET Balance = ?, LastUpdated = GETDATE() WHERE WalletID = ?"
                );
                updateStm.setDouble(1, newBalance);
                updateStm.setInt(2, walletId);
                updateStm.executeUpdate();
                
                // Log transaction
                PreparedStatement logStm = con.prepareStatement(
                    "INSERT INTO WalletTransactions (WalletID, Amount, TransactionType, Description) VALUES (?, ?, 'Purchase', 'Order payment')"
                );
                logStm.setInt(1, walletId);
                logStm.setDouble(2, -amount);
                logStm.executeUpdate();
                
                con.close();
                return true; // Success
            }
        }
        
        con.close();
        return false; // Insufficient balance
    }
}
