<%--
  Created by IntelliJ IDEA.
  User: Yanz
  Date: 2024/4/27
  Time: 下午12:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加商品</title>
    <link rel="stylesheet" href="css/table.css">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>

<%@include file="head.jsp"%>


<!-- TODO(Yanz,2024/4/26 下午11:32): 将manager页面设置成一个导航式页面，从该页面再进行上架物品的管理 -->
<div class="center">
    <form class="form1" action="addGoods" method="post" id="loginForm">
        <table class="table">
            <tr>
                <td></td>
                <!-- TODO(Yanz,2024/4/26 下午11:34): 将上架商品另起一个页面，使其成为后台的功能之一 -->
                <td><h2>上架商品</h2></td>
                <td></td>
            </tr>
            <tr>
                <td class="right"><label style="width: 80px;" for="goodsName">商品名：</label> </td>
                <td><input type="text" name="goodsName" id="goodsName" value="${messageModel.object.goodsName}"> </td>
                <td></td>
            </tr>
            <tr>
                <td class="right"><label for="category">商品分类：</label> </td>
                <td><input type="text" name="category" id="category" value="${messageModel.object.category}"> </td>
                <td></td>
            </tr>
            <tr>
                <td class="right"><label for="unitPrice">单价：</label> </td>
                <td><input type="text" name="unitPrice" id="unitPrice" value="${messageModel.object.unitPrice}"> </td>
                <td></td>
            </tr>
            <tr>
                <td class="right"><label for="stock">商品库存：</label> </td>
                <td><input type="text" name="stock" id="stock" value="${messageModel.object.stock}"> </td>
                <td></td>
            </tr>
            <tr>
                <td class="right"><label for="factory">厂家：</label> </td>
                <td><input type="text" name="factory" id="factory" value="${messageModel.object.factory}"> </td>
                <td></td>
            </tr>
            <tr>
                <!-- TODO(Yanz,2024/4/26 下午11:27):怎么将图片文件存储在本地并将信息储存到数据库 -->
                <td class="right"><label for="image">封面图：</label> </td>
                <td><input type="file" name="image" id="image" value="${messageModel.object.image}"> </td>
                <td></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center">
                    <span id="msg" style="font-size: 12px;color: red"> ${messageModel.msg}</span>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <button type="button" id="addGoodsBtn">上架</button>
                </td>
            </tr>
        </table>
    </form>
</div>


<%@include file="footer.jsp"%>

<%--引入Jquery的js文件--%>
<script type="text/javascript" src="js/jquery-3.7.1.js"></script>
<script type="text/javascript">

    $("#addGoodsBtn").click(function () {
        var goodsName = $("goodsName")
        var category = $("category")
        var unitPrice = $("goodsName")
        var stock = $("goodsName")
        var factory = $("goodsName")
        var image = $("image")
        //判断姓名是否为空
        if (isEmpty(goodsName) || isEmpty(category) || isEmpty(unitPrice) || isEmpty(stock) || isEmpty(factory) || isEmpty(image)){
            $("#msg").html("存在信息没填！")
            return;
        }
        //如果都不为空，则手动提交表单
        $("#addGoodsBtn").submit();

    });



    /**
     * 判断字符串是否为空
     * 如果为空返回true
     * 反之返回false
     * @param str
     * @returns {boolean}
     */
    function isEmpty(str){
        if (str === null || str.trim() === "") {
            return true;
        }
        return false;
    }
</script>
</body>
</html>
