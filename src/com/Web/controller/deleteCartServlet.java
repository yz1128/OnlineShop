package com.Web.controller;

import com.Web.entity.Cart;
import com.Web.entity.vo.MessageModel;
import com.Web.service.CartService;
import com.google.gson.Gson;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "deleteCartServlet", value = "/deleteCartServlet")
public class deleteCartServlet extends HttpServlet {
    public CartService cartService = new CartService();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        // 接收客户端的请求（接受参数：姓名、密码）
        String userName = request.getParameter("userName");
        String goodsName = request.getParameter("goodsName");

        //调用userService进行数据库的修改
            MessageModel messageModel = cartService.deleteByName(userName,goodsName);
            messageModel = cartService.queryByName(userName,goodsName);
            request.setAttribute("messageModel", messageModel);
            // 转换为 JSON 格式
            Gson gson = new Gson();
            String json = gson.toJson(messageModel.getObject());

            // 发送 JSON 数据到前端
            PrintWriter out = response.getWriter();
            out.print(json);
            out.flush();
        //TODO(Yanz,2024/4/30 上午12:00):购物车删除商品

    }



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
