<%@ page import="model.User" %>
<%
    if (request.getParameter("level") != null && request.getParameter("ini_len") != null) {
        int $level = 1;
        try {
            $level = Integer.parseInt(request.getParameter("level"));
        } catch (Exception e) {
        }
        int $ini_len = 0;
        try {
            $ini_len = Integer.parseInt(request.getParameter("ini_len"));
        } catch (Exception e) {
        }
        if ($level < 0) {
            $level = 1;
        }
        if ($level > 10) {
            $level = 10;
        }
        if ($ini_len < 1) {
            $ini_len = 1;
        }
        if ($ini_len > 20) {
            $ini_len = 20;
        }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Snake</title>
    <link rel="stylesheet" href="homepage.css" type="text/css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.css">
</head>
<body>
</body>
</html>
<% } else {%>
<!DOCTYPE html>
<html>
<head>
    <title>Snake v1.0</title>
</head>
<body>
<div class="form-group">
<%
    User user = (User) session.getAttribute("user");
    if(user!=null){
        out.println("Welcome, "+user.getUsername());
        out.println("<ul style=\"list-style-type:none;\" class = \"list-group\">");
        out.println("<li class=\"list-group-item\">Name: " + user.getName() + "</li>");
        out.println("<li class=\"list-group-item\">Email: " + user.getEmail() +"</li>");
        out.println("</ul>");
    }
%>
    <div>
        <form action="LogoutServlet" method="post">
            <input type="submit" name="logout" value="Logout">
        </form>
    </div>
    <div>
        <button type="button" onclick="location.href='update.jsp'">Update your profile</button>
    </div>
</div>
<form method="POST" action="snake.jsp">
    Level: <select name="level">
    <%
        for (int $i = 1; $i <= 10; $i++) {
    %>
    <option value="<%= $i%>"><%= $i%></option>
    <%
        }
    %>
</select>
    Initial Length: <select name="ini_len">
    <%
        for (int $i = 1; $i <= 20; $i++) {
    %>
    <option value="<%= $i%>"><%= $i%></option>
    <%
        }
    %>
</select>
    <input type="submit" name="submit" value="Start Game" />
</form>
</body>
</html>
<%
    }
%>