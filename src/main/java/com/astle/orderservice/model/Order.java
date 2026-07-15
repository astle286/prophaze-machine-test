package com.astle.orderservice.model;

public class Order {

    private int id;
    private String customer;
    private double amount;

    public Order(int id, String customer, double amount) {
        this.id = id;
        this.customer = customer;
        this.amount = amount;
    }

    public int getId() {
        return id;
    }

    public String getCustomer() {
        return customer;
    }

    public double getAmount() {
        return amount;
    }
}