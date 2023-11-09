<%-- 
    Document   : cart
    Created on : Oct 30, 2023, 8:19:41 PM
    Author     : HIEU
--%>

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
        <link rel="stylesheet" href="/Front/assets/css/cartCss.css">
        <link rel="stylesheet" href="/Front/assets/css/notificationCss.css">

        <style>
            .buttonPayment {
                width: 100%;
                height: 40px;
                background-color: var(--wp--preset--color--luminous-vivid-orangeRed);
                border: none;
                font-weight: bold;
                color: var(--wp--preset--color--white);
                padding-top: unset;
                display: flex;
                align-items: center;
                justify-content: center;
            }

        </style>

    </head>
    <body>
        <%
            Cookie[] cookieList = null;
            cookieList = request.getCookies();
            String username = "";
            for (int i = 0; i < cookieList.length; i++) {
                if (cookieList[i].getName().equals("login")) {
                    username = cookieList[i].getValue();
                    break;
                }
            }
            CartDAO cDAO = new CartDAO();
            ResultSet rs = cDAO.getProductInCart(username);
            KeyboardDAO kDAO = new KeyboardDAO();

            int totalMoney = 0;
        %>

        <%@include file="/Front/Header.jsp" %>
        <ul class="notifications"></ul>

        <%            boolean test = true;
            ResultSet r = cDAO.getProductInCart(username);

            if (r.next()) {
                test = false;
            }
            if (!test) {
        %>
        <div class="main" style=" width: 100%; height: auto; padding-bottom: 50px;">
            <div class="container" style=" height: auto;">
                <div class="row">
                    <div class="col-md-7 left" style="border: none;">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th colspan="3" class="productName product1">
                                        Sản phẩm
                                    </th>
                                    <th class="productPrice product product1">
                                        Giá
                                    </th>
                                    <th class="productQuantity product">
                                        Số lượng
                                    </th>
                                    <th class="productTotal product">
                                        Tạm Tính
                                    </th>
                                </tr>
                            </thead>
                            <tbody class="listBodyProduct">
                                <%                                    while (rs.next()) {
                                        String[] imgaeList = rs.getString("pro_image").split("&");
                                %>
                                <tr>
                                    <td class="tableItemFirst">
                                        <button class="productRemove"><a href="/OrderController/Delete/<%= rs.getInt("pro_id")%>/<%= username%>">x</a></button>
                                    </td>
                                    <td>
                                        <img class="productPicture " src="<%= imgaeList[0]%>"
                                             alt="">
                                    </td>
                                    <td class="tableItemThird">
                                        <a class="productContent ItemProduct" href=""><%= rs.getString("pro_name")%></a>
                                    </td>
                                    <td class="ItemProduct1">
                                        <span>
                                            <%= kDAO.converterNumber(rs.getInt("pro_price"))%>
                                        </span>
                                    </td>
                                    <td>
                                        <div class="d-flex ItemProduct" style="width: 100px; text-align: center">
                                            <span>
                                                <%= rs.getInt("quantity")%>
                                            </span>
                                        </div>
                                    </td>
                                    <td class="ItemProduct1">
                                        <span>
                                            <%
                                                totalMoney += rs.getInt("quantity") * rs.getInt("pro_price");
                                            %>
                                            <%= kDAO.converterNumber(rs.getInt("quantity") * rs.getInt("pro_price"))%>
                                        </span>
                                    </td>
                                </tr>
                                <%                                    }
                                %>
                            </tbody>
                        </table>
                    </div>

                    <div class="col-md-5 right">
                        <div class="container">
                            <table class="table totalTable">
                                <thead>
                                    <tr>
                                        <th>
                                            CỘNG GIỎ HÀNG
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr class="amoutTable">
                                        <th>
                                            Tạm tính
                                        </th>
                                        <td class="before">
                                            <%= kDAO.converterNumber(totalMoney)%>
                                        </td>
                                    </tr>
                                    <tr class="shipmountTable">
                                        <th>Giao hàng</th>
                                        <td>
                                            <ul>
                                                <li>
                                                    <input type="radio" name="check" id="" value="" checked readonly>
                                                    <label for=""><span>Đồng giá: ₫20,000</span></label>
                                                </li>
                                            </ul>
                                        </td>
                                    </tr>
                                    <tr class="amoutTable">
                                        <th>
                                            Tổng
                                        </th>
                                        <td class="final">
                                            <%= kDAO.converterNumber(totalMoney + 20000)%>
                                        </td>
                                    </tr>
                                    <tr>

                                    </tr>
                                </tbody>
                            </table>
                            <div class=" buttonPayment">
                                <a  class="text-decoration-none text-light"  href="/OrderController/Order">
                                    <!--<input style="cursor: pointer" name="submitCart" value="Tiến hàng thanh toán"/>-->
                                    Tiến hành thanh toán
                                </a>
                            </div>
                        </div>
                        <div class="discountCode">
                            <div class="discountCode-label">
                                <i class="bi bi-tag-fill"></i>
                                <span>
                                    Phiếu ưu đãi
                                </span>
                            </div>
                            <input type="text" placeholder="Mã ưu đãi">
                            <input type="submit" name="" id="" value="Áp dụng" class="submitCode">
                        </div>
                    </div>
                </div>

            </div>

        </div>
        <%
        } else {
        %>
        <div class="d-flex justify-content-center align-items-center flex-column" style="width: 100% ; height: 500px">
            <span>Chưa có sản phẩm nào trong giỏ hàng</span>
            <a href="/" class="btn btn-success">Go home</a>
        </div>
        <%
            }
        %>
        <%@include file="/Front/Footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
        <!--<script src="./js/list.js"></script>-->
        <script src="/Front/assets/js/notification.js"></script>
        <script src="/Front/assets/js/main.js"></script>

        <%
            String mesg = (String) session.getAttribute("status");
        %>
        <script>
            createToast("<%= mesg%>")
        </script>

        <%
            session.setAttribute("status", "");
        %>





    </body>
</html>
