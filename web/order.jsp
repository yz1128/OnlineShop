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
// 发起 AJAX 请求获取商品数据
    var userName = '<%= userName %>';
    // 声明变量存储总金额
    var totalAmount = 0;
    $.ajax({
        type: "POST",
        url: "orderServlet",
        dataType: "json",
        data:{userName:userName},
        success: function(data) {
            // 成功获取数据后，更新页面内容
            var products = data; // 假设返回的数据是商品对象数组
            var container = $("#product-container");
            var goodslength = 0; // 记录商品数量的
            container.empty(); // 清空容器
            // 遍历商品数据，生成 HTML 内容并添加到容器中
            if (products == null){
                var html =  "<div class='col-12 border-bottom' style='text-align: center;color: red;'><h4>还没有订单，快去下单吧！</h4></div>"
                container.append(html);
            }else {
                for (var i = 0; i < products.length; i++) {
                    var product = products[i];
                    var amount = product.unitPrice * product.Numb; // 计算商品金额
                    totalAmount += amount;  // 累加到总金额中
                    goodslength += 1;       // 记录商品数量的
                    var html = "<div class='row goods' style='width: 1202px;'>" +
                        "<div class='col-12'><h5>" + product.factory + "</h5></div>" +
                        "<div class='col-2' style='border-bottom-width: 15px; margin-bottom: 12px;'>" +
                        "<img src='image/" + product.image + "' alt='Product Image' style='width: 150px; height: 150px;'>" +
                        "</div>" +
                        "<div class='col-2'><p>" + product.goodsName + "</p></div>" +
                        "<div class='col-3'> <p>        </p> </div>" +
                        "<div class='col-1'> <p>￥" + product.unitPrice + "</p> </div>" +
                        "<div class='col-1'> <p>" + product.Numb + "</p> </div>" +
                        "<div class='col-2'> <p>￥" + product.unitPrice * product.Numb + "</p> </div>" +
                        "<div class='col-1'></div>" +
                        "</div>";
                    // 添加到容器
                    container.append(html);
                }
            }
                // 输出总金额
                $(".Sum").text("￥" + totalAmount.toFixed(2));
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

