*** Settings ***
Documentation     订单互通主要验证：
...               \ 1、在终端宝下单后订单能同步到药品终端网采购商订单管理列表；
...               2、在终端宝下单后订单能同步到药品终端网供应商订单管理列表。
...               该case会在web端和app之间切换，以suite分开
Force Tags        core    product
