*** Settings ***
Resource          ${RESOURCE_PATH}${/}single_service${/}通行证${/}login_app.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}搜索${/}search_app.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}采购${/}下单${/}create_order_app.robot
Resource          ../../资源/message.robot
Resource          ../../../../Resources/mobile_resources/订单.robot

*** Variables ***

*** Test Cases ***
用户在终端宝提交订单后能收到消息
    Given 终端宝用户已将商品放入购物车
    When 终端宝用户提交订单
    Then 组织下的店员收到提交订单成功的消息
    And 组织下的店长也收到提交订单的消息
    [Teardown]    Close Application

*** Keywords ***
终端宝用户已将商品放入购物车
    Start ZDB
    ZDB Login    ${SHOP_STAFF_NAME}    ${SHOP_STAFF_PWD}
    Buyer`s Cart Is Empty
    Buyer Searches Goods
    Buyer Joins Goods To Cart

终端宝用户提交订单
    Buyer Confirms Order Messages
    Buyer Submits Order
    获取订单编号

组织下的店员收到提交订单成功的消息
    Go Back
    进入消息菜单查看订单类消息    订单提交成功
