package com.Web.controller;

import com.Web.entity.OrderDetail;
import com.Web.entity.vo.MessageModel;
import com.Web.service.OrderService;
import com.google.gson.Gson;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "insertOrderServlet", value = "/insertOrderServlet")
public class insertOrderServlet extends HttpServlet {
    OrderService orderService = new OrderService();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String userName = request.getParameter("userName");
        MessageModel messageModel = orderService.insertOrder(userName);


        // 转换为 JSON 格式
        Gson gson = new Gson();
        String json = gson.toJson(messageModel.getObject());

        HttpSession session = request.getSession();
        session.setAttribute("balance", messageModel.getObject());

        // 发送 JSON 数据到前端
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
