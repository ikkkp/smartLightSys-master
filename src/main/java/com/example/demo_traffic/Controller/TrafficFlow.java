package com.example.demo_traffic.Controller;
import com.example.demo_traffic.Entity.Base64Util;
import com.example.demo_traffic.Entity.HttpUtil;
import com.example.demo_traffic.Entity.FileUtil;

import java.net.URLEncoder;


/**
 * 车流统计
 */
public class TrafficFlow {

    /**
     * 重要提示代码中所需工具类
     * FileUtil,Base64Util,HttpUtil,GsonUtils请从
     * https://ai.baidu.com/file/658A35ABAB2D404FBF903F64D47C1F72
     * https://ai.baidu.com/file/C8D81F3301E24D2892968F09AE1AD6E2
     * https://ai.baidu.com/file/544D677F5D4E4F17B4122FBD60DB82B3
     * https://ai.baidu.com/file/470B3ACCA3FE43788B5A963BF0B625F3
     * 下载
     */
    public static String traffic_flow() {
        // 请求url
        String url = "https://aip.baidubce.com/rest/2.0/image-classify/v1/vehicle_detect";
        try {
            // 本地文件路径
            String filePath = "C:\\Users\\24964\\Desktop\\1.jpg";
            byte[] imgData = FileUtil.readFileByBytes(filePath);
            String imgStr = Base64Util.encode(imgData);
            String imgParam = URLEncoder.encode(imgStr, "UTF-8");
            String param =  "&image=" + imgParam;
            // 注意这里仅为了简化编码每一次请求都去获取access_token，线上环境access_token有过期时间， 客户端可自行缓存，过期后重新获取。
            String accessToken = "24.6b238ad4891719f46e4b6da7e0d19cc2.2592000.1648998092.282335-25708515";
            String result = HttpUtil.post(url, accessToken, param);
            System.out.println(result);
            return result;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        TrafficFlow.traffic_flow();
    }
}
