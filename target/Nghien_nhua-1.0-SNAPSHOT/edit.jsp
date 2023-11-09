<%-- 
    Document   : edit
    Created on : Oct 31, 2023, 8:34:15 PM
    Author     : thinh
--%>

<%@page import="DAOs.AccountDAO"%>
<%@page import="Models.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="/Front/assets/image/logo/z4705695345706_20ca59964f9ad379fcebb44ceaad6cd4-removebg-preview.png"/>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <%@include file="/Front/Header.jsp" %>
        <style>
            .gradient-custom {
                background: rgb(255,101,249);
                background: linear-gradient(90deg, rgba(255,101,249,1) 0%, rgba(249,247,112,1) 100%);
            }
            .btn-logout{
                /* fallback for old browsers */

                background: rgb(255,101,249);
                background: linear-gradient(90deg, rgba(255,101,249,1) 0%, rgba(249,247,112,1) 100%);
            }
        </style>
    </head>
    <body>
        <%         
            Account acc = (Account) session.getAttribute("account");
        %>
        <form action="HomeController" method="post" id="form">
            <section class="vh-100" style="background-color: #f4f5f7;">
                <div class="container h-100">
                    <div class="row d-flex justify-content-center align-items-center h-100">
                        <div class="col col-lg-8 mb-4 mb-lg-0">
                            <div class="card mb-3" style="border-radius: .5rem;">
                                <div class="row g-0">
                                    <div class="col-md-4 gradient-custom text-center text-white"
                                         style="border-top-left-radius: .5rem; border-bottom-left-radius: .5rem;">
                                        <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava1-bg.webp" alt="Avatar"
                                             class="img-fluid my-5" style="width: 80px;" />
                                        <h5>Trang cá nhân</h5>
                                        <p class="fw-bold">Con nghiện</p>
                                        <i class="far fa-edit mb-5"></i>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="card-body p-4">
                                            <h4>Câp nhât thông tin</h4>
                                            <hr class="mt-0 mb-4">
                                            <div class="row pt-1">
                                                <div class="col-6 mb-3">
                                                    <h6>Tên người dùng</h6> 
                                                    <br/>
                                                    <input type="text" class="form-control" readOnly name="txtUsername"  value="<%= acc.getUsername()%>" required=""/>
                                                </div>
                                                <div class="col-6 mb-3">
                                                    <h6>Họ và tên</h6>
                                                    <br/>
                                                    <input type="text" class="form-control"  name="fullName" value="<%= acc.getFullname()%>" required=""/>
                                                    <br/>
                                                </div>
                                            </div>
                                            <div class="row pt-1">
                                                <div class="col-6 mb-3">
                                                    <h6>Địa chỉ</h6>
                                                    <br/>
                                                    <input type="text" class="form-control"  name="txtAdd"  value="<%= acc.getAddress()%>" required=""/>
                                                    <br/>
                                                </div>
                                                <div class="col-6 mb-3">
                                                    <h6>Số điện thoại</h6>
                                                    <br/>
                                                    <input type="text" class="form-control" id="phone" name="phone"  value="<%= acc.getSdt()%>" required=""/>
                                                    <span class="form-message"></span>
                                                    <br/>
                                                </div>
                                            </div>
                                            <div class="row pt-1">
                                                <div class="d-flex">
                                                    <div class=" mb-3">
                                                        <div class="form-group">
                                                            <button name="btnUpdate"  type="submit"
                                                                    class="btn form-control btn-primary rounded submit px-3" style="float: right;">Save</button>
                                                        </div>                                                    
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </form>
        <%@include file="/Front/Footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <script src="/Front/assets/js/main.js"></script>
        <script>

            const form = document.querySelector('#form');
            const phone = document.getElementById('phone');

            const setError = (element, message) => {
                const inputControl = element.parentElement;
                const errorDisplay = inputControl.querySelector('.form-message');
                errorDisplay.innerText = message;
                inputControl.classList.add('error');
                inputControl.classList.remove('success');
            };

            const isValidPhoneNumber = phone => {
                const regex = /^(0|\+84)(\s|\.)?((3[2-9])|(5[689])|(7[06-9])|(8[1-689])|(9[0-46-9]))(\d)(\s|\.)?(\d{3})(\s|\.)?(\d{3})$/;
                return regex.test(String(phone).toLowerCase());
            };

            const validateInputs = () => {
                const phoneValue = phone.value.trim();
                if (phoneValue === '') {
                    phone.classList.add('invalid')
                    phone.classList.remove('valid')
                    setError(phone, 'Phone is required');
                } else if (!isValidPhoneNumber(phoneValue)) {
                    phone.classList.add('invalid')
                    phone.classList.remove('valid')
                    setError(phone, 'Provide a valid phone number');
                } else {
                    phone.classList.remove('invalid')
                    phone.classList.add('valid')
                    setSuccess(phone);
                }
            };

            form.addEventListener('submit', function (e) {
                if (!validateInputs()) {
                    e.preventDefault();
                }
            });
        </script>
    </body>
</html>
