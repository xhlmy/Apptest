*** Settings ***
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}搜索${/}search_app.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}通行证${/}login_app.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}采购${/}下单${/}create_order_app.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}采购${/}购物车${/}cart_app.robot
Resource          ../../../Resources/mobile_resources/订单.robot

*** Test Cases ***
终端宝搜索商品下单
    [Setup]    Start ZDB
    ZDB Login    ${SHOP_MASTER_NAME}    ${SHOP_MASTER_PWD}
    Buyer`s Cart Is Empty
    Buyer Searches Goods
    Buyer Joins Goods To Cart
    Buyer Confirms Order Messages
    Buyer Submits Order
    获取订单编号
    [Teardown]    Close Application
