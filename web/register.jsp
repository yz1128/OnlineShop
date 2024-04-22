<%--
  Created by IntelliJ IDEA.
  User: Yanz
  Date: 2024/4/21
  Time: 下午1:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册页面</title>
    <style>
        .head{
            margin-top: 240px;
        }
        .right{
            text-align: right;
            width: 120px;
        }
        .center {
            margin: auto;
            width: 20%;
        }
        table{
            width: 360px;
        }
        form{
            width: 360px;
        }

    </style>
</head>
<body>

    <div class="head"></div>
    <div class="center">
            <form action="register" method="post">
                <table>
                    <tr>
                        <td></td>
                        <td><h2>用户注册</h2></td>
                        <td></td>
                    </tr>
                    <tr><!--label 标签的作用是当点击文字也会跳到文本输出框-->
                        <!--for属性与ID属性对应规定 label 绑定到哪个表单元素。-->
                        <td class="right"><label for="userName">用户名：</label> </td>
                        <td><input type="text" name="userName" id="userName" value="${messageModel.object.userName}"> </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="right"><label for="userPassword">密码：</label> </td>
                        <td><input type="password" name="userPassword" id="userPassword"> </td>
                        <td></td>

                    </tr>
                    <tr>
                        <td class="right"><label for="ConfirmPassword">确认密码：</label> </td>
                        <td><input type="password" name="ConfirmPassword" id="ConfirmPassword"> </td>
                        <td></td>
                    </tr>
                    <tr><!--label 标签的作用是当点击文字也会跳到文本输出框-->
                        <td class="right"><label for="userEmail">邮箱：</label> </td>
                        <td><input type="email" name="userEmail" id="userEmail" value="${messageModel.object.userEmail}"> </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="right"><label for="userAddress">地址：</label> </td>
                        <td><input type="text" name="userAddress" id="userAddress" value="${messageModel.object.userAddress}"> </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="right"><label for="userPhone">手机号：</label> </td>
                        <td><input type="text" name="userPhone" id="userPhone" value="${messageModel.object.userPhone}"> </td>
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
                            <input type="submit" value="注册" id="registerBtn">
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            已有账号？<a href="http://localhost:80/Web/login.jsp">立即登录</a>
                        </td>
                    </tr>
                </table>
            </form>
    </div>
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
        $("#registerBtn").click(function () {
            //获取用户姓名和密码的值
            var userName = $("#userName").val();
            var userPassword = $("#userPassword").val();
            var ConfirmPassword = $("#ConfirmPassword").val();
            //判断姓名是否为空
            if (isEmpty(userName)){
                //如果姓名为空，提示用户（span标签赋值），并且return html()
                $("#msg").html("用户姓名不可为空！")
                return;
            }
            //判断密码是否为空
            if (isEmpty(userPassword) || isEmpty(ConfirmPassword)){
                //如果姓名为空，提示用户（span标签赋值），并且return html()
                $("#msg").html("用户密码不可为空！")
                return;
            }
            //判断密码两次输入是否相同
            if (userPassword !== ConfirmPassword) {
                // 如果两次输入的密码不相同，提示用户密码不相同，并且返回
                $("#msg").html("两次输入的密码不相同！");
                return;
            }


            //如果都不为空，则手动提交表单
            $("#loginForm").submit();

        });
    </script>
</html>
