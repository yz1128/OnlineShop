package com.Web.mapper;

import com.Web.entity.Order;

import java.util.List;

public interface OrderMapper {
    int insertOrder(Order order);
    List<Order> queryOrdersByUserName(String userName);
}
