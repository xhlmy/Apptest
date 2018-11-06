*** Settings ***
Resource          ${RESOURCE_PATH}${/}single_service${/}通行证${/}login_web.robot
Resource          ${RESOURCE_PATH}${/}combine_service${/}交易域${/}物流${/}logistics_web.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}订单${/}order_web.robot
Resource          ${RESOURCE_PATH}${/}combine_service${/}交易域${/}订单${/}order_web.robot

*** Variables ***

*** Test Cases ***
Saler Sends Out Partial Goods
    Given Saler Logined Successfully
    When Saler Confirm Order
    Then Saler Sents Out Goods
    [Teardown]    Close Browsers

*** Keywords ***
Saler Sents Out Goods
    Out Cargo
    Registration Logistics Information
