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
<%--<script type="text/javascript">--%>
<%--  window.onload = function() {--%>
<%--    // 检查会话中是否有 'hasProcessed' 标志--%>
<%--    if (sessionStorage.getItem('hasProcessed') !== 'true') {--%>
<%--      sessionStorage.setItem('hasProcessed', true); // 设置标志--%>
<%--      document.getElementById('autoSubmitForm').submit();--%>
<%--    }--%>
<%--  };--%>
<%--</script>--%>
<form action="listServlet" method="post" id="autoSubmitForm">
  <!-- 表单字段 -->
</form>
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

  <!-- 商品展示 -->
    <!-- TODO(Yanz,2024/4/26 下午11:52): 使用 JSTL 标签遍历商品列表 -->
  <div class="product-container">
    <c:if test="${not empty sessionScope.goodsList}">
      <div class="product-container">
        <%-- 使用 JSTL 标签遍历商品列表 --%>
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
              <button>Add to Cart</button>
            </div>
          </c:if>
        </c:forEach>
      </div>
    </c:if>
  </div>
</div>
<%--<script type="text/javascript">--%>

<%--    document.getElementById('autoSubmitForm').submit();--%>

<%--</script>--%>
<%@include file="footer.jsp" %>

</body>
</html>

