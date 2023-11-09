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
public class KeycapDAO {

    Connection conn;

    public KeycapDAO() {
        try {
            conn = DB.DBConnection.connect();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(KeycapDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(KeycapDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ResultSet getAllKeycap() {
        ResultSet rs = null;

        Statement st;
        try {
            st = conn.createStatement();
            rs = st.executeQuery("select * from Keycap");
        } catch (SQLException ex) {
            Logger.getLogger(KeycapDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return rs;
    }

    public ResultSet getKeycap(int keyCap_id) {
        ResultSet rs = null;
        ResultSet main = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Keycap where id= ?");
            ps.setInt(1, keyCap_id);
            rs = ps.executeQuery();
            if (rs.next()) {
                main = rs;
            }
        } catch (SQLException ex) {
            Logger.getLogger(KeycapDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return main;
    }
}
