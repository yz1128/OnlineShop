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

<div class="shop">
    <br>
    <h3 style="text-align: center">全部订单</h3>
    <br>
    <div class="row" id="goods" style="width: 1202px;  padding-left: 0; padding-right: 0; margin-left: 0; margin-right: 0; border-left-width: 0; border-right-width: 0;">
        <div class="col-12 goodslength"></div>
        <div class="col-2">
            <p>订单编号</p>
        </div>
        <div class="col-2">
            <p>用户信息</p>
        </div>
        <div class="col-1">
            <p>订单状态</p>
        </div>
        <div class="col-2">
            <p>金额</p>
        </div>
        <div class="col-3">
            <p>收货地址</p>
        </div>
        <%--  商品信息  --%>
        <div  id="product-container">

        </div>
    </div>
</div>




<%@include file="footer.jsp"%>


<script>
    $(document).ready(function() {
        // 发起 AJAX 请求获取商品数据
        $.ajax({
            type: "POST",
            url: "showAllOrderServlet",
            dataType: "json",
            success: function(data) {
                // 成功获取数据后，更新页面内容
                var products = data; // 假设返回的数据是商品对象数组
                var container = $("#product-container");
                container.empty(); // 清空容器

                // 遍历商品数据，生成 HTML 内容并添加到容器中
                for (var i = 0; i < products.length; i++) {
                    var product = products[i];
                    var html = "<div class='row goods' style='width: 1202px;'>" +
                        "<div class='col-12'></div>" +
                        "<div class='col-2'> <p>" + product.orderId + "</p></div>" +
                        "<div class='col-2'> <p>" + product.userId + "</p> </div>" +
                        "<div class='col-1'> <p>" + product.orderState + "</p> </div>" +
                        "<div class='col-2'> <p>￥" + product.totalPrice + "</p> </div>" +
                        "<div class='col-3'> <p>   " + product.userAddress + "   </p> </div>" +
                        "</div>";

                    // 添加到容器
                    container.append(html);
                }
            },
            error: function(xhr, status, error) {
                // 处理错误情况
                console.error("Error:", error);
            }
        });
    });
</script>
</body>
</html>
