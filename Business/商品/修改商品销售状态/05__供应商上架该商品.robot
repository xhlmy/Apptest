*** Settings ***
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}商品${/}goods_web.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}通行证${/}login_web.robot

*** Test Cases ***
供应商上架该商品
    [Documentation]    writer:cp
    供应商修改商品上下架状态    上架
    [Teardown]    Close Browsers
