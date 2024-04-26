<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>搜索结果</title>
</head>
<body>
<%@include file="head.jsp"%>

<%-- 检查是否有商品列表 --%>
<c:if test="${not empty sessionScope.goodsList}">
    <div class="product-container">
            <%-- 使用 JSTL 标签遍历商品列表 --%>
        <c:forEach var="goods" items="${sessionScope.goodsList}">
            <div class="product">
                <img src="https://via.placeholder.com/200" alt="Product Image">
                <h3>${goods.goodsName}</h3>
                <!-- 这里可以输出更多商品的属性，例如价格、库存等 -->
                <p>Description of ${goods.goodsName}</p>
                <!-- 假设商品类中有一个属性叫做price -->
                <p>${goods.unitPrice}</p>
                <!-- 假设商品类中有一个属性叫做inStock -->
                <p>${goods.stock > 0 ? "In Stock" : "Out of Stock"}</p>
                <button>Add to Cart</button>
            </div>
        </c:forEach>
    </div>
</c:if>

<%@include file="footer.jsp"%>
</body>
</html>