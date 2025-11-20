package com.launchpad.controller;

import com.launchpad.dao.UserDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        if (userDAO.validateUser(email, password)) {
            HttpSession session = request.getSession();
            session.setAttribute("userId", userDAO.getUserByEmail(email).getId());
            session.setAttribute("userEmail", email);
            session.setAttribute("userName", userDAO.getUserByEmail(email).getName());
            session.setAttribute("loggedIn", true);
            
            response.sendRedirect("./launch");
        } else {
            request.setAttribute("error", "Invalid email or password");
            doGet(request, response);
        }
    }
}
