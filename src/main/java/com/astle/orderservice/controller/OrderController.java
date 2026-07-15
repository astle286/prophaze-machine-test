package com.astle.orderservice.controller;

import com.astle.orderservice.model.Order;
import com.astle.orderservice.service.OrderService;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
public class OrderController {

    private final OrderService orderService;

    public OrderController(OrderService orderService){
        this.orderService = orderService;
    }

    @GetMapping("/health")
    public Map<String,String> health(){

        return Map.of(
                "status","UP"
        );

    }

    @GetMapping("/version")
    public Map<String,String> version(){

        return Map.of(
                "version","1.0.0"
        );

    }

    @GetMapping("/orders")
    public List<Order> orders(){

        return orderService.getOrders();

    }

}