*** Settings ***

Resource    ../测试业务层/commonmethod.robot
Resource    ../测试数据层/rucan.json
Resource    ../配置/公共配置.resource
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary
*** Variables ***
*** Test Cases ***

查询测点实时值-post
    # 设置请求头 .
    ${token}    Login token
    ${header}     Create Dictionary    content-type=${content-type}    authorization=${token}
    # 准备请求数据
    ${json_data}=    Load Json From File        ../测试数据层/rucan.json
    ${data}=    Get From Dictionary    ${json_data}     featuresvalue
    # 发送post请求，并用变量接收响应结果

    ${resp}    methodpost test    ${featuresvalueurl}     ${data}    ${header}    
    # 将响应数据从字符串转换成python的字典对象

    log    ${resp.json()}

    # 断言 - 字符串相等
    ${dict}    Set variable    ${resp.json()}
    ${code}    Get From Dictionary    ${dict}    code
    ${data}    Get From Dictionary    ${dict}    data
    ${componentId}    Get From Dictionary    ${data}    componentId
    Should Be Equal As Strings     ${code}     00000
    Should Be Equal As Strings     ${resp.status_code}     200
    Should Be Equal As Integers    ${componentId}    0

查询测点实时值-post-查询结果为空
    # 设置请求头 .
    ${token}    Login token
    ${header}     Create Dictionary    content-type=${content-type}    authorization=${token}
    # 准备请求数据
    ${json_data}=    Load Json From File        ../测试数据层/rucan.json
    ${data}=    Get From Dictionary    ${json_data}     featuresvalue
    ${nulllist}=    Create List
    ${data}    Set To Dictionary    ${data}    featureKeyList    ${nulllist}
    # 发送post请求，并用变量接收响应结果

    ${resp}    methodpost test    ${featuresvalueurl}     ${data}    ${header}
    # 将响应数据从字符串转换成python的字典对象

    log    ${resp.json()}

    # 断言 - 字符串相等
    ${dict}    Set variable    ${resp.json()}
    ${code}    Get From Dictionary    ${dict}    code
    ${data}    Get From Dictionary    ${dict}    data
    ${items}    Get From Dictionary    ${data}    items
    Should Be Equal As Strings     ${code}     00000
    Should Be Equal As Strings     ${resp.status_code}     200
    Should Be Equal As Strings     ${items}     []