<%-- 
    Document   : productDetails
    Created on : Oct 17, 2023, 12:22:06 PM
    Author     : Laptop
--%>

<%@page import="DAOs.ProductDAO"%>
<%@page import="com.nimbusds.jose.crypto.impl.AAD"%>
<%@page import="DAOs.KeyboardDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Models.Keyboard"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Nghien Nhua</title>
        <link rel="shortcut icon" href="/Front/assets/image/logo/z4705695345706_20ca59964f9ad379fcebb44ceaad6cd4-removebg-preview.png"/>
        <!-- link boostrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <!-- link font awesome-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <!-- link to css -->     
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
        <link rel="stylesheet" href="/Front/assets/css/productCss.css"/>
    </head>

    <body>
        <%@include file="/Front/Header.jsp" %>
        <%            String name_product = (String) session.getAttribute("Name");
            String[] listImage = (String[]) session.getAttribute("listImage");
            String lower_name = (String) session.getAttribute("NameLower");

            KeyboardDAO kDAO = new KeyboardDAO();

        %>
        <div style="margin-top: 120px">

            <div class="modals js_modal">
                <div class="filter ">
                    <ul>
                        <li><a href="#">Keyboard</a></li>
                        <li><a href="#">Kit Bàn Phím</a></li>
                        <li><a href="#">Keycap</a></li>
                        <li><a href="#">Switch</a></li>
                    </ul>
                </div>
                <div class="btn_close js_modal_close"><i class="fa-solid fa-xmark"></i></div>
            </div>
            <div class="header">
                <h5 class="home"><a href="/" style="color: rgba(102,102,102,0.7);font-weight: normal;"> Trang chủ / </a>
                    <%= name_product%></h5>
            </div>
            <div class="nav_bar"> <a href="#" class="js_modals"><i class="fa-solid fa-bars"></i> Lọc</a> </div>
            <div class="container">
                <div class="aside-left">
                    <div class="product-list">
                        <ul>
                            <li><a href="/ProductController/Keyboard">Keyboard</a></li>
                            <li><a href="/ProductController/Kit-ban-phim">Kit Bàn Phím</a></li>
                            <li><a href="/ProductController/Key-cap">Keycap</a></li>
                            <li><a href="/ProductController/Switch">Switch</a></li>
                        </ul>
                    </div>
                    <div class="new-product">
                        <span class="new_product_title">Sản phẩm mới</span>
                        <div class="new_product_title_border"></div>
                        <div>
                            <%
                                ProductDAO proDAO = new ProductDAO();

                                ResultSet rs_new = proDAO.get2NewProduct();
                                String name = "";
                            %>

                            <ul class="product_list_widget">
                                <%
                                    while (rs_new.next()) {
                                        if (rs_new.getInt("category_id") == 1) {
                                            name = "Keyboard";
                                        } else if (rs_new.getInt("category_id") == 2) {
                                            name = "Kit-ban-phim";
                                        } else if (rs_new.getInt("category_id") == 3) {
                                            name = "Key-cap";
                                        } else if (rs_new.getInt("category_id") == 4) {
                                            name = "Switch";
                                        }
                                        String[] list = rs_new.getString("pro_image").split("&");
                                        String image = list[0];

                                %>
                                <li><a class="product-title"
                                       href="/ProductController/<%= name%>/<%= rs_new.getInt("pro_id")%>">
                                        <img src="<%= image%>"
                                             alt="">
                                        <span><%= rs_new.getString("pro_name")%></span>
                                    </a>
                                    <div class="card_body" style="text-align: left;">
                                        <span>
                                            <strike class="price_reduce"><i
                                                    class="fa-solid fa-dong-sign"></i><%= kDAO.converterNumber(kDAO.getPriceBeforeDiscount(rs_new.getInt("pro_discount"), rs_new.getInt("pro_price")))%></strike></span>
                                        <span class="price text fw-bold"><i class="fa-solid fa-dong-sign"><%= kDAO.converterNumber(rs_new.getInt("pro_price"))%></i></span>
                                    </div>
                                </li>

                                <%}%>
                            </ul>
                        </div>
                    </div>
                    <div class="new_post">
                        <span class="new_post_title">Bài viết mới</span>
                        <div class="new_post_title_border"></div>
                        <div>
                            <ul class="post_list_widget">
                                <li><a class="post-title"
                                       href="#!">
                                        <img src="https://akko.vn/wp-content/uploads/2021/05/akk-switch-cs-la-gi-280x280.jpg"
                                             alt="">
                                        <span>Tìm hiểu về Akko switch CS, Akko switch CS là gì?</span>
                                    </a>
                                </li>
                                <li><a class="post-title" href="#!">
                                        <img src="https://akko.vn/wp-content/uploads/2020/03/0023-150x150.png" alt="">
                                        <span>Các công nghệ in kí tự keycap bàn phím cơ</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="aside-right">
                    <div class="boxCard">
                        <%
                            ResultSet rs = (ResultSet) session.getAttribute("All");
                            while (rs.next()) {
                        %>
                        <div class="card_Product">
                            <%if (rs.getInt("pro_discount") != 0) {
                            %>
                            <div class="discount">
                                <div class="on-slace">
                                    <span>-<%=rs.getInt("pro_discount")%>%</span>
                                </div>
                            </div>
                            <%
                                }
                            %>
                            <div class="card_top">
                                <a href="/ProductController/<%= lower_name%>/<%= rs.getInt("pro_id")%>">
                                    <div>
                                        <%
                                            String[] list = rs.getString("pro_image").split("&");
                                            String image = list[0];
                                        %>
                                        <img src="<%= image%>"
                                             alt="">
                                    </div>
                                    <p class="card_title"><%= rs.getString("pro_name")%></p>
                                </a>
                            </div>
                            <div class="card_body">
                                <%
                                    if (rs.getInt("pro_discount") != 0) {
                                %>
                                <strike class="price_reduce"><i class="fa-solid fa-dong-sign"></i> <%= kDAO.converterNumber(kDAO.getPriceBeforeDiscount(rs.getInt("pro_discount"), rs.getInt("pro_price")))%></strike>
                                    <%
                                        }
                                    %>
                                <span class="price text fw-bold"><i class="fa-solid fa-dong-sign"><%= kDAO.converterNumber(rs.getInt("pro_price"))%></i></span>
                            </div>

                            <div class="card_bot">
                                <%
                                    if (rs.getInt("pro_quantity") != 0) {
                                %>
                                <p class="card_status" style="color: rgb(0, 128, 0);"><i class="fa-solid fa-check"></i>Còn Hàng</p>

                                <%
                                } else {
                                %>
                                <p class="card_status" style="color:red;"><i class="fa-solid fa-phone"></i>Hết Hàng</p>
                                <%
                                    }
                                %>


                            </div>

                        </div>
                        <%
                            }
                        %>
                    </div>

                </div>
            </div>
            <%@include file="/Front/Footer.jsp" %>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
                    integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>
            <script type="text/javascript" src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
            <script type="text/javascript" src="https://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
            <script type="text/javascript"
            src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
            <script src="/Front/assets/js/main.js"></script>

        </div>
    </body>

</html>
