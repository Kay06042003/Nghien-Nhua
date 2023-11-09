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
        <link rel="stylesheet" href="/Front/assets/css/stylePayment.css">
        <link rel="stylesheet" href="/Front/assets/css/notificationCss.css">
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
            .form-input.valid {
                border-color: #28a745;
                padding-right: calc(1.5em + 0.75rem);
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 8 8'%3e%3cpath fill='%2328a745' d='M2.3 6.73L.6 4.53c-.4-1.04.46-1.4 1.1-.8l1.1 1.4 3.4-3.8c.6-.63 1.6-.27 1.2.7l-4 4.6c-.43.5-.8.4-1.1.1z'/%3e%3c/svg%3e");
                background-repeat: no-repeat;
                background-position: center right calc(0.375em + 0.1875rem);
                background-size: calc(0.75em + 0.375rem) calc(0.75em + 0.375rem);
            }
            .form-input.invalid{
                border-color: #dc3545;
                padding-right: calc(1.5em + 0.75rem);
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='%23dc3545' viewBox='-2 -2 7 7'%3e%3cpath stroke='%23dc3545' d='M0 0l3 3m0-3L0 3'/%3e%3ccircle r='.5'/%3e%3ccircle cx='3' r='.5'/%3e%3ccircle cy='3' r='.5'/%3e%3ccircle cx='3' cy='3' r='.5'/%3e%3c/svg%3E");
                background-repeat: no-repeat;
                background-position: center right calc(0.375em + 0.1875rem);
                background-size: calc(0.75em + 0.375rem) calc(0.75em + 0.375rem);
            }
            .form-message {
                color: #dc3545;
                font-size: 14px;
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
            int total_price = 0;
        %>
        <%@include file="/Front/Header.jsp" %>
        <ul class="notifications"></ul>
        <!-- main -->
        <div class="main" style=" width: 100%; height: auto; padding-bottom: 50px;margin-top: 80px">
            <div class="container" style=" height: auto;">
                <form action="OrderController" id="form" method="post">
                    <div class="row">
                        <div class="col-md-7 left" style="border: none;">
                            <div class="container information">
                                <h3>THÔNG TIN THANH TOÁN</h3>

                                <div class="nameUser row">
                                    <label class="form-label " for="name">Tên:<span style="color: red">*</span></label>
                                    <input type="text" class="form-control-sm name form-input" id="name" name="txtName" autocomplete="off">
                                    <div class="form-message text-start"></div>
                                </div>

                                <div class="PhoneUser row">
                                    <label class="form-label" for="phone">Số điện thoại:<span style="color: red">*</span></label>
                                    <input type="text" class="form-control-sm form-input" id="phone" name="txtPhone" autocomplete="off">
                                    <div class="form-message text-start"></div>
                                </div>
                                <div class="mailUser row">
                                    <label class="form-label" for="mail">Địa chỉ email:</label>
                                    <input type="text" class="form-control-sm form-input" id="mail" name="txtEmail" autocomplete="off">
                                    <div class="form-message text-start"></div>
                                </div>

                                <div class="nationalUser row">
                                    <label class="form-label" for="name">Quốc gia/Khu vực</label>
                                    <span>Việt Nam</span>
                                </div>
                                <div class="addressUser row">
                                    <label class="form-label" for="address">Địa chỉ:<span style="color: red">*</span></label>
                                    <input type="text" class="form-control-sm form-input" id="address" name="txtAddress"
                                           placeholder="Ví dụ: 89/3 Nguyễn Thông, An Thới, Bình Thủy, Cần Thơ" autocomplete="off">
                                    <div class="form-message text-start"></div>
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

                                            while (rs.next()) {

                                        %>

                                        <tr class="productShow-Items">
                                            <td class="productShow-Items-Names"><%= rs.getString("pro_name")%><strong> x <%= rs.getString("quantity")%></strong></td>
                                            <td class="productShow-Items-Price">₫ <%= keyDAO.converterNumber(rs.getInt("pro_price") * rs.getInt("quantity"))%></td>
                                        </tr>
                                    </tbody>
                                    <%
                                            total_price += rs.getInt("pro_price") * rs.getInt("quantity");
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
                                    <input class="buttonPayment" type="submit" name="btnOrder" value="Tiến hàng thanh toán" />
                                </div>
                                <div class="contentFor">
                                    <p>
                                        Tất cả thông tin của bạn chỉ được sử dụng cho việc đặt hàng và cải thiện trải nghiệm sản
                                        phẩm. Ngoài ra được Akko đảm bảo về quyền riêng tư cá nhân theo quy định luật pháp
                                    </p>
                                </div>
                                <div class="contentFor">
                                    <p>

                                        <strong>(Email xác nhận đơn hàng có thể sẽ trong mục email quảng cáo)</strong>
                                    </p>
                                </div>
                            </div>

                        </div>
                    </div>
                </form>
            </div>

        </div>
        <%@include file="/Front/Footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
        <script src="/Front/assets/js/notification.js"></script>

        <%
//            HttpSession sess = request.getSession();
            String mesg = (String) session.getAttribute("status");
            if (mesg.contains("success")) {

        %>
        <script>
            createToast("success")
        </script>
        <%        } else if (mesg.contains("error")) {
        %>
        <script>
            createToast("error")
        </script>
        <%
            }
            session.setAttribute("status", "");
        %>

        <script>
            const form = document.querySelector('#form');
            const full_name = document.getElementById('name');
            const phone = document.getElementById('phone');
            const email = document.getElementById('mail');
            const add = document.getElementById('address');


            const setError = (element, message) => {
                const inputControl = element.parentElement;
                const errorDisplay = inputControl.querySelector('.form-message');
                errorDisplay.innerText = message;
                inputControl.classList.add('error');
                inputControl.classList.remove('success');
            };
            const setSuccess = element => {
                const inputControl = element.parentElement;
                const errorDisplay = inputControl.querySelector('.form-message');
                errorDisplay.innerText = '';
                inputControl.classList.add('success');
                inputControl.classList.remove('error');
            };
            const isValidNumber = number => {
                const regex = /^[^\W][^0-9]*$/;
                return regex.test(String(number).toLowerCase());
            };
            const isValidPhoneNumber = phone => {
                const regex = /^(0|\+84)(\s|\.)?((3[2-9])|(5[689])|(7[06-9])|(8[1-689])|(9[0-46-9]))(\d)(\s|\.)?(\d{3})(\s|\.)?(\d{3})$/;
                return regex.test(String(phone).toLowerCase());
            };

            const isValidEmail = email => {
                const regex = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                return regex.test(String(email).toLowerCase());
            };

            const isValidName = name => {
                const regex = /^[\p{L}\s]+$/;
                return regex.test(String(name).toLowerCase());
            };
            const validateInputs = () => {
                const full_nameValue = full_name.value.trim();
                const phoneValue = phone.value.trim();
                const emailValue = email.value.trim();
                const addValue = add.value.trim();
                let hasError = false;

                if (full_nameValue === '') {
                    full_name.classList.add('invalid');
                    full_name.classList.remove('valid');
                    setError(full_name, 'Tên là bắt buộc');
                    hasError = true;
                } else {
                    full_name.classList.remove('invalid');
                    full_name.classList.add('valid');
                    setSuccess(full_name);
                }

                if (phoneValue === '') {
                    phone.classList.add('invalid');
                    phone.classList.remove('valid');
                    setError(phone, 'Số điện thoại là bắt buộc');
                    hasError = true;
                } else if (!isValidPhoneNumber(phoneValue)) {
                    phone.classList.add('invalid');
                    phone.classList.remove('valid');
                    setError(phone, 'Cung cấp một số điện thoại hợp lệ');
                    hasError = true;
                } else {
                    phone.classList.remove('invalid');
                    phone.classList.add('valid');
                    setSuccess(phone);
                }

                if (emailValue === '') {
                    email.classList.add('invalid');
                    email.classList.remove('valid');
                    setError(email, 'Email là bắt buộc');
                    hasError = true;
                } else if (!isValidEmail(emailValue)) {
                    email.classList.add('invalid');
                    email.classList.remove('valid');
                    setError(email, 'Cung cấp một số email hợp lệ');
                    hasError = true;
                } else {
                    email.classList.remove('invalid');
                    email.classList.add('valid');
                    setSuccess(email);
                }

                if (addValue === '') {
                    add.classList.add('invalid');
                    add.classList.remove('valid');
                    setError(add, 'Địa chỉ là bắt buộc');
                    hasError = true;
                } else {
                    add.classList.remove('invalid');
                    add.classList.add('valid');
                    setSuccess(add);
                }

                return !hasError;
            }
            ;
            form.addEventListener('submit', function (e) {
                if (!validateInputs()) {
                    e.preventDefault(); // Ngăn chặn biểu mẫu gửi đi nếu có lỗi
                }
            });
        </script>


    </body>
</html>