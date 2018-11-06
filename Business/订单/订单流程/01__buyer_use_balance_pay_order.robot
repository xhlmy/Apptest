*** Settings ***
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}搜索${/}search_app.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}通行证${/}login_app.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}采购${/}购物车${/}cart_app.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}采购${/}下单${/}create_order_app.robot
Resource          ../../../Resources/mobile_resources/支付.robot
Resource          ../../../Resources/mobile_resources/搜索推荐.robot

*** Test Cases ***
Buyer Creates An Order And Payed
    [Tags]
    [Setup]    Start ZDB
    Given ZDB Login    ${SHOP_MASTER_NAME}    ${SHOP_MASTER_PWD}
    And Buyer`s Cart Is Empty
    When Buyer Search Goods
    And Buyer Joins Goods To Cart
    And Buyer Confirms Order Messages
    And Buyer Submits Order
    店员在终端宝使用余额支付
    [Teardown]

Buyer Creates An Order And Payed for formal
    [Tags]    formal    kill
    [Setup]    Start ZDB
    Given ZDB Login    ${SHOP_MASTER_NAME}    ${SHOP_MASTER_PWD}
    And Buyer`s Cart Is Empty
    When Buyer Search Goods
    And Buyer Joins Goods To Cart
    And Buyer Confirms Order Messages
    And Buyer Submits Order
    Comment    店员在终端宝使用余额支付
    [Teardown]

*** Keywords ***
Buyer Search Goods
    Buyer Searches Goods
    获取搜索页面单价
