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
        <!-- TODO(Yanz,2024/4/26 下午11:30): 存在搜索值为空时，返回所有商品信息的bug-->
                <!-- TODO(Yanz,2024/4/26 下午11:31): 更改一下搜索后的排版页面，计划将每个商品一行一行的展示-->
        <c:forEach var="goods" items="${sessionScope.goodsList}">
            <div class="product">
                <img src="image/${goods.image}" style="width:180px; overflow:hidden;" alt="Product Image">
                <h3>${goods.goodsName}</h3>
                <!-- 这里可以输出更多商品的属性，例如价格、库存等 -->
                <p>${goods.details}</p>
                <!-- 假设商品类中有一个属性叫做price -->
                <p>${goods.unitPrice}￥</p>
                <!-- 物品库存 -->
                <p>${goods.stock > 0 ? "有货" : "售空"}</p>
                <button>Add to Cart</button>
            </div>
        </c:forEach>
    </div>
</c:if>

<%@include file="footer.jsp"%>
</body>
</html>