/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.Keyboard;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Laptop
 */
public class KeyboardDAO {

    Connection conn;

    public KeyboardDAO() {
        try {
            conn = DB.DBConnection.connect();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(KeyboardDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(KeyboardDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ResultSet getAllKeyBoard() {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("select * from Keyboard");
        } catch (SQLException ex) {
            Logger.getLogger(KeyboardDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public ResultSet getKeyboard(int keyboard_id) {
        ResultSet rs = null;
        ResultSet main = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Keyboard where id= ?");
            ps.setInt(1, keyboard_id);
            rs = ps.executeQuery();
            if (rs.next()) {
                main = rs;
            }
        } catch (SQLException ex) {
            Logger.getLogger(KeyboardDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return main;
    }

    public String converterNumber(int number) {
        Locale locale = new Locale("en", "EN");
        String pattern = "###,###";
        DecimalFormat decimalFormat = (DecimalFormat) NumberFormat
                .getNumberInstance(locale);
        decimalFormat.applyPattern(pattern);
        String newNumber = decimalFormat.format(number);
        return newNumber;
    }

    public int getPriceBeforeDiscount(int discount, int price) {
        int priceBeforeDiscount = (int) (price / ((100 - discount) / 100.0));

        return priceBeforeDiscount;
    }

}
