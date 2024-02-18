package com.example.demo_traffic.Entity;

public class User {

    private String username;
    private  String password;
    private String user_passport;
    private String timestamp;

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public User(String username, String password, String user_passport, String timestamp) {
        this.username = username;
        this.password = password;
        this.user_passport=user_passport;
        this.timestamp=timestamp;
    }

    public String getUser_passport() {
        return user_passport;
    }

    public void setUser_passport(String user_passport) {
        this.user_passport = user_passport;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "User{" +
                "username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", user_passport='" + user_passport + '\'' +
                ", timestamp='" + timestamp + '\'' +
                '}';
    }
}
