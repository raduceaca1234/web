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
    <title>Login</title>
    <link rel="stylesheet" href="login.css" type="text/css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.css">
</head>
<body>
<form action="LoginServlet" method="post">
    <div class="form-group">
        Enter username : <input type="text" name="username"> <BR>
        Enter password : <input type="password" name="password"> <BR>
        <input type="submit" value="Login"/>
    </div>
</form>
</body>
</html>