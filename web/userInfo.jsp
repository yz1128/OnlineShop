<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>用户信息</title>
    <link href="css/bootstrap.min5.3.css" rel="stylesheet">
    <link rel="stylesheet" href="css/table.css">
</head>
<body style="background-color: #E8E1DF;">
<%-- 检测用户是否登录，若已登录继续加载网页，未登录则转发到登录界面 --%>
<%
    if (session.getAttribute("user") == null) {
        // 如果 session 不存在或者用户数据为空，则重定向到 login.jsp 页面
        response.sendRedirect("login.jsp");
    }
%>

<!-- 导航栏 -->
<%@include file="head.jsp"%>

<!-- 用户信息 -->
<div class="center">
    <form class="form" action="infoUpdateServlet" method="post" id="userInfoForm">
        <table class="table" >
            <tr>
                <td></td>
                <td><h2>信息修改</h2></td>
                <td></td>
            </tr>
            <tr>
                <td class="right"><label for="userName">用户名：</label> </td>
                <td><input type="text" name="userName" id="userName" value="${user.userName}" readonly> </td>
                <td></td>
            </tr>
            <tr>
                <td class="right"><label for="balance">余额：</label> </td>
                <td><input type="text" name="balance" id="balance" value="${user.balance}" readonly> </td>
                <td></td>
            </tr>
            <tr>
                <td class="right"><label for="userEmail">邮箱：</label> </td>
                <td><input type="email" name="userEmail" id="userEmail" value="${user.userEmail}"> </td>
                <td></td>
            </tr>
            <tr>
                <td class="right"><label for="userAddress">地址：</label> </td>
                <td><input type="text" name="userAddress" id="userAddress" value="${user.userAddress}"> </td>
                <td></td>
            </tr>
            <tr>
                <td class="right"><label for="userPhone">手机号：</label> </td>
                <td><input type="text" name="userPhone" id="userPhone" value="${user.userPhone}"> </td>
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
                    <a href="updatePassword.jsp">密码修改</a>
                    <input type="submit" value="提交" id="submitBtn">
                </td>
            </tr>
        </table>
    </form>
</div>

<!-- 底部信息 -->
<%@include file="footer.jsp"%>

<script type="text/javascript" src="js/jquery-3.7.1.js"></script>
<script type="text/javascript">
    $("#submitBtn").click(function(event) {
        event.preventDefault(); // 阻止表单的默认提交行为

        var userName = $("#userName").val();
        var userPassword = $("#userPassword").val();
        var ConfirmPassword = $("#ConfirmPassword").val();
        var userEmail = $("#userEmail").val();
        var userAddress = $("#userAddress").val();
        var userPhone = $("#userPhone").val();
        //判断姓名是否为空
        if (isEmpty(userName)){
            //如果姓名为空，提示用户（span标签赋值），并且return html()
            $("#msg").html("用户姓名不可为空！")
            return;
        }
        //判断邮箱是否符合要求
        if (isEmpty(userEmail) ){
            //如果邮箱为空，提示邮箱不能为空，并返回
            $("#msg").html("邮箱不能为空！")
            return;
        } else {
            // 创建一个邮箱正则表达式
            var emailPattern = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
            // 使用正则表达式测试邮箱格式
            if (!emailPattern.test(userEmail)) {
                // 如果邮箱格式不正确，提示邮箱格式错误，并返回
                $("#msg").html("邮箱格式错误！");
                return;
            }
        }
        //判断是否输入地址
        if (isEmpty(userAddress) ){
            //如果地址为空，提示地址不能为空，返回
            $("#msg").html("地址不能为空！")
            return;
        }
        //判断手机号是否符合要求
        if (isEmpty(userPhone) ){
            //如果手机号是否为空，提示手机号不能为空，返回
            $("#msg").html("手机号不能为空！")
            return;
        }
        if (userPhone.length !== 11){
            //如果手机号不足11位，提示不是正确的手机号，返回
            $("#msg").html("手机号不合法！")
            return;
        }
        //如果都不为空，则手动提交表单
        $("#userInfoForm").submit();
    });
    function isEmpty(str){
        if (str === null || str.trim() === "") {
            return true;
        }
        return false;
    }

</script>
</body>
</html>

