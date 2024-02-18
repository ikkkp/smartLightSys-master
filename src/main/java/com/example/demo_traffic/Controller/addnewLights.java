package com.example.demo_traffic.Controller;
import com.alibaba.fastjson.JSONObject;
import com.example.demo_traffic.Dao.LightsD.LightsDaoIpml;
import com.example.demo_traffic.Entity.Lights;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
@CrossOrigin
@RestController

public class addnewLights {
    @Autowired
    LightsDaoIpml lightsDaoIpml;
    @RequestMapping(value = "/addnewLights", method = RequestMethod.POST)
    public int addnewLights(@RequestBody JSONObject requestBody) {
        Lights newLight=new Lights(requestBody.getString("id"),requestBody.getString("idmsg"));
        int lights = lightsDaoIpml.addLights(newLight);
        return lights;
    }
}
