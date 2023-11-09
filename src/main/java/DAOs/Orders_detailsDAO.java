/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.Orders_details;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HIEU
 */
public class Orders_detailsDAO {

    Connection conn;

    public Orders_detailsDAO() {
        try {
            conn = DB.DBConnection.connect();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Orders_detailsDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Orders_detailsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Orders_details addOrderDetails(Orders_details o) {
        int count = 0;

        try {
            PreparedStatement ps = conn.prepareStatement("insert into Orders_details values(?,?,?,?,?)");
            ps.setInt(1, o.getOrder_id());
            ps.setInt(2, o.getPro_id());
            ps.setInt(3, o.getPrice());
            ps.setInt(4, o.getQuantity());
            ps.setInt(5, o.getTotalMoney());
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(Orders_detailsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count == 0) ? null : o;
    }
}
