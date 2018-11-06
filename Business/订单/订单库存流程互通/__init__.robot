*** Settings ***
Documentation     订单库存流程互通主要验证：
...               \ \ \ \ 1、药品终端网的库存与终端宝相同；
...               \ \ \ 2、下单后终端宝的库存变化正确；
...               \ \ 3、下单后药品终端网的库存及冻结库存变化正确；
...               \ 4、出库后冻结库存变化正确
...               该case会在web端和app之间切换，以suite分开
Force Tags        inventory    core
