package com.Web.entity;

public class OrderDetail {
    private int orderId;
    private int userId;
    private int goodsId;
    private int orderNumb;

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(int goodsId) {
        this.goodsId = goodsId;
    }

    public int getOrderNumb() {
        return orderNumb;
    }

    public void setOrderNumb(int orderNumb) {
        this.orderNumb = orderNumb;
    }
}
