package com.launchpad.dao;

import com.launchpad.model.Token;
import com.launchpad.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TokenDAO {
    public boolean saveToken(Token token) {
        String query = "INSERT INTO tokens (name, symbol, network, image_data, image_type, " +
                    "contract_address, transaction_hash, deployer_address) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?) RETURNING id";
        
        try (Connection conn = DatabaseConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, token.getName());
            stmt.setString(2, token.getSymbol());
            stmt.setString(3, token.getNetwork());
            stmt.setBytes(4, token.getImageData());
            stmt.setString(5, token.getImageType());
            stmt.setString(6, token.getContractAddress());
            stmt.setString(7, token.getTransactionHash());
            stmt.setString(8, token.getDeployerAddress());
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                token.setId(rs.getLong("id"));
                System.out.println("Token saved with ID: " + token.getId());
                return true;
            }
            return false;
            
        } catch (SQLException e) {
            System.err.println("SQL Error Code: " + e.getErrorCode());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Message: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public List<Token> getAllTokens() {
    List<Token> tokens = new ArrayList<>();
    String query = "SELECT id, name, symbol, network, image_data, image_type, " +
                   "contract_address, transaction_hash, deployer_address, created_at " +
                   "FROM tokens ORDER BY created_at DESC LIMIT 8";
    
    try (Connection conn = DatabaseConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(query);
         ResultSet rs = stmt.executeQuery()) {
        
        while (rs.next()) {
            Token token = new Token();
            token.setId(rs.getLong("id"));
            token.setName(rs.getString("name"));
            token.setSymbol(rs.getString("symbol"));
            token.setNetwork(rs.getString("network"));
            token.setImageData(rs.getBytes("image_data"));
            token.setImageType(rs.getString("image_type"));
            token.setContractAddress(rs.getString("contract_address"));
            token.setTransactionHash(rs.getString("transaction_hash"));
            token.setDeployerAddress(rs.getString("deployer_address"));
            
            tokens.add(token);
        }
        
        System.out.println("Retrieved " + tokens.size() + " tokens from database");
        
    } catch (SQLException e) {
        System.err.println("Error fetching tokens: " + e.getMessage());
        e.printStackTrace();
    }
    
    return tokens;
}

    public Token getTokenById(int id) {
        String query = "SELECT * FROM tokens WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Token token = new Token();
                token.setId(rs.getLong("id"));
                token.setName(rs.getString("name"));
                token.setSymbol(rs.getString("symbol"));
                token.setNetwork(rs.getString("network"));
                token.setImageData(rs.getBytes("image_data"));
                token.setImageType(rs.getString("image_type"));
                return token;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
}
