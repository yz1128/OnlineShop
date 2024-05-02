package com.Web.service;

import com.Web.entity.Goods;
import com.Web.entity.User;
import com.Web.entity.vo.MessageModel;
import com.Web.mapper.UserMapper;
import com.Web.util.GetSqlSession;
import com.Web.util.StringUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.Objects;

/**
 * 业务逻辑
 */
public class UserService {
    public MessageModel userLogin(String userName, String userPassword) {
        MessageModel messageModel = new MessageModel();

        //回显数据
        User u = new User();
        u.setUserName(userName);
        u.setUserPassword(userPassword);
        messageModel.setObject(u);

        // 1. 参数的非空判断
        if (StringUtil.isEmpty(userName) || StringUtil.isEmpty(userPassword)) {
            //将状态码、提示信息、回想数据设置到消息模型中，返回消息模型对象
            messageModel.setCode(0);
            messageModel.setMsg("用户姓名和密码不能为空！");
            return messageModel;
        }
        SqlSession session = GetSqlSession.createSqlSession();
        // 2.调用dao层的查询方法，通过用户名查询用户对象
        try {

            UserMapper userMapper = session.getMapper(UserMapper.class);
            User user = userMapper.queryUserByName(userName);
            // 3.判断用户对象是否为空
            if (user == null) {
                messageModel.setCode(0);
                messageModel.setMsg("用户不存在！");
                return messageModel;
            }

            // 4.判断数据库中查询到的用户密码与前台传递的密码作比较
            if (!userPassword.equals(user.getUserPassword())) {
                messageModel.setCode(0);
                messageModel.setMsg("用户密码不正确！");
                return messageModel;
            }
            System.out.println(user.getBalance());
            // 登录成功，将用户信息设置到消息模型中
            messageModel.setObject(user);
            messageModel.setCode(1);
            messageModel.setMsg("登录成功！");
        } catch (Exception e) {
            // 发生异常时的处理
            e.printStackTrace();
            messageModel.setCode(0);
            messageModel.setMsg("登录失败，发生异常：" + e.getMessage());
        } finally {
            // 确保SqlSession被关闭
            if (session != null) {
                session.close();
            }
        }
        return messageModel;
    }

