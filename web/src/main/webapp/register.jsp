<%--
  Created by IntelliJ IDEA.
  User: Alex
  Date: 30.04.2020
  Time: 16:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register</title>
    <script src="main.js"></script>
    <link rel="stylesheet" href="style.css" type="text/css">
</head>
<body>
<h2>Register</h2>
<form action="RegisterServlet" method="post" id="registerForm">
    <div class="form-group">
        <input type="text" name="username" placeholder="username" id="username"> <BR>
        <input type="password" name="password" placeholder="password" id="password"> <BR>
        <input type="text" name="name" placeholder="name" id="name"> <BR>
        <input type="text" name="email" placeholder="email" id="email"> <BR>
        <input type="text" name="age" placeholder="age" id="age"> <BR>
        <input type="button" value="Register" onclick="validateRegister()"/>
    </div>
</form>
</body>
</html>