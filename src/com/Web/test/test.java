package com.Web.test;

import com.Web.entity.Cart;
import com.Web.mapper.CartMapper;
import com.Web.util.GetSqlSession;
import org.apache.ibatis.session.SqlSession;

public class test {
    public static void main(String[] args) {
        // 获取sqlSession对象
        SqlSession session = GetSqlSession.createSqlSession();
        // 得到对应Mapper
        Cart cart =new Cart();
        cart.setUserName("1");
        cart.setNumb(3);
        CartMapper cartMapper = session.getMapper(CartMapper.class);
        int rowsAffected = cartMapper.updateNumbById(cart);
        System.out.println(rowsAffected);
    }
}
