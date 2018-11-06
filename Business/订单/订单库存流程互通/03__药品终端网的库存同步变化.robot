*** Settings ***
Suite Teardown    Close Browsers
Resource          ${RESOURCE_PATH}${/}single_service${/}通行证${/}login_web.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}订单${/}order_web.robot
Resource          ${RESOURCE_PATH}${/}combine_service${/}交易域${/}订单${/}order_web.robot
Resource          ${RESOURCE_PATH}${/}combine_service${/}交易域${/}物流${/}logistics_web.robot
Resource          ${RESOURCE_PATH}${/}single_service${/}交易域${/}商品${/}inventory_web.robot
Resource          ${RESOURCE_PATH}${/}combine_service${/}交易域${/}商品${/}inventory_web.robot
Resource          ../../../Resources/web_resources/library.robot

*** Test Cases ***
药品终端网的库存同步变化
    Check The Inventory Blocked    #验证下单后库存的冻结
    供应商出库
    Check The Blocked Inventory Released
    [Teardown]

*** Keywords ***
供应商出库
    Saler Confirm Order
    全部出库
    Registration Logistics Information

全部出库
    Click Element    //a[@class="oper"]    #点击出库按钮
    Wait Until Element Is Visible    jquery=input.checkGoodsBatch    ${WAIT_TIMEOUT}    #等待批次号输入框加载出来
    Input Text    jquery=input.checkGoodsBatch    001    #输入批次号
    Click Button    jquery=button.btn-md    #点击确认提交按钮
    Wait Until Element Is Visible    //h2[@class="margin-b20"]    #等待物流登记界面加载出来
