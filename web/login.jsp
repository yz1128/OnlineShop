<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录界面</title>
    <link rel="stylesheet" href="css/table.css">
</head>
<body>
    <%@include file="head.jsp"%>
        <div class="center">
            <form action="login" method="post" id="loginForm">
                <table>
                    <tr>
                        <td></td>
                        <td><h2>用户登录</h2></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="right"><label for="userName">用户名：</label> </td>
                        <td><input type="text" name="userName" id="userName" value="${messageModel.object.userName}"> </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="right"><label for="userPassword">密码：</label> </td>
                        <td><input type="password" name="userPassword" id="userPassword" value="${messageModel.object.userPassword}"> </td>
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
                            <button type="button" id="loginBtn">立即登录&nbsp;&nbsp;</button>
                            <a style="font-size: 12px" href="updatePassword.jsp">忘记密码</a>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            没有账号?<a href="register.jsp">&nbsp;注册</a>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    <%@include file="footer.jsp"%>
</body>
<%--引入Jquery的js文件--%>
<script type="text/javascript" src="js/jquery-3.7.1.js"></script>
<script type="text/javascript">
    /**
     * 登录表单验证
     *  1.给登录按钮绑定点击时间（通过id选择器绑定）
     *  2.获取用户姓名和密码的值
     *  3.判断姓名是否为空
     *      如果姓名为空，提示用户（span标签赋值），并且return
     *  4.判断密码是否为空
     *      如果密码为空，提示用户（span标签赋值），并且return
     *  5.如果都不为空，则手动提交表单
     */
    $("#loginBtn").click(function () {
        //获取用户姓名和密码的值
        var userName = $("#userName").val();
        var userPassword = $("#userPassword").val();
        //判断姓名是否为空
        if (isEmpty(userName)){
            //如果姓名为空，提示用户（span标签赋值），并且return html()
            $("#msg").html("用户姓名不可为空！")
            return;
        }
        //判断密码是否为空
        if (isEmpty(userPassword)){
            //如果姓名为空，提示用户（span标签赋值），并且return html()
            $("#msg").html("用户密码不可为空！")
            return;
        }
        //如果都不为空，则手动提交表单
        $("#loginForm").submit();

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
</html>
