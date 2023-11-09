<%-- 
    Document   : addProduct
    Created on : Nov 7, 2023, 1:30:50 PM
    Author     : HIEU
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.CategoryDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://kit.fontawesome.com/ae360af17e.js" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
        <title>Nghien Nhua</title>
        <link rel="shortcut icon" href="/Front/assets/image/logo/z4705695345706_20ca59964f9ad379fcebb44ceaad6cd4-removebg-preview.png"/>
        <style>
            <%@include file="/Front/assets/css/adminCss.css" %>
            .form-control.valid {
                border-color: #28a745;
                padding-right: calc(1.5em + 0.75rem);
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 8 8'%3e%3cpath fill='%2328a745' d='M2.3 6.73L.6 4.53c-.4-1.04.46-1.4 1.1-.8l1.1 1.4 3.4-3.8c.6-.63 1.6-.27 1.2.7l-4 4.6c-.43.5-.8.4-1.1.1z'/%3e%3c/svg%3e");
                background-repeat: no-repeat;
                background-position: center right calc(0.375em + 0.1875rem);
                background-size: calc(0.75em + 0.375rem) calc(0.75em + 0.375rem);
            }
            .form-control.invalid{
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
                <nav class="navbar navbar-expand px-3">
                    <!-- Button for sidebar toggle -->
                    <button class="btn" type="button" data-bs-theme="dark">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                </nav>
                <div class="container-fluid bg-light" style="border-radius: 10px">
                    <div class="container p-5">
                        <div>
                            <h2>Create New</h2>
                            <p>Product</p>
                            <hr class="bg-danger border-1 border-top border-dark" />
                        </div>

                        <form  method="post" id="form" action="UserController" enctype="multipart/form-data" class="row my-4 g-3 needs-validation d-flex justify-content-center" novalidate>

                            <div class="col-md-8 row my-2 d-flex justify-content-between">
                                <div class="col-auto">
                                    <label for="exampleFormControlInput1" class="form-label">Name:</label>
                                </div>
                                <div class="col-md-10">
                                    <input type="text" class="form-control" id="Pro_name" name="txtName"
                                           >
                                    <div class="form-message text-start"></div>
                                </div>
                            </div>

                            <div class="col-md-8 row my-2 d-flex justify-content-between">
                                <div class="col-auto">
                                    <label for="exampleFormControlInput1" class="form-label">Price:</label>
                                </div>
                                <div class="col-md-10">
                                    <input type="number" class="form-control" id="Pro_price" name="txtPrice">
                                    <div class="form-message text-start"></div>
                                </div>
                            </div>

                            <div class="col-md-8 row my-2 d-flex justify-content-between">
                                <div class="col-auto">
                                    <label for="exampleFormControlInput1" class="form-label">Quantity:</label>
                                </div>
                                <div class="col-md-10">
                                    <input type="number" class="form-control" id="Pro_quan" name="txtQuantity">
                                    <div class="form-message text-start"></div>
                                </div>
                            </div>

                            <div class="col-md-8 row my-2 d-flex justify-content-between">
                                <div class="col-auto">
                                    <label for="formFile" class="form-label">Picture:</label>
                                </div>
                                <div class="col-md-10">
                                    <input class="form-control" type="file" id="formFile" name="txtPicture"  multiple="true">
                                    <div class="form-message text-start"></div>
                                </div>
                            </div>

                            <div class="col-md-8 row my-2 d-flex justify-content-between">
                                <div class="col-auto">
                                    <label for="exampleFormControlTextarea1" class="form-label">Description:</label>
                                </div>
                                <div class="col-md-10">
                                    <input  type="text" class="form-control" id="Pro_des" name="txtDescription">
                                    <div class="form-message text-start"></div>
                                </div>
                            </div>

                            <div class="col-md-8 row my-2 d-flex justify-content-between">
                                <div class="col-auto">
                                    <label for="exampleFormControlInput1" class="form-label">Discount:</label>
                                </div>
                                <div class="col-md-10">
                                    <input type="number" class="form-control" id="Pro_dis" name="txtDiscount">
                                    <div class="form-message text-start"></div>
                                </div>
                            </div>
                            <div class="col-md-8 row my-2 d-flex justify-content-between">
                                <div class="col-auto">
                                    <label for="category" class="form-label">Type: </label>
                                </div>
                                <div class="col-md-10">
                                    <select class="form-select form-control" aria-label="Default select example" name="txtCateName" id="category" onchange="showFields()">
                                        <option value="default">-- Choose --</option>
                                        <%
                                            CategoryDAO cDAO = new CategoryDAO();
                                            ResultSet rs = cDAO.getAll();
                                            while (rs.next()) {
                                        %>      
                                        <option value="<%= rs.getString("product_id")%>"><%= rs.getString("product_name")%></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                    <div class="form-message text-start"></div>
                                </div>
                            </div>
                            <div id="fields" class="row  d-flex justify-content-center"></div>
                            <div class="col-12 my-2 d-flex justify-content-center gap-2">
                                <input type="submit" value="Create" name="btnAddNew" class="btn btn-primary"/>
                                <a href="/AdminController/Admin">
                                    <button type="button" class="btn btn-danger" name="btnBack"> Back to list</button>
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script>
            function showFields() {
                var category = document.getElementById("category").value;
                var fieldsDiv = document.getElementById("fields");
                fieldsDiv.innerHTML = "";
                if (category === "1") {
                    fieldsDiv.innerHTML = `
<div class="col-md-8 row my-2 d-flex justify-content-between">
<div class="col-auto">
<label for="exampleFormControlInput1" class="form-label">Led:</label>
</div>
<div class="col-md-10">
<input type="text" class="form-control" id="keyboard_led" name="led_keyboard">
<div class="form-message text-start"></div>
</div>
</div>
<div class="col-md-8 row my-2 d-flex justify-content-between">
<div class="col-auto">
<label for="exampleFormControlInput1" class="form-label">Mode:</label>
</div>
<div class="col-md-10">
<input type="text" class="form-control" id="keyboard_mode" name="mode_keyboard">
<div class="form-message"></div>
</div>
</div>
<div class="col-md-8 row my-2 d-flex justify-content-between">
<div class="col-auto">
<label for="exampleFormControlInput1" class="form-label">Switch:</label>
</div>
<div class="col-md-10">
<input type="text" class="form-control" id="keyboard_switch" name="switchType_keyboard">
<div class="form-message"></div>
</div>
</div>
<div class="col-md-8 row my-2 d-flex justify-content-between">
<div class="col-auto">
<label for="exampleFormControlInput1" class="form-label">Keycap:</label>
</div>
<div class="col-md-10">
<input type="text" class="form-control" id="keyboard_keycap" name="keycapType_keyboard">
<div class="form-message"></div>
</div>
</div>
`;
                    const keyboard_led = document.getElementById('keyboard_led');
                    const keyboard_mode = document.getElementById('keyboard_mode');
                    const keyboard_switch = document.getElementById('keyboard_switch');
                    const keyboard_keycap = document.getElementById('keyboard_keycap');
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
                        const regex = /^[1-9]\d*$/;
                        return regex.test(String(number).toLowerCase());
                    };
                    const validateInputs = () => {
                        const keyboard_ledValue = keyboard_led.value.trim();
                        const keyboard_modeValue = keyboard_mode.value.trim();
                        const keyboard_switchValue = keyboard_switch.value.trim();
                        const keyboard_keycapValue = keyboard_keycap.value.trim();
                        let hasError = false;

                        if (keyboard_ledValue === '') {
                            keyboard_led.classList.add('invalid');
                            keyboard_led.classList.remove('valid');
                            setError(keyboard_led, 'Keyboard led is required');
                            hasError = true;
                        } else {
                            keyboard_led.classList.remove('invalid');
                            keyboard_led.classList.add('valid');
                            setSuccess(keyboard_led);
                        }

                        if (keyboard_modeValue === '') {
                            keyboard_mode.classList.add('invalid');
                            keyboard_mode.classList.remove('valid');
                            setError(keyboard_mode, 'Keyboard mode is required');
                            hasError = true;
                        } else if (!isValidNumber(keyboard_modeValue)) {
                            keyboard_mode.classList.add('invalid');
                            keyboard_mode.classList.remove('valid');
                            setError(keyboard_mode, 'Provide a valid number');
                            hasError = true;
                        } else {
                            keyboard_mode.classList.remove('invalid');
                            keyboard_mode.classList.add('valid');
                            setSuccess(keyboard_mode);
                        }

                        if (keyboard_switchValue === '') {
                            keyboard_switch.classList.add('invalid');
                            keyboard_switch.classList.remove('valid');
                            setError(keyboard_switch, 'Keyboard switch is required');
                            hasError = true;
                        } else {
                            keyboard_switch.classList.remove('invalid');
                            keyboard_switch.classList.add('valid');
                            setSuccess(keyboard_switch);
                        }

                        if (keyboard_keycapValue === '') {
                            keyboard_keycap.classList.add('invalid');
                            keyboard_keycap.classList.remove('valid');
                            setError(keyboard_keycap, 'Keyboard keycap is required');
                            hasError = true;
                        } else {
                            keyboard_keycap.classList.remove('invalid');
                            keyboard_keycap.classList.add('valid');
                            setSuccess(keyboard_keycap);
                        }

                        return !hasError;
                    }
                    ;
                    form.addEventListener('submit', function (e) {
                        if (!validateInputs()) {
                            e.preventDefault(); // Ngăn chặn biểu mẫu gửi đi nếu có lỗi
                        }
                    });
                } else if (category === "2") {
                    fieldsDiv.innerHTML = `
<div class="col-md-8 row my-2 d-flex justify-content-between">
<div class="col-auto">
<label for="exampleFormControlInput1" class="form-label">Layout:</label> 
</div>
<div class="col-md-10">
<input type="text" class="form-control" id="kit_layout" name="layout_kit">
<div class="form-message"></div>
</div>
</div>
<div class="col-md-8 row my-2 d-flex justify-content-between">
<div class="col-auto">
<label for="exampleFormControlInput1" class="form-label">Mạch:</label>
</div>
<div class="col-md-10">            
<input type="text" class="form-control" id="kit_circuit" name="circuit_kit">
<div class="form-message"></div>
</div>
</div>
<div class="col-md-8 row my-2 d-flex justify-content-between">
<div class="col-auto">
<label for="exampleFormControlInput1" class="form-label">Plate:</label>
                    
 </div>
<div class="col-md-10">
<input type="text" class="form-control" id="kit_plate" name="plate_kit">
<div class="form-message"></div>
</div>
</div>
</div><div class="col-md-8 row my-2 d-flex justify-content-between">
<div class="col-auto">
<label for="exampleFormControlInput1" class="form-label">Mode:</label>
 </div>
<div class="col-md-10">
<input type="number" class="form-control" id="kit_mode" name="mode_kit">
<div class="form-message"></div>
</div>
</div>
<div class="col-md-8 row my-2 d-flex justify-content-between">
<div class="col-auto">
<label for="exampleFormControlInput1" class="form-label">Case:</label>
</div>
<div class="col-md-10">
<input type="text" class="form-control" id="kit_case" name="case_kit">
<div class="form-message"></div>
</div>
</div>
`;
                    const kit_layout = document.getElementById('kit_layout');
                    const kit_circuit = document.getElementById('kit_circuit');
                    const kit_plate = document.getElementById('kit_plate');
                    const kit_mode = document.getElementById('kit_mode');
                    const kit_case = document.getElementById('kit_case');
                    let hasError = false;

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
                        const regex = /^[1-9]\d*$/;
                        return regex.test(String(number).toLowerCase());
                    };
                    const validateInputs = () => {
                        const kit_layoutValue = kit_layout.value.trim();
                        const kit_circuitValue = kit_circuit.value.trim();
                        const kit_plateValue = kit_plate.value.trim();
                        const kit_modeValue = kit_mode.value.trim();
                        const kit_caseValue = kit_case.value.trim();
                        let hasError = false;
                        if (kit_layoutValue === '') {
                            kit_layout.classList.add('invalid');
                            kit_layout.classList.remove('valid');
                            setError(kit_layout, 'Kit layout is required');
                            hasError = true;
                        } else {
                            kit_layout.classList.remove('invalid');
                            kit_layout.classList.add('valid');
                            setSuccess(kit_layout);
                        }

                        if (kit_circuitValue === '') {
                            kit_circuit.classList.add('invalid');
                            kit_circuit.classList.remove('valid');
                            setError(kit_circuit, 'Kit circuit is required');
                            hasError = true;
                        } else {
                            kit_circuit.classList.remove('invalid');
                            kit_circuit.classList.add('valid');
                            setSuccess(kit_circuit);
                        }

                        if (kit_plateValue === '') {
                            kit_plate.classList.add('invalid');
                            kit_plate.classList.remove('valid');
                            setError(kit_plate, 'Kit plate is required');
                            hasError = true;
                        } else {
                            kit_plate.classList.remove('invalid');
                            kit_plate.classList.add('valid');
                            setSuccess(kit_plate);
                        }

                        if (kit_modeValue === '') {
                            kit_mode.classList.add('invalid');
                            kit_mode.classList.remove('valid');
                            setError(kit_mode, 'Kit mode is required');
                            hasError = true;
                        } else if (!isValidNumber(kit_modeValue)) {
                            kit_mode.classList.add('invalid');
                            kit_mode.classList.remove('valid');
                            setError(kit_mode, 'Provide a valid number');
                            hasError = true;
                        } else {
                            kit_mode.classList.remove('invalid');
                            kit_mode.classList.add('valid');
                            setSuccess(kit_mode);
                        }

                        if (kit_caseValue === '') {
                            kit_case.classList.add('invalid');
                            kit_case.classList.remove('valid');
                            setError(kit_case, 'Kit case is required');
                            hasError = true;
                        } else {
                            kit_case.classList.remove('invalid');
                            kit_case.classList.add('valid');
                            setSuccess(kit_case);
                        }
                        return !hasError;
                    }
                    ;
                    form.addEventListener('submit', function (e) {
                        if (!validateInputs()) {
                            e.preventDefault(); // Ngăn chặn biểu mẫu gửi đi nếu có lỗi
                        }
                    });


                } else if (category === "3") {
                    fieldsDiv.innerHTML = `
<div class="col-md-8 row my-2 d-flex justify-content-between">
<div class="col-auto">
<label for="exampleFormControlInput1" class="form-label">Chất liệu:</label>
</div>
<div class="col-md-10">            
<input type="text" class="form-control" id="keycap_material" name="material_key_cap">
<div class="form-message"></div>
</div>
</div>
<div class="col-md-8 row my-2 d-flex justify-content-between">
<div class="col-auto">
<label for="exampleFormControlInput1" class="form-label">Layout:</label>
</div>
<div class="col-md-10">            
<input type="text" class="form-control" id="keycap_layout" name="layout_keycap">
<div class="form-message"></div>
</div>
</div>
<div class="col-md-8 row my-2 d-flex justify-content-between">
<div class="col-auto">
<label for="exampleFormControlInput1" class="form-label">Độ dày:</label>
</div>
<div class="col-md-10">            
<input type="text" class="form-control" id="keycap_thickness" name="thickness_keycap">
<div class="form-message"></div>
</div>
</div>
<div class="col-md-8 row my-2 d-flex justify-content-between">
<div class="col-auto">
<label for="exampleFormControlInput1" class="form-label">Độ bền:</label>
</div>
<div class="col-md-10">                   
<input type="text" class="form-control" id="keycap_durability" name="durability_keycap">
<div class="form-message"></div>
</div>
</div>
`;
                    const keycap_material = document.getElementById('keycap_material');
                    const keycap_layout = document.getElementById('keycap_layout');
                    const keycap_thickness = document.getElementById('keycap_thickness');
                    const keycap_durability = document.getElementById('keycap_durability');
                    let hasError = false;

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
                        const regex = /^[1-9]\d*$/;
                        return regex.test(String(number).toLowerCase());
                    };
                    const validateInputs = () => {
                        const keycap_materialValue = keycap_material.value.trim();
                        const keycap_layoutValue = keycap_layout.value.trim();
                        const keycap_thicknessValue = keycap_thickness.value.trim();
                        const keycap_durabilityValue = keycap_durability.value.trim();

                        let hasError = false;
                        if (keycap_materialValue === '') {
                            keycap_material.classList.add('invalid');
                            keycap_material.classList.remove('valid');
                            setError(keycap_material, 'Keycap material is required');
                            hasError = true;
                        } else {
                            keycap_material.classList.remove('invalid');
                            keycap_material.classList.add('valid');
                            setSuccess(keycap_material);
                        }

                        if (keycap_layoutValue === '') {
                            keycap_layout.classList.add('invalid');
                            keycap_layout.classList.remove('valid');
                            setError(keycap_layout, 'Keycap layout is required');
                            hasError = true;
                        } else {
                            keycap_layout.classList.remove('invalid');
                            keycap_layout.classList.add('valid');
                            setSuccess(keycap_layout);
                        }

                        if (keycap_thicknessValue === '') {
                            keycap_thickness.classList.add('invalid');
                            keycap_thickness.classList.remove('valid');
                            setError(keycap_thickness, 'keycap thickness is required');
                            hasError = true;
                        } else if (!isValidNumber(keycap_thicknessValue)) {
                            keycap_thickness.classList.add('invalid');
                            keycap_thickness.classList.remove('valid');
                            setError(keycap_thickness, 'Provide kit_modea valid number');
                            hasError = true;
                        } else {
                            keycap_thickness.classList.remove('invalid');
                            keycap_thickness.classList.add('valid');
                            setSuccess(keycap_thickness);
                        }

                        if (keycap_durabilityValue === '') {
                            keycap_durability.classList.add('invalid');
                            keycap_durability.classList.remove('valid');
                            setError(keycap_durability, 'Keycap durabilitye is required');
                            hasError = true;
                        } else {
                            keycap_durability.classList.remove('invalid');
                            keycap_durability.classList.add('valid');
                            setSuccess(keycap_durability);
                        }
                        return !hasError;
                    }
                    ;
                    form.addEventListener('submit', function (e) {
                        if (!validateInputs()) {
                            e.preventDefault(); // Ngăn chặn biểu mẫu gửi đi nếu có lỗi
                        }
                    });

                } else if (category === "4") {
                    fieldsDiv.innerHTML = `
<div class="col-md-8 row my-2 d-flex justify-content-between">
<div class="col-auto">
<label for="exampleFormControlInput1" class="form-label">Pin:</label>
</div>
<div class="col-md-10">            
<input type="text" class="form-control" id="switch_pin" name="pin_switch">
<div class="form-message"></div>
</div>
</div>
</div>
<div class="col-md-8 row my-2 d-flex justify-content-between">
<div class="col-auto">
<label for="exampleFormControlInput1" class="form-label">Type:</label>
</div>
<div class="col-md-10">            
<input type="text" class="form-control" id="switch_type" name="type_switch">
<div class="form-message"></div>
</div>
</div>
<div class="col-md-8 row my-2 d-flex justify-content-between">
<div class="col-auto">
<label for="exampleFormControlInput1" class="form-label">Lò xò:</label>
</div>
<div class="col-md-10">            
<input type="text" class="form-control" id="switch_complexity" name="complexity_switch">
<div class="form-message"></div>
</div>
</div>
<div class="col-md-8 row my-2 d-flex justify-content-between">
<div class="col-auto">
<label for="exampleFormControlInput1" class="form-label">Độ bền:</label>
</div>
<div class="col-md-10">
<input type="text" class="form-control" id="switch_durability" name="durability_switch">
<div class="form-message"></div>
</div>
</div>
<div class="col-md-8 row my-2 d-flex justify-content-between">
<div class="col-auto">
<label for="exampleFormControlInput1" class="form-label">Hành trình:</label>
</div>
<div class="col-md-10">
<input type="text" class="form-control" id="switch_travel" name="travel_switch">
<div class="form-message"></div>
</div>
</div>
`;
                    const switch_pin = document.getElementById('switch_pin');
                    const switch_type = document.getElementById('switch_type');
                    const switch_complexity = document.getElementById('switch_complexity');
                    const switch_durability = document.getElementById('switch_durability');
                    const switch_travel = document.getElementById('switch_travel');
                    let hasError = false;

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
                        const regex = /^[1-9]\d*$/;
                        return regex.test(String(number).toLowerCase());
                    };
                    const validateInputs = () => {
                        const switch_pinValue = switch_pin.value.trim();
                        const switch_typeValue = switch_type.value.trim();
                        const switch_complexityValue = switch_complexity.value.trim();
                        const switch_durabilityValue = switch_durability.value.trim();
                        const switch_travelValue = switch_travel.value.trim();

                        if (switch_pinValue === '') {
                            switch_pin.classList.add('invalid');
                            switch_pin.classList.remove('valid');
                            setError(switch_pin, 'Switch pin is required');
                            hasError = true;
                        } else {
                            switch_pin.classList.remove('invalid');
                            switch_pin.classList.add('valid');
                            setSuccess(switch_pin);
                        }

                        if (switch_typeValue === '') {
                            switch_type.classList.add('invalid');
                            switch_type.classList.remove('valid');
                            setError(switch_type, 'Switch type is required');
                            hasError = true;
                        } else {
                            switch_type.classList.remove('invalid');
                            switch_type.classList.add('valid');
                            setSuccess(switch_type);
                        }

                        if (switch_complexityValue === '') {
                            switch_complexity.classList.add('invalid');
                            switch_complexity.classList.remove('valid');
                            setError(switch_complexity, 'Switch complexity is required');
                            hasError = true;
                        } else {
                            switch_complexity.classList.remove('invalid');
                            switch_complexity.classList.add('valid');
                            setSuccess(switch_complexity);
                        }

                        if (switch_durabilityValue === '') {
                            switch_durability.classList.add('invalid');
                            switch_durability.classList.remove('valid');
                            setError(switch_durability, 'Switch complexity is required');
                            hasError = true;
                        } else {
                            switch_durability.classList.remove('invalid');
                            switch_durability.classList.add('valid');
                            setSuccess(switch_durability);
                        }

                        if (switch_travelValue === '') {
                            switch_travel.classList.add('invalid');
                            switch_travel.classList.remove('valid');
                            setError(switch_travel, 'Switch travel is required');
                            hasError = true;
                        } else {
                            switch_travel.classList.remove('invalid');
                            switch_travel.classList.add('valid');
                            setSuccess(switch_travel);
                        }

                        return !hasError;
                    }
                    ;
                    form.addEventListener('submit', function (e) {
                        if (!validateInputs()) {
                            e.preventDefault(); // Ngăn chặn biểu mẫu gửi đi nếu có lỗi
                        }
                    });


                }
            }
        </script>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const form = document.querySelector('#form');
                const pro_name = document.getElementById('Pro_name');
                const pro_price = document.getElementById('Pro_price');
                const pro_quan = document.getElementById('Pro_quan');
                const pro_pic = document.getElementById('formFile');
                const pro_des = document.getElementById('Pro_des');
                const pro_dis = document.getElementById('Pro_dis');
                const pro_type = document.getElementById('category');


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
                    const regex = /^[1-9]\d*$/;
                    return regex.test(String(number).toLowerCase());
                };
                const isValidDiscount = number => {
                    const regex = /^[0-9]\d*$/;
                    return regex.test(String(number).toLowerCase());
                };
                const validateInputs = () => {
                    const pro_nameValue = pro_name.value.trim();
                    const pro_priceValue = pro_price.value.trim();
                    const pro_quanValue = pro_quan.value.trim();
                    const pro_picValue = pro_pic.value.trim();
                    const pro_desValue = pro_des.value.trim();
                    const pro_disValue = pro_dis.value.trim();
                    const pro_typeValue = pro_type.value.trim();
                    let hasError = false;

                    if (pro_nameValue === '') {
                        pro_name.classList.add('invalid');
                        pro_name.classList.remove('valid');
                        setError(pro_name, 'Full name is required');
                        hasError = true;
                    } else {
                        pro_name.classList.remove('invalid');
                        pro_name.classList.add('valid');
                        setSuccess(pro_name);
                    }



                    if (pro_priceValue === '') {
                        pro_price.classList.add('invalid');
                        pro_price.classList.remove('valid');
                        setError(pro_price, 'Price is required');
                        hasError = true;
                    } else if (!isValidNumber(pro_priceValue)) {
                        pro_price.classList.add('invalid');
                        pro_price.classList.remove('valid');
                        setError(pro_price, 'Provide a valid number');
                        hasError = true;
                    } else {
                        pro_price.classList.remove('invalid');
                        pro_price.classList.add('valid');
                        setSuccess(pro_price);
                    }

                    if (pro_quanValue === '') {
                        pro_quan.classList.add('invalid');
                        pro_quan.classList.remove('valid');
                        setError(pro_quan, 'Quantity is required');
                        hasError = true;
                    } else if (!isValidNumber(pro_quanValue)) {
                        pro_quan.classList.add('invalid');
                        pro_quan.classList.remove('valid');
                        setError(pro_quan, 'Provide quantity a valid number');
                        hasError = true;
                    } else {
                        pro_quan.classList.remove('invalid');
                        pro_quan.classList.add('valid');
                        setSuccess(pro_quan);
                    }



                    if (pro_picValue === '') {
                        pro_pic.classList.add('invalid');
                        pro_pic.classList.remove('valid');
                        setError(pro_pic, 'Picture is required');
                        hasError = true;
                    } else {
                        pro_pic.classList.remove('invalid');
                        pro_pic.classList.add('valid');
                        setSuccess(pro_pic);
                    }

                    if (pro_desValue === '') {
                        pro_des.classList.add('invalid');
                        pro_des.classList.remove('valid');
                        setError(pro_des, 'Description is required');
                        hasError = true;
                    } else {
                        pro_des.classList.remove('invalid');
                        pro_des.classList.add('valid');
                        setSuccess(pro_des);
                    }

                    if (pro_disValue === '') {
                        pro_dis.classList.add('invalid');
                        pro_dis.classList.remove('valid');
                        setError(pro_dis, 'Discount is required');
                        hasError = true;
                    } else if (!isValidDiscount(pro_disValue)) {
                        pro_dis.classList.add('invalid');
                        pro_dis.classList.remove('valid');
                        setError(pro_dis, 'Provide discount a valid number');
                        hasError = true;
                    } else {
                        pro_dis.classList.remove('invalid');
                        pro_dis.classList.add('valid');
                        setSuccess(pro_dis);
                    }


                    if (pro_typeValue === 'default') {
                        pro_type.classList.add('invalid');
                        pro_type.classList.remove('valid');
                        setError(pro_type, 'Type is required');
                        hasError = true;
                    } else {
                        pro_type.classList.remove('invalid');
                        pro_type.classList.add('valid');
                        setSuccess(pro_type);
                    }

                    return !hasError;
                }
                ;
                form.addEventListener('submit', function (e) {
                    if (!validateInputs()) {
                        e.preventDefault(); // Ngăn chặn biểu mẫu gửi đi nếu có lỗi
                    }
                });
            }
            );
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
    </body>
</html>
