package com.launchpad.controller;

import com.launchpad.dao.TokenDAO;
import com.launchpad.model.Token;
import java.io.IOException;
import java.io.OutputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/token-image")
public class TokenImageServlet extends HttpServlet {
    private TokenDAO tokenDAO = new TokenDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String tokenIdStr = request.getParameter("id");
        
        if (tokenIdStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Token ID required");
            return;
        }
        
        try {
            int tokenId = Integer.parseInt(tokenIdStr);
            Token token = tokenDAO.getTokenById(tokenId);
            
            if (token != null && token.getImageData() != null) {
                // Set content type
                response.setContentType(token.getImageType());
                response.setContentLength(token.getImageData().length);
                
                // Write image data to response
                try (OutputStream out = response.getOutputStream()) {
                    out.write(token.getImageData());
                    out.flush();
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found");
            }
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid token ID");
        }
    }
}
