package com.launchpad.dao;

import com.launchpad.model.User;
import com.launchpad.util.PasswordHash;
import com.launchpad.util.DatabaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    public boolean registerUser(User user) {
        String query = "INSERT INTO users (email, password, name) VALUES (?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, user.getEmail());
            stmt.setString(2, PasswordHash.hashPassword(user.getPassword()));
            stmt.setString(3, user.getName());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean validateUser(String email, String password) {
        String query = "SELECT * FROM users WHERE email = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, email);       
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String hashedPassword = rs.getString("password");
                return PasswordHash.verifyPassword(password, hashedPassword);
            }

            return false;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
