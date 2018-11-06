*** Settings ***
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}商品${/}goods_web.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}通行证${/}login_web.robot
Resource          ${RESOURCE_PATH}${/}combine_service${/}交易域${/}商品${/}goods_web.robot

*** Test Cases ***
供应商下架该商品
    [Documentation]    writer:cp
    Saler Logined Successfully
    确认商品已上架
    供应商修改商品上下架状态    下架
