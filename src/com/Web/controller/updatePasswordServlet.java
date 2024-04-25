package com.Web.controller;

import com.Web.entity.vo.MessageModel;
import com.Web.service.UserService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "updatePasswordServlet", value = "/updatePasswordServlet")
public class updatePasswordServlet extends HttpServlet {
    public UserService userService = new UserService();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        // 接收客户端的请求（接受参数：姓名、密码）
        String userName = request.getParameter("userName");
        String userPassword = request.getParameter("userPassword");
        String newUserPassword1 = request.getParameter("newUserPassword1");
        String newUserPassword2 = request.getParameter("newUserPassword2");
        //调用userService进行数据库的修改
        MessageModel messageModel = userService.updatePassword(userName,userPassword,newUserPassword1,newUserPassword2);

        // 判断消息模型状态码
        if (messageModel.getCode() == 1) { // 修改成功
            request.setAttribute("messageModel", messageModel);
            // 将用户信息存储到session中
            HttpSession session = request.getSession();
            session.setAttribute("user", messageModel.getObject());
            // 重定向到用户信息界面
            response.sendRedirect("updatePassword.jsp"); // 改动：直接重定向到用户信息的JSP页面
        } else { // 修改失败
            // 将消息模型对象设置到request作用域中
            request.setAttribute("messageModel", messageModel);

            // 转发到用户信息界面，并附带错误信息
            RequestDispatcher dispatcher = request.getRequestDispatcher("updatePassword.jsp");
            dispatcher.forward(request, response);
        }
    }
}
