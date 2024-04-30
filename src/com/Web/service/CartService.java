package com.Web.service;

import com.Web.entity.Cart;
import com.Web.entity.vo.MessageModel;
import com.Web.mapper.CartMapper;
import com.Web.util.GetSqlSession;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class CartService {
    public MessageModel insertCart(String userName, String goodsName) {
        MessageModel messageModel = new MessageModel();
        SqlSession session = GetSqlSession.createSqlSession();

        try {
            CartMapper cartMapper = session.getMapper(CartMapper.class);
            Cart cart = new Cart();
            cart.setUserName(userName);
            cart.setGoodsName(goodsName);

            // 尝试插入购物车
            int rowsAffected = cartMapper.insertCart(cart);
            if (rowsAffected > 0) {
                session.commit();
                messageModel.setCode(1);
                messageModel.setMsg("修改成功！");
            }else {
                messageModel.setCode(0);
                messageModel.setMsg("修改失败，发生异常!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            messageModel.setCode(0);
            messageModel.setMsg("修改失败，发生异常：" + e.getMessage());
        } finally {
            session.close();
        }
        return messageModel;
    }
    public MessageModel updateCart(String userName, String goodsName) {
        MessageModel messageModel = new MessageModel();
        SqlSession session = GetSqlSession.createSqlSession();

        try {
            // 从购物车里查询是否已有该订单
            CartMapper cartMapper = session.getMapper(CartMapper.class);
            Cart cart = new Cart();
            cart.setUserName(userName);
            cart.setGoodsName(goodsName);

            int rowsAffected = cartMapper.updateCart(cart);
            if (rowsAffected > 0) {
                session.commit();
                messageModel.setCode(1);
                messageModel.setMsg("修改成功！");
            } else {
                messageModel.setCode(0);
                messageModel.setMsg("修改失败，请稍后重试！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            messageModel.setCode(0);
            messageModel.setMsg("修改失败，发生异常：" + e.getMessage());
        } finally {
            session.close();
        }
        return messageModel;
    }
    public MessageModel queryByName(String userName, String goodsName) {
        MessageModel messageModel = new MessageModel();

        //回显数据


        Cart c = new Cart();
        c.setUserName(userName);
        c.setGoodsName(goodsName);
        messageModel.setObject(c);

        SqlSession session = GetSqlSession.createSqlSession();
        try {
            CartMapper cartMapper = session.getMapper(CartMapper.class);
            List<Cart> cartList = cartMapper.queryByName(c);

            if (cartList != null && !cartList.isEmpty()) {
                // Successfully retrieved carts
                messageModel.setObject(cartList);
                messageModel.setCode(1);
                messageModel.setMsg("查询成功！");
            } else {
                // No carts found for the given name
                messageModel.setCode(0);
                messageModel.setMsg("没有找到相关商品！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            messageModel.setCode(0);
            messageModel.setMsg("搜索失败，发生异常：" + e.getMessage());
        } finally {
            session.close();
        }
        return messageModel;
    }
    public MessageModel queryByUserName(String userName) {
        MessageModel messageModel = new MessageModel();


        SqlSession session = GetSqlSession.createSqlSession();
        try {
            CartMapper cartMapper = session.getMapper(CartMapper.class);
            List<Cart> cartList = cartMapper.queryByUserName(userName);

            if (cartList != null && !cartList.isEmpty()) {
                // Successfully retrieved carts
                messageModel.setObject(cartList);
                messageModel.setCode(1);
                messageModel.setMsg("查询成功！");
            } else {
                // No carts found for the given name
                messageModel.setCode(0);
                messageModel.setMsg("没有找到相关商品！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            messageModel.setCode(0);
            messageModel.setMsg("搜索失败，发生异常：" + e.getMessage());
        } finally {
            session.close();
        }
        return messageModel;
    }
    public MessageModel deleteByName(String userName, String goodsName) {
        MessageModel messageModel = new MessageModel();
        SqlSession session = GetSqlSession.createSqlSession();
        //回显数据
        CartMapper cartMapper = session.getMapper(CartMapper.class);

        Cart c = new Cart();
        c.setUserName(userName);
        c.setGoodsName(goodsName);

        messageModel.setObject(c);

        try {
            int rowsAffected = cartMapper.deleteByName(c);
            if (rowsAffected > 0) {
                messageModel.setCode(1);
            }else {
                messageModel.setCode(0);
                messageModel.setMsg("搜索失败，发生异常!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            messageModel.setCode(0);
            messageModel.setMsg("搜索失败，发生异常：" + e.getMessage());
        } finally {
            session.close();
        }
        return messageModel;
    }
}
