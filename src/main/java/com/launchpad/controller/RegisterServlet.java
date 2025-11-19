package com.launchpad.controller;

import com.launchpad.dao.UserDAO;
import com.launchpad.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Date;

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
        String confirmPassword = request.getParameter("confirm-password");
        String name = request.getParameter("name");
        Date dob = Date.valueOf(request.getParameter("dob"));

        if (password.length() < 8){
            request.setAttribute("error", "Password must be at least 8 characters long");
            request.getRequestDispatcher("./register").forward(request, response);
            return;
        }
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("./register").forward(request, response);
            return;
        }
        if (userDAO.isEmailExists(email)) {
            request.setAttribute("error", "Email already registered");
            request.getRequestDispatcher("./register").forward(request, response);
            return;
        }

        User newUser = new User();
        newUser.setEmail(email);
        newUser.setPassword(password);
        newUser.setName(name);
        newUser.setDob(dob);

        if (userDAO.registerUser(newUser)) {
            response.sendRedirect("./login?registered=success");
        } else {
            request.setAttribute("error", "Registration failed");
            doGet(request, response);
        }
    }
}
