package com.Web.mapper;

import com.Web.entity.OrderDetail;

import java.util.List;

public interface OrderDetailMapper {
    int insertOrderDetail(OrderDetail orderDetail);
    List<OrderDetail> queryOrderDetailsByOrderId(int orderId);
}
