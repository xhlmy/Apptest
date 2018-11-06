*** Settings ***
Resource          ${RESOURCE_PATH}${/}single_service${/}通行证${/}login_web.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}商品${/}inventory_web.robot

*** Test Cases ***
供应商获取商品库存
    Saler Logined Successfully
    Get The Inventory Messages
    [Teardown]

*** Keywords ***
