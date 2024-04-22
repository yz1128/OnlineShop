<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>网上商城</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
    <style>
        .dropdown-menu{
            background-color: rgba(var(--bs-dark-rgb), var(--bs-bg-opacity)) !important;
            width: auto;
        }
        .dropdown-item{
            width: auto;
        }
    </style>

</head>
<body>
<!-- 导航栏 -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="home.jsp">网上商城</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="home.jsp">首页</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">社区</a>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        分类
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="#">电脑</a></li>
                        <li><a class="dropdown-item" href="#">手机</a></li>
                        <li><a class="dropdown-item" href="#">平板</a></li>
                        <li><a class="dropdown-item" href="#">配件</a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">关于我们</a>
                </li>
            </ul>
            <form action="#" method="post" class="d-flex">
                <input  class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-success" type="submit">Search</button>
            </form>
            <div class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="userinfo" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    用户名
                </a>
                <ul class="dropdown-menu" aria-labelledby="userinfo">
                    <li><a class="dropdown-item" href="#">用户信息</a></li>
                    <li><a class="dropdown-item" href="#">设置</a></li>
                    <li><a class="dropdown-item" href="http://localhost:80/Web/login.jsp">登录</a></li>
                    <li><a class="dropdown-item" href="http://localhost:80/Web/logout">退出</a></li>
                </ul>
            </div>
            <ul class="navbar-nav  mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="car.jsp">购物车</a>
                </li>
            </ul>
        </div>
    </div>
</nav>


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

<!-- 底部信息 -->
<div class="footer">
    <p>&copy; 2024 Online Store. All Rights Reserved.</p>
</div>

<%--  --%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/jquery-3.7.1.js"></script>
<script>
    $(document).ready(function() {
        if (userName !== "") {
                $("#userinfo").text(userName); // 更新导航栏中的用户名
                $(".dropdown-menu .dropdown-item:contains('退出')").show(); // 显示退出按钮
                $(".dropdown-menu .dropdown-item:contains('登录')").hide(); // 隐藏登录按钮
          } else {
                $("#userinfo").text("未登录"); // 更新导航栏中的文本为"未登录"
                $(".dropdown-menu .dropdown-item:contains('退出')").hide(); // 隐藏退出按钮
                $(".dropdown-menu .dropdown-item:contains('登录')").show(); // 显示登录按钮
          }
    });
</script>

</body>
</html>

