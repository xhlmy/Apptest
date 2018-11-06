*** Settings ***
Resource          library.robot

*** Keywords ***
ZDB Manager Login
    Open Browser    ${ZDB_BACKGROUND_URL}
    Maximize Browser Window
    Wait Until Page Contains    药豆终端宝    ${WAIT_TIMEOUT}
    Clear Element Text    id=inputName
    Input Text    id=inputName    ${ZDB_MANAGER_USERNAME}
    Clear Element Text    id=inputPassword
    Input Password    id=inputPassword    ${ZDB_MANAGER_PASSWORD}
    Click Element    //button[@class='btn btn-primary btn-block btn-flat']
    Wait Until Page Contains    内容
