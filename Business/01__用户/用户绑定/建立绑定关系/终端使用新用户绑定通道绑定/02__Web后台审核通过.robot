*** Settings ***
Resource          ${RESOURCE_PATH}${/}single_service${/}通行证${/}login_web.robot

*** Test Cases ***
Web后台审核通过
    [Documentation]    writer:cp
    [Tags]    bind    formal
    ZDB Manager Logined Successfully
    通过终端提交的审核申请
    [Teardown]    Close Browsers

*** Keywords ***
通过终端提交的审核申请
    Go To    ${ZDB_BACKGROUND_URL}/bind/index
    Wait Until Element Is Visible    //select[@name="bindInfo_table_length"]    ${WAIT_TIMEOUT}    选择页面显示条数未加载出
    Click Element    //select[@class='form-control input-sm']/option[4]
    Wait Until Element Is Visible    //td[contains(.,"${name}")]    ${WAIT_TIMEOUT}    页面没有之前提交的审核信息
    Click Element    //td[contains(.,"${name}")]/parent::*/child::td[6]/a
    Alert Should Be Present    确认通过${name}的申请?
    Choose Ok On Next Confirmation
