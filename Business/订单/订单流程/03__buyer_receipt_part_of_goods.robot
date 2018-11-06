*** Settings ***
Suite Teardown
Resource          ../../../Resources/mobile_resources/library.robot
Resource          ../../../Resources/mobile_resources/订单.robot

*** Test Cases ***
Buyer Receipt Part Of Goods
    [Setup]
    When Shop Master See Order Was Sends Out
    Then Shop Master Receipt Part Of Goods
    [Teardown]    Close Application

*** Keywords ***
Shop Master See Order Was Sends Out
    Click Element    id=com.ypzdw.yaoyi:id/app_ebusiness_tv_back_main
    进入订单中心
    Click Element    //android.view.View[@content-desc='待收货']
    Wait Until Page Contains Element    //android.view.View[@content-desc='${ORDERCODE}']
    Click Element    //android.view.View[@content-desc='${ORDERCODE}']
    Wait Until Page Contains    发起冲红    ${WAIT_TIMEOUT}
    ${outPrice}    Evaluate    ${PRICE}*${OUT_NUMBER}
    Page Should Contain Text    ￥${outPrice}

Shop Master Receipt Part Of Goods
    Click A Point    600    800
    Wait Until Page Contains    取 \ \ 消
    Click Element    name=-
    Click Element    name=-
    ${receiptNumber}    Evaluate    ${OUT_NUMBER}-2
    ${receiptPrice}    Evaluate    ${receiptNumber}*${PRICE}
    Page Should Contain Text    ￥${receiptPrice}
    Wait Until Page Contains Element    //android.widget.TextView[@resource-id="com.ypzdw.yaoyi:id/tv_confirm" and @enabled="true"]    ${WAIT_TIMEOUT}
    Click Element    id=com.ypzdw.yaoyi:id/tv_confirm
    Wait Until Page Contains    冲红原因
    Click Element    name=未收到货
    Click Element    name=确认提交
    Wait Until Page Contains    待收货    ${WAIT_TIMEOUT}
    Wait Until Page Does Not Contain    ${ORDERCODE}    ${WAIT_TIMEOUT}    冲红失败
