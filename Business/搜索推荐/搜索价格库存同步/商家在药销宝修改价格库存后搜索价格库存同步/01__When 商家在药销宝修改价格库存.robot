*** Settings ***
Resource          ${RESOURCE_PATH}${/}combine_service${/}交易域${/}商品${/}goods_web.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}通行证${/}login_web.robot

*** Test Cases ***
商家在药销宝修改价格库存
    Saler Logined Successfully
    Saler Modified Goods Price And Inventory
    [Teardown]    Close Browsers
