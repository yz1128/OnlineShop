package com.Web.controller;

import com.Web.entity.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "indexServlet", value = "/indexServlet")
public class indexServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
// System.out.printf(user.getUserName());
        if (user == null) {
            response.sendRedirect("login.jsp");
        }else {
            response.sendRedirect("home.jsp");
        }
    }
}
