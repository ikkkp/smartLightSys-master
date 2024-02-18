package com.example.demo_traffic.Controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.example.demo_traffic.Dao.LightD.LightDaoIpml;
import com.example.demo_traffic.Dao.LightsD.LightsDaoIpml;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
@CrossOrigin
@RestController
public class searchController {
    @Autowired
    LightDaoIpml lightDaoIpml;
    @RequestMapping(value = "/search", method = RequestMethod.POST)
    public JSONArray lightserve() {
        List<Map<String, Object>> lights = lightDaoIpml.getall();
        String str = JSON.toJSONString(lights);
        JSONArray jsonArray = JSONArray.parseArray(str);
        return jsonArray;
    }
    @Autowired
    LightsDaoIpml lightsDaoIpml;
    @RequestMapping(value = "/searchLights", method = RequestMethod.POST)
    public JSONArray lightsserve(@RequestBody JSONObject requestBody) {
        List<Map<String, Object>> lights = lightsDaoIpml.getByLightsId(requestBody.getString("id"));
        String str = JSON.toJSONString(lights);
        JSONArray jsonArray = JSONArray.parseArray(str);
        return jsonArray;

    }
    @RequestMapping(value = "/searchid", method = RequestMethod.POST)
    public JSONArray lightfind(@RequestBody JSONObject requestBody) {
        List<Map<String, Object>> lights = lightDaoIpml.getById(requestBody.getString("id"));
        String str = JSON.toJSONString(lights);
        JSONArray jsonArray = JSONArray.parseArray(str);
        return jsonArray;
    }
}
