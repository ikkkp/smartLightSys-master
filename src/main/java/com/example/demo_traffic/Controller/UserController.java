package com.example.demo_traffic.Controller;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.example.demo_traffic.Entity.MsgEntity;
import com.example.demo_traffic.Entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.example.demo_traffic.Dao.UserD.UserDaoIpml;
import java.util.List;
import java.util.Map;
@CrossOrigin
@RestController
public class UserController {
    @Autowired
    UserDaoIpml userDaoIpml;
    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public MsgEntity login(@RequestBody JSONObject requestBody) {
        List<Map<String,Object>> maps=userDaoIpml.getall();
        String str = JSON.toJSONString(maps);
        JSONArray jsonArray = JSONArray.parseArray(str);
        for(Object object : jsonArray){
            JSONObject jsonObject = (JSONObject)object;
            if(jsonObject.getString("username").equals(requestBody.getString("username"))&&jsonObject.getString("password").equals(requestBody.getString("password"))){
                return new MsgEntity("SUCCESS","01","登录成功");
            }
        }
        return new MsgEntity("SUCCESS","-1","用户名或密码错误");
    };
    @RequestMapping(value = "/zhuce",method = RequestMethod.POST)
    public String zhuce(@RequestBody JSONObject requestBody) {
        String str="zhucexuliehao123456";
        if(requestBody.getString("test_password").equals(str))
        {
            User newUser=new User(requestBody.getString("user_name"),requestBody.getString("user_password"),"01",requestBody.getString("timestamp"));
            userDaoIpml.addStu(newUser);
            return "success";
        }
        else return "failure";
    };


}
