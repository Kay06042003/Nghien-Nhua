/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author HIEU
 */
public class Kit {

    private int kit_id;
    private String layout;
    private String mach;
    private String plate;
    private int mode;
    private String Case;
    private Product pro_id;

    public Kit() {
    }

    public Kit(int kit_id, String layout, String mach, String plate, int mode, String Case, Product pro_id) {
        this.kit_id = kit_id;
        this.layout = layout;
        this.mach = mach;
        this.plate = plate;
        this.mode = mode;
        this.Case = Case;
        this.pro_id = pro_id;
    }

    public int getKit_id() {
        return kit_id;
    }

    public void setKit_id(int kit_id) {
        this.kit_id = kit_id;
    }

    public String getLayout() {
        return layout;
    }

    public void setLayout(String layout) {
        this.layout = layout;
    }

    public String getMach() {
        return mach;
    }

    public void setMach(String mach) {
        this.mach = mach;
    }

    public String getPlate() {
        return plate;
    }

    public void setPlate(String plate) {
        this.plate = plate;
    }

    public int getMode() {
        return mode;
    }

    public void setMode(int mode) {
        this.mode = mode;
    }

    public String getCase() {
        return Case;
    }

    public void setCase(String Case) {
        this.Case = Case;
    }

    public Product getPro_id() {
        return pro_id;
    }

    public void setPro_id(Product pro_id) {
        this.pro_id = pro_id;
    }

}
