/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author Laptop
 */
public class Keyboard {

    private int keyboard_id;
    private String led;
    private int mode;
    private String Switch;
    private String keycap;
    private Product pro_id;

    public Keyboard() {
    }

    public Keyboard(int keyboard_id, String led, int mode, String Switch, String keycap, Product pro_id) {
        this.keyboard_id = keyboard_id;
        this.led = led;
        this.mode = mode;
        this.Switch = Switch;
        this.keycap = keycap;
        this.pro_id = pro_id;
    }

    public int getKeyboard_id() {
        return keyboard_id;
    }

    public void setKeyboard_id(int keyboard_id) {
        this.keyboard_id = keyboard_id;
    }

    public String getLed() {
        return led;
    }

    public void setLed(String led) {
        this.led = led;
    }

    public int getMode() {
        return mode;
    }

    public void setMode(int mode) {
        this.mode = mode;
    }

    public String getSwitch() {
        return Switch;
    }

    public void setSwitch(String Switch) {
        this.Switch = Switch;
    }

    public String getKeycap() {
        return keycap;
    }

    public void setKeycap(String keycap) {
        this.keycap = keycap;
    }

    public Product getPro_id() {
        return pro_id;
    }

    public void setPro_id(Product pro_id) {
        this.pro_id = pro_id;
    }

}