    public MessageModel userRegister(String userName, String userPassword, String ConfirmPassword, String userEmail, String userAddress, String userPhone) {
        MessageModel messageModel = new MessageModel();

        // 回显数据
        User u = new User();
        u.setUserName(userName);
        u.setUserPassword(userPassword);
        u.setConfirmPassword(ConfirmPassword);
        u.setUserEmail(userEmail);
        u.setUserAddress(userAddress);
        u.setUserPhone(userPhone);
        messageModel.setObject(u);
        // 1. 参数的非空判断
        if (StringUtil.isEmpty(userName) || StringUtil.isEmpty(userPassword) || StringUtil.isEmpty(ConfirmPassword) || StringUtil.isEmpty(userEmail) || StringUtil.isEmpty(userAddress) || StringUtil.isEmpty(userPhone)) {
            messageModel.setCode(0);
            messageModel.setMsg("注册信息不能为空！");
            return messageModel;
        }

        // 2. 检查密码匹配
        if (!Objects.equals(userPassword, ConfirmPassword)) {
            messageModel.setCode(0);
            messageModel.setMsg("两次输入的密码不一致！");
            return messageModel;
        }

        // 3. 调用DAO层方法检查用户名是否已被注册

        SqlSession session = GetSqlSession.createSqlSession();
        try {
            UserMapper userMapper = session.getMapper(UserMapper.class);
            User existingUser = userMapper.queryUserByName(userName);
            if (existingUser != null) {
                messageModel.setCode(0);
                messageModel.setMsg("用户名已被注册！");
                return messageModel;
            }
            int rowsAffected = userMapper.insertUser(u);
            if (rowsAffected > 0) {
                messageModel.setCode(1);
                messageModel.setMsg("注册成功！");
                session.commit();
            } else {
                messageModel.setCode(0);
                messageModel.setMsg("注册失败，请稍后重试！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            messageModel.setCode(0);
            messageModel.setMsg("注册失败，发生异常：" + e.getMessage());
        } finally {
            session.close();
        }
        return messageModel;
    }

    public MessageModel userInfoUpdate(String userName, String userEmail, String userAddress, String userPhone) {
        MessageModel messageModel = new MessageModel();

        // 回显数据
        User u = new User();
        u.setUserName(userName);
        u.setUserEmail(userEmail);
        u.setUserAddress(userAddress);
        u.setUserPhone(userPhone);
        messageModel.setObject(u);
        // 1. 参数的非空判断
        if (StringUtil.isEmpty(userEmail) || StringUtil.isEmpty(userAddress) || StringUtil.isEmpty(userPhone)) {
            messageModel.setCode(0);
            messageModel.setMsg("信息不能为空！");
            return messageModel;
        }
        SqlSession session = GetSqlSession.createSqlSession();
        try {
            UserMapper userMapper = session.getMapper(UserMapper.class);
            int rowsAffected = userMapper.updateUserInfo(u);
            session.commit();
            if (rowsAffected > 0) {
                messageModel.setCode(1);
                messageModel.setMsg("修改成功！");
            } else {
                messageModel.setCode(0);
                messageModel.setMsg("修改失败，请稍后重试！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            messageModel.setCode(0);
            messageModel.setMsg("修改失败，发生异常：" + e.getMessage());
        } finally {
            session.close();
        }
        return messageModel;
    }

    public MessageModel updatePassword(String userName,String userPassword,String newUserPassword1,String newUserPassword2) {
        MessageModel messageModel = new MessageModel();

        //回显数据
        User u = new User();
        u.setUserName(userName);
        u.setUserPassword(userPassword);
        u.setNewUserPassword1(newUserPassword1);
        u.setNewUserPassword2(newUserPassword2);
        messageModel.setObject(u);
        // 1. 参数的非空判断
        if (StringUtil.isEmpty(userPassword) || StringUtil.isEmpty(newUserPassword1) || StringUtil.isEmpty(newUserPassword2)) {
            //将状态码、提示信息、回想数据设置到消息模型中，返回消息模型对象
            messageModel.setCode(0);
            messageModel.setMsg("密码不能为空！");
            return messageModel;
        }

        // 2.调用dao层的查询方法，通过用户名查询用户对象
        SqlSession session = GetSqlSession.createSqlSession();


        try {
            UserMapper userMapper = session.getMapper(UserMapper.class);
            User user = userMapper.queryUserByName(userName);

            //4.判断数据库中查询到的用户密码与前台传递的密码作比较
            if (!userPassword.equals(user.getUserPassword())) {
                //如果不相等，将状态码、提示信息、回显数据设置到消息模型对象中，返回消息模型对象
                messageModel.setCode(0);
                messageModel.setMsg("用户密码不正确！");
                return messageModel;
            } else if (!newUserPassword1.equals(newUserPassword2)) {
                messageModel.setCode(0);
                messageModel.setMsg("两次密码不相同！");
                return messageModel;
            }
            //判断消息模型状态码
            int rowsAffected = userMapper.updateUserPassword(u);
            System.out.println(rowsAffected);
            if (rowsAffected > 0) {
                messageModel.setCode(1);
                messageModel.setMsg("修改成功！");
                session.commit();
            } else {
                messageModel.setCode(0);
                messageModel.setMsg("修改失败，请稍后重试！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            messageModel.setCode(0);
            messageModel.setMsg("修改失败，发生异常：" + e.getMessage());
        } finally {
            session.close();
        }
        return messageModel;
    }

    public MessageModel updateBalance(String userName,double balance) {
        MessageModel messageModel = new MessageModel();
        SqlSession session = GetSqlSession.createSqlSession();
        User u = new User();
        u.setUserName(userName);
        u.setBalance(balance);
        try {
            UserMapper userMapper = session.getMapper(UserMapper.class);
            int rowsAffected = userMapper.updateBalance(u);
            if (rowsAffected > 0) {
                session.commit();
                messageModel.setCode(1);
                messageModel.setMsg("修改成功！");
            } else {
                messageModel.setCode(0);
                messageModel.setMsg("修改失败，请稍后重试！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            messageModel.setCode(0);
            messageModel.setMsg("搜索失败，发生异常：" + e.getMessage());
        } finally {
            session.close();
        }
        return messageModel;
    }

    public MessageModel queryUserByName(String userName) {
        MessageModel messageModel = new MessageModel();

        //回显数据
        User u = new User();
        u.setUserName(userName);
        messageModel.setObject(u);
        SqlSession session = GetSqlSession.createSqlSession();

        try {
            UserMapper userMapper = session.getMapper(UserMapper.class);
            User user = userMapper.queryUserByName(userName);

            messageModel.setObject(user);
            messageModel.setCode(1);
            messageModel.setMsg("查询成功！");
        } catch (Exception e) {
            e.printStackTrace();
            messageModel.setCode(0);
            messageModel.setMsg("搜索失败，发生异常：" + e.getMessage());
        } finally {
            session.close();
        }
        return messageModel;
    }
}

