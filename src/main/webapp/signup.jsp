<%-- Document : index.jsp Created on : Oct 15, 2023, 9:22:41 PM Author : HIEU --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="shortcut icon" href="/Front/assets/image/logo/z4705695345706_20ca59964f9ad379fcebb44ceaad6cd4-removebg-preview.png"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <link rel="stylesheet" href="/Front/assets/css/sginupCss.css" />
        <link rel="stylesheet" href="/Front/assets/css/notificationCss.css" />

    </head>

    <body>
        <ul class="notifications"></ul>
        <section class="ftco-section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-10 col-lg-9">
                        <div class="login-wrap py-5">
                            <div class="img d-flex align-items-center justify-content-center"
                                 style="background-image: url(/Front/assets/image/logo/z4705695345706_20ca59964f9ad379fcebb44ceaad6cd4-removebg-preview.png);"></div>
                            <h3 class="text-center mb-0">Welcome</h3>
                            <p class="text-center">Sign up by entering the information below</p>
                            <form action="HomeController" id="form" method="post" class="login-form px-4 needs-validation">
                                <div id="error-message" style="color: red;"></div>
                                <div class="row">
                                    <div class="form-group col">
                                        <div class="icon d-flex align-items-center justify-content-center"><span
                                                class="bi bi-person-circle"></span></div>
                                        <input type="text" class="form-control" name="fullName" id="fullName" 
                                               placeholder="Fullname" autocomplete="off" required>
                                        <span class="form-message"></span>
                                    </div>
                                    <div class="form-group col">
                                        <div class="icon d-flex align-items-center justify-content-center"><span
                                                class="bi bi-person"></span></div>
                                        <input type="text" class="form-control" name="username" id="userName" 
                                               placeholder="Username" autocomplete="off" required>
                                        <span class="form-message"></span>
                                    </div>
                                    <div class="w-100"></div>
                                    <div class="form-group col">
                                        <div class="icon d-flex align-items-center justify-content-center"><span
                                                class="bi bi-phone"></span></div>
                                        <input type="text" class="form-control" name="phone" id="phone"
                                               placeholder="Phone number" autocomplete="off" required>
                                        <span class="form-message"></span>  
                                    </div>
                                    <div class="form-group col">
                                        <div class="icon d-flex align-items-center justify-content-center"><span
                                                class="bi bi-lock"></span></div>
                                        <input type="password" class="form-control" name="password" id="pass"
                                               placeholder="Password" autocomplete="off" required>
                                        <span class="form-message"></span>
                                    </div>
                                    <div class="w-100"></div>
                                    <div class="form-group col">
                                        <div class="icon d-flex align-items-center justify-content-center"><span
                                                class="bi bi-house"></span></div>
                                        <input type="text" class="form-control" name="address" id="add"
                                               placeholder="Address" autocomplete="off" required>
                                        <span class="form-message"></span>
                                    </div>
                                </div>
                                <div class="form-group d-md-flex">
                                    <div class="w-100 text-md-right">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <button name="btnSignUP" value="sumbit" type="submit"
                                            class="btn form-control btn-primary rounded submit px-3">Sign Up</button>
                                </div>
                            </form>
                            <div class="w-100 text-center mt-4 text">
                                <p class="mb-0">Have an account?</p>
                                <a href="/HomeController/Login">Log In</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

        <script src="/Front/assets/js/notification.js"></script>
        <script>
            const form = document.querySelector('#form');
            const phone = document.getElementById('phone');
            const full_name = document.getElementById('fullName');
            const user_name = document.getElementById('userName');
            const pwd = document.getElementById('pass');
            const add = document.getElementById('add');

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

            function containsDiacritics(input) {
                var diacriticsPattern = /[\u0300-\u036f]/g;
                return diacriticsPattern.test(input);
            }

            const isValidPhoneNumber = phone => {
                const regex = /^(0|\+84)(\s|\.)?((3[2-9])|(5[689])|(7[06-9])|(8[1-689])|(9[0-46-9]))(\d)(\s|\.)?(\d{3})(\s|\.)?(\d{3})$/;
                return regex.test(String(phone).toLowerCase());
            };

            const isValidUsername = user_name => {
                const regex = /^[a-z0-9_-]{3,16}$/;
                return regex.test(String(user_name).toLowerCase());
            };

            const validateInputs = () => {
                const phoneValue = phone.value.trim();
                const nameValue = full_name.value.trim();
                const usernameValue = user_name.value.trim();
                const pwdValue = pwd.value.trim();
                const addValue = add.value.trim();

                let hasError = false;

                if (nameValue === '') {
                    full_name.classList.add('invalid')
                    full_name.classList.remove('valid')
                    setError(full_name, 'Full name is required');
                    hasError = true;
                } else {
                    full_name.classList.remove('invalid')
                    full_name.classList.add('valid')
                    setSuccess(full_name);
                }

                if (usernameValue === '') {
                    user_name.classList.add('invalid')
                    user_name.classList.remove('valid')
                    setError(user_name, 'User name is required');
                    hasError = true;
                } else if (!isValidUsername(usernameValue)) {
                    user_name.classList.add('invalid')
                    user_name.classList.remove('valid')
                    setError(user_name, 'Username cannot have accents');
                    hasError = true;
                } else {
                    user_name.classList.remove('invalid')
                    user_name.classList.add('valid')
                    setSuccess(user_name);
                }

                if (pwdValue === '') {
                    pwd.classList.add('invalid')
                    pwd.classList.remove('valid')
                    setError(pwd, 'Password is required');
                    hasError = true;
                } else if (!isValidUsername(pwdValue)) {
                    pwd.classList.add('invalid')
                    pwd.classList.remove('valid')
                    setError(pwd, 'Password cannot have accents');
                    hasError = true;
                } else {
                    pwd.classList.remove('invalid')
                    pwd.classList.add('valid')
                    setSuccess(pwd);
                }
                if (nameValue === '') {
                    full_name.classList.add('invalid')
                    full_name.classList.remove('valid')
                    setError(full_name, 'Full name is required');
                    hasError = true;
                } else {
                    full_name.classList.remove('invalid')
                    full_name.classList.add('valid')
                    setSuccess(full_name);
                }
                if (addValue === '') {
                    add.classList.add('invalid')
                    add.classList.remove('valid')
                    setError(add, 'Address is required');
                    hasError = true;
                } else {
                    add.classList.remove('invalid')
                    add.classList.add('valid')
                    setSuccess(add);
                }
                if (phoneValue === '') {
                    phone.classList.add('invalid')
                    phone.classList.remove('valid')
                    setError(phone, 'Phone is required');
                    hasError = true;
                } else if (!isValidPhoneNumber(phoneValue)) {
                    phone.classList.add('invalid')
                    phone.classList.remove('valid')
                    setError(phone, 'Provide a valid phone number');
                    hasError = true;
                } else {
                    phone.classList.remove('invalid')
                    phone.classList.add('valid')
                    setSuccess(phone);
                }
                return !hasError;
            };

            form.addEventListener('submit', function (e) {
                if (!validateInputs()) {
                    console.log("hello")
                    e.preventDefault(); // Ngăn chặn biểu mẫu gửi đi nếu có lỗi
                }
            });

        </script>
        <%
            HttpSession sess = request.getSession();
            String mesg = (String) sess.getAttribute("status");
        %>
        <script>
            createToast("<%= mesg%>")
        </script>
        <%
            sess.setAttribute("status", "");
        %>


    </body>

</html>