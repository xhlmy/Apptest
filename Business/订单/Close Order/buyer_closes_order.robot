*** Settings ***
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}搜索${/}search_app.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}通行证${/}login_app.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}采购${/}购物车${/}cart_app.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}采购${/}下单${/}create_order_app.robot
Resource          ../../../Resources/mobile_resources/支付.robot
Resource          ../../../Resources/mobile_resources/订单.robot

*** Test Cases ***
Close Order
    [Documentation]    店老板关闭订单：
    ...    流程：清空购物车->下单->关闭订单
    ...    规则：验证支付宝支付跳转
    [Tags]
    [Setup]    Start ZDB
    Given ZDB Login    ${SHOP_MASTER_NAME}    ${SHOP_MASTER_PWD}
    And Buyer`s Cart Is Empty
    When Buyer Creates An Order
    Then Buyer Closes The Order
    [Teardown]    Close Application

*** Keywords ***
Buyer Closes The Order
    获取订单编号
    Click Element    //android.view.View[@content-desc='${ORDERCODE}']/following-sibling::android.view.View[5]/android.view.View    #根据订单编号关闭订单
    Wait Until Page Contains    温馨提示
    Click Element    name=是
    Wait Until Page Contains    已关闭

Buyer Creates An Order
    Buyer Searches Goods
    Buyer Joins Goods To Cart
    Buyer Confirms Order Messages
    Buyer Submits Order
    Buyer Pays Order Just Jump To Alipay Page
