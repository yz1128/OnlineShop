package com.Web.service;

import com.Web.entity.*;
import com.Web.entity.vo.MessageModel;
import com.Web.mapper.*;
import com.Web.util.GetSqlSession;
import org.apache.ibatis.session.SqlSession;

import java.util.ArrayList;
import java.util.Random;

import java.util.List;

public class OrderService {
    public MessageModel insertOrder(String userName) {
        MessageModel messageModel = new MessageModel();
        SqlSession session = GetSqlSession.createSqlSession();

        try {
            CartMapper cartMapper = session.getMapper(CartMapper.class);
            OrderMapper orderMapper = session.getMapper(OrderMapper.class);
            UserMapper userMapper = session.getMapper(UserMapper.class);
            GoodsMapper goodsMapper = session.getMapper(GoodsMapper.class);
            OrderDetailMapper orderDetailMapper = session.getMapper(OrderDetailMapper.class);
            User user = userMapper.queryUserByName(userName);

            Random random = new Random();
            int orderId = random.nextInt(9999);
            double totalPrice = 0.00;
            List<Cart> cartList = cartMapper.queryByUserName(userName);

            double balance = user.getBalance();
            for (Cart cart : cartList) {
                List<Goods> goodsList = goodsMapper.queryByGoodsName(cart.getGoodsName());
                if (!goodsList.isEmpty()) {
                    for (Goods goods : goodsList) {
                        OrderDetail od = new OrderDetail();
                        od.setOrderId(orderId);
                        od.setUserId(user.getUserId());
                        od.setGoodsId(goods.getGoodsId()); // 使用商品列表中的商品ID
                        od.setOrderNumb(cart.getNumb());
                        totalPrice += goods.getUnitPrice() * cart.getNumb();
                        // 尝试插入订单详情
                        int rowsAffected = orderDetailMapper.insertOrderDetail(od);
                        if (rowsAffected > 0) {
                            messageModel.setCode(1);
                            messageModel.setMsg("订单详情插入成功！");
                        } else {
                            messageModel.setCode(0);
                            messageModel.setMsg("订单详情插入失败，发生异常！");
                            session.rollback();
                            return messageModel;
                        }
                    }
                } else {
                    messageModel.setCode(0);
                    messageModel.setMsg("购物车中存在已下架商品！");
                    session.rollback();
                    return messageModel;
                }
            }



            Order o = new Order();
            o.setOrderId(orderId);
            o.setUserId(user.getUserId());
            o.setTotalPrice(totalPrice);
            o.setUserAddress(user.getUserAddress());
            o.setReceiptName(user.getUserName());
            Cart c = new Cart();
            c.setUserName(user.getUserName());
            balance = balance - totalPrice;
            User u = new User();
            u.setUserName(userName);
            u.setBalance(balance);


            // 更新用户余额
            int rowsAffected4 = userMapper.updateBalance(u);
            // 如果更新余额成功，则插入订单和删除购物车中商品
            if (rowsAffected4 > 0) {
                messageModel.setObject(balance);
                int rowsAffected2 = orderMapper.insertOrder(o);
                int rowsAffected3 = cartMapper.deleteAllByName(c);
                // 如果订单插入和购物车删除都成功，则提交事务
                if (rowsAffected2 > 0 && rowsAffected3 > 0) {
                    session.commit();
                    messageModel.setCode(1);
                    messageModel.setMsg("订单插入成功！");
                } else {
                    messageModel.setCode(0);
                    messageModel.setMsg("订单插入失败，发生异常！");
                    session.rollback();
                }
            } else {
                messageModel.setCode(0);
                messageModel.setMsg("更新用户余额失败！");
                session.rollback();
            }
        } catch (Exception e) {
            e.printStackTrace();
            messageModel.setCode(0);
            messageModel.setMsg("插入订单失败，发生异常：" + e.getMessage());
            session.rollback();
        } finally {
            session.close();
        }
        return messageModel;
    }

    public MessageModel queryOrderByUserName(String userName) {
        MessageModel messageModel = new MessageModel();
        SqlSession session = GetSqlSession.createSqlSession();
        List<OrderDetailWithGoods> orderDetailsWithGoods = new ArrayList<>();

        try {
            OrderMapper orderMapper = session.getMapper(OrderMapper.class);
            OrderDetailMapper orderDetailMapper = session.getMapper(OrderDetailMapper.class);
            GoodsMapper goodsMapper = session.getMapper(GoodsMapper.class);

            // 根据用户名查询订单
            List<Order> orders = orderMapper.queryOrdersByUserName(userName);

            // 遍历每个订单，查询订单详情和商品信息
            for (Order order : orders) {
                List<OrderDetail> orderDetails = orderDetailMapper.queryOrderDetailsByOrderId(order.getOrderId());
                for (OrderDetail orderDetail : orderDetails) {
                    Goods goods = goodsMapper.queryByGoodsId(orderDetail.getGoodsId());
                    OrderDetailWithGoods detailWithGoods = new OrderDetailWithGoods();
                    detailWithGoods.setOrderId(order.getOrderId());
                    detailWithGoods.setGoodsId(orderDetail.getGoodsId());
                    detailWithGoods.setGoodsName(goods.getGoodsName());
                    detailWithGoods.setFactory(goods.getFactory());
                    detailWithGoods.setUnitPrice(goods.getUnitPrice());
                    detailWithGoods.setImage(goods.getImage());
                    detailWithGoods.setUnitPrice(goods.getUnitPrice());
                    orderDetailsWithGoods.add(detailWithGoods);
                }
            }

            // 设置查询结果到消息模型
            messageModel.setObject(orderDetailsWithGoods);
            messageModel.setCode(1);
            messageModel.setMsg("查询成功！");
        } catch (Exception e) {
            e.printStackTrace();
            messageModel.setCode(0);
            messageModel.setMsg("查询失败，发生异常：" + e.getMessage());
        } finally {
            session.close();
        }
        return messageModel;
    }
}
