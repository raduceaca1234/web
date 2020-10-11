<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update info</title>
    <script src="main.js"></script>
    <link rel="stylesheet" href="style.css" type="text/css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.css">
</head>
<body>
<h2>Update info:</h2>
<form action="UpdateServlet" method="post" id="updateForm">
    <div class="form-group" >
    <input type="text" name="name" placeholder="name" id="Name"><br>
    <input type="text" name="email" placeholder="email" id="Email"><br>
    <input type="text" name="age" placeholder="age" id="Age"><br>
    <button type="button" value="Update" onclick="validateUpdateInfo()">Update</button>
    </div>
</form>
</body>
</html>