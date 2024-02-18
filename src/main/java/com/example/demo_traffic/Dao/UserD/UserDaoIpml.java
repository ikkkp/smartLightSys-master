package com.example.demo_traffic.Dao.UserD;

import java.util.List;

import com.example.demo_traffic.Dao.UserD.UserDao;
import com.example.demo_traffic.Entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;
import java.util.Map;
@CrossOrigin
@RestController
public class UserDaoIpml implements UserDao {
    @Autowired
    JdbcTemplate jdbcTemplate;
    @Override
    public List<Map<String, Object>> getall(){
        List<Map<String,Object>> maps=jdbcTemplate.queryForList("select *from users");
        return maps;
    };

    @Override
    public int addStu(User user) {
        String sql = "insert into users(username,password,user_passport,timestamp ) values(?,?,?,?)";
        int result = jdbcTemplate.update(sql, user.getUsername(),user.getPassword(),user.getUser_passport(),user.getTimestamp());
        return 0;
    }

}
