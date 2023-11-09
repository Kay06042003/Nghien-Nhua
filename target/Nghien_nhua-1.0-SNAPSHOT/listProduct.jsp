<%-- 
    Document   : listProduct
    Created on : Oct 18, 2023, 11:03:43 AM
    Author     : thinh
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.ProductDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html><head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css"/>
        <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#example').DataTable();
            });
        </script>
    </head>
    <body>
        <style>
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
                width: 100px;
            }
        </style>
        <%
            if (request.getParameter("id") != null && request.getParameter("id").equals("") == false) {
                int pro_id = Integer.parseInt(request.getParameter("id"));
                ProductDAO pDAO = new ProductDAO();
                pDAO.deleteProduct(pro_id);
            }
        %>
        <h1>List of Products</h1>
        <a href="/ProductController/ListProduct/Create"><button type="button" class="btn btn-primary mb-2">Create New</button></a>
        <div>
            <table id="example" class="table table-hover table-striped table-bordered dataTable dtr-inline col-sm-12">
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
                    %>
                    <tr>
                        <td><%= rs.getString("pro_id")%></td>
                        <td><%= rs.getString("pro_name")%></td>
                        <td><%= rs.getInt("pro_price")%></td>                                 
                        <td><%= rs.getString("pro_quantity")%></td>
                        <td><img src="<%= rs.getString("pro_image")%>" alt="Laptop" style="width: 60px"/></td>
                        <td><%= rs.getString("pro_discription")%></td>
                        <td><%= rs.getString("pro_discount")%></td>
                        <td><%= rs.getString("product_name")%></td>

                        <td>
                            <a href="edit.jsp?id"><button type="button" class="btn btn-success m-2">Edit</button></a>  <a  href="/ProductController/ListProduct/Delete/<%= rs.getString("pro_id")%>" class="btn btn-danger link-delete">Delete</a>

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
        <script>
            var overlay = document.getElementById("overlay");
            var confirmBtn = document.getElementById("confirmBtn");
            var cancelBtn = document.getElementById("cancelBtn");
            const elements = document.querySelectorAll(".link-delete");

            elements.forEach(function (element) {
                var atributeValue = element.getAttribute("href")
                element.addEventListener("click", function (event) {
                    event.preventDefault();
                    overlay.style.display = "block";
                });

                confirmBtn.addEventListener("click", function () {
// Xử lý khi người dùng nhấn OK
                    overlay.style.display = "none";
// Chuyển hướng hoặc thực hiện các hành động khác ở đây
                    window.location.href = atributeValue;
                });

                cancelBtn.addEventListener("click", function () {
// Xử lý khi người dùng nhấn Cancel
                    overlay.style.display = "none";
// Không làm gì cả hoặc thực hiện các hành động khác tùy vào yêu cầu của bạn
                });
            });
        </script>
    </body>
</html>
