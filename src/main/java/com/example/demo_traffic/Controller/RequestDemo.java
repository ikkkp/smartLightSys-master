package com.example.demo_traffic.Controller;

import com.baidubce.http.ApiExplorerClient;
import com.baidubce.http.HttpMethodName;
import com.baidubce.model.ApiExplorerRequest;
import com.baidubce.model.ApiExplorerResponse;
import com.example.demo_traffic.Entity.Base64Util;
import com.example.demo_traffic.Entity.HttpUtil;
import com.example.demo_traffic.Entity.FileUtil;

import java.net.URLEncoder;

// 车辆检测 示例代码
public class RequestDemo {
    public static void main(String[] args) {
        String path = "https://aip.baidubce.com/rest/2.0/image-classify/v1/vehicle_detect";
        ApiExplorerRequest request = new ApiExplorerRequest(HttpMethodName.POST, path);

        // 设置header参数
        request.addHeaderParameter("Content-Type", "application/json;charset=UTF-8");

        // 设置query参数
        request.addQueryParameter("access_token", "24.2a759afd9229ed328f1b80b5aa297dd5.2592000.1648996201.282335-25708515");

        // 设置jsonBody参数
        String jsonBody = "url=https://baidu-ai.bj.bcebos.com/image-classify/car.jpeg&area=1,1,1,1048,1680,1048,1680,1";
        request.setJsonBody(jsonBody);

        ApiExplorerClient client = new ApiExplorerClient();

        try {
            ApiExplorerResponse response = client.sendRequest(request);
            // 返回结果格式为Json字符串
            System.out.println(response.getResult());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
