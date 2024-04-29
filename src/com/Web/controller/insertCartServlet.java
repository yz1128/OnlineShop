package com.Web.controller;

import com.Web.entity.vo.MessageModel;
import com.Web.service.CartService;

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
        // Creating a message model object
        System.out.println(userName + goodsName);
        MessageModel messageModel = cartService.insertCart(userName,goodsName);
        // Validating parameters
        if (goodsName == null || goodsName.isEmpty()) {
            messageModel.setCode(0); // Setting status code to failure
            messageModel.setMsg("商品名不能为空");
        } else if (userName == null || userName.isEmpty()) {
            messageModel.setCode(0); // Setting status code to failure
            messageModel.setMsg("用户名不能为空");
        }
//        cartService.insertCart(userName, goodsName);

            // Inserting into the cart
            if (messageModel.getCode() == 1) {
                messageModel.setCode(1); // Setting status code to success
                messageModel.setMsg("商品已成功添加到购物车");
            } {
                messageModel.setCode(0); // Setting status code to failure
                messageModel.setMsg("添加商品到购物车时发生错误: " );
            }
        }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}




