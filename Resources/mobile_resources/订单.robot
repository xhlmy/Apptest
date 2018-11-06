*** Settings ***
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}采购${/}购物车${/}cart_app.robot
Resource          library.robot

*** Keywords ***
获取订单编号
    Go Back
    Wait Until Page Contains    购物车    ${WAIT_TIMEOUT}
    Go Back
    Wait Until Page Contains    搜索    ${WAIT_TIMEOUT}
    Go Back
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/tab_my    ${WAIT_TIMEOUT}
    进入订单中心
    ${ORDERCODE}    Get Element Attribute    //android.widget.ListView/android.view.View[1]/android.view.View[4]    name
    Set Global Variable    ${ORDERCODE}

进入订单中心
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/tab_my
    Click Element    id=com.ypzdw.yaoyi:id/tab_my
    Wait Until Page Contains Element    id=com.ypzdw.yaoyi:id/layout_work    ${WAIT_TIMEOUT}
    Click Element    id=com.ypzdw.yaoyi:id/tv_all_orders
    Wait Until Page Contains Element    //android.widget.ListView/android.view.View[@index="0"]    ${WAIT_TIMEOUT}
