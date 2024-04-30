package com.Web.controller;

import com.Web.entity.vo.MessageModel;
import com.Web.service.CartService;
import com.google.gson.Gson;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "showCartServlet", value = "/showCartServlet")
public class showCartServlet extends HttpServlet {
    CartService cartService = new CartService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // 接收客户端的请求（接受参数：商品名）
        String userName = request.getParameter("userName");
        System.out.println(userName);
        // 创建一个消息模型对象
        MessageModel messageModel = cartService.queryByUserName(userName);

        // 转换为 JSON 格式
        Gson gson = new Gson();
        String json = gson.toJson(messageModel.getObject());

        // 发送 JSON 数据到前端
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }
}
