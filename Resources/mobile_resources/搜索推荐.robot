*** Settings ***
Resource          library.robot

*** Keywords ***
获取搜索页面单价
    ${priceStr}    Get Element Attribute    //android.view.View[@content-desc="供应商：${COMPANY_NAME}"]/following::android.view.View[5]    name
    @{priceNum}    Get Regexp Matches    ${priceStr}    ￥(.*)    1
    ${PRICE}    Convert To Number    @{priceNum}[0]
    Set Global Variable    ${PRICE}

终端宝获取商品库存
    ${ZDBinventory}    Get Element Attribute    //android.view.View[contains(@content-desc,'库存') and @clickable='true']    name
    @{ZDBinventory}    Get Regexp Matches    ${ZDBinventory}    ：(.*)    1
    ${ZDB_INVENTORY}    Convert To String    @{ZDBinventory}[0]
    Set Global Variable    ${ZDB_INVENTORY}
