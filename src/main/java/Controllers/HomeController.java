/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.AccountDAO;
import DAOs.KeyboardDAO;
import Models.Account;
import Models.Keyboard;
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
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Laptop
 */
public class HomeController extends HttpServlet {

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
            out.println("<title>Servlet HomeController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeController at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        if (path.endsWith("/HomeController/Login")) {
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } else if (path.endsWith("/HomeController/Signup")) {
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
        } else if (path.endsWith("/HomeController/User")) {
            request.getRequestDispatcher("/user.jsp").forward(request, response);
        } else if (path.endsWith("/HomeController/Logout")) {
            Cookie[] cList = null;
            cList = request.getCookies();
            for (int i = 0; i < cList.length; i++) {
                if (cList[i].getName().equals("login")) {
                    cList[i].setPath("/");
                    cList[i].setMaxAge(0);
                    response.addCookie(cList[i]);
                    break;
                }
            }
            session.setAttribute("account", null);
            response.sendRedirect("/ProductController/Keyboard");
        } else if (path.endsWith("/HomeController/User/Edit")) {
            Cookie[] cookie = null;
            cookie = request.getCookies();
            String username = "";
            for (int i = 0; i < cookie.length; i++) {
                if (cookie[i].getName().equals("login")) {
                    username = cookie[i].getValue();
                    break;
                }
            }
            AccountDAO accDAO = new AccountDAO();
            Account acc = accDAO.getAccount(username);
            session.setAttribute("acc", acc);
            request.getRequestDispatcher("/edit.jsp").forward(request, response);
        } else if (path.endsWith("/HomeController/Order-List")) {
            request.getRequestDispatcher("/order_list.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/error.jsp").forward(request, response);
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
        AccountDAO aDAO = new AccountDAO();
        HttpSession session = request.getSession();

        if (request.getParameter("btnLogin") != null) {
            String username = request.getParameter("username");
            String password = request.getAttribute("password").toString();
            session.removeAttribute("ErrorPW"); // xoa session khi nguoi dung nhap lai user and pw
            session.removeAttribute("errorUser");

            ArrayList<String> userNameList = new ArrayList<>();
            ResultSet rs = aDAO.getUserName();

            try {
                while (rs.next()) {
                    userNameList.add(rs.getString("username"));
                }
            } catch (SQLException ex) {
                Logger.getLogger(ProductController.class.getName()).log(Level.SEVERE, null, ex);
            }

            boolean flag = userNameList.contains(username);

            if (flag) {
                Account account = aDAO.getAccount(username);

                if (account.getPassword().equalsIgnoreCase(password)) {
                    // tao va add cookie
                    Cookie cookie = new Cookie("login", username);
                    cookie.setMaxAge(3 * 24 * 60 * 60);
                    cookie.setPath("/");
                    response.addCookie(cookie);
                    // tao session

                    session.setAttribute("account", account);
                    response.sendRedirect("/");
                } else {
                    session.setAttribute("ErrorPW", "Sai mat khau!");
                    response.sendRedirect("/HomeController/Login");
                }
            } else {
                session.setAttribute("errorUser", "Sai tai khoan!");
                response.sendRedirect("/HomeController/Login");
            }
        }

        if (request.getParameter("btnSignUP") != null) {
            String username = request.getParameter("username");
            String password = request.getAttribute("password").toString();
            String fulName = request.getParameter("fullName");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");

            ArrayList<String> listUser = new ArrayList<>();
            ResultSet rs = aDAO.getUserName();
            try {
                while (rs.next()) {
                    listUser.add(rs.getString("username"));
                }
            } catch (SQLException ex) {
                Logger.getLogger(HomeController.class.getName()).log(Level.SEVERE, null, ex);
            }

            boolean flag = false;

            for (String string : listUser) {
                if (string.equalsIgnoreCase(username)) {
                    flag = true;
                }
            }
            if (flag) {
                session.setAttribute("status", "ErrorLogin");
                response.sendRedirect("/HomeController/Signup");
            } else {
                Account account = new Account(username, password, fulName, address, phone);
                Account acc = aDAO.addAccount(account);
                if (acc == null) {
                    session.setAttribute("status", "error");
                    response.sendRedirect("/HomeController/Signup");
                } else {
                    session.setAttribute("status", "success");
                    response.sendRedirect("/HomeController/Signup");
                }
            }
        }

        if (request.getParameter("btnUpdate") != null) {
            String username = request.getParameter("txtUsername");
            String fulName = request.getParameter("fullName");
            String address = request.getParameter("txtAdd");
            String phone = request.getParameter("phone");
            AccountDAO cDao = new AccountDAO();
            Account newAcc = new Account(username, "a", fulName, address, phone);
            Account rs = cDao.update(username, newAcc);
            if (rs == null) {//them that bai
                Account thongtincu = cDao.getAccount(username);
                session.setAttribute("account", thongtincu);
                response.sendRedirect("/HomeController/User/Edit");
            } else {
                session.setAttribute("account", newAcc);
                response.sendRedirect("/HomeController/User");
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
