package com.Web.mapper;

import com.Web.entity.Cart;

import java.util.List;

public interface CartMapper {
     int insertCart(Cart cart);
     int updateCart(Cart cart);
     List<Cart> queryByName(Cart cart);
//     int updateNumbById(Cart cart);
}
