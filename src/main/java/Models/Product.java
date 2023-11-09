/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.sql.Date;

/**
 *
 * @author HIEU
 */
public class Product {

    private int pro_id;
    private String pro_name;
    private String pro_quantity;
    private int pro_price;
    private String pro_image;
    private String pro_discription;
    private int pro_discount;
    private int category_id;

    public Product() {
    }

    public Product(int pro_id, String pro_name, String pro_quantity, int pro_price, String pro_image, String pro_discription, int pro_discount, int category_id) {
        this.pro_id = pro_id;
        this.pro_name = pro_name;
        this.pro_quantity = pro_quantity;
        this.pro_price = pro_price;
        this.pro_image = pro_image;
        this.pro_discription = pro_discription;
        this.pro_discount = pro_discount;
        this.category_id = category_id;
    }

    public int getPro_id() {
        return pro_id;
    }

    public void setPro_id(int pro_id) {
        this.pro_id = pro_id;
    }

    public String getPro_name() {
        return pro_name;
    }

    public void setPro_name(String pro_name) {
        this.pro_name = pro_name;
    }

    public String getPro_quantity() {
        return pro_quantity;
    }

    public void setPro_quantity(String pro_quantity) {
        this.pro_quantity = pro_quantity;
    }

    public int getPro_price() {
        return pro_price;
    }

    public void setPro_price(int pro_price) {
        this.pro_price = pro_price;
    }

    public String getPro_image() {
        return pro_image;
    }

    public void setPro_image(String pro_image) {
        this.pro_image = pro_image;
    }

    public String getPro_discription() {
        return pro_discription;
    }

    public void setPro_discription(String pro_discription) {
        this.pro_discription = pro_discription;
    }

    public int getPro_discount() {
        return pro_discount;
    }

    public void setPro_discount(int pro_discount) {
        this.pro_discount = pro_discount;
    }

    public int getCategory_id() {
        return category_id;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
    }

}
