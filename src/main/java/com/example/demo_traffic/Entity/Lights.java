package com.example.demo_traffic.Entity;

public class Lights {
    private String id;
    private String idmsg;

    public Lights(String id, String idmsg) {
        this.id = id;
        this.idmsg = idmsg;
    }

    @Override
    public String toString() {
        return "Lights{" +
                "id='" + id + '\'' +
                ", idmsg='" + idmsg + '\'' +
                '}';
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdmsg() {
        return idmsg;
    }

    public void setIdmsg(String idmsg) {
        this.idmsg = idmsg;
    }
}
