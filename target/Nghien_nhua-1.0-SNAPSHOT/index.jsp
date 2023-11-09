<%-- 
Document   : home
Created on : Oct 17, 2023, 11:49:11 AM
Author     : Laptop
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.ProductDAO"%>
<%@page import="DAOs.KeyboardDAO"%>
<%@page import="Models.Keyboard"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Nghien Nhua</title>
        <link rel="shortcut icon" href="/Front/assets/image/logo/z4705695345706_20ca59964f9ad379fcebb44ceaad6cd4-removebg-preview.png"/>
        <!-- link boostrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <!-- link font awesome-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <!-- Link css slick slider -->
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
        <!-- link to css -->
        <style><%@include file="/Front/assets/css/style.css"%></style>
        <!--<link rel="stylesheet" href="/css/style.css"/>-->
        <%@include file="/Front/Header.jsp" %>
        <style>
            .card_Product {
                width: 250px;
                height: 400px;
                padding: 0 10px;
                overflow: hidden;
                max-width: 25%;
                position: relative;
                float: left;

            }

            .discount {
                position: absolute;
                margin-top: 20px;
                z-index: 100;
                background-color: rgb(210, 110, 75);
                width: 45px;
                height: 45px;
                border-radius: 50%;
                color: rgb(255, 255, 255);
                padding: 5px;
                pointer-events: none;
                text-align: center;
                top: 0;
                left: 0;
                display: flex;
                justify-content: center;
                align-items: center;
            }
        </style>
    </head>


    <body>
        <%            ProductDAO proDAO = new ProductDAO();
            ResultSet rs = proDAO.getNewProduct();
            String lower_name = "";
            KeyboardDAO kDAO = new KeyboardDAO();
            int count = 0;
        %>

        <!-- navbar mobiap -->
        <main>
            <section class="slide">
                <div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img src="/Front/assets/image/productQC/5075B-Plus-goku-naruto-1400x510.jpg" class="d-block w-100"
                                 alt="">
                        </div>
                        <div class="carousel-item">
                            <img src="/Front/assets/image/productQC/AKKO-3068B-banner-01-1400x510.jpg" class="d-block w-100"
                                 alt="...">
                        </div>
                        <div class="carousel-item">
                            <img src="/Front/assets/image/productQC/M1-Banner-1400x510.jpg" class="d-block w-100" alt="...">
                        </div>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls"
                            data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls"
                            data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>
            </section>
            <div class="container-fuild">
                <div class="container-xxl">
                    <div class="mainProduct">
                        <div class="product_container">
                            <a href="/ProductController/Keyboard"><img
                                    src="/Front/assets/image/productPic/ban-phim-co-akko-3098n-multi-modes-world-tour-london-ava.jpg"
                                    alt="akko"></a>
                            <h2>KEYBOARD</h2>
                        </div>
                        <div class="product_container">
                            <a href="/ProductController/Kit-ban-phim"><img src="/Front/assets/image/kitPic/kit_5.jpg"
                                                                           alt="akko"></a>
                            <h2>KIT</h2>
                        </div>
                        <div class="product_container">
                            <a href="/ProductController/Key-cap"><img src="/Front/assets/image/productPic/akko-keycap-neon-02.jpg" alt="akko"></a>
                            <h2>KEYCAP</h2>
                        </div>
                        <div class="product_container">
                            <a href="/ProductController/Switch"><img src="/Front/assets/image/switchPic/switch_1.jpg" alt="akko"></a>
                            <h2>Switch</h2>
                        </div>
                    </div>

                </div>
            </div>

            <div class="container-fuild">
                <div class="container-xxl">
                    <section class="newProduct">
                        <div class="headingTitle">
                            <i class="fa-regular fa-star"></i>
                            <h2>SẢN PHẨM MỚI</h2>
                        </div>
                        <%
                            while (rs.next()) {
                                if (rs.getInt("category_id") == 1) {
                                    lower_name = "Keyboard";
                                } else if (rs.getInt("category_id") == 2) {
                                    lower_name = "Kit-ban-phim";
                                } else if (rs.getInt("category_id") == 3) {
                                    lower_name = "Key-cap";
                                } else if (rs.getInt("category_id") == 4) {
                                    lower_name = "Switch";
                                }

                        %>
                        <div class="card_Product mt-3">
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
                    </section>
                </div>
            </div>
            <%
                ResultSet rs_BS = proDAO.getProductBestSeller();
            %>
            <div class="container-fuild">
                <div class="container-xxl">
                    <section class="newProduct">
                        <div class="headingTitle">
                            <i class="fa-regular fa-heart"></i>
                            <h2>Best Seller</h2>
                        </div>
                        <%
                            while (rs_BS.next()) {
                                if (rs_BS.getInt("category_id") == 1) {
                                    lower_name = "Keyboard";
                                } else if (rs_BS.getInt("category_id") == 2) {
                                    lower_name = "Kit-ban-phim";
                                } else if (rs_BS.getInt("category_id") == 3) {
                                    lower_name = "Key-cap";
                                } else if (rs_BS.getInt("category_id") == 4) {
                                    lower_name = "Switch";
                                }

                        %>
                        <div class="card_Product mt-3">
                            <%if (rs_BS.getInt("pro_discount") != 0) {
                            %>
                            <div class="discount">
                                <div class="on-slace">
                                    <span>-<%=rs_BS.getInt("pro_discount")%>%</span>
                                </div>

                            </div>
                            <%
                                }
                            %>
                            <div class="card_top">
                                <a href="/ProductController/<%= lower_name%>/<%= rs_BS.getInt("pro_id")%>">
                                    <div>
                                        <%
                                            String[] list = rs_BS.getString("pro_image").split("&");
                                            String image = list[0];
                                        %>
                                        <img src="<%= image%>"
                                             alt="">
                                    </div>
                                    <p class="card_title"><%= rs_BS.getString("pro_name")%></p>
                                </a>
                            </div>
                            <div class="card_body">
                                <%
                                    if (rs_BS.getInt("pro_discount") != 0) {
                                %>
                                <strike class="price_reduce"><i class="fa-solid fa-dong-sign"></i> <%= kDAO.converterNumber(kDAO.getPriceBeforeDiscount(rs_BS.getInt("pro_discount"), rs_BS.getInt("pro_price")))%></strike>
                                    <%
                                        }
                                    %>
                                <span class="price text fw-bold"><i class="fa-solid fa-dong-sign"><%= kDAO.converterNumber(rs_BS.getInt("pro_price"))%></i></span>
                            </div>
                            <div class="card_bot">
                                <%
                                    if (rs_BS.getInt("pro_quantity") != 0) {
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
                    </section>
                </div>

            </div>
            <section class="product_bg">
                <div class="product_bg-content">
                    <img  src="/Front/assets/image/productPic/akko-3068niu_800_1.jpg" alt="">
                </div>
                <div class="product_bg-content">
                    <img src="/Front/assets/image/productPic/akko-3108_luffy_800_1.jpg" alt="">
                </div>
            </section>

            <div class="container-fuild">
                <div class="container-xxl">
                    <section class="feedback">
                        <div class="feedback_container">
                            <div class="feedback_content">
                                <div class="feedback_content-icon">
                                    <i class="fa-solid fa-truck-fast"></i>
                                </div>
                                <h2>MIỄN PHÍ VẬN CHUYỂN</h2>
                                <p>Tất cả sản phẩm được đặt hàng tại Akko.vn đều được miễn phí vận chuyển. Khách hàng được kiểm tra
                                    hàng trước khi thanh toán.</p>
                            </div>
                            <div class="feedback_content feedback_line">
                                <div class="feedback_content-icon">
                                    <i class="fa-brands fa-hire-a-helper"></i>
                                </div>
                                <h2>HỖ TRỢ 24/7</h2>
                                <p>Hỗ trợ khách hàng trực tuyến về mua hàng cũng như các thắc mắc về sản phẩm .</p>
                            </div>
                            <div class="feedback_content">
                                <div class="feedback_content-icon">
                                    <i class="fa-solid fa-file-contract"></i>
                                </div>
                                <h2>CHẾ ĐỘ BẢO HÀNH VƯỢT TRỘI</h2>
                                <p>Tất cả sản phẩm Akko đều được bảo hành 12 tháng, 1 đổi 1. Trung tâm bảo hành toàn quốc</p>
                            </div>
                        </div>
                    </section>
                </div>

            </div>
            
        </main>
        <%@include file="/Front/Footer.jsp" %>



        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>

        <script type="text/javascript" src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
        <script type="text/javascript" src="https://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

        
        <script src="/Front/assets/js/script.js"></script>
        <script src="/Front/assets/js/main.js"></script>
    </body>

</html>