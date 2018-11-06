*** Settings ***
Resource          ${RESOURCE_PATH}${/}single_service${/}通行证${/}login_app.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}搜索${/}search_app.robot
Resource          ../../../../Resources/mobile_resources/搜索推荐.robot

*** Test Cases ***
买家在终端宝搜索界面能查看到最新的价格库存
    [Setup]    Start ZDB
    ZDB Login    ${SHOP_MASTER_NAME}    ${SHOP_MASTER_PWD}
    Buyer Searches Goods
    买家在搜索页能查看到最新的价格
    买家在搜索页能查看到最新的库存
    [Teardown]    Close Application

*** Keywords ***
买家在搜索页能查看到最新的价格
    获取搜索页面单价
    Should Be Equal As Strings    ${GOODS_NEW_PRICE}    ${PRICE}    终端宝搜索价格同步失败

买家在搜索页能查看到最新的库存
    终端宝获取商品库存
    Should Be Equal As Strings    ${INVENTORY_NEW}    ${ZDB_INVENTORY}    终端宝搜索库存同步失败
