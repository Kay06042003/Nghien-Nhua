/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.CartDAO;
import DAOs.OrderDAO;
import DAOs.Orders_detailsDAO;
import DAOs.ProductDAO;
import Models.Order;
import Models.Orders_details;
import com.nimbusds.jose.crypto.impl.AAD;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HIEU
 */
public class OrderController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet OrderController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getRequestURI();
        if (path.endsWith("/OrderController/Cart")) {
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
        } else if (path.endsWith("/OrderController/Order")) {
            request.getRequestDispatcher("/order.jsp").forward(request, response);
        } else if (path.startsWith("/OrderController/Delete/")) {
            String[] s = path.split("/");
            try {
                int pro_id = Integer.parseInt(s[s.length - 2]);
                String username = s[s.length - 1];
                CartDAO cDAO = new CartDAO();
                int test = cDAO.DeleteProductInCart(username, pro_id);
                if (test == 0) {
                    throw new Exception("");
                }
                response.sendRedirect("/OrderController/Cart");
            } catch (Exception ex) {
                response.sendRedirect("/error.jsp");
            }
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = "";
        Cookie[] cList = request.getCookies();
        for (int i = 0; i < cList.length; i++) {
            if (cList[i].getName().equals("login")) {
                username = cList[i].getValue();
                break;
            }
        }
        if (request.getParameter("btnOrder") != null) {
            String name = request.getParameter("txtName");
            String phone = request.getParameter("txtPhone");
            String email = request.getParameter("txtEmail");
            String address = request.getParameter("txtAddress");

            CartDAO cDAO = new CartDAO();
            int total = cDAO.getTotalMoney(username);
            Order order = new Order(1, username, "Waiting Accept", name, total, phone, email, address);
            OrderDAO oDAO = new OrderDAO();
            Order o = oDAO.addOrder(order, username);
            if (o == null) {

            } else {
                int id = oDAO.getOrderID(username);
                Orders_detailsDAO odDAO = new Orders_detailsDAO();
                Orders_details oDetails = null;
                ResultSet rs = cDAO.getProductInCart(username);
                ProductDAO pDAO = new ProductDAO();
                int totalDetail = 0;
                try {
                    while (rs.next()) {
                        totalDetail = 0;
                        totalDetail = rs.getInt("quantity") * rs.getInt("pro_price");
                        oDetails = new Orders_details(1, id, rs.getInt("pro_id"), rs.getInt("pro_price"), rs.getInt("quantity"), totalDetail);
                        Orders_details od = odDAO.addOrderDetails(oDetails);
                        int newQuantity = pDAO.updateQuantityProduct(rs.getInt("quantity"), rs.getInt("pro_id"));
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(OrderController.class.getName()).log(Level.SEVERE, null, ex);
                }
                cDAO.deleteCart(username);
                response.sendRedirect("/");
            }

        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
