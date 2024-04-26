package com.Web.service;

import com.Web.entity.Goods;
import com.Web.entity.vo.MessageModel;
import com.Web.mapper.GoodsMapper;
import com.Web.util.GetSqlSession;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

/**
 * 业务逻辑
 */
public class GoodsService {

    public MessageModel queryGoods(String goodsName) {
        MessageModel messageModel = new MessageModel();

        //回显数据
        Goods g = new Goods();
        g.setGoodsName(goodsName);
        messageModel.setObject(g);
        System.out.println(goodsName);
        // 2.调用dao层的查询方法，通过用户名查询用户对象
        SqlSession session = GetSqlSession.createSqlSession();

        try {
            GoodsMapper goodsMapper = session.getMapper(GoodsMapper.class);
            List<Goods> goodsList = goodsMapper.queryByGoodsName(goodsName);
            System.out.println(goodsName + "goodsList容量" + goodsList.size());
            for (Goods goods : goodsList) {
                System.out.println("ID: " + goods.getGoodsId() + ", 名称: " + goods.getGoodsName());
                // 这里可以输出更多商品的属性，例如价格、库存等

            }

            // 3.判断用户对象是否为空
            if (goodsList == null) {
                //将状态码、提示信息、回想数据设置到消息模型中，返回消息模型对象
                messageModel.setCode(0);
                messageModel.setMsg("商品不存在！");
                //回显数据
                return messageModel;
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


    /**
     * 切换物品上架状态
     * @param goodsId
     * @return
     */
    public MessageModel shiftGoodsState(String goodsId) {
        MessageModel messageModel = new MessageModel();

        // 回显数据
        Goods g = new Goods();
        g.setGoodsId(goodsId);
        messageModel.setObject(g);
        System.out.println("goodsId："+g.getGoodsId());

        // 3. 调用DAO层方法检查物品是否存在
        SqlSession session = GetSqlSession.createSqlSession();

        try {
            GoodsMapper goodsMapper = session.getMapper(GoodsMapper.class);
            List<Goods> existingGoods = goodsMapper.selectByGoodsId(goodsId);

            if (existingGoods == null) {
                messageModel.setCode(0);
                messageModel.setMsg("不存在该物品！");
                return messageModel;
            }
            //切换状态码goodsState
            if (g.getGoodsState() == 1) {
                g.setGoodsState(0);
            } else {
                g.setGoodsState(1);
            }
            // 4. 如果一切正常，则将切换物品上架状态
            int rowsAffected = goodsMapper.updateGoodsStateById(g.getGoodsId(),g.getGoodsState());
            //提交事务
            if (rowsAffected > 0) {
                messageModel.setCode(1);
                messageModel.setMsg("切换成功！");
                session.commit();
            } else {
                messageModel.setCode(0);
                messageModel.setMsg("切换失败，请稍后重试！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            messageModel.setCode(0);
            messageModel.setMsg("切换失败，发生异常：" + e.getMessage());
        } finally {
            session.close();
        }

        return messageModel;
    }
}
