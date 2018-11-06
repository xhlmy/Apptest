*** Settings ***
Resource          ../../资源/message.robot

*** Test Cases ***
组织下的成员在终端宝能收到关闭订单的消息
    店员收到关闭订单的消息
    店长也收到关闭订单的消息
    [Teardown]    Close Application
