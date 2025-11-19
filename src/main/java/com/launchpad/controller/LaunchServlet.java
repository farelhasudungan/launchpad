package com.launchpad.controller;

import com.launchpad.dao.TokenDAO;
import com.launchpad.model.Token;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.security.SecureRandom;

@WebServlet("/launch")
@MultipartConfig(maxFileSize = 1024 * 1024)
public class LaunchServlet extends HttpServlet {
    private TokenDAO tokenDAO = new TokenDAO();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String network = request.getParameter("network");
            String tokenName = request.getParameter("tokenName");
            String symbol = request.getParameter("symbol");
            Part imagePart = request.getPart("tokenImage");
            
            if (network == null || network.trim().isEmpty()) {
                throw new IllegalArgumentException("Network is required");
            }
            if (tokenName == null || tokenName.trim().isEmpty()) {
                throw new IllegalArgumentException("Token name is required");
            }
            if (symbol == null || symbol.trim().isEmpty()) {
                throw new IllegalArgumentException("Symbol is required");
            }
            
            Token token = new Token();
            token.setName(tokenName);
            token.setSymbol(symbol.toUpperCase());
            token.setNetwork(network);
            
            if (imagePart != null && imagePart.getSize() > 0) {
                try (InputStream inputStream = imagePart.getInputStream()) {
                    byte[] imageBytes = inputStream.readAllBytes();
                    System.out.println("Image read successfully: " + imageBytes.length + " bytes");
                    token.setImageData(imageBytes);
                    token.setImageType(imagePart.getContentType());
                }
            }
            
            // Simulate deployment
            token.setContractAddress("0x" + generateRandomHex(40));
            token.setDeployerAddress("0x" + generateRandomHex(40));
            token.setTransactionHash("0x" + generateRandomHex(64));
            
            System.out.println("Contract Address: " + token.getContractAddress());
            System.out.println("Deployer Address: " + token.getDeployerAddress());
            System.out.println("Transaction Hash: " + token.getTransactionHash());
            
            // Save to database
            boolean success = tokenDAO.saveToken(token);
            
            System.out.println("Save result: " + success);
            System.out.println("=========================");
            
            if (success) {
                response.sendRedirect(request.getContextPath() + 
                    "/launch?success=true&contract=" + token.getContractAddress());
            } else {
                request.setAttribute("error", "Failed to save token to database");
                doGet(request, response);
            }

        } catch (IllegalArgumentException e) {
            System.err.println("Validation error: " + e.getMessage());
            request.setAttribute("error", "Validation error: " + e.getMessage());
            doGet(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Deployment failed: " + e.getMessage());
            doGet(request, response);
        }
    }

    private String generateRandomHex(int length) {
    SecureRandom random = new SecureRandom();
    StringBuilder hex = new StringBuilder();
    
    for (int i = 0; i < length; i++) {
        int value = random.nextInt(16);
        hex.append(Integer.toHexString(value));
    }
    
    return hex.toString();
}

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Token> newestTokens = tokenDAO.getAllTokens();
            
            // Set as request attribute
            request.setAttribute("newestTokens", newestTokens);
            
            System.out.println("Loaded " + (newestTokens != null ? newestTokens.size() : 0) + " newest tokens");

            request.getRequestDispatcher("/launch.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load tokens: " + e.getMessage());
            request.getRequestDispatcher("/launch.jsp").forward(request, response);
        }
    }
}