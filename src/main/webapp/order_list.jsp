<%-- 
    Document   : cart
    Created on : Oct 30, 2023, 8:19:41 PM
    Author     : HIEU
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="DAOs.OrderDAO"%>
<%@page import="DAOs.ProductDAO"%>
<%@page import="DAOs.KeyboardDAO"%>
<%@page import="Models.Account"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.CartDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Nghien nhua</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="/Front/assets/image/logo/z4705695345706_20ca59964f9ad379fcebb44ceaad6cd4-removebg-preview.png"/>
        <!-- icon -->
        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.2.1/css/fontawesome.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css">
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="/Front/assets/css/stylePayment.css">
        <style>
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
        <%@include file="/Front/Header.jsp" %>
        <%            String username = "";
            Cookie[] cookieList = request.getCookies();
            for (int i = 0; i < cookieList.length; i++) {
                if (cookieList[i].getName().equals("login")) {
                    username = cookieList[i].getValue();
                    break;
                }
            }
            OrderDAO orderDAO = new OrderDAO();
            KeyboardDAO kDAO = new KeyboardDAO();
            ProductDAO proDAO = new ProductDAO();
            int total_price = 0;
            String status = "";
            int pro_id = 0;
            int price = 0;
            int quantity = 0;
            ArrayList<Integer> arr = new ArrayList<Integer>();
            ResultSet rs_id = orderDAO.getAllOrderWithUsername(username);
            while (rs_id.next()) {
                if (!arr.contains(rs_id.getInt("id"))) {
                    arr.add(rs_id.getInt("id"));
                }
            }


        %>
        <ul class="notifications"></ul>
        <!-- main -->
        <div class="main" style=" width: 100%; height: auto; min-height: 500px; padding-bottom: 50px;margin-top: 80px">
            <%                for (int i = 0; i < arr.size(); i++) {
                    total_price = 0;
                    ResultSet rs_info = orderDAO.getAllOrderWithID(arr.get(i));
                    while (rs_info.next()) {
                        pro_id = rs_info.getInt("pro_id");
                    }
            %>
            <div class="container" style=" height: auto; margin-bottom: 50px">
                <div class="right">
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
                                        status = rs_infoProduct.getString("order_status");
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
                                <tr class="amoutTable">
                                    <td>
                                        Tình Trạng Đơn Hàng
                                    </td>
                                    <td class="totalAfter">

                                        <%
                                            if (status.equals("Waiting Accept")) {
                                        %>
                                        <div class="text fw-bold" style="color: #e4af45">

                                            <%= status%>
                                        </div>
                                        <%
                                        } else if (status.equals("Reject")) {
                                        %>
                                        <div class="text fw-bold" style="color: red">

                                            <%= status%>
                                        </div>
                                        <%
                                        } else {

                                        %>
                                        <div class="text fw-bold" style="color: green">
                                            <%= status%>
                                        </div>
                                        <%
                                            }
                                        %>

                                    </td>

                                </tr>

                            </tfoot>


                        </table>


                    </div>

                </div>
            </div>
        </div>
        <%            }
            if (pro_id == 0) {

        %>
        <div class="d-flex justify-content-center align-items-center flex-column" style="width: 100% ; height: 500px">
            <span>Chưa có lịch sử mua hàng nào</span>
            <a href="/" class="btn btn-success">Go home</a>
        </div>
        <%            }

        %>
    </div>


</div>
<div class="chat">
    <div class="boxChat">
        <div class="boxChat_icon"><i class="fa-regular fa-message"></i></div>
        <div class="boxChat_icon"><i class="fa-brands fa-facebook-messenger"></i></div>
        <div class="boxChat_icon"><i class="fa-solid fa-phone"></i></div>
    </div>
    <div class="boxchatAnimation">
    </div>
</div>
<%@include file="/Front/Footer.jsp" %>


<script src="/Front/assets/js/slick.js"></script>
<script src="/Front/assets/js/main.js"></script>


</body>
</html>
