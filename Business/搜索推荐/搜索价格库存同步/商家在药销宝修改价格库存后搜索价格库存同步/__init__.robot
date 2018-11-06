*** Settings ***
Documentation     搜索价格库存同步主要验证：
...               前提：商家在药销宝修改价格库存
...               1、终端宝搜索界面能查看到最新的价格
...               2、终端宝搜索界面能查看到最新的库存
...               该case涉及web端和app，使用suite分开
Force Tags        product
