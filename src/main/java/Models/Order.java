/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import DAOs.CartDAO;
import java.sql.Date;
import java.text.SimpleDateFormat;

/**
 *
 * @author HIEU
 */
public class Order {

    private int order_id;
    private String username;
    private Date order_date;
    private String order_status;
    private String order_name;
    private int order_totalMoney;
    private String order_phone;
    private String order_email;
    private String order_address;

    public Order() {
    }

    public Order(int order_id, String username, String order_status, String order_name, int order_totalMoney, String order_phone, String order_email, String order_address) {
        this.order_id = order_id;
        this.username = username;
        this.order_status = order_status;
        this.order_name = order_name;
        this.order_totalMoney = order_totalMoney;
        this.order_phone = order_phone;
        this.order_email = order_email;
        this.order_address = order_address;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Date getOrder_date() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        java.sql.Date sqlDate = new java.sql.Date(Long.parseLong(dateFormat.format(order_date)));
        return sqlDate;
    }

    public void setOrder_date(Date order_date) {
        this.order_date = order_date;
    }

    public String getOrder_status() {

        return order_status;
    }

    public void setOrder_status(String order_status) {
        this.order_status = order_status;
    }

    public String getOrder_name() {
        return order_name;
    }

    public void setOrder_name(String order_name) {
        this.order_name = order_name;
    }

    public int getOrder_totalMoney() {
        return order_totalMoney;
    }

    public void setOrder_totalMoney(int order_totalMoney) {
        this.order_totalMoney = order_totalMoney;
    }

    public String getOrder_phone() {
        return order_phone;
    }

    public void setOrder_phone(String order_phone) {
        this.order_phone = order_phone;
    }

    public String getOrder_email() {
        return order_email;
    }

    public void setOrder_email(String order_email) {
        this.order_email = order_email;
    }

    public String getOrder_address() {
        return order_address;
    }

    public void setOrder_address(String order_address) {
        this.order_address = order_address;
    }

}
