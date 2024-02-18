package com.example.demo_traffic.Dao.LightsD;

import com.example.demo_traffic.Entity.Light;
import com.example.demo_traffic.Entity.Lights;

import java.util.List;
import java.util.Map;

public interface LightsDao {
    public List<Map<String,Object>> getallLights();
    public List<Map<String,Object>> getByLightsId(String id);
    public int addLights(Lights lights);
    public int deleteByLightsId(Lights lights);
    public int updateByLightsId(Lights lights);
}
