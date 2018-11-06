*** Settings ***
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}搜索${/}search_app.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}采购${/}购物车${/}cart_app.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}采购${/}下单${/}create_order_app.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}通行证${/}login_app.robot
Resource          ../../../Resources/mobile_resources/library.robot
Resource          ../../../Resources/mobile_resources/搜索推荐.robot
Resource          ../../../Resources/mobile_resources/支付.robot

*** Test Cases ***
采购商在终端宝消费并验证其组织余额变化
    [Setup]    Start ZDB
    Given 采购商已获取组织余额
    When 采购商在终端宝下单并支付
    Then 采购商的组织余额变化正确
    [Teardown]    Close Application

*** Keywords ***
采购商已获取组织余额
    ZDB Login    ${SHOP_MASTER_NAME}    ${SHOP_MASTER_PWD}
    Click Element    id=com.ypzdw.yaoyi:id/tab_my
    Wait Until Page Contains Element    name=组织账户
    Click Element    name=组织账户
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/tv_cash_amount
    ${ACCOUNT_BALANCE_APP}    Get Element Attribute    id=com.ypzdw.yaoyi:id/tv_cash_amount    text
    Should Be Equal    ${ACCOUNT_BALANCE_APP}    ${ACCOUNT_BALANCE}
    Go Back
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/tab_my
    Set Test Variable    ${ACCOUNT_BALANCE_APP}

采购商的组织余额变化正确
    Click Element    id=com.ypzdw.yaoyi:id/app_ebusiness_tv_back_main
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/tab_my
    Click Element    id=com.ypzdw.yaoyi:id/tab_my
    Wait Until Page Contains Element    name=组织账户
    Click Element    name=组织账户
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/tv_cash_amount
    ${afterDeal}    Get Element Attribute    id=com.ypzdw.yaoyi:id/tv_cash_amount    text
    ${AFTER_DEAL_ACCOUNT}    Convert To Number    ${afterDeal}
    Set Global Variable    ${AFTER_DEAL_ACCOUNT}
    ${ACCOUNT_BALANCE_APP}    Evaluate    ${ACCOUNT_BALANCE_APP}-${TOTAL_PRICE}
    Should Be Equal As Numbers    ${ACCOUNT_BALANCE_APP}    ${AFTER_DEAL_ACCOUNT}

提交订单
    获取订单总额
    Buyer Submits Order

采购商在终端宝下单并支付
    搜索商品
    Buyer Joins Goods To Cart
    Buyer Confirms Order Messages
    提交订单
    店员在终端宝使用余额支付

搜索商品
    Buyer`s Cart Is Empty
    Buyer Searches Goods
    获取搜索页面单价

获取订单总额
    ${discountAmount}    Get Element Attribute    //android.view.View[@content-desc='优惠总计：']/following-sibling::android.view.View    name
    @{discountAmount}    Get Regexp Matches    ${discountAmount}    ￥(.*)    1
    ${discountAmount}    Convert To Number    @{discountAmount}[0]
    ${postageMoney}    Get Element Attribute    //android.view.View[@content-desc='运费总计：']/following-sibling::android.view.View    name
    @{postageMoney}    Get Regexp Matches    ${postageMoney}    ￥(.*)    1
    ${postageMoney}    Convert To Number    @{postageMoney}[0]
    ${TOTAL_PRICE}    Evaluate    ${PRICE}*${BUY_NUMBER}+${postageMoney}-${discountAmount}
    Set Global Variable    ${TOTAL_PRICE}
