<%-- 
    Document   : Header
    Created on : Oct 17, 2023, 12:25:01 PM
    Author     : Laptop
--%>

<%@page import="Models.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/hml; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="shortcut icon" href="/Front/assets/image/logo/z4705695345706_20ca59964f9ad379fcebb44ceaad6cd4-removebg-preview.png"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <!-- link font awesome-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <!-- Link css slick slider -->
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
        <!-- link to css -->
        <style><%@include file="/Front/assets/css/style.css"%></style>
        <!--link-->

    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light navContainer">
            <div class="container-fluid" >
                <div class="container-xxl">
                    <div class="d-flex justify-content-between align-items-center">
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                                aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>

                        </button>
                        <a class="navbar-brand" href="/"><img style="width: 100px;"
                                                              src="/Front/assets/image/logo/z4705695345706_20ca59964f9ad379fcebb44ceaad6cd4-removebg-preview.png"
                                                              alt=""></a>

                        <div class="d-flex align-items-center">
                            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                                <div class="navbar-collapse-box d-flex align-items-center">
                                    <form class="nav_search" action="">
                                        <div>
                                            <input oninput="funcSearch(this)" class="nav_search-box" name='txt' type="search" placeholder="Tìm kiếm sản phẩm" data-bs-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample" autocomplete="off">
                                            <button class="nav_search-icon" type="submit"><i
                                                    class="fa-solid fa-magnifying-glass"></i></button>
                                            <div class="collapse" id="collapseExample">
                                                <div id="content" class="searchBoxProduct bg-light shadow-sm p-3 mb-5 bg-body rounded" style="width: 300px; max-height: 700px; overflow: auto;">
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                    <ul class="navbar-nav mb-2 mb-lg-0">
                                        <li class="nav-item">
                                            <a class="nav-link" href="/ProductController/Keyboard">KEYBOARD</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="/ProductController/Kit-ban-phim">KIT BÀN PHÍM</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="/ProductController/Key-cap">KEYCAP</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="/ProductController/Switch"">SWITCH</a>
                                        </li>

                                        <%
                                            Account account = (Account) session.getAttribute("account");

                                            if (account != null) {
                                                if (account.getRole() == 1) {

                                        %>
                                        <li class="nav-item support">
                                            <a class="nav-link" href="/HomeController/User">HỒ SƠ</a>
                                        </li> 
                                        <%                                        } else {

                                        %>
                                        <li class="nav-item support">
                                            <a class="nav-link" href="/AdminController/Admin">ADMIN</a>
                                        </li> 
                                        <%                                            }
                                        } else {

                                        %>
                                        <li class="nav-item support">
                                            <a class="nav-link" href="/HomeController/Login">ĐĂNG NHẬP</a>
                                        </li> 
                                        <%    }
                                        %>
                                    </ul>
                                </div>
                            </div>
                            <div class="boxShop">
                                <ul class="navbar-nav mb-2 mb-lg-0">
                                    <li class="nav-item">
                                        <a class="nav-link" href="/OrderController/Cart"><i class="fa-solid fa-cart-shopping shop_icon"></i></a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </nav>
        
        <script>
            var boxSearch = document.getElementById("collapseExample");
            document.addEventListener("click", function (e) {
                if (e.target !== boxSearch) {
                    boxSearch.classList.remove("show");
                }
            })
            function funcSearch(para) {
                var txtSearch = para.value;
                $.ajax({
                    url: "/LiveSearch",
                    type: "get",
                    data: {
                        txt: txtSearch
                    },
                    success: function (data) {
                        var row = document.getElementById("content")
                        row.innerHTML = data;
                    },
                    error: function (asfd) {

                    }
                })
            }
        </script>
    </body>
</html>
