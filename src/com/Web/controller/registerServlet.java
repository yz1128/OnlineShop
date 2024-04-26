package com.Web.controller;

import com.Web.entity.vo.MessageModel;
import com.Web.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class registerServlet extends HttpServlet {

    // 实例化UserService对象
    private UserService userService = new UserService();


    /**
     * 用户登录
     *   １.接收客户端的请求（接受参数：姓名、密码）
     *   ２.调用service层的方法，返回消息模型对象
     *   ３.判断消息模型状态码
     *      如果状态码是失败
     *          将消息模型对象设置到request作用域中，请求转发跳转到login.jsp
     *      如果状态码是成功
     *          将消息模型中的用户信息设置到session作用域中，重定向跳转到index．jsp
     *   ４.请求转发跳转到登录页面
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        //1.接收客户端的请求（接受参数：姓名、密码）
        String userName = request.getParameter("userName");
        String userPassword = request.getParameter("userPassword");
        String ConfirmPassword = request.getParameter("ConfirmPassword");
        String userEmail = request.getParameter("userEmail");
        String userAddress = request.getParameter("userAddress");
        String userPhone = request.getParameter("userPhone");

        //２.调用service层的方法，返回消息模型对象
        MessageModel messageModel = userService.userRegister(userName,userPassword,ConfirmPassword,userEmail,userAddress,userPhone);
        //3.判断消息模型状态码
        if (messageModel.getCode() == 1) {//成功
            //将消息模型中的用户信息设置到session作用域中，重定向跳转到login.jsp
            request.getSession().setAttribute("user", messageModel.getObject());
            response.sendRedirect("login.jsp");
        } else {//失败
            //将消息模型对象设置到request作用域中，请求转发跳转到login.jsp
            request.setAttribute("messageModel", messageModel);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

}
