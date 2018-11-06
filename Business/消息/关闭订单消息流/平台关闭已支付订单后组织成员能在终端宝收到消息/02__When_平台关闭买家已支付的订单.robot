*** Settings ***
Resource        ${RESOURCE_PATH}${/}single_service${/}交易域${/}订单${/}order_web.robot
Resource        ${RESOURCE_PATH}${/}single_service${/}通行证${/}login_web.robot
Resource        ${RESOURCE_PATH}${/}single_service${/}交易域${/}搜索${/}search_web.robot
Resource        ${RESOURCE_PATH}${/}single_service${/}交易域${/}采购${/}购物车${/}cart_web.robot
Resource        ${RESOURCE_PATH}${/}single_service${/}交易域${/}采购${/}下单${/}create_order_web.robot
Resource        ${RESOURCE_PATH}${/}combine_service${/}交易域${/}支付${/}支付工具${/}pay_web.robot

*** Test Cases ***
平台关闭买家已支付的订单
  Buyer Logined Successfully    ${BUYER_MOBILE}    ${BUYER_PWD}
  Buyer Search Good From Index Page  ${SEARCH_GOOD_GYZZ}  ${SEARCH_GOOD_ID}
  Buyer Joined Cart From Search Reasult Page  ${SEARCH_GOOD_ID}
  Buyer Confirm Order
  Buyer Submits Order
  Buyer Pay Order
  Manager Logined Successfully
  Manager Closes An Order
  [Teardown]  Close Browsers
