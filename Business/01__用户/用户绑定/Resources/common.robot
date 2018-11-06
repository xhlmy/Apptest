*** Settings ***
Resource          ${RESOURCE_PATH}${/}single_service${/}通行证${/}login_app.robot

*** Keywords ***
负责人登录并确认账号为未绑定
    ZDB Login    ${SHOP_MASTER_NAME}    ${SHOP_MASTER_PWD}
    确认账号为未绑定

确认账号为未绑定
    Click Element    id=com.ypzdw.yaoyi:id/tab_my
    ${name}    Get Element Attribute    id=com.ypzdw.yaoyi:id/tv_name    text
    Set Global Variable    ${name}
    ${status}    Run Keyword And Return Status    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/tv_manage_tips    8s
    Run Keyword If    '${status}'=='True'    点击管理
    ...    ELSE    点击去绑定
    Wait Until Page Contains Element    //android.widget.TextView[@text="我的组织"]    ${WAIT_TIMEOUT}
    : FOR    ${n}    IN RANGE    20
    \    ${status}    Run Keyword And Return Status    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/tv_unbind
    \    Run Keyword If    '${status}'=='True'    解除绑定
    \    ...    ELSE    Exit For Loop

解除绑定
    Wait Until Page Contains Element    //android.widget.TextView[@text='${name}']/parent::android.widget.LinearLayout/following-sibling::android.widget.TextView[@text='解绑']    ${WAIT_TIMEOUT}    解绑按钮未加载出
    Click Element    //android.widget.TextView[@text='${name}']/parent::android.widget.LinearLayout/following-sibling::android.widget.TextView[@text='解绑']
    Wait Until Page Contains Element    id=android:id/button1    ${WAIT_TIMEOUT}    点击解绑按钮页面无响应
    Click Element    id=android:id/button1
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/tv_title_more    ${WAIT_TIMEOUT}    解绑后页面未回到绑定页面

绑定成功
    Wait Until Page Contains Element    //android.widget.TextView[@text='${name}']/parent::android.widget.LinearLayout/following-sibling::android.widget.TextView    ${WAIT_TIMEOUT}    未绑定成功
    Go Back
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/tab_buy    ${WAIT_TIMEOUT}    点击返回后未回到“我的”页面
    Click Element    id=com.ypzdw.yaoyi:id/tab_buy
    Wait Until Page Contains Element    //android.webkit.WebView    ${WAIT_TIMEOUT}

终端完善信息提交绑定申请
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/tv_title_more    ${WAIT_TIMEOUT}    添加绑定按钮未加载出现
    Click Element    id=com.ypzdw.yaoyi:id/tv_title_more
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/layout_user    ${WAIT_TIMEOUT}    未加载出选择绑定类型页面
    Click Element    id=com.ypzdw.yaoyi:id/layout_user
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/layout_organ    ${WAIT_TIMEOUT}    新用户绑定页面未加载成功
    Click Element    id=com.ypzdw.yaoyi:id/layout_organ
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/edt_search    ${WAIT_TIMEOUT}    搜索组织页面未加载成功
    Input Text    id=com.ypzdw.yaoyi:id/edt_search    ${CUSTOMER_NAME}
    Click Element    id=com.ypzdw.yaoyi:id/tv_search_organ
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/cb_organ    ${WAIT_TIMEOUT}    未搜索到要绑定的组织
    Click Element    id=com.ypzdw.yaoyi:id/cb_organ
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/layout_job    ${WAIT_TIMEOUT}    选择组织后未回到新用户绑定组织页面
    Click Element    id=com.ypzdw.yaoyi:id/layout_job
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/cb_organ    ${WAIT_TIMEOUT}    未成功加载出账号职位选择页面
    Comment    Click Element    //android.widget.CheckBox[@text='负责人']
    Click Element    //android.widget.CheckBox[@text='员工']
    Click Element    id=com.ypzdw.yaoyi:id/tv_title_more
    Wait Until Page Contains Element    //android.widget.TextView[@text='员工 ']    ${WAIT_TIMEOUT}    选择角色未保存成功
    Click Element    id=com.ypzdw.yaoyi:id/tv_submit_audit
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/btn_bind    ${WAIT_TIMEOUT}    信息填写完成后未成功回到“我的”页面
    Click Element    id=com.ypzdw.yaoyi:id/btn_bind
    Wait Until Page Contains Element    //android.widget.TextView[@text='${name}']    ${WAIT_TIMEOUT}    提交审核失败（估计程序本身问题）
    Go Back
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/tab_buy    ${WAIT_TIMEOUT}    未回到终端用户界面

使用快速绑定通道绑定
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/tv_title_more    ${WAIT_TIMEOUT}    添加绑定按钮未加载出现
    Click Element    id=com.ypzdw.yaoyi:id/tv_title_more
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/layout_terminal    ${WAIT_TIMEOUT}    未加载出选择绑定类型页面
    Click Element    id=com.ypzdw.yaoyi:id/layout_terminal
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/edt_account    ${WAIT_TIMEOUT}    未成功加载出输入账号密码页面
    Input Text    id=com.ypzdw.yaoyi:id/edt_account    ${BUYER_NAME}
    Input Text    id=com.ypzdw.yaoyi:id/edt_password    ${BUYER_PWD}
    Click Element    id=com.ypzdw.yaoyi:id/btn_bind
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/edt_real_name    ${WAIT_TIMEOUT}    未成功加载出输入基本信息页面
    Input Text    id=com.ypzdw.yaoyi:id/edt_real_name    ${name}
    Click Element    id=com.ypzdw.yaoyi:id/layout_choose_position
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/cb_organ    ${WAIT_TIMEOUT}    未成功加载出账号职位选择页面
    Click Element    //android.widget.CheckBox[@text='负责人']
    Comment    Click Element    //android.widget.CheckBox[@text='员工']
    Click Element    id=com.ypzdw.yaoyi:id/tv_title_more
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/btn_submit    ${WAIT_TIMEOUT}    选择完职位后未回到基本信息填写页面
    Click Element    id=com.ypzdw.yaoyi:id/btn_submit
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/tab_my    ${WAIT_TIMEOUT}    基本信息填写完成后未回到终端用户界面
    进入我的绑定页面

进入我的绑定页面
    Click Element    id=com.ypzdw.yaoyi:id/tab_my
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/tv_manage_tips    ${WAIT_TIMEOUT}    未进入我的页面
    Click Element    id=com.ypzdw.yaoyi:id/tv_manage_tips

员工登录并确认账号为未绑定
    ZDB Login    ${SHOP_STAFF_NAME}    ${SHOP_STAFF_PWD}
    确认账号为未绑定

点击管理
    Click Element    id=com.ypzdw.yaoyi:id/tv_manage_tips

点击去绑定
    Click Element    id=com.ypzdw.yaoyi:id/btn_bind
