<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>网上商城</title>
</head>
<%@include file="head.jsp"%>
<body>
<!-- 导航栏 -->
<%
    if (session.getAttribute("user") == null) {
        // 如果 session 不存在或者用户数据为空，则重定向到 login.jsp 页面
        response.sendRedirect("login.jsp");
    }
%>

<div class="shop" style="background-color: #E8E1DF;">
    <div class="row" id="goods" style="width: 1202px; background-color: white; padding-left: 0; padding-right: 0; margin-left: 0; margin-right: 0; border-left-width: 0; border-right-width: 0;">
        <div class="col-12"><h4>购物车(全部1件)</h4></div>
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
            <p>操作</p>
        </div>
        <%--  商品信息  --%>
        <div  id="product-container">

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
            <h4 class="Sum" style="color: red;font-weight: bold;margin-top: 8px;">0.00</h4>
        </div>
        <div class="col-1" >
            <button type="button" class="btn btn-warning">结算</button>
        </div>
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
                    var html =  "<div class='row' style='width: 1202px;'>" +
                                "<div class='col-12'><h5>" + product.factory + "</h5></div>" +
                                "<div class='col-2' style='border-bottom-width: 15px; margin-bottom: 12px;'>" +
                                "<img src='image/" + product.image + "' alt='Product Image' style='width: 150px; height: 150px;'>" +
                                "</div>" +
                                "<div class='col-2'><p>" + product.goodsName + "</p></div>" +
                                "<div class='col-3'> <p>" + product.details + "</p> </div>" +
                                "<div class='col-1'> <p>￥" + product.unitPrice + "</p> </div>" +
                                "<div class='col-1'> <p>" + product.Numb + "</p> </div>" +
                                "<div class='col-2'> <p>￥" + product.unitPrice * product.Numb + "</p> </div>" +
                                "<div class='col-1'> <button class='Delete-btn' data-product-name='" + product.goodsName + "'>移出</button> </div>" +
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
                            //location.reload(); // 刷新页面

                            setTimeout(function() {// 刷新页面
                                location.reload();
                            }, 2000);

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


