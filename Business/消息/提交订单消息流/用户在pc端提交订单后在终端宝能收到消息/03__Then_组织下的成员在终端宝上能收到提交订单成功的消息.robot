*** Settings ***
Resource          ../../资源/message.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}通行证${/}login_app.robot

*** Test Cases ***
组织下的成员在终端宝上能收到提交订单成功的消息
    组织下的店员收到提交订单成功的消息
    组织下的店长也收到提交订单的消息
    [Teardown]    Close Application

*** Keywords ***
组织下的店员收到提交订单成功的消息
    ZDB Login    ${SHOP_STAFF_NAME}    ${SHOP_STAFF_PWD}
    进入消息菜单查看订单类消息    订单提交成功
