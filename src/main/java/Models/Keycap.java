/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author HIEU
 */
public class Keycap {

    private int key_id;
    private String chatLieu;
    private String layOut;
    private int doDay;
    private String doBen;
    private Product pro_id;

    public Keycap() {
    }

    public Keycap(int key_id, String chatLieu, String layOut, int doDay, String doBen, Product pro_id) {
        this.key_id = key_id;
        this.chatLieu = chatLieu;
        this.layOut = layOut;
        this.doDay = doDay;
        this.doBen = doBen;
        this.pro_id = pro_id;
    }

    public int getKey_id() {
        return key_id;
    }

    public void setKey_id(int key_id) {
        this.key_id = key_id;
    }

    public String getChatLieu() {
        return chatLieu;
    }

    public void setChatLieu(String chatLieu) {
        this.chatLieu = chatLieu;
    }

    public String getLayOut() {
        return layOut;
    }

    public void setLayOut(String layOut) {
        this.layOut = layOut;
    }

    public int getDoDay() {
        return doDay;
    }

    public void setDoDay(int doDay) {
        this.doDay = doDay;
    }

    public String getDoBen() {
        return doBen;
    }

    public void setDoBen(String doBen) {
        this.doBen = doBen;
    }

    public Product getPro_id() {
        return pro_id;
    }

    public void setPro_id(Product pro_id) {
        this.pro_id = pro_id;
    }

}
