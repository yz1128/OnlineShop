<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>网上商城</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<%@include file="head.jsp"%>
<body  style="background-color: #E8E1DF;">
<!-- 导航栏 -->
<%
    if (session.getAttribute("user") == null) {
        // 如果 session 不存在或者用户数据为空，则重定向到 login.jsp 页面
        response.sendRedirect("login.jsp");
    }
%>

<div class="shop">
    <div class="row" id="goods" style="width: 1202px;  padding-left: 0; padding-right: 0; margin-left: 0; margin-right: 0; border-left-width: 0; border-right-width: 0;">
        <div class="col-12 goodslength"><h4>购物车(全部1件)</h4></div>
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
            <h4 class="Sum" style="color: red;font-weight: bold;margin-top: 8px;"> </h4>
        </div>
        <div class="col-1" >
            <button type="button" class="btn btn-warning submit">结算</button>
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
        // 声明变量存储总金额
        var totalAmount = 0;
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
                var goodslength = 0; // 记录商品数量的
                container.empty(); // 清空容器
                // 遍历商品数据，生成 HTML 内容并添加到容器中
                if (products == null){
                    var html =  "<div class='col-12 border-bottom' style='text-align: center;color: red;'><h4>购物车里没商品，快去采购吧！</h4></div>"
                    container.append(html);
                }else{
                    for (var i = 0; i < products.length; i++) {
                        var product = products[i];
                        var amount = product.unitPrice * product.Numb; // 计算商品金额
                        totalAmount += amount;  // 累加到总金额中
                        goodslength += 1;       // 记录商品数量的
                        var html =  "<div class='row goods' style='width: 1202px;'>" +
                                    "<div class='col-12'><h5>" + product.factory + "</h5></div>" +
                                    "<div class='col-2' style='border-bottom-width: 15px; margin-bottom: 12px;'>" +
                                    "<img src='image/" + product.image + "' alt='Product Image' style='width: 150px; height: 150px;'>" +
                                    "</div>" +
                                    "<div class='col-2'><p>" + product.goodsName + "</p></div>" +
                                    "<div class='col-3'> <p>        </p> </div>" +
                                    "<div class='col-1'> <p>￥" + product.unitPrice + "</p> </div>" +
                                    "<div class='col-1'> <p>" + product.Numb + "</p> </div>" +
                                    "<div class='col-2'> <p>￥" + product.unitPrice * product.Numb + "</p> </div>" +
                                    "<div class='col-1'> <button class='Delete-btn' data-product-name='" + product.goodsName + "'>移出</button> </div>" +
                                    "</div>";
                        // 添加到容器
                        container.append(html);
                    }
                }

                // 更新总金额显示
                $(".Sum").text(totalAmount.toFixed(2));
                $(".goodslength").val("购物车(全部"+ goodslength + "件)");


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
                        data: { goodsName, userName: goodsName, userName }, // 将商品名称作为请求参数发送到服务器
                        success: function(response) {
                            // 处理删除购物车成功的情况（如果需要）
                            showToast(goodsName); // 显示 Toast 通知
                            // 从页面中删除相应的商品元素
                            setTimeout(function() {// 刷新页面
                                location.reload();
                            });
                            // 更新总金额
                            totalAmount -= amount;
                            $(".Sum").text(totalAmount.toFixed(2));
                            $(".goodslength").val("购物车(全部"+ goodslength + "件)");
                        },
                        error: function(xhr, status, error) {
                            // 处理删除购物车失败的情况（如果需要）
                            showToast(goodsName); // 显示 Toast 通知
                        }
                    });
                });
                // 为结算按钮添加点击事件处理程序
                $(".submit").click(function() {
                    var userName = '<%= userName %>'; // 获取用户名
                    var banlance = '<%= balance %>'
                    if (banlance < totalAmount) {
                        // 如果余额不足弹窗
                        var msg = ("余额不足，请充值或减少购物车商品数量！");
                        wrongToast(msg)
                        return; // 终止事件处理程序，不执行后续的 AJAX 请求
                    }
                    banlance = banlance - totalAmount;
                    // 发起 AJAX 请求调用 insertOrderServlet，并传递用户名作为参数
                    $.ajax({
                        type: "POST",
                        url: "insertOrderServlet", // 假设存在一个用于处理结算请求的 Servlet
                        data: { userName: userName }, // 将用户名作为请求参数发送到服务器
                        success: function(response) {
                            // 处理结算成功的情况（如果需要）
                            submitToast(totalAmount);

                            // 刷新页面
                            setTimeout(function() {
                                location.reload();
                            });
                        },
                        error: function(xhr, status, error) {
                            // 处理结算失败的情况（如果需要）
                            console.error("Error:", error);
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
    function submitToast(totalAmount) {
        // 创建 Toast 通知
        var toast = $("<div class='toast' role='alert' aria-live='assertive' aria-atomic='true'>" +
            "<div class='toast-header'>" +
            "<strong class='me-auto'>购物车消息</strong>" +
            "<button type='button' class='btn-close' data-bs-dismiss='toast' aria-label='Close'></button>" +
            "</div>" +
            "<div class='toast-body'>" +
            "结算完毕，共消费" + totalAmount + "元" +
            "</div>" +
            "</div>");

        // 将 Toast 元素添加到容器中
        $(".toast-container").append(toast);

        // 初始化 Toast
        var subToast = new bootstrap.Toast(toast[0]);

        // 显示 Toast
        subToast.show();

        // 监听 Toast 隐藏事件，以便在 Toast 隐藏后从 DOM 中移除
        toast.on("hidden.sub.toast", function () {
            toast.remove();
        });
    }
    function wrongToast(msg) {
        // 创建 Toast 通知
        var toast = $("<div class='toast' role='alert' aria-live='assertive' aria-atomic='true'>" +
            "<div class='toast-header'>" +
            "<strong class='me-auto'>购物车消息</strong>" +
            "<button type='button' class='btn-close' data-bs-dismiss='toast' aria-label='Close'></button>" +
            "</div>" +
            "<div class='toast-body'>" +
             msg +
            "</div>" +
            "</div>");

        // 将 Toast 元素添加到容器中
        $(".toast-container").append(toast);

        // 初始化 Toast
        var wrToast = new bootstrap.Toast(toast[0]);

        // 显示 Toast
        wrToast.show();

        // 监听 Toast 隐藏事件，以便在 Toast 隐藏后从 DOM 中移除
        toast.on("hidden.wr.toast", function () {
            toast.remove();
        });
    }
</script>
</body>
</html>


