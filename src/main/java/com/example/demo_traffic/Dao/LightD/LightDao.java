package com.example.demo_traffic.Dao.LightD;

import com.example.demo_traffic.Entity.Light;

import java.util.List;
import java.util.Map;

public interface LightDao {
    public List<Map<String,Object>> getall();
    public List<Map<String,Object>> getById(String id);
    public int addLight(Light light);
    public int deleteById(Light light);
    public int updateById(Light light);
}
