package com.example.demo_traffic.Entity;

public class MsgEntity {
    private String state;
    private String code;
    private Object msg;

    public MsgEntity(String state, String code, Object msg) {
        this.state = state;
        this.code = code;
        this.msg = msg;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Object getMsg() {
        return msg;
    }

    public void setMsg(Object msg) {
        this.msg = msg;
    }
}
