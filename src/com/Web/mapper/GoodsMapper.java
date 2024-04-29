package com.Web.mapper;

import com.Web.entity.Cart;
import com.Web.entity.Goods;

import java.util.List;

public interface GoodsMapper {
     List<Goods> queryByGoodsName(String goodsName);
     Goods searchByGoodsName(String goodsName);
     List<Goods> queryByCategory(String category);
     List<Goods> selectByGoodsId(int goodsId);
     List<Goods> listGoods();
     int updateGoodsStateById(Cart cart);
     int addGoods(Goods goods);
}
