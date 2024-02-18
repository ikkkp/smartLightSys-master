package com.example.demo_traffic.Dao.UserD;

import com.example.demo_traffic.Entity.User;

import java.util.List;
import java.util.Map;

public interface UserDao {
    public List<Map<String, Object>> getall();
    public int addStu(User user);

}