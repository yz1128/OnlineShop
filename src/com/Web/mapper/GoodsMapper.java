package com.Web.mapper;

import com.Web.entity.Goods;

import java.util.List;

public interface GoodsMapper {
    public List<Goods> queryByGoodsName(String goodsName);
    public List<Goods> selectByGoodsId(String goodsId);
    public int updateGoodsStateById(String goodsId,int goodsState);
    public int insert(Goods goods);
}
