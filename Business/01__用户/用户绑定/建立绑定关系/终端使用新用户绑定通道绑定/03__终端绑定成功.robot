*** Settings ***
Resource          ../../Resources/common.robot

*** Test Cases ***
终端绑定成功
    [Documentation]    writer:cp
    [Tags]    bind    formal
    [Setup]
    进入我的绑定页面
    绑定成功
    [Teardown]    Close Application
