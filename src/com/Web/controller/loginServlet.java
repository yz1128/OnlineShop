package com.Web.controller;

import com.Web.entity.vo.MessageModel;
import com.Web.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/login")
public class loginServlet extends HttpServlet {

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
        //1.接收客户端的请求（接受参数：姓名、密码）
        String userName = request.getParameter("userName");
        String userPassword = request.getParameter("userPassword");
        System.out.println(userName + userPassword);
        //２.调用service层的方法，返回消息模型对象
        MessageModel messageModel = userService.userLogin(userName,userPassword);
        //3.判断消息模型状态码
        if (messageModel.getCode() == 1) {//成功
            //将消息模型中的用户信息设置到session作用域中，重定向跳转到index.jsp
            HttpSession session = request.getSession();
            session.setAttribute("user", messageModel.getObject());
            Cookie cookie = new Cookie("JSESSIONID",session.getId());
            cookie.setMaxAge(60*30);
            cookie.setPath("/");
            response.addCookie(cookie);
            response.sendRedirect("indexServlet");
        } else {//失败
            //将消息模型对象设置到request作用域中，请求转发跳转到login.jsp
            request.setAttribute("messageModel", messageModel);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

}
