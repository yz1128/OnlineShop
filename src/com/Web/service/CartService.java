package com.Web.service;

import com.Web.entity.Cart;
import com.Web.entity.Goods;
import com.Web.entity.vo.MessageModel;
import com.Web.mapper.CartMapper;
import com.Web.mapper.GoodsMapper;
import com.Web.util.GetSqlSession;
import com.Web.util.StringUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class CartService {
    //TODO(Yanz,2024/4/26 下午11:38): 通过物品显示的
    public MessageModel insertCart(String userName, String goodsName) {
        MessageModel messageModel = new MessageModel();

        // 回显数据
        Cart c = new Cart();
        c.setUserName(userName);
        c.setGoodsName(goodsName);

        // 1. 参数的非空判断
        if (StringUtil.isEmpty(userName) || StringUtil.isEmpty(goodsName)) {
            //将状态码、提示信息、回想数据设置到消息模型中，返回消息模型对象
            messageModel.setCode(0);
            return messageModel;
        }
        SqlSession session = GetSqlSession.createSqlSession();
        // 2.调用dao层的查询方法，通过用户名查询用户对象
        try {
            CartMapper cartMapper = session.getMapper(CartMapper.class);
            int rowsAffected = cartMapper.insertCart(c);
            System.out.println(rowsAffected);
            // 3.判断用户对象是否为空
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
    public MessageModel queryGoodsByName(String goodsName) {
        MessageModel messageModel = new MessageModel();

        //回显数据
        Goods g = new Goods();
        g.setGoodsName(goodsName);
        messageModel.setObject(g);
//        System.out.println(goodsName);
//        2.调用dao层的查询方法，通过用户名查询用户对象
        SqlSession session = GetSqlSession.createSqlSession();

        try {
            GoodsMapper goodsMapper = session.getMapper(GoodsMapper.class);
            List<Goods> goodsList = goodsMapper.queryByGoodsName(goodsName);

            for (Goods goods : goodsList) {
                System.out.println("ID: " + goods.getGoodsId() + ", 名称: " + goods.getGoodsName());
                // 这里可以输出更多商品的属性，例如价格、库存等
            }
            // 登录成功，将商品信息设置到消息模型中
            messageModel.setObject(goodsList);
            messageModel.setCode(1);
            messageModel.setMsg("查询成功！");
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
