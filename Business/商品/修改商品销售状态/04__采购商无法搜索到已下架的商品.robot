*** Settings ***
Resource          ${RESOURCE_PATH}${/}single_service${/}通行证${/}login_app.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}搜索${/}search_app.robot

*** Test Cases ***
采购商无法搜索到已下架的商品
    [Documentation]    writer:cp
    [Setup]    Start ZDB
    ZDB Login    ${SHOP_MASTER_NAME}    ${SHOP_MASTER_PWD}
    采购商无法搜索到商品

*** Keywords ***
