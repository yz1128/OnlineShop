package com.Web.controller;

import com.Web.entity.vo.MessageModel;
import com.Web.service.GoodsService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "listServlet", value = "/listServlet")
public class listServlet extends HttpServlet {
    protected GoodsService goodsService = new GoodsService();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 接收客户端的请求（接受参数：商品名）
        // 创建一个消息模型对象
        MessageModel messageModel = new MessageModel();
        messageModel = goodsService.listGoods();

        //判断消息模型状态码
        if (messageModel.getCode() == 1) {//成功
            HttpSession session = request.getSession();
            session.setAttribute("goodsList", messageModel.getObject());
            response.sendRedirect("index.jsp");
        } else {//失败
            //将消息模型对象设置到request作用域中，请求转发跳转到index.jsp
            request.setAttribute("messageModel", messageModel);
            response.sendRedirect("index.jsp");
        }
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
