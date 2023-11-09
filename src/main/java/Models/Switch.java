/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author HIEU
 */
public class Switch {

    private int switch_id;
    private String pin;
    private String type;
    private String loxo;
    private String doBen;
    private String hanhTrinh;
    private Product pro_id;

    public Switch() {
    }

    public Switch(int switch_id, String pin, String type, String loxo, String doBen, String hanhTrinh, Product pro_id) {
        this.switch_id = switch_id;
        this.pin = pin;
        this.type = type;
        this.loxo = loxo;
        this.doBen = doBen;
        this.hanhTrinh = hanhTrinh;
        this.pro_id = pro_id;
    }

    public int getSwitch_id() {
        return switch_id;
    }

    public void setSwitch_id(int switch_id) {
        this.switch_id = switch_id;
    }

    public String getPin() {
        return pin;
    }

    public void setPin(String pin) {
        this.pin = pin;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getLoxo() {
        return loxo;
    }

    public void setLoxo(String loxo) {
        this.loxo = loxo;
    }

    public String getDoBen() {
        return doBen;
    }

    public void setDoBen(String doBen) {
        this.doBen = doBen;
    }

    public String getHanhTrinh() {
        return hanhTrinh;
    }

    public void setHanhTrinh(String hanhTrinh) {
        this.hanhTrinh = hanhTrinh;
    }

    public Product getPro_id() {
        return pro_id;
    }

    public void setPro_id(Product pro_id) {
        this.pro_id = pro_id;
    }
}
