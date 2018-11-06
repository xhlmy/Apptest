*** Settings ***
Resource          ../../Resources/common.robot

*** Test Cases ***
终端提交绑定申请
    [Documentation]    writer:cp
    [Tags]    bind    formal
    [Setup]    Start ZDB
    员工登录并确认账号为未绑定
    终端完善信息提交绑定申请
    [Teardown]

*** Keywords ***
