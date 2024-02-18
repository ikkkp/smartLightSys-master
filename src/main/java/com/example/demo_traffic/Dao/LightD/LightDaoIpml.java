package com.example.demo_traffic.Dao.LightD;
import com.example.demo_traffic.Dao.LightD.LightDao;
import com.example.demo_traffic.Entity.Light;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;
@CrossOrigin
@RestController

public class LightDaoIpml implements LightDao {
    @Autowired
    JdbcTemplate jdbcTemplate;
    @Override
    public List<Map<String,Object>> getall()
    {
        List<Map<String,Object>> maps=jdbcTemplate.queryForList("select *from light");
        return maps;
    };
    @Override
    public List<Map<String,Object>> getById(String id) {
        String sql = "select * from light where id = ? ";
        List<Map<String,Object>> lights = jdbcTemplate.queryForList( sql,id);
        return lights;
    }

    @Override
    public int addLight(Light light){
        String sql = "insert into light(id,lat,lng,location,name) values(?,?,?,?,?)";
        int result = jdbcTemplate.update(sql, light.getId(),light.getLat(),light.getLng(),light.getLocation(),light.getName());
        return result;
    };


    @Override
    public int deleteById(Light light){
        String sql = "delete from light where id = ?";
        int result = jdbcTemplate.update(sql, light.getId());
        return result;
    };


    @Override
    public int updateById(Light light){
        String sql = "update light set lat=?,lng=? where id = ?";
        int result = jdbcTemplate.update(sql, light.getLat(),light.getLng(),light.getId());
        return result;
    };

}
