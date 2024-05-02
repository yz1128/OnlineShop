package com.Web.controller;

import com.Web.entity.vo.MessageModel;
import com.Web.service.CartService;
import com.google.gson.Gson;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "insertCartServlet", value = "/insertCartServlet")
public class insertCartServlet extends HttpServlet {
    protected CartService cartService = new CartService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        String goodsName = request.getParameter("goodsName");
        String userName = request.getParameter("userName");
        int userId = Integer.parseInt(request.getParameter("userId"));
        MessageModel messageModel = cartService.queryByName(userName, goodsName);
        //先查是否有此userName和goodsName的cartId
        if (messageModel.getCode() != 1) {
            //没有就创建insertCart插入一个
            cartService.insertCart(userName,goodsName,userId);
        }else {
            // 如果有就updateNumbByName
            cartService.updateCart(userName,goodsName);
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}




