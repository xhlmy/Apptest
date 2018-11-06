*** Settings ***
Resource          ${RESOURCE_PATH}${/}single_service${/}通行证${/}login_web.robot
Resource          ../../../Resources/web_resources/login.robot

*** Variables ***

*** Test Cases ***
Manager Creates A Platform Coupon Theme
    [Tags]    coupon
    Manager Publishes Coupon
    Manager Creates Mobile Theme
    Manager Join Coupon In Mobile Theme
    ZDB Manager Create Coupon Theme
    [Teardown]    Close Browsers

*** Keywords ***
Manager Publishes Coupon
    Manager Logined Successfully
    Manger Publishes A Platform Coupon With App Display And Use
    [Teardown]

Manager Creates Mobile Theme
    Go To    ${MANAGER_URL}/operate/topic/index
    Wait Until Page Contains Element    id=createLink    ${WAIT_TIMEOUT}
    Click Element    id=createLink
    Wait Until Page Contains Element    id=l_submit
    ${title_name}    Generate Random String    8
    Input Text    id=y_title    ${title_name}
    ${currentTime}    Get Current Date    result_format=%Y-%m-%d %H:%M
    ${start_time}    Add Time To Date    ${currentTime}    1 hour    result_format=%Y-%m-%d %H:%M
    ${end_time}    Add Time To Date    ${currentTime}    2 hours    result_format=%Y-%m-%d %H:%M
    Execute Javascript    document.getElementById('ActivityStartTime').setAttribute('value','${start_time}')
    Execute Javascript    document.getElementById('ActivityEndTime').setAttribute('value','${end_time}')
    Click Element    id=J_showUpLoad
    Wait Until Page Contains Element    id=btn-file
    Click Element    id=btn-file
    Win Wait    文件上传
    Control Set Text    文件上传    ${EMPTY}    Edit1    ${EXECDIR}\\resources\\img\\test1.png
    Control Click    文件上传    ${EMPTY}    Button1
    Click Element    id=J-upPic-submit
    Wait Until Element Is Not Visible    id=J-upPic-submit
    Input Text    id=y_headNameSpecial    李论测试专题头部名
    Click Element    //input[@value="${SHOP_MASTER_AREACODE}"]
    Click Element    id=l_submit
    Wait Until Page Contains Element    //td[contains(text(),'${title_name}')]
    ${THEME_ID}    Get Text    //td[contains(text(),'${title_name}')]//preceding::td[1]
    Set Global Variable    ${THEME_ID}
    [Teardown]

Manager Join Coupon In Mobile Theme
    Click Element    //td[contains(text(),'${THEME_ID}')]/following::td[5]/a[contains(text(),'优惠券')]
    Wait Until Page Contains Element    id=y_saveCoupon
    Comment    Input Text    id=y_searchIpt    ${COUPON_ID}
    Comment    Click Element    id=y_searchBtn
    Comment    Wait Until Page Contains Element    //span[@class='glyphicon glyphicon-plus cur_p y_addFromSearch']    ${WAIT_TIMEOUT}    将优惠券加入主题时未找到指定优惠券
    Wait Until Keyword Succeeds    30s    2s    搜索加入优惠券
    Click Element    //span[@class='glyphicon glyphicon-plus cur_p y_addFromSearch']
    Wait Until Page Contains Element    //span[@class='glyphicon glyphicon-remove cur_p y_delSelected']
    Click Element    id=y_saveCoupon
    [Teardown]

ZDB Manager Create Coupon Theme
    ZDB Manager Login
    Over All AD
    Create Coupon Theme
    [Teardown]

Manger Publishes A Platform Coupon With App Display And Use
    Go To    ${M_URL}/Operate/Coupon/Index
    Wait Until Element Is Visible    id=createLink
    Click Element    id=createLink
    Wait Until Page Contains Element    id=l_submit    ${WAIT_TIMEOUT}
    ${title}    Generate Random String    6
    Input Text    id=Title    ${title}
    ${COUPON_MONEY}    Evaluate    random.randint(1,20)    random,sys
    Set Global Variable    ${COUPON_MONEY}
    Input Text    id=Price    ${COUPON_MONEY}
    Input Text    id=LimitPrice    ${COUPON_MONEY}
    ${activityStartTime}    Get Current Date    result_format=%Y-%m-%d
    ${activityEndTime}    Get Current Date    result_format=%Y-%m-%d %H:%M
    ${beginDemandTime}    Add Time To Date    ${activityEndTime}    2 minutes    result_format=%Y-%m-%d %H:%M
    ${endDemandTime}    Add Time To Date    ${activityEndTime}    1 hours    result_format=%Y-%m-%d %H:%M
    Execute Javascript    document.getElementById('ActivityStartTime').setAttribute('value','${activityStartTime}')
    Execute Javascript    document.getElementById('ActivityEndTime').setAttribute('value','${activityStartTime}')
    Execute Javascript    document.getElementById('BeginDemandTime').setAttribute('value','${activityEndTime}')
    Execute Javascript    document.getElementById('EndDemandTime').setAttribute('value','${endDemandTime}')
    Input Text    id=CardNum    1
    Click Element    //label[contains(text(),'显示平台')]/following::div[1]//label[1]
    Click Element    //label[contains(text(),'使用平台')]/following::div[1]//label[1]
    Click Element    id=l_submit
    Wait Until Page Contains    ${title}
    ${COUPON_ID}    Get Text    //p[contains(text(),'${title}')]/parent::div/parent::td/parent::tr/td[1]
    Set Global Variable    ${COUPON_ID}

Over All AD
    Go To    ${ZDB_BACKGROUND_URL}/admin/adInfo/list
    Wait Until Element Is Visible    //select[@name="status"]
    : FOR    ${n}    IN RANGE    20
    \    ${status}    Run Keyword And Return Status    Search Normal AD
    \    Run Keyword If    '${status}'=='True'    Delete AD
    \    ...    ELSE    Exit For Loop

Search Normal AD
    Select From List By Value    //select[@name="status"]    NORMAL
    Click Element    //button[@type="submit"]
    Wait Until Element Contains    //tr[1]/td[12]/a    下线

Delete AD
    Click Element    //tr[1]/td[12]/a
    Get Alert Message
    Choose Ok On Next Confirmation

Create Coupon Theme
    Go To    ${ZDB_BACKGROUND_URL}/admin/adInfo/new
    Wait Until Page Contains Element    id=location
    Select From List By Index    id=location    1
    Click Element    //input[@value="${SHOP_MASTER_AREACODE}"]
    Select From List By Index    id=linkType    4
    Wait Until Element Is Visible    id=oid
    Input Text    id=oid    ${THEME_ID}
    Choose File    id=fileupload    ${EXECDIR}\\resources\\img\\优惠券.jpg
    Input Text    id=title    李论测试标题
    Clear Element Text    id=adIndex
    Input Text    id=adIndex    68
    Click Element    //button
    Wait Until Page Contains    下线
    ${AD_ID}    Get Text    //tbody/tr[1]/td[1]
    Set Global Variable    ${AD_ID}

搜索加入优惠券
    Input Text    id=y_searchIpt    ${COUPON_ID}
    Click Element    id=y_searchBtn
    Wait Until Page Contains Element    //span[@class='glyphicon glyphicon-plus cur_p y_addFromSearch']    ${WAIT_TIMEOUT}    将优惠券加入主题时未找到指定优惠券
