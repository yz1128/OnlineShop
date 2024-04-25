<%@ page import="com.Web.entity.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
    <style>
        .dropdown-menu{
            background-color: rgba(var(--bs-dark-rgb), var(--bs-bg-opacity)) !important;
            width: auto;
        }
        .dropdown-item{
            width: auto;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="index.jsp">网上商城</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="index.jsp">首页</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">社区</a>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        分类
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="#">电脑</a></li>
                        <li><a class="dropdown-item" href="#">手机</a></li>
                        <li><a class="dropdown-item" href="#">平板</a></li>
                        <li><a class="dropdown-item" href="#">配件</a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">关于我们</a>
                </li>
            </ul>
            <form action="#" method="post" class="d-flex">
                <input  class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-success" type="submit">Search</button>
            </form>
            <div class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="userinfo" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    用户名
                </a>
                <ul class="dropdown-menu" aria-labelledby="userinfo">
                    <li><a class="dropdown-item" href="http://localhost:80/Web/userInfoUpdate">用户信息</a></li>
                    <li><a class="dropdown-item" href="#">设置</a></li>
                    <li><a class="dropdown-item" href="http://localhost:80/Web/login.jsp">登录</a></li>
                    <li><a class="dropdown-item" href="http://localhost:80/Web/logout">退出</a></li>
                </ul>
            </div>
            <ul class="navbar-nav  mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="car.jsp">购物车</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!--  -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/jquery-3.7.1.js"></script>

<%
    User user = (User) session.getAttribute("user");
    String userName = user != null ? user.getUserName() : "";
%>

<script>
    $(document).ready(function() {
        var userName = '<%= userName %>'; // 将用户名传递给 JavaScript 变量
        if (userName) {
            $("#userinfo").text(userName); // 更新导航栏中的用户名
            $(".dropdown-menu .dropdown-item:contains('退出')").show(); // 显示退出按钮
            $(".dropdown-menu .dropdown-item:contains('登录')").hide(); // 隐藏登录按钮
        } else {
            $("#userinfo").text("未登录"); // 更新导航栏中的文本为"未登录"
            $(".dropdown-menu .dropdown-item:contains('退出')").hide(); // 隐藏退出按钮
            $(".dropdown-menu .dropdown-item:contains('登录')").show(); // 显示登录按钮
        }
    });
</script>
</body>
</html>