*** Settings ***
Resource          ${RESOURCE_PATH}${/}single_service${/}通行证${/}login_web.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}搜索${/}search_web.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}采购${/}购物车${/}cart_web.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}采购${/}下单${/}create_order_web.robot

*** Variables ***

*** Test Cases ***
终端用户在网页上提交订单
    Buyer Logined Successfully    ${BUYER_MOBILE}    ${BUYER_PWD}
    Ensure The Cart Is Empty
    Buyer Search Good From Index Page    ${SEARCH_GOOD_GYZZ}    ${SEARCH_GOOD_ID}
    Buyer Joined Cart From Search Reasult Page    ${SEARCH_GOOD_ID}
    Buyer Confirm Order
    Buyer Submits Order
    [Teardown]    Close Browsers
