package com.example.demo_traffic.Controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.example.demo_traffic.Dao.LightD.LightDaoIpml;
import com.example.demo_traffic.Entity.Light;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
@CrossOrigin
@RestController
public class addnewLight {
    @Autowired
    LightDaoIpml lightDaoIpml;
    @RequestMapping(value = "/addnewLight", method = RequestMethod.POST)
    public int addnewLight(@RequestBody JSONObject requestBody) {
        Light newLight=new Light(requestBody.getString("lat"),requestBody.getString("lng"),requestBody.getString("id"),requestBody.getString("lightname"),requestBody.getString("location"));
        int lights = lightDaoIpml.addLight(newLight);
        return lights;
    }
}
