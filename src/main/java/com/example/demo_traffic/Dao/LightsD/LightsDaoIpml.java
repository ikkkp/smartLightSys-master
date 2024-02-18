package com.example.demo_traffic.Dao.LightsD;

import com.example.demo_traffic.Entity.Light;
import com.example.demo_traffic.Entity.Lights;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;
@CrossOrigin
@RestController
public class LightsDaoIpml implements LightsDao{
    @Autowired
    JdbcTemplate jdbcTemplate;
    @Override
    public List<Map<String,Object>> getallLights()
    {
        List<Map<String,Object>> maps=jdbcTemplate.queryForList("select *from lights");
        return maps;
    };
    @Override
    public List<Map<String,Object>> getByLightsId(String id) {
        String sql = "select * from lights where id = ? ";
        List<Map<String,Object>> lights = jdbcTemplate.queryForList(sql,id);
        return lights;
    }

    @Override
    public int addLights(Lights lights){
        String sql = "insert into lights(id,idmsg) values(?,?)";
        int result = jdbcTemplate.update(sql, lights.getId(), lights.getIdmsg());
        return result;
    };


    @Override
    public int deleteByLightsId(Lights lights){
        String sql = "delete from lights where id = ?";
        int result = jdbcTemplate.update(sql, lights.getId());
        return result;
    };


    @Override
    public int updateByLightsId(Lights lights){
        String sql = "update lights set idmsg=?  where id = ?";
        int result = jdbcTemplate.update(sql, lights.getIdmsg(),lights.getId());
        return result;
    };

}
