/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.Account;
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
public class AccountDAO {
    
    Connection conn;
    
    public AccountDAO() {
        try {
            conn = DB.DBConnection.connect();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public ResultSet getUserName() {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("select username from account");
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }
    
    public Account getAccount(String username) {
        Account account = null;
        
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Account where username=?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                account = new Account(rs.getString("username"), rs.getString("password"), rs.getString("fullname"), rs.getString("address"), rs.getString("sdt"), rs.getInt("role"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return account;
    }
    
    public ResultSet getAllAccount() {
        ResultSet rs = null;
        
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("select * from Account");
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }
    
    public Account addAccount(Account account) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("Insert into Account values(?,?,?,?,?,?)");
            ps.setString(1, account.getUsername());
            ps.setString(2, account.getPassword());
            ps.setString(3, account.getFullname());
            ps.setString(4, account.getSdt());
            ps.setString(5, account.getAddress());
            ps.setInt(6, 1);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count == 0) ? null : account;
    }
    
    public Account update(String username, Account newAcc) {
        int count = 0;
        try {
            
            PreparedStatement ps = conn.prepareStatement("update Account set fullName=?, sdt=?, address=? where username=? ");
            ps.setString(1, newAcc.getFullname());
            ps.setString(2, newAcc.getSdt());
            ps.setString(3, newAcc.getAddress());
            ps.setString(4, username);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count == 0) ? null : newAcc;
    }
}
