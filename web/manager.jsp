<%--
  Created by IntelliJ IDEA.
  User: Yanz
  Date: 2024/4/26
  Time: 下午4:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>后台管理</title>
    <link rel="stylesheet" href="css/table.css">
</head>
<body style="background-color: #E8E1DF;">
<%
    if ( session.getAttribute("user") == null || ((User) session.getAttribute("user")).getPower() == 0 ) {
        // 如果 session 不存在或者用户权限为0，则重定向到 login.jsp 页面
        response.sendRedirect("login.jsp");
    }
%>
<%@include file="head.jsp"%>
<!-- TODO(Yanz,2024/4/26 下午11:32): 将manager页面设置成一个导航式页面，从该页面再进行上架物品的管理 -->






<%@include file="footer.jsp"%>
</body>
</html>
