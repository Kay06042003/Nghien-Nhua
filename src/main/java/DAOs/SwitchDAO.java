/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Laptop
 */
public class SwitchDAO {

    Connection conn;

    public SwitchDAO() {
        try {
            conn = DB.DBConnection.connect();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(KeyboardDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(KeyboardDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ResultSet getAllSwitch() {
        ResultSet rs = null;

        Statement st;
        try {
            st = conn.createStatement();
            rs = st.executeQuery("select * from Switch");
        } catch (SQLException ex) {
            Logger.getLogger(KitDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return rs;
    }

    public ResultSet getSwtich(int switch_id) {
        ResultSet rs = null;
        ResultSet main = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Switch where id= ?");
            ps.setInt(1, switch_id);
            rs = ps.executeQuery();
            if (rs.next()) {
                main = rs;
            }
        } catch (SQLException ex) {
            Logger.getLogger(SwitchDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return main;
    }
}
