package com.Web.entity;

import java.util.Date;

public class Order {
    private String orderId;
    private String totalPrice;
    private int orderState;  //订单状态（0 未付款，1 已支付，2 已发货，3 订单取消）
    private Date creationTime;  //订单创建时间
    private Date payTime;       //订单支付时间
    private Date shipTime;      //发货时间
    private Date receiptTime;   //收件时间
    private Date receiptName;   //收件人

    public String getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(String totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public int getOrderState() {
        return orderState;
    }

    public void setOrderState(int orderState) {
        this.orderState = orderState;
    }

    public Date getCreationTime() {
        return creationTime;
    }

    public void setCreationTime(Date creationTime) {
        this.creationTime = creationTime;
    }

    public Date getPayTime() {
        return payTime;
    }

    public void setPayTime(Date payTime) {
        this.payTime = payTime;
    }

    public Date getShipTime() {
        return shipTime;
    }

    public void setShipTime(Date shipTime) {
        this.shipTime = shipTime;
    }

    public Date getReceiptTime() {
        return receiptTime;
    }

    public void setReceiptTime(Date receiptTime) {
        this.receiptTime = receiptTime;
    }

    public Date getReceiptName() {
        return receiptName;
    }

    public void setReceiptName(Date receiptName) {
        this.receiptName = receiptName;
    }
}
