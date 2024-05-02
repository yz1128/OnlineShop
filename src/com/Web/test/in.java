package com.Web.test;

import com.Web.service.OrderService;

public class in {
    public static void main(String[] args) {
        OrderService orderService = new OrderService();
        orderService.insertOrder("admin");
    }
}
