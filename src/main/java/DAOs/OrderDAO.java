/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.Order;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.Calendar;

/**
 *
 * @author HIEU
 */
public class OrderDAO {

    Connection conn;

    public OrderDAO() {
        try {
            conn = DB.DBConnection.connect();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int getOrderID(String username) {
        int order_id = 0;
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT TOP 1 * FROM Orders where username = ? ORDER BY id DESC");
            ps.setString(1, username);
            rs = ps.executeQuery();
            while (rs.next()) {
                order_id = rs.getInt("id");
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return order_id;
    }

    public Order addOrder(Order order, String username) {
        int count = 0;
        java.util.Date dateToInsert = new java.util.Date();
        Date sqlDate = new Date(dateToInsert.getTime());
        try {
            PreparedStatement ps = conn.prepareStatement("insert into Orders values(?,?,?,?,?,?,?,?)");
            ps.setString(1, username);
            ps.setDate(2, sqlDate);
            ps.setString(3, order.getOrder_status());
            ps.setString(4, order.getOrder_name());
            ps.setInt(5, order.getOrder_totalMoney());
            ps.setString(6, order.getOrder_phone());
            ps.setString(7, order.getOrder_email());
            ps.setString(8, order.getOrder_address());

            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return (count == 0) ? null : order;
    }

    public ResultSet getAllOrderWithUsername(String username) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Orders o join Orders_details od on o.id = od.order_id where o.username=?");
            ps.setString(1, username);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public ResultSet getAllOrder_Id(String username) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select distinct o.id from Orders o join Orders_details od on o.id = od.order_id where o.username=?");
            ps.setString(1, username);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public ResultSet getAllOrderWithID(int id) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Orders o join Orders_details od on o.id = od.order_id where o.id=?");
            ps.setInt(1, id);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public ResultSet getAllOrderWithStatus(String status) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Orders o join Orders_details od on o.id = od.order_id where o.order_status=?");
            ps.setString(1, status);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public void acceptOrder(int order_id) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("update Orders set order_status='Accept' where id=?");
            ps.setInt(1, order_id);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void rejectOrder(int order_id) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("update Orders set order_status='Reject' where id=?");
            ps.setInt(1, order_id);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public int getRevenueToday() {
        int result = 0;
        try {
            ResultSet rs = null;
            java.util.Date dateToInsert = new java.util.Date();
            java.sql.Date sqlDate = new java.sql.Date(dateToInsert.getTime());

            PreparedStatement ps = conn.prepareStatement("select sum(o.order_totalMoney) from Orders o\n"
                    + "where o.order_date = ? and o.order_status ='Accept'");
            ps.setDate(1, sqlDate);
            rs = ps.executeQuery();
            while (rs.next()) {
                result += rs.getInt(1);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    public int getRevenueTotal() {
        int result = 0;
        try {
            ResultSet rs = null;
            Statement st = conn.createStatement();
            rs = st.executeQuery("select sum(o.order_totalMoney) from Orders o where o.order_status ='Accept'");
            while (rs.next()) {
                result += rs.getInt(1);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    public int getRequest() {
        int result = 0;
        try {
            ResultSet rs = null;
            Statement st = conn.createStatement();
            rs = st.executeQuery("select count(o.id) from Orders o where o.order_status ='Waiting Accept'");
            while (rs.next()) {
                result += rs.getInt(1);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    public int getTotalOrderByMonth(int month) {
        int total = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("	SELECT count(id) as total\n"
                    + "	FROM Orders\n"
                    + "	WHERE MONTH(order_date) = ? and order_status = 'Accept'");
            ps.setInt(1, month);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return total;
    }
}
