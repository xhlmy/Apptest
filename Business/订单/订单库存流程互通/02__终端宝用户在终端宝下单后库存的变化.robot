*** Settings ***
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}采购${/}购物车${/}cart_app.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}采购${/}下单${/}create_order_app.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}通行证${/}login_app.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}搜索${/}search_app.robot
Resource          ../../../Resources/mobile_resources/搜索推荐.robot
Resource          ../../../Resources/mobile_resources/订单.robot
Resource          ../../../Resources/mobile_resources/支付.robot

*** Test Cases ***
下单并验证库存变化
    [Setup]    Start ZDB
    终端宝用户下单前先验证与药品终端网库存相等
    终端宝用户在终端宝提交订单
    验证提交订单后库存变化
    [Teardown]    Close Application

*** Keywords ***
终端宝用户下单前先验证与药品终端网库存相等
    ZDB Login    ${SHOP_MASTER_NAME}    ${SHOP_MASTER_PWD}
    Buyer`s Cart Is Empty
    Buyer Searches Goods
    终端宝获取商品库存
    终端宝与pc端比较商品库存

终端宝用户在终端宝提交订单
    Buyer Joins Goods To Cart
    Buyer Confirms Order Messages
    Buyer Submits Order
    店员在终端宝使用余额支付
    Comment    获取订单编号

验证提交订单后库存变化
    Go Back
    Comment    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/tab_buy
    Comment    Click Element    id=com.ypzdw.yaoyi:id/tab_buy
    Comment    Wait Until Page Contains Element    name=搜索购
    New Buyer Searches Goods
    ${ZDBinventorAfterDeal}    Get Element Attribute    //android.view.View[contains(@content-desc,'库存') and @clickable='true']    name
    @{ZDBinventorAfterDeal}    Get Regexp Matches    ${ZDBinventorAfterDeal}    ：(.*)    1
    ${ZDBinventorAfterDeal}    Convert To Number    @{ZDBinventorAfterDeal}[0]
    ${ZDBinventorAfterDeal1}    Evaluate    ${ZDBinventory}-${BUY_NUMBER}
    Should Be Equal As Numbers    ${ZDBinventorAfterDeal}    ${ZDBinventorAfterDeal1}    下单后库存终端宝库存未变化

终端宝与pc端比较商品库存
    Should Be Equal As Numbers    ${INVENTORY}    ${ZDBinventory}
