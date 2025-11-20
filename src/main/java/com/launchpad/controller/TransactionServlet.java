package com.launchpad.controller;

import com.launchpad.dao.TransactionDAO;
import com.launchpad.model.Transaction;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

@WebServlet({"/transaction/create", "/transaction/list", "/transaction/update"})
public class TransactionServlet extends HttpServlet {
    
    private TransactionDAO transactionDAO = new TransactionDAO();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String path = request.getServletPath();
        
        if ("/transaction/create".equals(path)) {
            createTransaction(request, response);
        } else if ("/transaction/update".equals(path)) {
            updateTransaction(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String path = request.getServletPath();
        
        if ("/transaction/list".equals(path)) {
            listTransactions(request, response);
        }
    }
    
   private void createTransaction(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        Gson gson = new Gson();
        
        HttpSession session = request.getSession(false);
        Integer userId = null;
        
        if (session != null && session.getAttribute("userId") != null) {
            userId = (Integer) session.getAttribute("userId");
        } else {
            String walletAddress = request.getParameter("walletAddress");
            if (walletAddress != null && !walletAddress.isEmpty()) {
                userId = Math.abs(walletAddress.hashCode());
            }
        }
        
        try {
            Transaction transaction = new Transaction();
            transaction.setUserId(userId);
            
            String tokenIdParam = request.getParameter("tokenId");
            if (tokenIdParam != null && !tokenIdParam.isEmpty()) {
                try {
                    transaction.setTokenId(Long.parseLong(tokenIdParam));
                } catch (NumberFormatException e) {
                    transaction.setTokenId((long) Math.abs(tokenIdParam.hashCode()));
                }
            } else {
                transaction.setTokenId(0L);
            }
            
            String tokenSymbol = request.getParameter("tokenSymbol");
            String tokenName = request.getParameter("tokenName");
            String tokenAddress = request.getParameter("tokenId");

            transaction.setTransactionType(request.getParameter("type"));
            transaction.setAmount(new BigDecimal(request.getParameter("amount")));
            transaction.setPricePerToken(new BigDecimal(request.getParameter("pricePerToken")));
            transaction.setTotalPrice(new BigDecimal(request.getParameter("totalPrice")));
            transaction.setWalletAddress(request.getParameter("walletAddress"));
            transaction.setStatus("PENDING");
            transaction.setTokenName(tokenName != null ? tokenName : "Unknown Token");
            transaction.setTokenSymbol(tokenSymbol != null ? tokenSymbol : "UNKNOWN");
            transaction.setTokenAddress(tokenAddress);
            
            boolean success = transactionDAO.createTransaction(transaction);
            
            JsonObject jsonResponse = new JsonObject();
            
            if (success) {
                jsonResponse.addProperty("success", true);
                jsonResponse.addProperty("transactionId", transaction.getId());
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("error", "Failed to create transaction");
            }
            
            response.getWriter().write(gson.toJson(jsonResponse));
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("success", false);
            errorResponse.addProperty("error", e.getMessage() != null ? e.getMessage() : "Unknown error");
            
            response.getWriter().write(gson.toJson(errorResponse));
        }
    }
    
    private void updateTransaction(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        try {
            Long transactionId = Long.parseLong(request.getParameter("transactionId"));
            String status = request.getParameter("status");
            String txHash = request.getParameter("transactionHash");
            
            boolean success = transactionDAO.updateTransactionStatus(transactionId, status, txHash);
            
            response.setContentType("application/json");
            if (success) {
                response.getWriter().write("{\"success\": true}");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"error\": \"Failed to update transaction\"}");
            }
            
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }
    
    private void listTransactions(HttpServletRequest request, HttpServletResponse response) 
        throws IOException {
    
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        int limit = request.getParameter("limit") != null ? 
                Integer.parseInt(request.getParameter("limit")) : 20;
        
        List<Transaction> transactions;
        
        try {
            transactions = transactionDAO.getAllRecentTransactions(limit);
            
            // ✅ Build JSON safely
            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < transactions.size(); i++) {
                Transaction tx = transactions.get(i);
                if (i > 0) json.append(",");
                
                json.append("{");
                json.append("\"id\":").append(tx.getId()).append(",");
                json.append("\"type\":\"").append(escapeJson(tx.getTransactionType())).append("\",");
                json.append("\"tokenSymbol\":\"").append(escapeJson(tx.getTokenSymbol() != null ? tx.getTokenSymbol() : "UNKNOWN")).append("\",");
                json.append("\"amount\":").append(tx.getAmount()).append(",");
                json.append("\"pricePerToken\":").append(tx.getPricePerToken()).append(",");
                json.append("\"totalPrice\":").append(tx.getTotalPrice()).append(",");
                json.append("\"walletAddress\":\"").append(escapeJson(tx.getWalletAddress())).append("\",");
                json.append("\"transactionHash\":\"").append(escapeJson(tx.getTransactionHash() != null ? tx.getTransactionHash() : "")).append("\",");
                json.append("\"createdAt\":\"").append(tx.getCreatedAt()).append("\"");
                json.append("}");
            }
            json.append("]");
            
            response.getWriter().write(json.toString());
            response.getWriter().flush();
            
        } catch (Exception e) {
            System.err.println("Error in listTransactions: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("[]"); // Return empty array on error
        }
    }

    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}