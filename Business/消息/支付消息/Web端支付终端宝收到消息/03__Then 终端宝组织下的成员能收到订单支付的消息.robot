*** Settings ***
Resource          ../../资源/message.robot

*** Test Cases ***
终端宝成员能收到订单支付的消息
    店员收到订单支付成功的消息
    店长也收到订单支付成功的消息
    [Teardown]    Close Application
