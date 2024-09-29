*** Settings ***

Resource    ../测试业务层/commonmethod.robot
Resource    ../测试数据层/rucan.json
Resource    ../配置/公共配置.resource
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary
*** Test Cases ***

查询测点数据-post
    # 设置请求头 .
    ${token}    Login token
    ${header}     Create Dictionary    content-type=${content-type}    authorization=${token}
    # 准备请求数据
    ${json_data}=    Load Json From File        ../测试数据层/rucan.json
    ${data}=    Get From Dictionary    ${json_data}     seriesdata
    # 发送post请求，并用变量接收响应结果

    ${resp}    methodpost test    ${seriesdataurl}     ${data}    ${header}
    # 将响应数据从字符串转换成python的字典对象

    log    ${resp.json()}

    # 断言 - 字符串相等
    ${dict}    Set variable    ${resp.json()}
    ${code}    Get From Dictionary    ${dict}    code
    Should Be Equal As Strings     ${code}     00000
    Should Be Equal As Strings     ${resp.status_code}     200

查询测点数据-post-查询结果为空
    # 设置请求头 .
    ${token}    Login token
    ${header}     Create Dictionary    content-type=${content-type}    authorization=${token}
    # 准备请求数据
    ${json_data}=    Load Json From File        ../测试数据层/rucan.json
    ${data}=    Get From Dictionary    ${json_data}     seriesdata
    ${number}    Set Variable    1764518400
    ${data}    Set To Dictionary    ${data}    startAt    ${number}    endAt    ${number}
    # 发送post请求，并用变量接收响应结果

    ${resp}    methodpost test    ${seriesdataurl}     ${data}    ${header}
    # 将响应数据从字符串转换成python的字典对象

    log    ${resp.json()}

    # 断言 - 字符串相等
    ${dict}    Set variable    ${resp.json()}
    ${code}    Get From Dictionary    ${dict}    code
    ${data}    Get From Dictionary    ${dict}    data
    ${lines}    Get From Dictionary    ${data}    lines
    Should Be Equal As Strings     ${code}     00000
    Should Be Equal As Strings     ${lines}     []
    Should Be Equal As Strings     ${resp.status_code}     200