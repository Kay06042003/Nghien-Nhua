<%-- 
    Document   : cart
    Created on : Oct 30, 2023, 8:19:41 PM
    Author     : HIEU
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="DAOs.ProductDAO"%>
<%@page import="DAOs.OrderDAO"%>
<%@page import="DAOs.KeyboardDAO"%>
<%@page import="Models.Account"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.CartDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <script src="https://kit.fontawesome.com/ae360af17e.js" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">

        <title>Nghien Nhua</title>
        <link rel="shortcut icon" href="/Front/assets/image/logo/z4705695345706_20ca59964f9ad379fcebb44ceaad6cd4-removebg-preview.png"/>

        <style>
            <%@include file="/Front/assets/css/adminCss.css" %>
            <%@include file="/Front/assets/css/stylePayment.css" %>
            <%@include file="/Front/assets/css/notificationCss.css" %>
            .buttonPayment {
                width: 100%;
                height: 40px;
                background-color: var(--wp--preset--color--luminous-vivid-orangeRed);
                text-align: center;
                border: none;
                font-weight: bold;
                color: var(--wp--preset--color--white);
                padding-top: unset;
            }


        </style>
    </head>
    <body>
        <ul class="notifications"></ul>
        <div class="wrapper" style="position: relative; z-index: 100">
            <!-- Sidebar -->
            <aside id="sidebar">
                <div class="h-100">
                    <div class="sidebar-logo">
                        <a href="#">Nghiện Chúa</a>
                    </div>
                    <!-- Sidebar Navigation -->
                    <ul class="sidebar-nav">
                        <li class="sidebar-item">
                            <a href="/AdminController/Admin" class="sidebar-link">
                                <i class="fa-solid fa-list pe-2"></i>
                                DashBoard
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a href="#" class="sidebar-link collapsed" data-bs-toggle="collapse" data-bs-target="#pages"
                               aria-expanded="false" aria-controls="pages">
                                <i class="fa-regular fa-file-lines pe-2"></i>
                                Đơn Hàng
                            </a>
                            <ul id="pages" class="sidebar-dropdown list-unstyled collapse" data-bs-parent="#sidebar">
                                <li class="sidebar-item">
                                    <a href="/AdminController/Accept-Order" class="sidebar-link">Duyệt Đơn Hàng</a>
                                </li>
                                <li class="sidebar-item">
                                    <a href="/AdminController/Create" class="sidebar-link">Thêm sản phẩm</a>
                                </li>
                            </ul>
                        </li>
                        <li class="sidebar-item">
                            <a href="#" class="sidebar-link collapsed" data-bs-toggle="collapse" data-bs-target="#dashboard"
                               aria-expanded="false" aria-controls="dashboard">
                                <i class="fa-solid fa-sliders pe-2"></i>
                                Thống kê
                            </a>
                            <ul id="dashboard" class="sidebar-dropdown list-unstyled collapse" data-bs-parent="#sidebar">
                                <li class="sidebar-item">
                                    <a href="/AdminController/StatisticsDay" class="sidebar-link">Thống Kê Theo Ngày</a>
                                </li>
                                <li class="sidebar-item">
                                    <a href="/AdminController/StatisticsMonth" class="sidebar-link">Thống Kê Theo Tháng</a>
                                </li>
                                <li class="sidebar-item">
                                    <a href="/AdminController/StatisticsYear" class="sidebar-link">Thống Kê Theo Năm</a>
                                </li>
                            </ul>
                        </li>
                        <li class="sidebar-item">
                            <a href="#" class="sidebar-link collapsed" data-bs-toggle="collapse" data-bs-target="#auth"
                               aria-expanded="false" aria-controls="auth">
                                <i class="fa-regular fa-user pe-2"></i>
                                Setting
                            </a>
                            <ul id="auth" class="sidebar-dropdown list-unstyled collapse" data-bs-parent="#sidebar">
                                <li class="sidebar-item">
                                    <a href="/" class="sidebar-link">Trang mua hàng</a>
                                </li>
                                <li class="sidebar-item">
                                    <a href="/HomeController/Logout" class="sidebar-link">Logout</a>
                                </li>
                            </ul>
                        </li>

                </div>
            </aside>
            <!-- Main Component -->
            <div class="main">
                <nav class="navbar navbar-expand px-3">
                    <!-- Button for sidebar toggle -->
                    <button class="btn" type="button" data-bs-theme="dark">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                </nav>
                <main class="content">
                    <div class="container-fluid bg-light" style="border-radius: 10px">
                        <div class="main" style=" width: 100%; height: auto; padding-bottom: 50px; border-radius: 10px">
                            <div class="text-center pt-2">
                                <h2>Thông tin đơn hàng</h2>
                            </div>

                            <%
                                OrderDAO orderDAO = new OrderDAO();
                                KeyboardDAO kDAO = new KeyboardDAO();
                                ProductDAO proDAO = new ProductDAO();
                                int total_price = 0;
                                String name = "";
                                String sdt = "";
                                String email = "";
                                String address = "";
                                int pro_id = 0;
                                int price = 0;
                                int quantity = 0;
                                ArrayList<Integer> arr = new ArrayList<Integer>();
                                ResultSet rs_id = orderDAO.getAllOrderWithStatus("Waiting Accept");
                                while (rs_id.next()) {
                                    if (!arr.contains(rs_id.getInt("id"))) {
                                        arr.add(rs_id.getInt("id"));
                                    }
                                }
                                if (!arr.isEmpty()) {

                                    for (int i = 0; i < arr.size(); i++) {
                                        total_price = 0;
                                        ResultSet rs_info = orderDAO.getAllOrderWithID(arr.get(i));
                                        while (rs_info.next()) {
                                            name = rs_info.getString("order_name");
                                            sdt = rs_info.getString("order_phone");
                                            email = rs_info.getString("order_email");
                                            address = rs_info.getString("order_address");
                                            pro_id = rs_info.getInt("pro_id");

                                        }
                            %>
                            <div class="container" style=" height: auto;">
                                <form action="OrderController" method="post">
                                    <div class="row">
                                        <div class="col-md-7 left" style="border: none;">
                                            <div class="container information">
                                                <h3 class="text-dark">THÔNG TIN THANH TOÁN</h3>

                                                <div class="nameUser row">
                                                    <label class="form-label " for="name">Tên</label>
                                                    <input readonly="" type="text" class="form-control-sm name" id="name" value="<%=name%>" name="txtName">
                                                </div>

                                                <div class="PhoneUser row">
                                                    <label class="form-label" for="phone">Số điện thoại</label>
                                                    <input readonly="" type="text" class="form-control-sm" id="phone" value="<%=sdt%>" name="txtPhone">
                                                </div>
                                                <div class="mailUser row">
                                                    <label class="form-label" for="mail">Địa chỉ email</label>
                                                    <input readonly="" type="text" class="form-control-sm" id="mail"value="<%=email%>" name="txtEmail">
                                                </div>

                                                <div class="nationalUser row">
                                                    <label class="form-label" for="name">Quốc gia/Khu vực</label>
                                                    <spanViệt>Việt Nam</span>
                                                </div>
                                                <div class="addressUser row">
                                                    <label class="form-label" for="address">Địa chỉ</label>
                                                    <input  readonly="" type="text" class="form-control-sm" id="address" value="<%=address%>"name="txtAddress"
                                                            >
                                                </div>
                                            </div>

                                        </div>

                                        <div class="col-md-5 right">
                                            <div class="container paySlide">
                                                <h3> ĐƠN HÀNG CỦA BẠN</h3>
                                                <table class="table totalTable">
                                                    <thead>
                                                        <tr class="amoutTable">
                                                            <th class="sp">
                                                                SẢN PHẨM
                                                            </th>
                                                            <th class="tamTinh">
                                                                TẠM TÍNH
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody class="productShow">
                                                        <%                                            KeyboardDAO keyDAO = new KeyboardDAO();
                                                            ResultSet rs_infoProduct = orderDAO.getAllOrderWithID(arr.get(i));

                                                            while (rs_infoProduct.next()) {
                                                                price = rs_infoProduct.getInt("price");
                                                                quantity = rs_infoProduct.getInt("quantity");
                                                                pro_id = rs_infoProduct.getInt("pro_id");
                                                                ResultSet rs_Product = proDAO.getProductByID(pro_id);

                                                        %>

                                                        <tr class="productShow-Items">
                                                            <td class="productShow-Items-Names"><%= rs_Product.getString("pro_name")%><strong> x <%= quantity%></strong></td>
                                                            <td class="productShow-Items-Price">₫ <%= keyDAO.converterNumber(price * quantity)%></td>
                                                        </tr>
                                                    </tbody>
                                                    <%
                                                            total_price += price * quantity;
                                                        }%>
                                                    <tfoot>
                                                        <tr class="amoutTable">
                                                            <td>
                                                                Tạm tính
                                                                </th>
                                                            <td class="totalBefore">
                                                                ₫<%= keyDAO.converterNumber(total_price)%>
                                                            </td>
                                                        </tr>
                                                        <tr class="shipmountTable">
                                                            <th>Giao hàng</th>
                                                            <td>
                                                                <ul>

                                                                    <li>
                                                                        <input type="radio" name="check" id="" value="" checked >
                                                                        <label for=""><span>Đồng giá: ₫20,000</span></label>
                                                                    </li>
                                                                </ul>
                                                            </td>
                                                        </tr>
                                                        <tr class="amoutTable">
                                                            <td>
                                                                Tổng
                                                            </td>
                                                            <td class="totalAfter">
                                                                ₫<%= keyDAO.converterNumber(total_price + 20000)%>
                                                            </td>
                                                        </tr>
                                                    </tfoot>


                                                </table>
                                                <div class="buttonPayment">
                                                    <a href="/AdminController/Accept/<%=arr.get(i)%>">
                                                        Xác Nhận Đơn Hàng
                                                    </a>
                                                </div>
                                                </br>
                                                <div class="buttonPayment">
                                                    <a  href="/AdminController/Reject/<%=arr.get(i)%>">
                                                        Từ Chối Đơn Hàng
                                                    </a>
                                                </div>

                                            </div>

                                        </div>
                                    </div>
                                </form>
                            </div>
                            <%
                                }
                            } else {

                            %>
                            <span class="text-center mt-5">Chưa có đơn hàng nào chờ xác nhận</span>
                            <%                                }
                            %>
                        </div>
                    </div>
                </main>
            </div>
        </div>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
        <script src="/Front/assets/js/admin.js"></script>
        <script src="/Front/assets/js/notification.js"></script>

        <%
            HttpSession sess = request.getSession();
            String mesg = (String) sess.getAttribute("status");
        %>
        <script>
            createToast("<%= mesg %>")
        </script>

        <%
            //            HttpSession session = request.getSession();
            sess.setAttribute("status", "");
        %>




    </body>
</html>
