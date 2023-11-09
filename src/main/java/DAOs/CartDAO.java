/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HIEU
 */
public class CartDAO {

    Connection conn;

    public CartDAO() {
        try {
            conn = DB.DBConnection.connect();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ResultSet getProductInCart(String username) {
        ResultSet rs = null;
        int quantity = 0;
        int count = 0;
        ArrayList<Integer> listID = new ArrayList<>();
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Cart c join Product p on c.pro_id = p.pro_id where username = ?");
            ps.setString(1, username);
            rs = ps.executeQuery();
            while (rs.next()) {
                if (!listID.contains(rs.getInt("pro_id"))) {
                    listID.add(rs.getInt("pro_id"));
                }
            }

            for (Integer pro_id : listID) {
                quantity = 0;
                PreparedStatement pss = conn.prepareStatement("select * from Cart c join Product p on c.pro_id = p.pro_id where username = ? and c.pro_id=?");
                pss.setString(1, username);
                pss.setInt(2, pro_id);
                rs = pss.executeQuery();
                while (rs.next()) {
                    quantity += rs.getInt("quantity");
                }

                PreparedStatement psss = conn.prepareStatement("delete from Cart where username = ? and pro_id= ?");
                psss.setString(1, username);
                psss.setInt(2, pro_id);
                count = psss.executeUpdate();

                PreparedStatement pssss = conn.prepareStatement("INSERT INTO Cart (pro_id, username, quantity) VALUES (?, ?, ?)");
                pssss.setInt(1, pro_id);
                pssss.setString(2, username);
                pssss.setInt(3, quantity);
                count = pssss.executeUpdate();
            }
            PreparedStatement pre = conn.prepareStatement("select * from Cart c join Product p on c.pro_id = p.pro_id where username = ?");
            pre.setString(1, username);
            rs = pre.executeQuery();

        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public int DeleteProductInCart(String username, int pro_id) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("delete from Cart where username = ? and pro_id= ? ");
            ps.setString(1, username);
            ps.setInt(2, pro_id);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public int getTotalMoney(String username) {
        int totalMoney = 0;
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Cart c join Product p on c.pro_id = p.pro_id where username = ?");
            ps.setString(1, username);
            rs = ps.executeQuery();
            while (rs.next()) {
                totalMoney += rs.getInt("pro_price") * rs.getInt("quantity");
            }
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return totalMoney;
    }

    public void deleteCart(String username) {
        int count = 0;
        PreparedStatement ps;
        try {
            ps = conn.prepareStatement("delete from Cart where username = ?");
            ps.setString(1, username);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
