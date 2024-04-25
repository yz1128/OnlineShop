package com.Web.mapper;

import com.Web.entity.User;

/**
 * 用户接口类
 */
public interface UserMapper {
    public User queryUserByName(String userName);
    public int insertUser(User user);
    public int updateUserInfo(User user);
    public int updateUserPassword(User user);
}
