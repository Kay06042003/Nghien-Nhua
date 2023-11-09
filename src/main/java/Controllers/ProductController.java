/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.AccountDAO;
import DAOs.KeyboardDAO;
import DAOs.KeycapDAO;
import DAOs.KitDAO;
import DAOs.ProductDAO;
import DAOs.SwitchDAO;
import Models.Account;
import Models.Keyboard;
import Models.Keycap;
import Models.Kit;
import Models.Switch;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Laptop
 */
public class ProductController extends HttpServlet {

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
            out.println("<title>Servlet ProductController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductController at " + request.getContextPath() + "</h1>");
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
        HttpSession session = (HttpSession) request.getSession();
        if (path.endsWith("/ProductController/Kit-ban-phim")) {
            ProductDAO pDAO = new ProductDAO();
            ResultSet rs = pDAO.getProductByCategory(2);
            session.setAttribute("All", rs);
            session.setAttribute("Name", "KIT BÀN PHÍM");
            session.setAttribute("NameLower", "Kit-ban-phim");
            if (rs != null) {
                request.getRequestDispatcher("/product.jsp").forward(request, response);
            }
        } else if (path.endsWith("/ProductController/Keyboard")) {
            ProductDAO pDAO = new ProductDAO();
            ResultSet rs = pDAO.getProductByCategory(1);
            session.setAttribute("All", rs);
            session.setAttribute("Name", "KEYBOARD");
            session.setAttribute("NameLower", "Keyboard");
            if (rs != null) {
                request.getRequestDispatcher("/product.jsp").forward(request, response);
            }
        } else if (path.endsWith("/ProductController/Key-cap")) {
            ProductDAO pDAO = new ProductDAO();
            ResultSet rs = pDAO.getProductByCategory(3);
            session.setAttribute("All", rs);
            session.setAttribute("Name", "KEYCAP");
            session.setAttribute("NameLower", "Key-cap");

            if (rs != null) {
                request.getRequestDispatcher("/product.jsp").forward(request, response);
            }
        } else if (path.endsWith("/ProductController/Switch")) {
            ProductDAO pDAO = new ProductDAO();
            ResultSet rs = pDAO.getProductByCategory(4);
            session.setAttribute("All", rs);
            session.setAttribute("Name", "SWITCH");
            session.setAttribute("NameLower", "Switch");

            if (rs != null) {
                request.getRequestDispatcher("/product.jsp").forward(request, response);
            }
        } else {
            if (path.startsWith("/ProductController/Keyboard/")) {
                String[] s = path.split("/");
                try {
                    String type = s[2];
                    int id = Integer.parseInt(s[s.length - 1]);
                    ProductDAO pDAO = new ProductDAO();
                    Keyboard key = pDAO.getKeyboardDetails(id, 1);
                    if (key == null) {
                        response.sendRedirect("/ProductController/Keyboard");
                    } else {
                        String[] listImage = key.getPro_id().getPro_image().split("&");
                        session.setAttribute("listImage", listImage);
                        session.setAttribute("getProduct", key);
                        session.setAttribute("typeNow", type);
                        session.setAttribute("id_product", id);
                    }
                } catch (Exception e) {
                    response.sendRedirect("/");
                }
                request.getRequestDispatcher("/productDetails.jsp").forward(request, response);
            } else if (path.startsWith("/ProductController/Kit-ban-phim/")) {
                String[] s = path.split("/");
                try {
                    String type = s[2];
                    int id = Integer.parseInt(s[s.length - 1]);
                    ProductDAO pDAO = new ProductDAO();

                    Kit kit = pDAO.getKitDetails(id, 2);

                    if (kit == null) {
                        response.sendRedirect("/ProductController/Kit-ban-phim");
                    } else {
                        String[] listImage = kit.getPro_id().getPro_image().split("&");
                        session.setAttribute("listImage", listImage);
                        session.setAttribute("getProduct", kit);
                        session.setAttribute("typeNow", type);
                        session.setAttribute("id_product", id);
                    }
                } catch (Exception e) {
                    response.sendRedirect("/");
                }
                request.getRequestDispatcher("/productDetails.jsp").forward(request, response);
            } else if (path.startsWith("/ProductController/Key-cap/")) {
                String[] s = path.split("/");
                try {
                    String type = s[2];
                    int id = Integer.parseInt(s[s.length - 1]);
                    ProductDAO pDAO = new ProductDAO();
                    Keycap key = pDAO.getKeycapDetails(id, 3);
                    if (key == null) {
                        response.sendRedirect("/ProductController/Key-cap");
                    } else {
                        String[] listImage = key.getPro_id().getPro_image().split("&");
                        session.setAttribute("listImage", listImage);
                        session.setAttribute("getProduct", key);
                        session.setAttribute("typeNow", type);
                        session.setAttribute("id_product", id);
                    }
                } catch (Exception e) {
                    response.sendRedirect("/");
                }
                request.getRequestDispatcher("/productDetails.jsp").forward(request, response);
            } else if (path.startsWith("/ProductController/Switch/")) {
                String[] s = path.split("/");
                try {
                    String type = s[2];
                    int id = Integer.parseInt(s[s.length - 1]);
                    ProductDAO pDAO = new ProductDAO();
                    Switch swi = pDAO.getSwitchDetails(id, 4);

                    if (swi == null) {
                        response.sendRedirect("/ProductController/Key-cap");
                    } else {
                        String[] listImage = swi.getPro_id().getPro_image().split("&");
                        session.setAttribute("listImage", listImage);
                        session.setAttribute("getProduct", swi);
                        session.setAttribute("typeNow", type);
                        session.setAttribute("id_product", id);
                    }
                } catch (Exception e) {
                    response.sendRedirect("/");
                }
                request.getRequestDispatcher("/productDetails.jsp").forward(request, response);
            } else {
                response.sendRedirect("/");
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
        ProductDAO proDAO = new ProductDAO();
        String path = request.getRequestURI();
        HttpSession session = (HttpSession) request.getSession();
        String[] s = path.split("/");
        int id = (int) session.getAttribute("id_product");
        String type = s[2];
        String username = "";
        Cookie[] cList = request.getCookies();
        for (int i = 0; i < cList.length; i++) {
            if (cList[i].getName().equals("login")) {
                username = cList[i].getValue();
                break;
            }
        }
        if (username.equals("")) {
            session.setAttribute("status", "login");
            response.sendRedirect("/ProductController/" + type + "/" + id);
        } else {
            if (request.getParameter("btnAddCart") != null) {
                if (type.equals("Keyboard")) {
                    int quantity = Integer.parseInt(request.getParameter("txtQuantity"));
                    int pro_quantity = proDAO.getProductQuantity(id);
                    if (quantity > pro_quantity) {
                        session.setAttribute("status", "ErrorAddtoCart");
                        response.sendRedirect("/ProductController/" + type + "/" + id);
                    } else {
                        boolean b = proDAO.addCard(id, quantity, username);
                        if (b) {
                            session.setAttribute("status", "success");
                        } else {
                            session.setAttribute("status", "error");
                        }
                        response.sendRedirect("/ProductController/Keyboard/" + id);
                    }

                } else if (type.equals("Kit-ban-phim")) {
                    int quantity = Integer.parseInt(request.getParameter("txtQuantity"));
                    int pro_quantity = proDAO.getProductQuantity(id);
                    if (quantity > pro_quantity) {
                        session.setAttribute("status", "ErrorAddtoCart");
                        response.sendRedirect("/ProductController/" + type + "/" + id);
                    } else {
                        boolean b = proDAO.addCard(id, quantity, username);
                        if (b) {
                            session.setAttribute("status", "success");
                        } else {
                            session.setAttribute("status", "error");
                        }
                        response.sendRedirect("/ProductController/Kit-ban-phim/" + id);
                    }
                } else if (type.equals("Key-cap")) {
                    int quantity = Integer.parseInt(request.getParameter("txtQuantity"));
                    int pro_quantity = proDAO.getProductQuantity(id);
                    if (quantity > pro_quantity) {
                        session.setAttribute("status", "ErrorAddtoCart");
                        response.sendRedirect("/ProductController/" + type + "/" + id);
                    } else {
                        boolean b = proDAO.addCard(id, quantity, username);
                        if (b) {
                            session.setAttribute("status", "success");
                        } else {
                            session.setAttribute("status", "error");
                        }
                        response.sendRedirect("/ProductController/Key-cap/" + id);
                    }
                } else if (type.equals("Switch")) {
                    int quantity = Integer.parseInt(request.getParameter("txtQuantity"));
                    int pro_quantity = proDAO.getProductQuantity(id);
                    if (quantity > pro_quantity) {
                        session.setAttribute("status", "ErrorAddtoCart");
                        response.sendRedirect("/ProductController/" + type + "/" + id);
                    } else {
                        boolean b = proDAO.addCard(id, quantity, username);
                        if (b) {
                            session.setAttribute("status", "success");
                        } else {
                            session.setAttribute("status", "error");
                        }
                        response.sendRedirect("/ProductController/Switch/" + id);
                    }
                }
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
