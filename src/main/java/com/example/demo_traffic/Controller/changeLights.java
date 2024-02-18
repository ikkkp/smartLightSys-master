package com.example.demo_traffic.Controller;

import com.alibaba.fastjson.JSONObject;
import com.example.demo_traffic.Dao.LightsD.LightsDaoIpml;
import com.example.demo_traffic.Entity.Lights;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@CrossOrigin
@RestController

public class changeLights {
    @Autowired
    LightsDaoIpml lightsDaoIpml;
    @RequestMapping(value = "/changeLights", method = RequestMethod.POST)
    public int changeLights(@RequestBody JSONObject requestBody) {

        Lights lights=new Lights(requestBody.getString("id"),requestBody.getString("idmsg"));
        int result = lightsDaoIpml.updateByLightsId(lights);
        return  result;
    }
}
