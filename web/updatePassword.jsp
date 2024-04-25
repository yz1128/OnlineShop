<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>修改密码</title>
    <link rel="stylesheet" href="css/table.css">
</head>
<body>
<%-- 检测用户是否登录，若已登录继续加载网页，未登录则转发到登录界面 --%>
<%
    if (session == null || session.getAttribute("user") == null) {
        // 如果 session 不存在或者用户数据为空，则重定向到 login.jsp 页面
        response.sendRedirect("login.jsp");
    }
%>

<%--导航栏--%>
<%@include file="head.jsp"%>

<%--网页内容--%>
<div class="center">
    <form class="form" action="updatePasswordServlet" method="post">
        <table class="table" >
            <tr>
                <td></td>
                <td><h2>密码修改</h2></td>
                <td></td>
            </tr>
            <tr>
                <td class="right"><label for="userName">用户名：</label> </td>
                <td><input type="text" name="userName" id="userName" value="${user.userName}" readonly> </td>
                <td></td>
            </tr>
            <tr>
                <td class="right"><label for="userPassword">旧密码：</label> </td>
                <td><input type="password" name="userPassword" id="userPassword" value="${messageModel.object.userPassword}"> </td>
                <td></td>
            </tr>
            <tr>
                <td class="right"><label for="newUserPassword1">新密码：</label> </td>
                <td><input type="password" name="newUserPassword1" id="newUserPassword1" value="${messageModel.object.newUserPassword1}"> </td>
                <td></td>
            </tr>
            <tr>
                <td class="right"><label for="newUserPassword2">确认新密码：</label> </td>
                <td><input type="password" name="newUserPassword2" id="newUserPassword2" value="${messageModel.object.newUserPassword2}"> </td>
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
                    <input type="submit" value="确认修改" id="submitBtn">
                </td>
            </tr>
        </table>
    </form>
</div>


<!-- 底部信息 -->
<%@include file="footer.jsp"%>
</body>
</html>
