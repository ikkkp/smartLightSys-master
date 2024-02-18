package com.example.demo_traffic.Entity;

public class Light {
    private String lat;
    private String lng;
    private String id;
    private String name;
    private String location;


    public Light(String lat, String lng, String id, String name, String location) {
        this.lat = lat;
        this.lng = lng;
        this.id = id;
        this.name = name;
        this.location = location;
    }

    public String getLng() {
        return lng;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setLng(String lng) {
        this.lng = lng;
    }

    public String getLat() {
        return lat;
    }

    public void setLat(String lat) {
        this.lat = lat;
    }

    public String getId() {
        return id;
    }


    public void setId(String id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return "Light{" +
                "lat='" + lat + '\'' +
                ", lng='" + lng + '\'' +
                ", id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", location='" + location + '\'' +
                '}';
    }
}
