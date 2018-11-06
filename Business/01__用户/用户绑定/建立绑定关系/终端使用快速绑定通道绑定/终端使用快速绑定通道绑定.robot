*** Settings ***
Resource          ../../Resources/common.robot

*** Test Cases ***
终端使用快速绑定通道绑定
    [Documentation]    writer:cp
    [Tags]    bind    formal
    [Setup]    Start ZDB
    Given 负责人登录并确认账号为未绑定
    When 使用快速绑定通道绑定
    Then 绑定成功
    [Teardown]    Close Application

*** Keywords ***
