<%-- 
    Document   : admin
    Created on : Nov 5, 2023, 10:08:17 AM
    Author     : HIEU
--%>

<%@page import="java.util.Arrays"%>
<%@page import="DAOs.KeyboardDAO"%>
<%@page import="DAOs.OrderDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.ProductDAO"%>
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

        <style>
            <%@include file="/Front/assets/css/adminCss.css" %>
            .overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
            }

            .overlay-content {
                background-color: white;
                padding: 20px;
                width: 350px;
                height: 200px;
                text-align: center;
                border-radius: 10px;
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
            }
            .overlay-content p{
                font-size: 20px;
            }
            #confirmBtn{
                margin-bottom: 7px;
            }
            .overlay-content button{
                width: 100px;
            }
            .table-bordered{
                border: 1px solid #e9ecef;
                width: 100%;
            }
        </style>
    </head>
    <body>
        <%
            if (request.getParameter("id") != null && request.getParameter("id").equals("") == false) {
                int pro_id = Integer.parseInt(request.getParameter("id"));
                ProductDAO pDAO = new ProductDAO();
                pDAO.deleteProduct(pro_id);
            }
        %>
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
                    <%
                        OrderDAO oDAO = new OrderDAO();
                        int priceToday = oDAO.getRevenueToday();
                        int priceTotal = oDAO.getRevenueTotal();
                        int numberReq = oDAO.getRequest();
                        KeyboardDAO k = new KeyboardDAO();
                        int[] data = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
                        for (int i = 1; i < 13; i++) {
                            data[i - 1] = oDAO.getTotalOrderByMonth(i);
                        }

                    %>
                    <div class="row my-4">
                        <div class="col-md-6">
                            <div class="row mb-3 mt-3 py-3">
                                <div class="col-xl-4 mb-4">
                                    <div class="card border-left-primary shadow h-100 py-2">
                                        <div class="card-body">
                                            <div class="row no-gutters align-items-center">
                                                <div class="col mr-2">
                                                    <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                        Earnings (Day)</div>
                                                    <div class="h5 mb-0 font-weight-bold text-gray-800">$<%= k.converterNumber(priceToday)%></div>
                                                </div>
                                                <div class="col-auto">
                                                    <i class="fas fa-calendar fa-2x text-gray-300"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-4 mb-4">
                                    <div class="card border-left-success shadow h-100 py-2">
                                        <div class="card-body">
                                            <div class="row no-gutters align-items-center">
                                                <div class="col mr-2">
                                                    <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                        Earnings (Total)</div>
                                                    <div class="h5 mb-0 font-weight-bold text-gray-800">$<%= k.converterNumber(priceTotal)%></div>
                                                </div>
                                                <div class="col-auto">
<!--                                                    <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>-->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-4 mb-4">
                                    <div class="card border-left-warning shadow h-100 py-2">
                                        <div class="card-body">
                                            <div class="row no-gutters align-items-center">
                                                <div class="col mr-2">
                                                    <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                                        Pending Requests</div>
                                                    <div class="h5 mb-0 font-weight-bold text-gray-800"><%= numberReq%></div>
                                                </div>
                                                <div class="col-auto">
                                                    <i class="fas fa-comments fa-2x text-gray-300"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="bg-light" style="max-width: 600px; max-height: 300px ;border-radius: 10px">
                                <canvas id="myChart"></canvas>
                            </div>                                 
                        </div>
                    </div>


                    <div class="container-fluid bg-light" style="border-radius: 10px">
                        <div class="mb-3 mt-3 py-3">
                            <%                                if (request.getParameter("id") != null && request.getParameter("id").equals("") == false) {
                                    int pro_id = Integer.parseInt(request.getParameter("id"));
                                    ProductDAO pDAO = new ProductDAO();
                                    pDAO.deleteProduct(pro_id);
                                }
                            %>
                            <h1 class="text-center">List of Products</h1>
                            <div>
                                <table id="example" class="table table-hover table-striped table-bordered dataTable dtr-inline col-sm-12" style="width: 100">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Product Name</th>
                                            <th>Price</th>
                                            <th>Quantity</th>
                                            <th>Picture</th>
                                            <th>Description</th>
                                            <th>Discount</th>
                                            <th>Category Name</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            ProductDAO pDAO = new ProductDAO();
                                            ResultSet rs = pDAO.getAll();
                                            while (rs.next()) {
                                                String[] image = rs.getString("pro_image").split("&");
                                        %>
                                        <tr>
                                            <td><%= rs.getString("pro_id")%></td>
                                            <td><%= rs.getString("pro_name")%></td>
                                            <td><%= rs.getInt("pro_price")%></td>                                 
                                            <td><%= rs.getString("pro_quantity")%></td>
                                            <td><img src="<%= image[0]%>" alt="Laptop" style="width: 60px"/></td>
                                            <td><%= rs.getString("pro_discription")%></td>
                                            <td><%= rs.getString("pro_discount")%></td>
                                            <td><%= rs.getString("product_name")%></td>

                                            <td>
                                                <a href="/AdminController/Edit/<%= rs.getInt("pro_id")%>"><button type="button" class="btn btn-success m-2">Edit</button></a>  <a onclick="return confirm('Are you sure?')" href="/AdminController/Delete/<%= rs.getInt("pro_id")%>" class="btn btn-danger link-delete">Delete</a>
                                            </td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                            <div class="overlay" id="overlay">
                                <div class="overlay-content">
                                    <p>Are you sure you want to delete this product?</p>
                                    <button class="btn btn-primary" id="confirmBtn">OK</button>
                                    <button class="btn btn-danger" id="cancelBtn">Cancel</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>

        <script src="/Front/assets/js/admin.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
                                                    const ctx = document.getElementById('myChart');

                                                    new Chart(ctx, {
                                                        type: 'line',
                                                        data: {
                                                            labels: ["T1", "T2", "T3", "T4", "T5", "T6", "T7", "T8", "T9", "T10", "T11", "T12"],
                                                            datasets: [{
                                                                    label: 'Đơn hàng',
                                                                    data: [<%= Arrays.toString(data).replaceAll("[\\[\\]]", "")%>],
                                                                    borderWidth: 1,
                                                                    tension: 0.4,
                                                                }]
                                                        },
                                                        options: {
                                                            scales: {
                                                                y: {
                                                                    beginAtZero: true
                                                                }
                                                            }
                                                        }
                                                    });

        </script>
    </body>
</html>
