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
    <!-- 商品列表 -->
    <div id="product-container" class="product-container" style="display: flex; flex-wrap: wrap; justify-content: space-between;">
        <!-- 商品列表 -->
    </div>

<!-- 底部信息 -->
<%@include file="footer.jsp" %>
<div class="toast-container position-fixed bottom-0 end-0 p-3">
    <!-- 这里将放置 Toast 通知 -->
</div>
<script>
    <!-- 在页面底部固定位置创建一个容器用于显示 Toast 通知 -->




    $(document).ready(function() {
        // 发起 AJAX 请求获取商品数据
        $.ajax({
            type: "POST",
            url: "listServlet",
            dataType: "json",
            success: function(data) {
                // 成功获取数据后，更新页面内容
                var products = data; // 假设返回的数据是商品对象数组
                var container = $("#product-container");
                container.empty(); // 清空容器

                // 遍历商品数据，生成 HTML 内容并添加到容器中
                for (var i = 0; i < products.length; i++) {
                    var product = products[i];
                    var html = "<div class='product' style='flex: 0 0 20%; max-width: 20%; margin-bottom: 20px; padding: 10px; border: 1px solid #ddd; border-radius: 5px;'>" +
                        "<img src='image/" + product.image + "' alt='Product Image' style='width: 180px; height: 180px; display: block; margin: 0 auto;'> " +
                        "<h3>" + product.goodsName + "</h3>" +
                        "<p>" + product.details + "</p>" +
                        "<p>" + product.unitPrice + "￥</p>" +
                        "<p>" + (product.stock > 100 ? "有货" : product.stock) + "</p>" +
                        "<button class='add-to-cart-btn' data-product-name='" + product.goodsName + "'>Add to Cart</button>" + // 将商品名称作为按钮的自定义属性
                        "</div>";

                    // 添加到容器
                    container.append(html);
                }

                // 为每个 "Add to Cart" 按钮添加点击事件处理程序
                $(".add-to-cart-btn").click(function() {
                    var goodsName = $(this).data("product-name"); // 获取商品名称
                    var userName = '<%= userName %>';
                    var userId = '<%= userId %>'
                    if (isEmpty(userName)) {
                        window.location.href = "login.jsp"; // 重定向到登录页面
                        return;
                    }
                    // 发起 AJAX 请求将商品添加到购物车
                    $.ajax({
                        type: "POST",
                        url: "insertCartServlet", // 假设存在一个用于处理添加到购物车请求的 Servlet
                        data: { goodsName,userName,userId: goodsName,userName,userId }, // 将商品名称作为请求参数发送到服务器
                        success: function(response) {
                            // 处理添加到购物车成功的情况（如果需要）
                            showToast(goodsName); // 显示 Toast 通知
                        },
                        error: function(xhr, status, error) {
                            // 处理添加到购物车失败的情况（如果需要）
                            showToast(goodsName); // 显示 Toast 通知
                        }
                    });
                });
            },
            error: function(xhr, status, error) {
                // 处理错误情况
                console.error("Error:", error);
            }
        });
    });

    function isEmpty(userName) {
        return userName.length === 0;
    }
    function showToast(goodsName) {
        // 创建 Toast 通知
        var toast = $("<div class='toast' role='alert' aria-live='assertive' aria-atomic='true'>" +
            "<div class='toast-header'>" +
            "<strong class='me-auto'>加入购物车</strong>" +
            "<button type='button' class='btn-close' data-bs-dismiss='toast' aria-label='Close'></button>" +
            "</div>" +
            "<div class='toast-body'>" +
            "商品：" + goodsName + " 已加入购物车" +
            "</div>" +
            "</div>");

        // 将 Toast 元素添加到容器中
        $(".toast-container").append(toast);

        // 初始化 Toast
        var bsToast = new bootstrap.Toast(toast[0]);

        // 显示 Toast
        bsToast.show();

        // 监听 Toast 隐藏事件，以便在 Toast 隐藏后从 DOM 中移除
        toast.on("hidden.bs.toast", function () {
            toast.remove();
        });
    }

</script>






</body>
</html>

