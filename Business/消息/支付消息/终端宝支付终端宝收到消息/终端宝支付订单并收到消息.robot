*** Settings ***
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}搜索${/}search_app.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}采购${/}购物车${/}cart_app.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}采购${/}下单${/}create_order_app.robot
Resource          ../../资源/message.robot
Resource          ../../../../Resources/mobile_resources/支付.robot

*** Test Cases ***
终端宝支付订单并收到消息
    Given 店员在终端宝提交订单
    When 店员在终端宝使用余额支付
    Then 店员收到订单已支付成功的消息
    And 店长也收到订单支付成功的消息
    [Teardown]    Close Application

*** Keywords ***
店员在终端宝提交订单
    Start ZDB
    ZDB Login    ${SHOP_STAFF_NAME}    ${SHOP_STAFF_PWD}
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/tab_buy    ${WAIT_TIMEOUT}    #采购选项卡未加载出来
    Click Element    id=com.ypzdw.yaoyi:id/tab_buy    #点击采购选项卡
    Buyer Searches Goods
    Buyer Joins Goods To Cart
    Buyer Confirms Order Messages
    Buyer Submits Order

店员收到订单已支付成功的消息
    Click Element    id=com.ypzdw.yaoyi:id/app_ebusiness_tv_back_main    #点击返回首页
    进入消息菜单查看订单类消息    订单支付成功
