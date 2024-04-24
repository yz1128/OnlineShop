package com.Web.mapper;

import com.Web.entity.Goods;

public interface GoodsMapper {
    public Goods selectByGoodsName(String goodsName);
    public Goods selectByGoodsId(String goodsId);
    public int updateGoodsStateById(String goodsId);
    public int insert(Goods goods);
}
