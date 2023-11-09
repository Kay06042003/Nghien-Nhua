/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.Keyboard;
import Models.Keycap;
import Models.Kit;
import Models.Product;
import Models.Switch;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HIEU
 */
public class ProductDAO {

    Connection conn;

    public ProductDAO() {
        try {
            conn = DB.DBConnection.connect();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ResultSet getAllProduct() {
        ResultSet rs = null;

        Statement st;
        try {
            st = conn.createStatement();
            rs = st.executeQuery("select * from Product join Keyboard on Product.pro_id = Keyboard.pro_id");
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public ResultSet getAll() {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("select * from product join category on product.category_id = category.product_id");
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public ResultSet getProductByCategory(int category_id) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from getProduct(?)");
            ps.setInt(1, category_id);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public Keycap getKeycapDetails(int pro_id, int category_id) {
        ResultSet rs = null;
        Keycap key = null;
        Product pro = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Product p join Keycap k on p.pro_id = k.pro_id where p.pro_id=?");
            ps.setInt(1, pro_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                pro = new Product(rs.getInt("pro_id"), rs.getString("pro_name"), rs.getString("pro_quantity"), rs.getInt("pro_price"), rs.getString("pro_image"), rs.getString("pro_discription"), rs.getInt("pro_discount"), rs.getInt("category_id"));
                key = new Keycap(rs.getInt("id"), rs.getString("chatlieu"), rs.getString("layout"), rs.getInt("doday"), rs.getString("doben"), pro);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return key;
    }

    public ResultSet getSimilarProduct(int category_id, int pro_id) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from  dbo.getProduct(?) where pro_id != ?");
            ps.setInt(1, category_id);
            ps.setInt(2, pro_id);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public Keyboard getKeyboardDetails(int pro_id, int category_id) {
        ResultSet rs = null;
        Keyboard key = null;
        Product pro = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Product p join Keyboard k on p.pro_id = k.pro_id where p.pro_id=?");
            ps.setInt(1, pro_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                pro = new Product(rs.getInt("pro_id"), rs.getString("pro_name"), rs.getString("pro_quantity"), rs.getInt("pro_price"), rs.getString("pro_image"), rs.getString("pro_discription"), rs.getInt("pro_discount"), rs.getInt("category_id"));
                key = new Keyboard(rs.getInt("id"), rs.getString("led"), rs.getInt("mode"), rs.getString("switch"), rs.getString("keycap"), pro);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return key;
    }

    public Kit getKitDetails(int pro_id, int category_id) {
        ResultSet rs = null;
        Kit kit = null;
        Product pro = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Product p join Kit k on p.pro_id = k.pro_id where p.pro_id=?");
            ps.setInt(1, pro_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                pro = new Product(rs.getInt("pro_id"), rs.getString("pro_name"), rs.getString("pro_quantity"), rs.getInt("pro_price"), rs.getString("pro_image"), rs.getString("pro_discription"), rs.getInt("pro_discount"), rs.getInt("category_id"));
                kit = new Kit(rs.getInt("id"), rs.getString("layout"), rs.getString("mach"), rs.getString("plate"), rs.getInt("mode"), rs.getString("case"), pro);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return kit;
    }

    public Switch getSwitchDetails(int pro_id, int category_id) {
        ResultSet rs = null;
        Switch swi = null;
        Product pro = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Product p join Switch k on p.pro_id = k.pro_id where p.pro_id=?");
            ps.setInt(1, pro_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                pro = new Product(rs.getInt("pro_id"), rs.getString("pro_name"), rs.getString("pro_quantity"), rs.getInt("pro_price"), rs.getString("pro_image"), rs.getString("pro_discription"), rs.getInt("pro_discount"), rs.getInt("category_id"));
                swi = new Switch(rs.getInt("id"), rs.getString("pin"), rs.getString("type"), rs.getString("lo_xo"), rs.getString("do_ben"), rs.getString("hanh_trinh"), pro);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return swi;
    }

    public boolean addCard(int id, int quantity, String username) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("Insert into Cart values(?,?,?)");
            ps.setString(1, username);
            ps.setInt(2, id);
            ps.setInt(3, quantity);
            count = ps.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count != 0);
    }

    public int updateQuantityProduct(int quantity, int pro_id) {
        int count = 0;

        try {
            PreparedStatement ps = conn.prepareStatement("UPDATE product SET pro_quantity = pro_quantity - ? WHERE pro_id = ?");
            ps.setInt(1, quantity);
            ps.setInt(2, pro_id);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return count;
    }

    public int getProductQuantity(int pro_id) {
        int quantity = 0;
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("Select * from Product where pro_id = ?");
            ps.setInt(1, pro_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                quantity = rs.getInt("pro_quantity");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return quantity;
    }

    public ResultSet getProductByID(int product_id) {
        ResultSet rs = null;
        ResultSet main = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from product where pro_id=?");
            ps.setInt(1, product_id);
            rs = ps.executeQuery();
            if (rs.next()) {
                main = rs;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return main;
    }

    public Product getProduct(int pro_id) {
        Product pro = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from product where pro_id= ?");
            ps.setInt(1, pro_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                pro = new Product(rs.getInt("pro_id"), rs.getString("pro_name"), rs.getString("pro_quantity"), rs.getInt("pro_price"), rs.getString("pro_image"), rs.getString("pro_discription"), rs.getInt("pro_discount"), rs.getInt("category_id"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return pro;
    }

    public List<Product> getProductSearch(String pro_name) {
        List<Product> list = new ArrayList<>();
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Product where pro_name like ?");
            ps.setString(1, "%" + pro_name + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                Product pro = new Product();
                pro.setPro_id(rs.getInt("pro_id"));
                pro.setPro_name(rs.getString("pro_name"));
                pro.setPro_quantity(rs.getString("pro_quantity"));
                pro.setPro_price(rs.getInt("pro_price"));
                pro.setPro_image(rs.getString("pro_image"));
                pro.setPro_discription(rs.getString("pro_discription"));
                pro.setPro_discount(rs.getInt("pro_discount"));
                pro.setCategory_id(rs.getInt("category_id"));
                list.add(pro);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public void deleteProduct(int pro_id) {
        try {
            PreparedStatement ps = conn.prepareStatement("update product set pro_quantity = 0 where pro_id =?");
            ps.setInt(1, pro_id);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Product addNew(Product newPro) {
        int count = 0;
        ResultSet rs = null;
        java.util.Date dateToInsert = new java.util.Date();
        Date sqlDate = new Date(dateToInsert.getTime());
        try {
            PreparedStatement ps = conn.prepareStatement("Insert into product values(?,?,?,?,?,?,?,?)");
            ps.setString(1, newPro.getPro_name());
            ps.setString(2, newPro.getPro_quantity());
            ps.setInt(3, newPro.getPro_price());
            ps.setString(4, newPro.getPro_image());
            ps.setString(5, newPro.getPro_discription());
            ps.setInt(6, newPro.getPro_discount());
            ps.setDate(7, sqlDate);
            ps.setInt(8, newPro.getCategory_id());
            count = ps.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count == 0) ? null : newPro;
    }

    public Keyboard addNewKeyBoard(Keyboard newKeyboard) {
        int count = 0;
        ResultSet rs = null;
        int pro_id = getPro_id();
        try {
            PreparedStatement ps = conn.prepareStatement("Insert into Keyboard values(?,?,?,?,?)");
            ps.setString(1, newKeyboard.getLed());
            ps.setInt(2, newKeyboard.getMode());
            ps.setString(3, newKeyboard.getSwitch());
            ps.setString(4, newKeyboard.getKeycap());
            ps.setInt(5, pro_id);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count == 0) ? null : newKeyboard;
    }

    public Kit addNewKit(Kit newKit) {
        int count = 0;
        ResultSet rs = null;
        int pro_id = getPro_id();
        try {
            PreparedStatement ps = conn.prepareStatement("Insert into Kit values(?,?,?,?,?,?)");
            ps.setString(1, newKit.getLayout());
            ps.setString(2, newKit.getMach());
            ps.setString(3, newKit.getPlate());
            ps.setInt(4, newKit.getMode());
            ps.setString(5, newKit.getCase());
            ps.setInt(6, pro_id);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count == 0) ? null : newKit;
    }

    public Keycap addNewKeycap(Keycap newKeycap) {
        int count = 0;
        ResultSet rs = null;
        int pro_id = getPro_id();
        try {
            PreparedStatement ps = conn.prepareStatement("Insert into Keycap values(?,?,?,?,?)");
            ps.setString(1, newKeycap.getChatLieu());
            ps.setString(2, newKeycap.getLayOut());
            ps.setInt(3, newKeycap.getDoDay());
            ps.setString(4, newKeycap.getDoBen());
            ps.setInt(5, pro_id);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count == 0) ? null : newKeycap;
    }

    public Switch addNewSwitch(Switch newSwitch) {
        int count = 0;
        ResultSet rs = null;
        int pro_id = getPro_id();
        try {
            PreparedStatement ps = conn.prepareStatement("Insert into Switch values(?,?,?,?,?,?)");
            ps.setString(1, newSwitch.getPin());
            ps.setString(2, newSwitch.getType());
            ps.setString(3, newSwitch.getLoxo());
            ps.setString(4, newSwitch.getDoBen());
            ps.setString(5, newSwitch.getHanhTrinh());
            ps.setInt(6, pro_id);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count == 0) ? null : newSwitch;
    }

    public int getPro_id() {
        ResultSet rs = null;
        int pro_id = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT top 1 pro_id FROM Product ORDER BY pro_id DESC");
            rs = ps.executeQuery();
            if (rs.next()) {
                pro_id = rs.getInt("pro_id");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return pro_id;
    }

    public void deletePro(int pro_id) {
        try {
            PreparedStatement ps = conn.prepareStatement("delete from product where pro_id =?");
            ps.setInt(1, pro_id);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ResultSet getProductToStatics(String str) {
        ResultSet rs = null;
        try {
            Date date = Date.valueOf(str);
            PreparedStatement ps = conn.prepareStatement("select  o.username, o.order_name, p.pro_name, od.quantity, od.totalMoney, o.order_date  from Orders_details od  join Product p\n"
                    + "on od.pro_id = p.pro_id join Orders o\n"
                    + "on o.id = od.order_id\n"
                    + "where (o.order_date) = ? and o.order_status = 'Accept'");
            ps.setDate(1, date);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return rs;
    }

    public ResultSet getProductToStaticsForMonth(String str) {
        ResultSet rs = null;
        try {
            int month = Integer.parseInt(str);

            PreparedStatement ps = conn.prepareStatement("select  o.username, o.order_name, p.pro_name, od.quantity, od.totalMoney, o.order_date  from Orders_details od  join Product p\n"
                    + "on od.pro_id = p.pro_id join Orders o\n"
                    + "on o.id = od.order_id\n"
                    + "where month(o.order_date) = ? and o.order_status = 'Accept'");
            ps.setInt(1, month);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return rs;
    }

    public ResultSet getProductToStaticsForYear(String str) {
        ResultSet rs = null;
        try {
            int month = Integer.parseInt(str);

            PreparedStatement ps = conn.prepareStatement("select  o.username, o.order_name, p.pro_name, od.quantity, od.totalMoney, o.order_date  from Orders_details od  join Product p\n"
                    + "on od.pro_id = p.pro_id join Orders o\n"
                    + "on o.id = od.order_id\n"
                    + "where year(o.order_date) = ? and o.order_status = 'Accept'");
            ps.setInt(1, month);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return rs;
    }

    public ResultSet getProductBestSeller() {
        ResultSet rs = null;

        Statement st;
        try {
            st = conn.createStatement();
            rs = st.executeQuery("select  distinct top 8 (od.pro_id), p.pro_name,p.pro_image, p.pro_price,p.pro_quantity,p.pro_discount,p.category_id,sum(od.quantity) as \"So luong ban ra\" from \n"
                    + "Orders_details od join Product p\n"
                    + "on od.pro_id = p.pro_id\n"
                    + "group by (od.pro_id), p.pro_name,p.pro_image, p.pro_price,p.pro_quantity,p.pro_discount,p.category_id\n"
                    + "order by sum(od.quantity) desc");
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public ResultSet getNewProduct() {
        ResultSet rs = null;

        Statement st;
        try {
            st = conn.createStatement();
            rs = st.executeQuery("select top 8 * from Product order by pro_id desc");
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public ResultSet get2NewProduct() {
        ResultSet rs = null;

        Statement st;
        try {
            st = conn.createStatement();
            rs = st.executeQuery("select top 2 * from Product order by pro_id desc");
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public Product update(int pro_id, int cate_id, Product newinfo) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("update product set pro_name=?, pro_quantity=?, pro_price=?, pro_image=?, pro_discription=?, pro_discount=?, category_id=? where pro_id=?");
            ps.setString(1, newinfo.getPro_name());
            ps.setString(2, newinfo.getPro_quantity());
            ps.setInt(3, newinfo.getPro_price());
            ps.setString(4, newinfo.getPro_image());
            ps.setString(5, newinfo.getPro_discription());
            ps.setInt(6, newinfo.getPro_discount());
            ps.setInt(7, cate_id);
            ps.setInt(8, pro_id);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count == 0) ? null : newinfo;
    }

    public Keyboard updateKeyboard(int pro_id, Keyboard newinfoKeyboard) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("update keyboard set led=?, mode=?, switch=?, keycap=? where pro_id=?");
            ps.setString(1, newinfoKeyboard.getLed());
            ps.setInt(2, newinfoKeyboard.getMode());
            ps.setString(3, newinfoKeyboard.getSwitch());
            ps.setString(4, newinfoKeyboard.getKeycap());
            ps.setInt(5, pro_id);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count == 0) ? null : newinfoKeyboard;
    }

    public Kit updateKit(int pro_id, Kit newinfoKit) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("update kit set layout=?, mach=?, plate=?, mode=?, [case]=? where pro_id=?");
            ps.setString(1, newinfoKit.getLayout());
            ps.setString(2, newinfoKit.getMach());
            ps.setString(3, newinfoKit.getPlate());
            ps.setInt(4, newinfoKit.getMode());
            ps.setString(5, newinfoKit.getCase());
            ps.setInt(6, pro_id);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count == 0) ? null : newinfoKit;
    }

    public Switch updateSwitch(int pro_id, Switch newinfoSwitch) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("update switch set pin=?, type=?, lo_xo=?, do_ben=?, hanh_trinh=? where pro_id=?");
            ps.setString(1, newinfoSwitch.getPin());
            ps.setString(2, newinfoSwitch.getType());
            ps.setString(3, newinfoSwitch.getLoxo());
            ps.setString(4, newinfoSwitch.getDoBen());
            ps.setString(5, newinfoSwitch.getHanhTrinh());
            ps.setInt(6, pro_id);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count == 0) ? null : newinfoSwitch;
    }

    public Keycap updateKeycap(int pro_id, Keycap newinfoKeycap) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("update keycap set chatlieu=?, layout=?, doday=?, doben=? where pro_id=?");
            ps.setString(1, newinfoKeycap.getChatLieu());
            ps.setString(2, newinfoKeycap.getLayOut());
            ps.setInt(3, newinfoKeycap.getDoDay());
            ps.setString(4, newinfoKeycap.getDoBen());
            ps.setInt(5, pro_id);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count == 0) ? null : newinfoKeycap;
    }

}
