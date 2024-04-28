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
<!-- TODO(Yanz,2024/4/28 上午1:34): 进入网页自动加载listServlet或者服务器启动加载一个可以获取点赞前十 -->



<!-- 导航栏 -->
<%@include file="head.jsp" %>



<!-- 商品展示 -->
<div class="shop">
  <%-- 轮播图片广告 --%>
  <div id="carouselExampleIndicators" class="carousel slide">
    <div class="carousel-indicators">
      <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
      <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
      <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
    </div>
    <div class="carousel-inner">
      <div class="carousel-item active">
        <img src="image/misu7Cre.jpg" style="width: 1200px;height: 650px;" class="d-block w-100" alt="...">
      </div>
      <div class="carousel-item">
        <img src="image/su7_1.jpg" style="width: 1200px;height: 650px;" class="d-block w-100" alt="...">
      </div>
      <div class="carousel-item">
        <img src="image/mi14Pro.jpg" style="width: 1200px;height: 650px;" class="d-block w-100" alt="...">
      </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Next</span>
    </button>
  </div>
    <!-- 商品列表 -->
    <div id="product-container" class="product-container" style="display: flex; flex-wrap: wrap; justify-content: space-between;">

    </div>

    <%-- 异步加载商品数据 --%>
    <script>
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
              var productName = $(this).data("product-name"); // 获取商品名称
              // 发起 AJAX 请求将商品添加到购物车
              $.ajax({
                type: "POST",
                url: "addToCart", // 假设存在一个用于处理添加到购物车请求的 Servlet
                data: { productName: productName }, // 将商品名称作为请求参数发送到服务器
                success: function(response) {
                  // 处理添加到购物车成功的情况（如果需要）
                  alert("Product added to cart: " + productName);
                },
                error: function(xhr, status, error) {
                  // 处理添加到购物车失败的情况（如果需要）
                  console.error("Error adding product to cart:", error);
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
    </script>

</div>


<%@include file="footer.jsp" %>

</body>
</html>

