<%-- 
    Document   : list
    Created on : Oct 5, 2023, 3:34:55 PM
    Author     : Le Chi Khiem - CE171515
--%>

<%@page import="Models.Account"%>
<%@page import="DAOs.UserDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Information</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"/>

        <!-- Latest compiled JavaScript -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

    </head>
    <body>
        <h1 style="padding: 20px 0 20px 50px">Information's User</h1>
        <%
            Cookie[] cList = null;
            cList = request.getCookies();
            if (cList == null) {
                response.sendRedirect("index.jsp");

            } else {
                boolean flag = false;
                for (Cookie c : cList) {
                    if (c.getName().equals("login") && c.getValue().equals("username")) {
                        flag = true;
                        break;      // nguoi dung dang nhap            
                    }
                }
                if (!flag) {
                    response.sendRedirect("index.jsp");
                }
            }
        %>

        <%
            UserDAO uDAO = new UserDAO();
            String userName = request.getParameter("userName");
            Account acc = uDAO.getInfo(userName);
            if (acc != null) {
        %> 
        <div class="container">
            <div class="row bg-light mb-4 p-3">
                <div class="col-sm-10"></div>
                <div class="col-sm-2"> Hello,<%=acc.getFullName()%>  <a onclick="return confirm('Are you sure you want to log out?')" href="index.jsp?username=<%=acc.getUserName()%>">Log out</a> 
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-bordered table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>User Name</th>
                            <th>Full Name</th>
                            <th>Gender</th>
                            <th>Birthday</th>
                            <th>Department</th>
                        </tr>
                    </thead>
                    <tbody class="table-light">
                        <tr>
                            <td><%=acc.getUserName()%></td>
                            <td><%=acc.getFullName()%></td>
                            <td><%=acc.getGender()%></td>
                            <td><%=acc.getBirthday()%></td>
                            <td><%=acc.getDepartment()%></td>
                        </tr>
                    </tbody>
                </table>

            </div>
        </div>
        <%
            }
        %>




    </body>
</html>
