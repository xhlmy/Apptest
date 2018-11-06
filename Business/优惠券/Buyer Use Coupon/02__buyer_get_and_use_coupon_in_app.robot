*** Settings ***
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}搜索${/}search_app.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}通行证${/}login_app.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}采购${/}购物车${/}cart_app.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}采购${/}下单${/}create_order_app.robot

*** Test Cases ***
Buyer Gets And Uses Coupon In APP
    [Tags]    coupon
    [Setup]    Start ZDB
    ZDB Login    ${SHOP_MASTER_NAME}    ${SHOP_MASTER_PWD}
    Buyer Gets Coupon
    Buyer Uses Coupon
    [Teardown]    Close Application

*** Keywords ***
Buyer Gets Coupon
    Click Element    id=com.ypzdw.yaoyi:id/tab_buy
    Wait Until Page Contains Element    //android.webkit.WebView[@content-desc='采购首页']/following::android.view.View[1]    ${WAIT_TIMEOUT}
    Swipe    370    260    370    260    500
    Wait Until Page Contains Element    //android.view.View[@content-desc='点击领取']    ${WAIT_TIMEOUT}
    Click Element    //android.view.View[@content-desc='点击领取']
    Wait Until Page Contains Element    //android.view.View[@content-desc='已领取']
    Swipe    30    75    30    75    500    #点击H5优惠券界面的返回
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/tab_my
    Click Element    id=com.ypzdw.yaoyi:id/tab_my
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/tv_organ_wallet_tips
    Click Element    id=com.ypzdw.yaoyi:id/tv_organ_wallet_tips
    Wait Until Page Contains Element    //android.widget.TextView[@text='优惠券']    ${WAIT_TIMEOUT}    确认订单页面未显示优惠券使用的地方
    Click Element    //android.widget.TextView[@text='优惠券']
    Wait Until Page Contains Element    //android.view.View[@content-desc='立即使用']    ${WAIT_TIMEOUT}

Buyer Uses Coupon
    Click Element    //android.view.View[@content-desc='平台券']/following::android.view.View[1]
    Wait Until Page Contains    搜索购    20
    Buyer`s Cart Is Empty
    Buyer Searches Goods
    Buyer Joins Goods To Cart
    Buyer Confirms Order Messages
    Buyer Use Coupon In Order Page
    Buyer Submits Order

Buyer Use Coupon In Order Page
    #由于优惠券的H5界面无法定位，只能采取暴力方法进行流程
    Wait Until Page Contains Element    name=选择使用
    Click Element    name=选择使用
    sleep    3
    Swipe    350    240    350    240    500    #选择优惠券
    Sleep    1
    Swipe    350    1250    350    1250    500    #确认选择
    sleep    2
    ${couponUseMoney}    Get Element Attribute    //android.view.View[@content-desc="优惠券"]/following::android.view.View[2]    name
    @{couponUseMoney}    Get Regexp Matches    ${couponUseMoney}    ￥(.*)    1
    ${couponUseMoney}    Convert To Number    @{couponUseMoney}[0]
    ${postageMoney}    Get Element Attribute    //android.view.View[@content-desc="运费总计："]/following::android.view.View[1]    name
    @{postageMoney}    Get Regexp Matches    ${postageMoney}    ￥(.*)    1
    ${postageMoney}    Convert To Number    @{postageMoney}[0]
    ${totalMoney}    Evaluate    ${PRICE}*${BUY_NUMBER}-${couponUseMoney}+${postageMoney}
    ${totalMoney}    Convert To String    ${totalMoney}
    Wait Until Page Contains    ${totalMoney}    #确认优惠券使用后生效
