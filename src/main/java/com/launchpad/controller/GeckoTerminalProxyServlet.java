package com.launchpad.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/api/gecko/*")
public class GeckoTerminalProxyServlet extends HttpServlet {
    private static final String GECKO_API_BASE = "https://api.coingecko.com/api/v3";
    private String apiKey;
    
    @Override
    public void init() throws ServletException {
        apiKey = System.getenv("COINGECKO_API");
        if (apiKey != null) {
            apiKey = apiKey.trim();
            System.out.println("GeckoTerminal Proxy initialized");
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        if (pathInfo == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing path");
            return;
        }
        
        String queryString = request.getQueryString();
        String targetUrl = GECKO_API_BASE + pathInfo;
        if (queryString != null) {
            targetUrl += "?" + queryString;
        }
        
        System.out.println("Proxying request to: " + targetUrl);
        try {
            URL url = URI.create(targetUrl).toURL();
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            if (apiKey != null && !apiKey.isEmpty()) {
                conn.setRequestProperty("x-cg-demo-api-key", apiKey);
            }
            conn.setRequestProperty("Accept", "application/json");
            
            int responseCode = conn.getResponseCode();
            
            BufferedReader in;
            if (responseCode >= 200 && responseCode < 300) {
                in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            } else {
                in = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
            }
            
            String inputLine;
            StringBuilder content = new StringBuilder();
            while ((inputLine = in.readLine()) != null) {
                content.append(inputLine);
            }
            in.close();
            conn.disconnect();
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.setStatus(responseCode);
            
            response.setHeader("Access-Control-Allow-Origin", "*");
            response.setHeader("Access-Control-Allow-Methods", "GET");
            response.setHeader("Access-Control-Allow-Headers", "Content-Type");
            
            response.getWriter().write(content.toString());
            
        } catch (Exception e) {
            System.err.println("Error proxying request: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Error connecting to GeckoTerminal API: " + e.getMessage());
        }
    }
}
