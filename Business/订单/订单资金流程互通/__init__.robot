*** Settings ***
Documentation     订单资金流程互通主要是验证在终端宝下单后终端宝用户所在的组织账户余额在终端宝和药品终端网同步变化，同时在药品终端网新增账务明细，以下case涉及到app和web端，因此采用suite的方式将web与app分开
Force Tags        money    core
