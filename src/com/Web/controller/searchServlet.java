package com.Web.controller;

import com.Web.entity.vo.MessageModel;
import com.Web.service.GoodsService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "searchServlet", value = "/searchServlet")
public class searchServlet extends HttpServlet {
    protected GoodsService goodsService = new GoodsService();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        // 接收客户端的请求（接受参数：商品名）
        String goodsName = request.getParameter("goodsName");
        MessageModel messageModel = goodsService.queryGoods(goodsName);
        //3.判断消息模型状态码
        if (messageModel.getCode() == 1) {//成功
            //将消息模型中的用户信息设置到session作用域中，重定向跳转到index.jsp
            HttpSession session = request.getSession();
            session.setAttribute("goodsList", messageModel.getObject());
            response.sendRedirect("search.jsp");
        } else {//失败
            //将消息模型对象设置到request作用域中，请求转发跳转到login.jsp
            request.setAttribute("messageModel", messageModel);
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}
