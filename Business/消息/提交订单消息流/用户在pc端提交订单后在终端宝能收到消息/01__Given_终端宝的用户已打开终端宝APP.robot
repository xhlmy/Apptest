*** Settings ***
Resource          ${RESOURCE_PATH}${/}single_service${/}通行证${/}login_app.robot

*** Test Cases ***
打开终端宝
    Start ZDB
