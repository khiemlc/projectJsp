<%-- 
    Document   : index
    Created on : Oct 5, 2023, 2:33:36 PM
    Author     : Le Chi Khiem - CE171515
--%>

<%@page import="Models.Account"%>
<%@page import="DAOs.UserDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <style>
            body {
                background: linear-gradient(to right, #0f2027, #203a43, #2c5364);
                font-family: 'Poppins', sans-serif;
            }

            #form {
                width: 300px;
                margin: 20vh auto 0 auto;
                padding: 20px;
                background-color: whitesmoke;
                border-radius: 4px;
                font-size: 12px;
            }

            #form h1 {
                color: #0f2027;
                text-align: center;
            }

            #form #btnLogin {
                padding: 10px;
                margin-top: 10px;
                width: 100%;
                color: white;
                font-size: 20px;
                background-color: rgb(41, 57, 194);
                border: none;
                border-radius: 4px;
            }

            #form #btnLogin:hover{
                cursor: pointer;
                filter: brightness(200%);
                background: rgb(68, 79, 182);
            }

            .input-control {
                display: flex;
                flex-direction: column;
            }

            .input-control input:focus {
                outline: 0;
            }

            .input-control input {
                border: 2px solid #f0f0f0;
                border-radius: 4px;
                display: block;
                font-size: 12px;
                padding: 10px;
                width: 90%;
            }

            /* display border red color when error */
            .input-control.error input {
                border-color: #ff3860;
            }

            /* display error message */
            .input-control .error {
                color: #ff3860;
                font-size: 9px;
                height: 13px;
            }
        </style>

    </head>
    <body>          

        <%
            if (request.getParameter("username") != null) {
                Cookie[] cList = request.getCookies();
                for (Cookie c : cList) {
                    if (c.getName().equals("login")) {
                        c.setMaxAge(0);
                        response.addCookie(c);
                    }
                }
            }
        %>
                    
        <%
            if (request.getParameter("submit") != null && request.getParameter("submit").equals("") == false) {
                UserDAO uDAO = new UserDAO();
                String userName = request.getParameter("userName");
                String pass = request.getParameter("password");
                String pass_hash = uDAO.getMd5(pass);
                Account acc = uDAO.getUser(userName, pass_hash);
                if (acc == null) {
                    response.sendRedirect("index.jsp?loginFail=1");
                } else {
                    Cookie c = new Cookie("login", "username");
                    c.setMaxAge(24 * 60 * 60 * 3);
                    response.addCookie(c);
                    response.sendRedirect("list.jsp?userName="+userName);
                }
            }
        %>

        <form id="form" method="post" onsubmit="return validate()">
            <h1>Login Form</h1>
            <div class="input-control">
                <label for="userName">User Name:</label>
                <input type="text" name="userName" id="userName">
                <div class="error"></div>
            </div>
            <div class="input-control">
                <label for="password">Password:</label>
                <input type="password" name="password" id="password">
                <div class="error"></div>
            </div>
            <button id="btnLogin" type="submit" name="submit" value="Login">Login</button>
            <%
                String err = request.getParameter("loginFail");
                if ("1".equals(err)) {
                    out.print("<h3 style=\"color: red;\">Đăng nhập thất bại</h3>");
                }
            %>
        </form>

        <script>
            function validate() {
                var user = document.getElementById("userName");
                var pass = document.getElementById("password");
                if (user.value !== "" && pass.value !== "") {
                    return true;
                } else {
                    validateInputs();
                    alert("Dữ liệu không được để trống. Vui lòng kiểm tra lại.");
                    return false;
                }
            }

            const setError = (element, message) => {
                const inputControl = element.parentElement;
                const errorDisplay = inputControl.querySelector('.error');

                errorDisplay.innerText = message;
                inputControl.classList.add('error');
                inputControl.classList.remove('success');
            };

            const validateInputs = () => {
                var user = document.getElementById("userName");
                var pass = document.getElementById("password");

                const usernameValue = user.value.trim();
                const passwordValue = pass.value.trim();

                if (usernameValue === "") {
                    setError(user, "Username is required");
                }
                if (passwordValue === "") {
                    setError(pass, "Password is required");
                } else if (passwordValue.length < 5) {
                    setError(pass, "Password must be at least 5 character.");
                }
            };
        </script>
    </body>
</html>
