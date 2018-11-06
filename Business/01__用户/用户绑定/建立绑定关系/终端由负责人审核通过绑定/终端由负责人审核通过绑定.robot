*** Settings ***
Resource          ../../Resources/common.robot

*** Test Cases ***
终端由负责人审核通过绑定
    [Documentation]    writer:cp
    [Tags]    bind
    [Setup]    Start ZDB
    Given 员工登录并确认账号为未绑定
    When 终端完善信息提交绑定申请
    And 店铺负责人审核通过
    Then 终端查看绑定成功
    [Teardown]    Close Application

*** Keywords ***
店铺负责人审核通过
    负责人登录
    通过终端审核请求
    重置ZDB

通过终端审核请求
    Click Element    id=com.ypzdw.yaoyi:id/tab_my
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/tv_manage_tips    ${WAIT_TIMEOUT}    我的页面加载失败
    Click Element    id=com.ypzdw.yaoyi:id/tv_manage_tips
    Wait Until Page Contains Element    //android.widget.TextView[@text='${name}']/parent::android.widget.LinearLayout/following-sibling::android.widget.TextView[@text='通过']    ${WAIT_TIMEOUT}    1.页面未加载成功2.未提交审核成功
    Click Element    //android.widget.TextView[@text='${name}']/parent::android.widget.LinearLayout/following-sibling::android.widget.TextView[@text='通过']
    Wait Until Page Contains Element    //android.widget.TextView[@text='${name}']/parent::android.widget.LinearLayout/following-sibling::android.widget.TextView[@text='解绑']    ${WAIT_TIMEOUT}    审核后绑定状态错误

负责人登录
    重置ZDB
    ZDB Login    ${SHOP_MASTER_NAME}    ${SHOP_MASTER_PWD}

重置ZDB
    Reset Application
    Swipe Page

终端查看绑定成功
    ZDB Login    ${SHOP_STAFF_NAME}    ${SHOP_STAFF_PWD}
    进入我的绑定页面
    绑定成功
