/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import DAOs.ProductDAO;
import Models.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author HIEU
 */
public class LiveSearch extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");
        String txtSearch = request.getParameter("txt");
        ProductDAO pro = new ProductDAO();
        List<Product> list = pro.getProductSearch(txtSearch);
        PrintWriter out = response.getWriter();
        for (Product product : list) {
            String[] imgStrings = product.getPro_image().split("&");
            String type = "";
            int category_id = product.getCategory_id();
            switch (category_id) {
                case 1:
                    type = "Keyboard";
                    break;
                case 2:
                    type = "Kit-ban-phim";
                    break;
                case 3:
                    type = "Key-cap";
                    break;
                case 4:
                    type = "Switch";
                    break;
            }
            out.println("<a href=\"/ProductController/" + type + "/" + product.getPro_id() + "\" class='text-decoration-none text-dark'>\n"
                    + "                                                        <div class=\"row\" style=\"width: 100%; height: auto; font-size: 14px\">\n"
                    + "                                                            <div class='col-md-3 '>\n"
                    + "                                                                <img style=\"width: 100%\" src=\"" + imgStrings[0] + "\" alt=\"alt\"/>\n"
                    + "                                                            </div>\n"
                    + "                                                            <div class='col-md-7'>\n"
                    + "                                                                <p class=\"d-block\" style=\"word-wrap: break-word;\"> " + product.getPro_name() + "</p>\n"
                    + "                                                            </div>\n"
                    + "                                                            <div class='col-md-2'>\n"
                    + "                                                                <p style=\"font-size: 12px\">" + product.getPro_price() + "</p>\n"
                    + "                                                            </div>\n"
                    + "                                                            <div style=\"width: 100%; height: 1px\" class=\"vr bg-secondary\"></div>\n"
                    + "                                                        </div>\n"
                    + "                                                    </a>");
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
        processRequest(request, response);
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
        processRequest(request, response);
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
