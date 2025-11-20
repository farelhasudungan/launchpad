package com.launchpad.dao;

import com.launchpad.model.Transaction;
import com.launchpad.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TransactionDAO {
    public boolean createTransaction(Transaction transaction) {
    String query = "INSERT INTO transactions (user_id, token_id, transaction_type, " +
                  "amount, price_per_token, total_price, wallet_address, status, " +
                  "token_name, token_symbol, token_address) " +
                  "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) RETURNING id";
    
    try (Connection conn = DatabaseConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(query)) {
        
        if (transaction.getUserId() != null) {
            stmt.setInt(1, transaction.getUserId());
        } else {
            stmt.setNull(1, java.sql.Types.INTEGER);
        }
        
        if (transaction.getTokenId() != null) {
            stmt.setLong(2, transaction.getTokenId());
        } else {
            stmt.setNull(2, java.sql.Types.BIGINT);
        }
        
        stmt.setString(3, transaction.getTransactionType());
        stmt.setBigDecimal(4, transaction.getAmount());
        stmt.setBigDecimal(5, transaction.getPricePerToken());
        stmt.setBigDecimal(6, transaction.getTotalPrice());
        stmt.setString(7, transaction.getWalletAddress());
        stmt.setString(8, transaction.getStatus());
        
        stmt.setString(9, transaction.getTokenName());
        stmt.setString(10, transaction.getTokenSymbol());
        stmt.setString(11, transaction.getTokenAddress());
        
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            transaction.setId(rs.getLong("id"));
            return true;
        }
        return false;
        
    } catch (SQLException e) {
        System.err.println("Error creating transaction: " + e.getMessage());
        e.printStackTrace();
        return false;
    }
}

    
    public boolean updateTransactionStatus(Long transactionId, String status, 
                                          String transactionHash) {
        String query = "UPDATE transactions SET status = ?, transaction_hash = ?, " +
                      "completed_at = CURRENT_TIMESTAMP WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, status);
            stmt.setString(2, transactionHash);
            stmt.setLong(3, transactionId);
            
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating transaction: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Transaction> getAllRecentTransactions(int limit) {
        List<Transaction> transactions = new ArrayList<>();
        
        // ✅ Simple query - NO JOIN needed!
        String query = "SELECT * FROM transactions " +
                    "WHERE status = 'COMPLETED' " +
                    "ORDER BY created_at DESC LIMIT ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Transaction tx = mapResultSetToTransaction(rs);
                transactions.add(tx);
            }
            
        } catch (SQLException e) {
            System.err.println("Error fetching recent transactions: " + e.getMessage());
            e.printStackTrace();
        }
        
        return transactions;
    }

    private Transaction mapResultSetToTransaction(ResultSet rs) throws SQLException {
        Transaction transaction = new Transaction();
        transaction.setId(rs.getLong("id"));
        
        int userId = rs.getInt("user_id");
        if (!rs.wasNull()) {
            transaction.setUserId(userId);
        }
        
        long tokenId = rs.getLong("token_id");
        if (!rs.wasNull()) {
            transaction.setTokenId(tokenId);
        }
        
        transaction.setTransactionType(rs.getString("transaction_type"));
        transaction.setAmount(rs.getBigDecimal("amount"));
        transaction.setPricePerToken(rs.getBigDecimal("price_per_token"));
        transaction.setTotalPrice(rs.getBigDecimal("total_price"));
        transaction.setWalletAddress(rs.getString("wallet_address"));
        transaction.setTransactionHash(rs.getString("transaction_hash"));
        transaction.setStatus(rs.getString("status"));
        transaction.setCreatedAt(rs.getTimestamp("created_at"));
        
        Timestamp completedAt = rs.getTimestamp("completed_at");
        if (!rs.wasNull()) {
            transaction.setCompletedAt(completedAt);
        }
        
        transaction.setTokenName(rs.getString("token_name"));
        transaction.setTokenSymbol(rs.getString("token_symbol"));
        transaction.setTokenAddress(rs.getString("token_address"));
        
        return transaction;
    }
}
