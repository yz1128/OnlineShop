package com.Web.mapper;

import com.Web.entity.Cart;

public interface CartMapper {
     int insertCart();
     int queryByGoodsName(String goodsName);
     int updateNumbById(Cart cart);
}
