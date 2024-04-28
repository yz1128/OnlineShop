package com.Web.mapper;

import com.Web.entity.Cart;
import com.Web.entity.Goods;

import java.util.List;

public interface CartMapper {
    public int insertCart(Cart cart);
    public List<Goods> queryByGoodsName(String goodsName);
}
