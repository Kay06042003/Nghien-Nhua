<%-- 
    Document   : admin
    Created on : Nov 5, 2023, 10:08:17 AM
    Author     : HIEU
--%>

<%@page import="DAOs.KeyboardDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://kit.fontawesome.com/ae360af17e.js" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
        <title>Nghien Nhua</title>
        <link rel="shortcut icon" href="/Front/assets/image/logo/z4705695345706_20ca59964f9ad379fcebb44ceaad6cd4-removebg-preview.png"/>

        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css"/>
        <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#example').DataTable();
            });
        </script>
        <style>
            <%@include file="/Front/assets/css/adminCss.css" %>
        </style>
    </head>
    <body>
        <div class="wrapper">
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
                <nav class="navbar navbar-expand px-3 border-bottom">
                    <!-- Button for sidebar toggle -->
                    <button class="btn" type="button" data-bs-theme="dark">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                </nav>
                <main class="content px-3 py-2">
                    <div class="container-fluid bg-light" style="border-radius: 10px">
                        <div class="mb-3" style="padding-top: 25px; text-align: center">
                            <h3 style="color: black">Thống Kê Theo Năm</h3>
                            <form method="post" action="AdminController"  color: white">
                                <input type="number" name="year"  min="2020" max="2030" >
                                <input type="submit" name="btnSubmitForYear" value="Report">
                            </form>
                        </div>    


                        <table id="example" style="margin-top: 30px; ">
                            <thead>
                                <tr>
                                    <th style="color: black">
                                        No
                                    </th>
                                    <th style="color: black">
                                        Username
                                    </th>
                                    <th style="color: black">
                                        Customer Name
                                    </th>
                                    <th style="color: black">
                                        Product Name
                                    </th>
                                    <th style="color: black">
                                        Quantity
                                    </th>
                                    <th style="color: black">
                                        Total Money
                                    </th>
                                    <th style="color: black">
                                        Oder date
                                    </th>
                                </tr>    
                            </thead>
                            <tbody>
                                <%
                                    if (session.getAttribute("ResultYear") != null) {
                                        int i = 0;
                                        KeyboardDAO kdao = new KeyboardDAO();
                                        ResultSet rs = (ResultSet) session.getAttribute("ResultYear");
                                        while (rs.next()) {
                                            i++;
                                %>
                                <tr>
                                    <td style="color: black"><%=i%></td>
                                    <td style="color: black"><%= rs.getString("username")%></td>
                                    <td style="color: black"><%= rs.getString("order_name")%></td>
                                    <td style="color: black"><%= rs.getString("pro_name")%></td>                           
                                    <td style="color: black"><%= rs.getInt("quantity")%></td>
                                    <td style="color: black"><%= kdao.converterNumber(rs.getInt("totalMoney"))%></td>
                                    <td style="color: black"><%= rs.getDate("order_date")%></td>
                                </tr>
                            </tbody>
                            <%
                                    }
                                }
                            %>
                        </table>
                    </div>
                </main>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
        <script src="/Front/assets/js/admin.js"></script>
    </body>
</html>
