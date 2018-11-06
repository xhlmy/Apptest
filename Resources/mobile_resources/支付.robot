*** Settings ***
Resource          ${RESOURCE_PATH}${/}single_service${/}Library${/}library_app.robot
Resource          library.robot

*** Keywords ***
店员在终端宝使用余额支付
    Wait Until Page Contains Element    //android.widget.TextView[@text="终端账户余额"]/following-sibling::android.widget.CheckBox[@checked="true"]    ${WAIT_TIMEOUT}
    Click Element    name=确认支付    #点击支付
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/dialog_title_tv    #终端网账号密码出现
    Input Text    id=com.ypzdw.yaoyi:id/dialog_edt1    ${BUYER_NAME}
    Input Password    id=com.ypzdw.yaoyi:id/dialog_edt2    ${BUYER_PWD}
    Click Element    id=com.ypzdw.yaoyi:id/dialog_confirm
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/app_ebusiness_tv_back_main    #返回首页出现
    ${ORDERCODE}    Get Element Attribute    id=com.ypzdw.yaoyi:id/app_ebusiness_tv_order_no    text
    Set Global Variable    ${ORDERCODE}
    Page Should Contain Text    支付成功

Buyer Pays Order Just Jump To Alipay Page
    Wait Until Page Contains Element    //android.widget.TextView[@text="终端账户余额"]/following-sibling::android.widget.CheckBox[@checked="true"]    ${WAIT_TIMEOUT}
    Click Element    //android.widget.TextView[@text='支付宝']/following-sibling::android.widget.CheckBox
    Click Element    name=确认支付
    Comment    Wait Until Page Contains Element    //android.view.View[@content-desc='继续支付']    ${WAIT_TIMEOUT}
    Comment    Click Element    //android.view.View[@content-desc='继续支付']
    Wait Until Page Contains    登录支付宝    ${WAIT_TIMEOUT}
    Click Element    name=返回
    Wait Until Page Contains    退出    ${WAIT_TIMEOUT}
    sleep    3s    确认对话框需要完全加载才能准确点击！
    #由于确认退出按钮显示错位，只能用坐标定位
    Swipe    360    840    360    840    1000
    Wait Until Page Contains    选择支付方式
