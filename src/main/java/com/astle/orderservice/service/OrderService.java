package com.astle.orderservice.service;

import com.astle.orderservice.model.Order;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderService {

    public List<Order> getOrders() {

        return List.of(
                new Order(1,"John",1200),
                new Order(2,"Alice",850),
                new Order(3,"Bob",450)
        );

    }

}