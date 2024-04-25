package com.Web.controller;

import com.Web.entity.vo.MessageModel;
import com.Web.service.UserService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/login")
public class loginServlet extends HttpServlet {

    // 实例化UserService对象
    private UserService userService = new UserService();

    /**
     * 处理用户登录请求
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 避免在生产环境中打印敏感信息
        // String userName = request.getParameter("userName");
        // String userPassword = request.getParameter("userPassword");

        // 设置请求和响应的编码为UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 接收客户端的请求（接受参数：用户名、密码）
        String userName = request.getParameter("userName");
        String userPassword = request.getParameter("userPassword");

        // 调用service层的方法，返回消息模型对象
        MessageModel messageModel = userService.userLogin(userName, userPassword);

        // 判断消息模型状态码
        if (messageModel.getCode() == 1) { // 登录成功
            // 将用户信息存储到session中
            HttpSession session = request.getSession();
            session.setAttribute("user", messageModel.getObject());

            // 如果需要设置Cookie，可以创建并添加到响应中
            // Cookie cookie = new Cookie("JSESSIONID", session.getId());
            // cookie.setMaxAge(60 * 30); // 设置Cookie有效期为30分钟
            // cookie.setPath("/"); // 设置Cookie的作用路径
            // response.addCookie(cookie);

            // 重定向到主页
            response.sendRedirect("index.jsp"); // 改动：直接重定向到主页的JSP页面
        } else { // 登录失败
            // 将消息模型对象设置到request作用域中
            request.setAttribute("messageModel", messageModel);

            // 转发到登录页面，并附带错误信息
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
        }
    }

    // 改动：添加doGet方法以处理非法的GET请求
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported for login.");
    }
}