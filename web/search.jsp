<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>搜索结果</title>
</head>
<body style="background-color: #E8E1DF;">
<%@include file="head.jsp"%>

<%-- 检查是否有商品列表 --%>
<div class="shop">
    <!-- 商品列表 -->
    <!-- 商品列表 -->
    <c:if test="${not empty sessionScope.goodsList}">
        <div class="product-container">
                <%-- 使用 JSTL 标签遍历商品列表 --%>
            <!-- TODO(Yanz,2024/4/26 下午11:30): 存在搜索值为空时，返回所有商品信息的bug-->
            <!-- TODO(Yanz,2024/4/26 下午11:31): 更改一下搜索后的排版页面，计划将每个商品一行一行的展示-->
            <c:forEach var="goods" items="${sessionScope.goodsList}">
                <c:if test="${goods.goodsState != 1}">
                    <div class="product">
                        <img src="image/${goods.image}" alt="Product Image" style="width: 180px;height:180px">
                        <h3>${goods.goodsName}</h3>
                        <!-- 这里可以输出更多商品的属性，例如价格、库存等 -->
                        <p>${goods.details}</p>
                        <!-- 假设商品类中有一个属性叫做price -->
                        <p>${goods.unitPrice}￥</p>
                        <!-- 物品库存 -->
                        <p>${goods.stock > 100 ? "有货" : goods.stock}</p>
                        <button class="add-to-cart-btn" data-product-name=${product.goodsName}>Add to Cart</button>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </c:if>

</div>

<%@include file="footer.jsp"%>

<!-- 在页面底部固定位置创建一个容器用于显示 Toast 通知 -->
<div class="toast-container position-fixed bottom-0 end-0 p-3">
    <!-- 这里将放置 Toast 通知 -->
</div>

<%-- 异步加载商品数据 --%>
<script>
    $(document).ready(function() {
        // 发起 AJAX 请求获取商品数据
        // 为每个 "Add to Cart" 按钮添加点击事件处理程序
        $(".add-to-cart-btn").click(function() {
            var goodsName = $(this).data("product-name"); // 获取商品名称
            var userName = '<%= userName %>';
            var userId = '<%= userId %>'
            if (isEmpty(userName)) {
                window.location.href = "login.jsp"; // 重定向到登录页面
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