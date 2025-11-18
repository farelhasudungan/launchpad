package com.launchpad.controller;

import com.launchpad.dao.UserDAO;
import com.launchpad.model.User;
import java.io.IOException;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("userEmail");
        
        if (email == null) {
            response.sendRedirect("login");
            return;
        }

        User user = userDAO.getUserByEmail(email);
        if (user != null) {
            request.setAttribute("user", user);
            request.getRequestDispatcher("/profile.jsp").forward(request, response);
        } else {
            session.invalidate();
            response.sendRedirect("login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("userEmail");
        
        if (email == null) {
            response.sendRedirect("login");
            return;
        }

        String name = request.getParameter("name");
        String dobStr = request.getParameter("dob");
        String socialLink = request.getParameter("socialLink");

        User user = new User();
        user.setEmail(email);
        user.setName(name);
        user.setSocialLink(socialLink);
        
        if (dobStr != null && !dobStr.isEmpty()) {
            user.setDob(Date.valueOf(dobStr));
        }

        if (userDAO.updateUserProfile(user)) {
            request.setAttribute("success", "Profile updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update profile.");
        }

        doGet(request, response);
    }
}