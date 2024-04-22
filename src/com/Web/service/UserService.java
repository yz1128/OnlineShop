package com.Web.service;

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
    /**
     * 用户登录
     * 1.参数的非空判断
     *      如果参数为空
     *          将状态码、提示信息、回想数据设置到消息模型中，返回消息模型对象
     * 2.调用dao层的查询方法，通过用户名查询用户对象
     * 3.判断用户对象是否为空
     *      将状态码、提示信息、回想数据设置到消息模型中，返回消息模型对象
     * 4.判断数据库中查询到的用户密码与前台传递的密码作比较
     *      如果不相等，将状态码、提示信息、回显数据设置到消息模型对象中，返回消息模型对象
     * 5.登录成功，成功状态、提示信息、用户对象设置消息模型对象，并return
     * @param userName
     * @param userPassword
     * @return
     */
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

        // 2.调用dao层的查询方法，通过用户名查询用户对象
        SqlSession session = GetSqlSession.createSqlSession();
        UserMapper userMapper = session.getMapper(UserMapper.class);
        User user = userMapper.queryUserByName(userName);

        // 3.判断用户对象是否为空
        if (user == null) {
            //将状态码、提示信息、回想数据设置到消息模型中，返回消息模型对象
            messageModel.setCode(0);
            messageModel.setMsg("用户不存在！");
            //回显数据
            return messageModel;
        }

        //4.判断数据库中查询到的用户密码与前台传递的密码作比较
        if (!userPassword.equals(user.getUserPassword())) {
            //如果不相等，将状态码、提示信息、回显数据设置到消息模型对象中，返回消息模型对象
            messageModel.setCode(0);
            messageModel.setMsg("用户密码不正确！");
            return messageModel;
        }

        //登录成功，将用户信息设置到消息模型中
        messageModel.setObject(user);

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
        System.out.println("ConfirmPassword："+u.getConfirmPassword());
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
        UserMapper userMapper = session.getMapper(UserMapper.class);
        User existingUser = userMapper.queryUserByName(userName);
        if (existingUser != null) {
            messageModel.setCode(0);
            messageModel.setMsg("用户名已被注册！");
            return messageModel;
        }

        // 4. 如果一切正常，则将用户信息插入数据库中
        try {
            int rowsAffected = userMapper.insertUser(u);
            session.commit();
            if (rowsAffected > 0) {
                messageModel.setCode(1);
                messageModel.setMsg("注册成功！");
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

}
