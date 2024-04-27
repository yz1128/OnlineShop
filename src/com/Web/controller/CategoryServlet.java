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

@WebServlet(name = "CategoryServlet", value = "/CategoryServlet")
public class CategoryServlet extends HttpServlet {
    protected GoodsService goodsService = new GoodsService();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        // 接收客户端的请求（接受参数：商品名）
        String category = request.getParameter("category");
        MessageModel messageModel = new MessageModel();
        if (category == null || category.isEmpty()){
            messageModel.setCode(0); // 设置状态码为失败
            //将消息模型对象设置到request作用域中，请求转发跳转到login.jsp
            request.setAttribute("messageModel", messageModel);
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } else {  // 商品名不为空时，返回商品信息
            messageModel.setCode(1); // 设置状态码为成功
            messageModel = goodsService.queryGoodsByCategory(category);
            HttpSession session = request.getSession();
            session.setAttribute("goodsList", messageModel.getObject());
            response.sendRedirect("search.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
