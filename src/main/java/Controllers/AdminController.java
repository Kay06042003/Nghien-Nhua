/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.OrderDAO;
import DAOs.ProductDAO;
import Models.Keyboard;
import Models.Keycap;
import Models.Kit;
import Models.Product;
import Models.Switch;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.sql.ResultSet;
import java.util.Collection;

/**
 *
 * @author HIEU
 */
@MultipartConfig
public class AdminController extends HttpServlet {

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
            out.println("<title>Servlet AdminController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminController at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        String path = request.getRequestURI();
        if (path.startsWith("/AdminController/Admin")) {
            request.getRequestDispatcher("/admin.jsp").forward(request, response);
        } else if (path.startsWith("/AdminController/StatisticsDay")) {
            request.getRequestDispatcher("/statisticProductForDay.jsp").forward(request, response);
        } else if (path.startsWith("/AdminController/StatisticsMonth")) {
            request.getRequestDispatcher("/statisticProductForMonth.jsp").forward(request, response);
        } else if (path.startsWith("/AdminController/StatisticsYear")) {
            request.getRequestDispatcher("/statisticProductForYear.jsp").forward(request, response);
        } else if (path.endsWith("/AdminController/Accept-Order")) {
            request.getRequestDispatcher("/order_confirm.jsp").forward(request, response);
        } else if (path.startsWith("/AdminController/Accept/")) {
            String[] s = path.split("/");
            int order_id = Integer.parseInt(s[s.length - 1]);
            OrderDAO orderDAO = new OrderDAO();
            orderDAO.acceptOrder(order_id);
            session.setAttribute("status", "success");
            response.sendRedirect("/AdminController/Accept-Order");
        } else if (path.startsWith("/AdminController/Reject/")) {
            String[] s = path.split("/");
            int order_id = Integer.parseInt(s[s.length - 1]);
            OrderDAO orderDAO = new OrderDAO();
            orderDAO.rejectOrder(order_id);
            session.setAttribute("status", "success");
            response.sendRedirect("/AdminController/Accept-Order");
        } else if (path.endsWith("/AdminController/ListProduct")) {
            request.getRequestDispatcher("/listProduct.jsp").forward(request, response);
        } else if (path.endsWith("/AdminController/Create")) {
            request.getRequestDispatcher("/addProduct.jsp").forward(request, response);
        } else if (path.startsWith("/AdminController/Delete")) {
            String[] s = path.split("/");
            try {
                int id = Integer.parseInt(s[s.length - 1]);
                ProductDAO pDAO = new ProductDAO();
                pDAO.deleteProduct(id);
                response.sendRedirect("/AdminController/Admin");
            } catch (Exception ex) {
                response.sendRedirect("/ErrorController");
            }

        } else if (path.startsWith("/AdminController/Edit")) {
            String[] s = path.split("/");
            try {
                int id = Integer.parseInt(s[s.length - 1]);
                ProductDAO pDAO = new ProductDAO();
                Product pro = pDAO.getProduct(id);
                if (pro == null) {
                    response.sendRedirect("/AdminController/Admin");
                } else {
                    session.setAttribute("pro", pro);
                    switch (pro.getCategory_id()) {
                        case 1:
                            Keyboard keyboard = pDAO.getKeyboardDetails(id, 1);
                            if (keyboard == null) {
                                response.sendRedirect("/AdminController/Admin");
                            } else {
                                session.setAttribute("keyboard", keyboard);
//                                request.getRequestDispatcher("/editProduct.jsp").forward(request, response);
                            }
                            break;
                        case 2:
                            Kit kit = pDAO.getKitDetails(id, 2);
                            if (kit == null) {
                                response.sendRedirect("/AdminController/Admin");
                            } else {
                                session.setAttribute("kit", kit);
//                                request.getRequestDispatcher("/editProduct.jsp").forward(request, response);
                            }
                            break;
                        case 3:
                            Keycap keycap = pDAO.getKeycapDetails(id, 3);
                            if (keycap == null) {
                                response.sendRedirect("/AdminController/Admin");
                            } else {
                                session.setAttribute("keycap", keycap);
                            }
                            break;
                        case 4:
                            Switch switchs = pDAO.getSwitchDetails(id, 4);
                            if (switchs == null) {
                                response.sendRedirect("/AdminController/Admin");
                            } else {
                                session.setAttribute("switch", switchs);
//                                request.getRequestDispatcher("/editProduct.jsp").forward(request, response);
                            }
                            break;
                    }
                }
            } catch (Exception ex) {
                response.sendRedirect("/AdminController/Admin");
            }
            request.getRequestDispatcher("/editProduct.jsp").forward(request, response);

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
        if (request.getParameter("btnAddNew") != null) {
            String uploadPath = "E:\\Nghien_nhua\\Nghien_nhua\\src\\main\\webapp\\Front\\assets\\image\\keyboardPic";
            // upload hinh vao thu muc
            Collection<Part> parts = request.getParts();
            String pic = "";
            for (Part part : parts) {
                String fileName = part.getSubmittedFileName();
                if (fileName != null && !fileName.isEmpty()) {
                    part.write(uploadPath + File.separator + fileName);
                    pic += "/Front/assets/image/keyboardPic/" + fileName + "&";

                } else {
                    fileName = "";
                }
            }
            String name = request.getParameter("txtName");
            int price = Integer.parseInt(request.getParameter("txtPrice"));
            String quantity = request.getParameter("txtQuantity");
            String des = request.getParameter("txtDescription");
            int discount = Integer.parseInt(request.getParameter("txtDiscount"));
            int cate_id = Integer.parseInt(request.getParameter("txtCateName"));
            Product newpro = new Product(0, name, quantity, price, pic, des, discount, cate_id);
            ProductDAO pDAO = new ProductDAO();
            Product pro = pDAO.addNew(newpro);
            if (pro == null) {
                response.sendRedirect("/AdminController/Admin");
            } else {
                switch (cate_id) {
                    case 1:
                        String keyboard_led = request.getParameter("led_keyboard");
                        int keyboard_mode = Integer.parseInt(request.getParameter("mode_keyboard"));
                        String keyboard_switch = request.getParameter("switchType_keyboard");
                        String keyboard_keycap = request.getParameter("keycapType_keyboard");
                        Keyboard newKeyboard = new Keyboard(0, keyboard_led, keyboard_mode, keyboard_switch, keyboard_keycap, pro);
                        Keyboard keyboard = pDAO.addNewKeyBoard(newKeyboard);
                        if (keyboard == null) {
                            response.sendRedirect("/AdminController/Admin");
                            pDAO.deletePro(pDAO.getPro_id());
                        } else {
                            response.sendRedirect("/AdminController/Admin");
                        }
                        break;
                    case 2:
                        String kit_layout = request.getParameter("layout_kit");
                        String kit_circuit = request.getParameter("circuit_kit");
                        String kit_plate = request.getParameter("plate_kit");
                        int kit_mode = Integer.parseInt(request.getParameter("mode_kit"));
                        String kit_case = request.getParameter("case_kit");
                        Kit newKit = new Kit(0, kit_layout, kit_circuit, kit_plate, kit_mode, kit_case, pro);
                        Kit kit = pDAO.addNewKit(newKit);
                        if (kit == null) {
                            response.sendRedirect("/AdminController/Admin");
                            pDAO.deletePro(pDAO.getPro_id());
                        } else {
                            response.sendRedirect("/AdminController/Admin");
                        }
                        break;
                    case 3:
                        String keycap_material = request.getParameter("material_key_cap");
                        String keycap_layout = request.getParameter("layout_keycap");
                        int keycap_thickness = Integer.parseInt(request.getParameter("thickness_keycap"));
                        String keycap_durability = request.getParameter("durability_keycap");
                        Keycap newKeycap = new Keycap(0, keycap_material, keycap_layout, keycap_thickness, keycap_durability, pro);
                        Keycap keycap = pDAO.addNewKeycap(newKeycap);
                        if (keycap == null) {
                            response.sendRedirect("/AdminController/Admin");
                            pDAO.deletePro(pDAO.getPro_id());
                        } else {
                            response.sendRedirect("/AdminController/Admin");
                        }
                        break;
                    case 4:
                        String switch_pin = request.getParameter("pin_switch");
                        String switch_type = request.getParameter("type_switch");
                        String switch_complexity = (request.getParameter("complexity_switch"));
                        String switch_durability = (request.getParameter("durability_switch"));
                        String switch_travel = (request.getParameter("travel_switch"));
                        Switch newSwitch = new Switch(0, switch_pin, switch_type, switch_complexity, switch_durability, switch_travel, pro);
                        Switch switchs = pDAO.addNewSwitch(newSwitch);
                        if (switchs == null) {
                            response.sendRedirect("/AdminController/Admin");
                            pDAO.deletePro(pDAO.getPro_id());
                        } else {
                            response.sendRedirect("/AdminController/Admin");
                        }
                        break;
                }
            }
        }

        if (request.getParameter("btnUpdate") != null) {
            String uploadPath = "E:\\Nghien_nhua\\Nghien_nhua\\src\\main\\webapp\\Front\\assets\\image\\keyboardPic";
            // upload hinh vao thu muc
            Collection<Part> parts = request.getParts();
            String pic = "";
            for (Part part : parts) {
                String fileName = part.getSubmittedFileName();
                if (fileName != null) {
                    if (fileName.endsWith(".jpg") || fileName.endsWith(".png")) {
                        part.write(uploadPath + File.separator + fileName);
                        pic += "/Front/assets/image/keyboardPic/" + fileName + "&";
                    }
                } else {
                    fileName = "";
                }
            }

            if (pic.equals("")) {
                pic = request.getParameter("txtPicture2");
            }
            int pro_id = Integer.parseInt(request.getParameter("hiddenID"));
            String name = request.getParameter("txtName");
            int price = Integer.parseInt(request.getParameter("txtPrice"));
            String quantity = request.getParameter("txtQuantity");
            String des = request.getParameter("txtDescription");
            int discount = Integer.parseInt(request.getParameter("txtDiscount"));
            int cate_id = Integer.parseInt(request.getParameter("hiddenSelect"));
            Product newpro = new Product(0, name, quantity, price, pic, des, discount, cate_id);
            ProductDAO pDAO = new ProductDAO();
            Product rs = pDAO.update(pro_id, cate_id, newpro);
            if (rs == null) {
                Product oldInfo = pDAO.getProduct(pro_id);
                HttpSession session = request.getSession();
                session.setAttribute("pro", oldInfo);
                response.sendRedirect("/ProductController/Edit/" + pro_id);
            } else {
                switch (cate_id) {
                    case 1:
                        String keyboard_led = request.getParameter("led_keyboard");
                        int keyboard_mode = Integer.parseInt(request.getParameter("mode_keyboard"));
                        String keyboard_switch = request.getParameter("switchType_keyboard");
                        String keyboard_keycap = request.getParameter("keycapType_keyboard");
                        Keyboard newKeyboard = new Keyboard(0, keyboard_led, keyboard_mode, keyboard_switch, keyboard_keycap, rs);
                        Keyboard keyboard = pDAO.updateKeyboard(pro_id, newKeyboard);
                        if (keyboard == null) {
                            Keyboard oldInfoKeyboard = pDAO.getKeyboardDetails(pro_id, 1);
                            HttpSession session = request.getSession();
                            session.setAttribute("keyboard", oldInfoKeyboard);
                            response.sendRedirect("/ProductController/Edit/" + pro_id);

                        } else {
                            response.sendRedirect("/AdminController/Admin");
                        }
                        break;
                    case 2:
                        String kit_layout = request.getParameter("layout_kit");
                        String kit_circuit = request.getParameter("circuit_kit");
                        String kit_plate = request.getParameter("plate_kit");
                        int kit_mode = Integer.parseInt(request.getParameter("mode_kit"));
                        String kit_case = request.getParameter("case_kit");
                        Kit newKit = new Kit(0, kit_layout, kit_circuit, kit_plate, kit_mode, kit_case, rs);
                        Kit kit = pDAO.updateKit(pro_id, newKit);
                        if (kit == null) {
                            Kit oldInfoKit = pDAO.getKitDetails(pro_id, 2);
                            HttpSession session = request.getSession();
                            session.setAttribute("kit", oldInfoKit);
                            response.sendRedirect("/ProductController/Edit/" + pro_id);
                        } else {
                            response.sendRedirect("/AdminController/Admin");
                        }
                        break;
                    case 3:
                        String keycap_material = request.getParameter("material_key_cap");
                        String keycap_layout = request.getParameter("layout_keycap");
                        int keycap_thickness = Integer.parseInt(request.getParameter("thickness_keycap"));
                        String keycap_durability = request.getParameter("durability_keycap");
                        Keycap newKeycap = new Keycap(0, keycap_material, keycap_layout, keycap_thickness, keycap_durability, rs);
                        Keycap keycap = pDAO.updateKeycap(pro_id, newKeycap);
                        if (keycap == null) {
                            Keycap oldInfoKeycap = pDAO.getKeycapDetails(pro_id, 3);
                            HttpSession session = request.getSession();
                            session.setAttribute("keycap", oldInfoKeycap);
                            response.sendRedirect("/ProductController/Edit/" + pro_id);
                        } else {
                            response.sendRedirect("/AdminController/Admin");
                        }
                        break;
                    case 4:
                        String switch_pin = request.getParameter("pin_switch");
                        String switch_type = request.getParameter("type_switch");
                        String switch_complexity = (request.getParameter("complexity_switch"));
                        String switch_durability = (request.getParameter("durability_switch"));
                        String switch_travel = (request.getParameter("travel_switch"));
                        Switch newSwitch = new Switch(0, switch_pin, switch_type, switch_complexity, switch_durability, switch_travel, rs);
                        Switch switchs = pDAO.updateSwitch(pro_id, newSwitch);
                        if (switchs == null) {
                            Switch oldInfoSwitch = pDAO.getSwitchDetails(pro_id, 4);
                            HttpSession session = request.getSession();
                            session.setAttribute("keycap", oldInfoSwitch);
                            response.sendRedirect("/ProductController/Edit/" + pro_id);
                        } else {
                            response.sendRedirect("/AdminController/Admin");
                        }
                        break;
                }
            }
        }

        if (request.getParameter("btnSubmitForDay") != null) {
            String date = request.getParameter("dates");
            ProductDAO cDaos = new ProductDAO();
            ResultSet rs = cDaos.getProductToStatics(date);
            HttpSession session = request.getSession();
            session.setAttribute("Result", rs);
            response.sendRedirect("/AdminController/StatisticsDay");
        }

        if (request.getParameter("btnSubmitForMoth") != null) {
            String month = request.getParameter("month");
            ProductDAO cDaos = new ProductDAO();
            ResultSet rs = cDaos.getProductToStaticsForMonth(month);
            HttpSession session = request.getSession();
            session.setAttribute("ResultMonth", rs);
            response.sendRedirect("/AdminController/StatisticsMonth");
        }

        if (request.getParameter("btnSubmitForYear") != null) {
            String year = request.getParameter("year");
            ProductDAO cDaos = new ProductDAO();
            ResultSet rs = cDaos.getProductToStaticsForYear(year);
            HttpSession session = request.getSession();
            session.setAttribute("ResultYear", rs);
            response.sendRedirect("/AdminController/StatisticsYear");
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
