package com.Web.controller;

import com.Web.entity.vo.MessageModel;
import com.Web.service.GoodsService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

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
        // 创建一个消息模型对象
        MessageModel messageModel = new MessageModel();
        // 校验参数是否为空
        if (goodsName == null || goodsName.isEmpty()){
            messageModel.setCode(0); // 设置状态码为失败
            messageModel.setMsg("商品名不能为空");
            // 将消息模型对象设置到 request 作用域中，请求转发跳转到 search.jsp
            request.setAttribute("messageModel", messageModel);
            request.getRequestDispatcher("index.jsp").forward(request, response);
            // 结束方法
            return;
        }
        // 商品名为空时，返回错误消息
        messageModel = goodsService.queryGoodsByName(goodsName);

        //判断消息模型状态码
        if (messageModel.getCode() == 1) {//成功
            //将消息模型中的用户信息设置到session作用域中，重定向跳转到index.jsp
            HttpSession session = request.getSession();
            session.setAttribute("goodsList", messageModel.getObject());
            response.sendRedirect("search.jsp");
        } else {//失败
            //将消息模型对象设置到request作用域中，请求转发跳转到login.jsp
            request.setAttribute("messageModel", messageModel);
            response.sendRedirect("index.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
