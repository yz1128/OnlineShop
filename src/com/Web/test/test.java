package com.Web.test;

import com.Web.entity.User;
import com.Web.mapper.UserMapper;
import com.Web.util.GetSqlSession;
import org.apache.ibatis.session.SqlSession;

public class test {
    public static void main(String[] args) {
        // 获取sqlSession对象
        SqlSession Session = GetSqlSession.createSqlSession();
        // 得到对应Mapper
        UserMapper userMapper = Session.getMapper(UserMapper.class);
        // 调用方法，返回用户对象
        User user = userMapper.queryUserByName("admin");
        System.out.println(user);
    }
}
