<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>网上商城</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<!-- 导航栏 -->
<%@include file="head.jsp"%>
<%
    if (session.getAttribute("user") == null) {
        // 如果 session 不存在或者用户数据为空，则重定向到 login.jsp 页面
        response.sendRedirect("login.jsp");
    }
%>

<div class="shop">
    <div id="product-container" class="product-container" style="display: flex; flex-wrap: wrap; justify-content: space-between;">
        <!-- 商品列表 -->
    </div>
</div>

<!-- 底部信息 -->
<%@include file="footer.jsp"%>

<!-- 在页面底部固定位置创建一个容器用于显示 Toast 通知 -->
<div class="toast-container position-fixed bottom-0 end-0 p-3">
    <!-- 这里将放置 Toast 通知 -->
</div>

<%-- 异步加载商品数据 --%>
<script>
    $(document).ready(function() {
        var userName = '<%= userName %>';
        // 发起 AJAX 请求获取商品数据
        $.ajax({
            type: "POST",
            url: "showCartServlet",
            data: {userName: userName},
            dataType: "json",
            success: function(data) {
                // 成功获取数据后，更新页面内容
                var products = data; // 假设返回的数据是商品对象数组
                var container = $("#product-container");
                container.empty(); // 清空容器

                // 遍历商品数据，生成 HTML 内容并添加到容器中
                for (var i = 0; i < products.length; i++) {
                    var product = products[i];
                    var html = "<div class='product' style='display: flex; margin-bottom: 20px;'>" +
                        "<div class='product-image' style='flex: 0 0 180px; margin-right: 20px;'>" +
                        "<img src='image/" + product.image + "' alt='Product Image' style='width: 180px; height: 180px;'>" +
                        "</div>" +
                        "<div class='product-details' style='flex: 1;'>" +
                        "<h3>" + product.goodsName + "</h3>" +
                        "</div>" +
                        "</div>";

                    // 添加到容器
                    container.append(html);
                }



                // 为每个 "Delete-btn" 按钮添加点击事件处理程序
                $(".Delete-btn").click(function() {
                    var goodsName = $(this).data("product-name"); // 获取商品名称
                    var userName = '<%= userName %>';
                    if (isEmpty(userName)) {
                        window.location.href = "login.jsp"; // 重定向到登录页面
                    }
                    // 发起 AJAX 请求将商品添加到购物车
                    $.ajax({
                        type: "POST",
                        url: "deleteCartServlet", // 假设存在一个用于处理删除购物车请求的 Servlet
                        data: { goodsName,userName: goodsName,userName }, // 将商品名称作为请求参数发送到服务器
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
            "<strong class='me-auto'>购物车消息</strong>" +
            "<button type='button' class='btn-close' data-bs-dismiss='toast' aria-label='Close'></button>" +
            "</div>" +
            "<div class='toast-body'>" +
            "商品：" + goodsName + " 已删除" +
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


