package com.Web.mapper;

import com.Web.entity.Cart;

import java.util.List;

public interface CartMapper {
     int insertCart(Cart cart);
     int updateCart(Cart cart);
     int deleteByName(Cart cart);
     int deleteAllByName(Cart cart);
     List<Cart> queryByName(Cart cart);
     List<Cart> queryByUserName(String userName);
//     int updateNumbById(Cart cart);
}
