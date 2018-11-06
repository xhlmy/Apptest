*** Settings ***
Resource          ${RESOURCE_PATH}${/}single_service${/}通行证${/}login_web.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}支付${/}交易风控${/}支付跟踪${/}money_web.robot

*** Test Cases ***
采购商获取账户余额
    Buyer Logined Successfully    ${BUYER_MOBILE}    ${BUYER_PWD}
    Get Account Balance From Pur Page
    [Teardown]

*** Keywords ***
