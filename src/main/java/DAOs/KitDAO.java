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
public class KitDAO {

    Connection conn;

    public KitDAO() {
        try {
            conn = DB.DBConnection.connect();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(KeyboardDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(KeyboardDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ResultSet getAllKit() {
        ResultSet rs = null;

        Statement st;
        try {
            st = conn.createStatement();
            rs = st.executeQuery("select * from Kit");
        } catch (SQLException ex) {
            Logger.getLogger(KitDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return rs;
    }
    public ResultSet getKit(int kit_id) {
        ResultSet rs = null;
        ResultSet main = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Kit where id= ?");
            ps.setInt(1, kit_id);
            rs = ps.executeQuery();
            if (rs.next()) {
                main = rs;
            }
        } catch (SQLException ex) {
            Logger.getLogger(KitDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return main;
    }
}
