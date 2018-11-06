*** Settings ***
Resource          ../Resources/common.robot

*** Test Cases ***
解除绑定关系
    [Tags]    bind
    [Setup]    Start ZDB
    Given 负责人登录并确认账号为已绑定
    When 解除绑定
    Then 解除绑定后无法查看到采购和工作页面
    And 恢复账号绑定状态
    [Teardown]    Close Application

*** Keywords ***
负责人登录并确认账号为已绑定
    ZDB Login    ${SHOP_MASTER_NAME}    ${SHOP_MASTER_PWD}
    确认账号为已绑定

确认账号为已绑定
    Click Element    id=com.ypzdw.yaoyi:id/tab_my
    ${name}    Get Element Attribute    id=com.ypzdw.yaoyi:id/tv_name    text
    Set Global Variable    ${name}
    Click Element    id=com.ypzdw.yaoyi:id/tv_manage_tips
    Wait Until Page Contains Element    //android.widget.TextView[@text="我的组织"]    ${WAIT_TIMEOUT}
    ${status}    Run Keyword And Return Status    Wait Until Page Does Not Contain Element    id=com.ypzdw.yaoyi:id/tv_unbind
    Run Keyword If    '${status}'=='True'    使用快速绑定通道绑定

解除绑定后无法查看到采购和工作页面
    Go Back
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/tab_buy    ${WAIT_TIMEOUT}    未成功回到“我的”页面
    Click Element    id=com.ypzdw.yaoyi:id/tab_buy
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/tv_result_tips    ${WAIT_TIMEOUT}    未绑定提示未显示
    Wait Until Page Does Not Contain Element    id=com.ypzdw.yaoyi:id/tv_title_search    ${WAIT_TIMEOUT}    解除绑定后依然可以购买

恢复账号绑定状态
    进入未绑定状态下我的绑定页面
    使用快速绑定通道绑定
    绑定成功

进入未绑定状态下我的绑定页面
    Click Element    id=com.ypzdw.yaoyi:id/tab_my
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/btn_bind    ${WAIT_TIMEOUT}    未进入我的页面
    Click Element    id=com.ypzdw.yaoyi:id/btn_bind
