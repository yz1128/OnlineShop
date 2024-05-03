<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>订单</title>
    <link href="css/bootstrap.min5.3.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body style="background-color: #E8E1DF;">
<!-- 导航栏 -->
<%@include file="head.jsp" %>


<div class="shop">
    <div class="row" id="goods" style="width: 1202px;  padding-left: 0; padding-right: 0; margin-left: 0; margin-right: 0; border-left-width: 0; border-right-width: 0;">
        <div class="col-12 "></div>
        <div class="col-2" style="border-bottom-width: 15px; margin-bottom: 12px;">
        </div>
        <div class="col-2">
            <p>商品信息</p>
        </div>
        <div class="col-3">
            <p></p>
        </div>
        <div class="col-1">
            <p>单价</p>
        </div>
        <div class="col-1">
            <p>数量</p>
        </div>
        <div class="col-2">
            <p>金额</p>
        </div>
        <div class="col-1">
        </div>
        <%--  商品信息  --%>
        <div  id="product-container">
            <%--    在此插入商品信息    --%>
        </div>
        <div class="col-2" style="border-bottom-width: 15px; margin-bottom: 12px;">
        </div>
        <div class="col-2">
        </div>
        <div class="col-3">
        </div>
        <div class="col-2" style="margin-top: 16px;">
            <p>合计（不含运费）：</p>
        </div>
        <div class="col-2">
            <h4 class="Sum" style="color: red;font-weight: bold;margin-top: 8px;"> </h4>
        </div>
        <div class="col-1" >
        </div>
    </div>
</div>




<!-- 底部信息 -->
<%@include file="footer.jsp" %>
<script>
    $(document).ready(function() {
        $.ajax({
            type: "POST",
            url: "orderServlet",
            dataType: "json",
            data:{userName:userName},
            success: function(data) {
                var orderDetailsWithGoods = data.object; // 假设返回的数据是 orderDetailsWithGoods 对象数组
                var container = $("#product-container");
                container.empty(); // 清空容器

                // 遍历订单详情和商品信息
                for (var i = 0; i < orderDetailsWithGoods.length; i++) {
                    var detailWithGoods = orderDetailsWithGoods[i];
                    // 创建订单详情和商品信息的 HTML 元素
                    var html = "<div class='order-detail'>";
                    html += "<p>商品名称：" + detailWithGoods.goodsName + "</p>";
                    html += "<p>单价：" + detailWithGoods.unitPrice + "</p>";
                    html += "<p>数量：" + detailWithGoods.Numb + "</p>";
                    // 其他字段的展示...
                    html += "</div>";
                    // 将 HTML 元素添加到容器中
                    container.append(html);
                }
            },
            error: function(xhr, status, error) {
                console.error("Error:", error);
            }
        });
    });
</script>






</body>
</html>

