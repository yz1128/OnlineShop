<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
  <%-- 轮播图片广告 --%>
  <div id="carouselExampleIndicators" class="carousel slide">
    <div class="carousel-indicators">
      <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
      <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
      <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
    </div>
    <div class="carousel-inner">
      <div class="carousel-item active">
        <img src="image/register_bg.jpg" class="d-block w-100" alt="...">
      </div>
      <div class="carousel-item">
        <img src="https://via.placeholder.com/200" class="d-block w-100" alt="...">
      </div>
      <div class="carousel-item">
        <img src="https://via.placeholder.com/200" class="d-block w-100" alt="...">
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
  <!-- 商品展示 -->
  <div class="product-container">
    <div class="product">
      <img src="https://via.placeholder.com/200" alt="Product Image">
      <h3>Product 1</h3>
      <p>Description of Product 1</p>
      <p>$19.99</p>
      <button>Add to Cart</button>
    </div>
    <div class="product">
      <img src="https://via.placeholder.com/200" alt="Product Image">
      <h3>Product 2</h3>
      <p>Description of Product 2</p>
      <p>$29.99</p>
      <button>Add to Cart</button>
    </div>
    <div class="product">
      <img src="https://via.placeholder.com/200" alt="Product Image">
      <h3>Product 3</h3>
      <p>Description of Product 3</p>
      <p>$39.99</p>
      <button>Add to Cart</button>
    </div>
  </div>
</div>

<%@include file="footer.jsp" %>

</body>
</html>

