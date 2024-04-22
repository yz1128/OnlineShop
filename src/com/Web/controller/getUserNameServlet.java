package com.Web.controller;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "/getUserName")
public class getUserNameServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // 获取会话对象
        HttpSession session = request.getSession(false); // 参数设为false表示如果会话不存在则不创建新会话

        if (session != null) {
            // 从会话中获取用户名
            String userName = (String) session.getAttribute("userName");
            if (userName != null) {
                // 将用户名发送到前端页面
                out.println(userName);
            } else {
                out.println("用户名为空");
            }
        } else {
            out.println("会话不存在");
        }
    }
}
