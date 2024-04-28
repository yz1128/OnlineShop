package com.Web.entity;

public class Cart {
    private String carId;//购物车编号
    private int carNumb;

    public int getCarNumb() {
        return carNumb;
    }

    public void setCarNumb(int carNumb) {
        this.carNumb = carNumb;
    }

    public String getCarId() {
        return carId;
    }

    public void setCarId(String carId) {
        this.carId = carId;
    }
}
