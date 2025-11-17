package com.launchpad.controller;

import com.launchpad.dao.UserDAO;
import com.launchpad.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String name = request.getParameter("name");

        User newUser = new User();
        newUser.setEmail(email);
        newUser.setPassword(password); // Hash in production
        newUser.setName(name);

        if (userDAO.registerUser(newUser)) {
            response.sendRedirect("login.jsp?registered=success");
        } else {
            request.setAttribute("error", "Registration failed");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
