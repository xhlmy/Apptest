*** Settings ***
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}搜索${/}search_app.robot
Resource          ../../../Resources/mobile_resources/library.robot

*** Test Cases ***
采购商能够搜索到下架后上架商品
    [Documentation]    writer:cp
    采购商再次搜索查看商品已上架
    [Teardown]    Close Application

*** Keywords ***
采购商再次搜索查看商品已上架
    Wait Until Keyword Succeeds    20s    1s    再次搜索查看商品

再次搜索查看商品
    Click Element    //android.view.View[@content-desc='搜索']
    Wait Until Page Contains    ${COMPANY_NAME}
