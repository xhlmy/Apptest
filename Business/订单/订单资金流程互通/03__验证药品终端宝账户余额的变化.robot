*** Settings ***
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}支付${/}交易风控${/}支付跟踪${/}money_web.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}通行证${/}login_web.robot
Resource          ../../../Resources/web_resources/library.robot

*** Test Cases ***
采购商在终端宝消费后药品终端网的资金流同步变化
    采购商在终端宝消费后药品终端网的账户余额同步变化
    采购商在终端宝消费后药品终端网的账户明细同步记录
    [Teardown]    Close Browsers

*** Keywords ***
采购商在终端宝消费后药品终端网的账户明细同步记录
    Go To    http://pur.ypzdw.info/Finance/TradeCashFlow
    Wait Until Page Contains Element    //td[@class='T-left']    ${WAIT_TIMEOUT}
    ${detailAccount}    Get Text    //td[contains(.,'${ORDERCODE}')]/preceding-sibling::td[1]
    @{detailAccount}    Get Regexp Matches    ${detailAccount}    ¥(.*)    1
    ${detailAccount}    Replace String    @{detailAccount}[0]    ,    ${EMPTY}
    ${detailAccount}    Convert To Number    ${detailAccount}
    ${detailPayAccount}    Get Text    //td[contains(.,'${ORDERCODE}')]/preceding-sibling::td[2]/strong
    @{detailPayAccount}    Get Regexp Matches    ${detailPayAccount}    ¥(.*)    1
    ${detailPayAccount}    Convert To Number    @{detailPayAccount}[0]
    Should Be Equal As Numbers    ${detailPayAccount}    ${TOTAL_PRICE}
    Should Be Equal As Numbers    ${detailAccount}    ${ACCOUNT_BALANCE}

采购商在终端宝消费后药品终端网的账户余额同步变化
    Get Account Balance From Pur Page
    检查终端宝和PC账户余额同步

检查终端宝和PC账户余额同步
    Should Be Equal As Numbers    ${ACCOUNT_BALANCE}    ${AFTER_DEAL_ACCOUNT}
