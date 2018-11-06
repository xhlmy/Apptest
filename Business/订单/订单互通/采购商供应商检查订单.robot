*** Settings ***
Resource          ${RESOURCE_PATH}${/}single_service${/}通行证${/}login_web.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}订单${/}order_web.robot

*** Test Cases ***
采购商供应商查看生成的订单
    Buyer Logined Successfully    ${BUYER_MOBILE}    ${BUYER_PWD}
    采购商检查生成的订单
    Saler Logined Successfully
    供应商检查生成的订单
    [Teardown]    Close Browsers

*** Keywords ***
