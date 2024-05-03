package com.Web.controller;

import com.Web.entity.vo.MessageModel;
import com.Web.service.GoodsService;
import com.Web.service.OrderService;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "showAllOrderServlet", value = "/showAllOrderServlet")
public class showAllOrderServlet extends HttpServlet {
    protected OrderService orderService = new OrderService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // 创建一个消息模型对象
        MessageModel messageModel = orderService.showAllOrder();

        // 转换为 JSON 格式
        Gson gson = new Gson();
        String json = gson.toJson(messageModel.getObject());

        // 发送 JSON 数据到前端
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
