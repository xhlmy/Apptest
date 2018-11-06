*** Settings ***
Resource          ${RESOURCE_PATH}${/}single_service${/}通行证${/}login_app.robot
Resource          ../../../Resources/mobile_resources/library.robot

*** Keywords ***
进入消息菜单查看订单类消息
    [Arguments]    ${oderMessage}
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/tab_home    ${WAIT_TIMEOUT}    #消息选项卡未加载
    Click Element    id=com.ypzdw.yaoyi:id/tab_home    #点击消息选项卡
    Wait Until Page Contains Element    name=订单消息    ${WAIT_TIMEOUT}    #未接收到订单消息
    Click Element    name=订单消息    #点击订单消息
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/tv_vendor    ${WAIT_TIMEOUT}    未接收到订单消息
    ${text}    Get Element Attribute    id=com.ypzdw.yaoyi:id/tv_vendor    text
    Should Be Equal    ${text}    ${COMPANY_SHORT_NAME}
    Click Element    id=com.ypzdw.yaoyi:id/tv_vendor
    ${text1}    Get Element Attribute    id=com.ypzdw.yaoyi:id/tv_state    text
    Should Be Equal    ${text1}    ${oderMessage}

店员返回终端宝首页并退出
    Go Back
    Go Back
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/tab_my    ${WAIT_TIMEOUT}    #我的选项卡未加载出来
    Click Element    id=com.ypzdw.yaoyi:id/tab_my    #进入我的选项卡
    Swipe    315    1146    315    618
    Wait Until Page Contains Element    name=退出登录    ${WAIT_TIMEOUT}    #退出登录未显示
    Click Element    name=退出登录    #点击退出登录
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/dialog_confirm    #退出登录确认框未弹出
    Click Element    id=com.ypzdw.yaoyi:id/dialog_confirm    #点击确定退出

组织下的店长也收到提交订单的消息
    店员返回终端宝首页并退出
    ZDB Login    ${SHOP_MASTER_NAME}    ${SHOP_MASTER_PWD}
    进入消息菜单查看订单类消息    订单提交成功

店长也收到关闭订单的消息
    店员返回终端宝首页并退出
    ZDB Login    ${SHOP_MASTER_NAME}    ${SHOP_MASTER_PWD}
    进入消息菜单查看订单类消息    订单已关闭

店员收到关闭订单的消息
    Open Application    http://127.0.0.1:4723/wd/hub    platformName=Android    platformVersion=23    deviceName=192.168.56.101:5555    automationName=appium    appActivity=ui.splash.SplashActivity
    ...    appPackage=com.ypzdw.yaoyi    unicodeKeyboard=True    resetKeyboard=True
    ZDB Login    ${SHOP_STAFF_NAME}    ${SHOP_STAFF_PWD}
    进入消息菜单查看订单类消息    订单已关闭

店员收到订单支付成功的消息
    Open Application    http://127.0.0.1:4723/wd/hub    platformName=Android    platformVersion=23    deviceName=192.168.56.101:5555    automationName=appium    appActivity=ui.splash.SplashActivity
    ...    appPackage=com.ypzdw.yaoyi    unicodeKeyboard=True    resetKeyboard=True
    ZDB Login    ${SHOP_STAFF_NAME}    ${SHOP_STAFF_PWD}
    进入消息菜单查看订单类消息    订单支付成功

店长也收到订单支付成功的消息
    店员返回终端宝首页并退出
    ZDB Login    ${SHOP_MASTER_NAME}    ${SHOP_MASTER_PWD}
    进入消息菜单查看订单类消息    订单支付成功
