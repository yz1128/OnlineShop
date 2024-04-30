<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>网上商城</title>
  <link href="css/bootstrap.min5.3.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<!-- 导航栏 -->
<%@include file="head.jsp" %>

<!-- 商品展示 -->
<div class="shop">
    <div id="product-container" class="product-container" style="display: flex; flex-wrap: wrap; justify-content: space-between;">
        <ul>
            <li>

            </li>
        </ul>

    </div>
</div>
<%@include file="footer.jsp" %>
<%-- 异步加载商品数据 --%>
</body>
</html>

