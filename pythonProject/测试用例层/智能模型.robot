*** Settings ***
# 应用管理--应用列表--应用模型--智能模型
# 应用管理--模型监视
Resource    ../测试业务层/commonmethod.robot
Resource    ../测试数据层/rucan.json
Resource    ../测试业务层/sql.robot
Resource    ../配置/公共配置.resource
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary
Library    String
*** Variables ***

*** Test Cases ***

新增智能模型-post
    # 设置请求头 .
    ${token}    Login token
    ${header}     Create Dictionary    content-type=${content-type}    authorization=${token}
    # 准备请求数据
    ${json_data}=    Load Json From File        ../测试数据层/rucan.json
    ${data}=    Get From Dictionary    ${json_data}     ZNMXadd
    ${random_value}=    Generate Random String    5    [MUNBER]
    #${addname}    Set variable    FPtest${random_value}
    Set Global Variable    ${addname}    FPtest${random_value}
    ${data}    Set To Dictionary    ${data}    name    ${addname}
    # 发送post请求，并用变量接收响应结果

    ${resp}    methodpost test    ${ZNMXaddurl}     ${data}    ${header}
    # 将响应数据从字符串转换成python的字典对象

    log    ${resp.json()}

    # 断言 - 字符串相等
    ${sqlresult}    db query    select ID,`Key` from t_model where Name='${addname}'
    # 断言 - 字符串相等
    ${dict}    Set variable    ${resp.json()}
    ${code}    Get From Dictionary    ${dict}    code
    ${result}    Get From Dictionary    ${dict}    result
    ${name}    Get From Dictionary    ${result}    name
    ${id}    Get From Dictionary    ${result}    id
    ${key}    Get From Dictionary    ${result}    key
    Set Global Variable    ${addid}    ${id}
    Set Global Variable    ${addkey}    ${key}
    Should Be Equal As Integers    ${code}    0
    Should Be Equal As Strings     ${resp.status_code}     200
    Should Be Equal As Integers     ${id}     ${sqlresult[0][0]}
    Should Be Equal As Strings     ${key}     ${sqlresult[0][1]}
    Should Be Equal As Strings     ${addname}     ${name}

模型监视查询新增是否成功
    # 设置请求头 .
    Sleep    10s
    ${token}    Login token
    ${header}     Create Dictionary    content-type=${content-type}    authorization=${token}
    # 准备请求数据
    ${json_data}=    Load Json From File        ../测试数据层/rucan.json
    ${data}=    Get From Dictionary    ${json_data}     MXJSlist
    ${data}    Set To Dictionary    ${data}    search    ${addname}
    # 发送post请求，并用变量接收响应结果

    ${resp}    methodpost test    ${MXJSlisturl}     ${data}    ${header}
    # 将响应数据从字符串转换成python的字典对象

    log    ${resp.json()}

    # 断言 - 字符串相等
    ${dict}    Set variable    ${resp.json()}
    ${code}    Get From Dictionary    ${dict}    code
    ${data}    Get From Dictionary    ${dict}    data
    ${total}    Get From Dictionary    ${data}    total
    Should Be Equal As Strings     ${code}    00000
    Should Be Equal As Strings     ${resp.status_code}     200
    Should Be Equal As Integers    ${total}    1

修改智能模型-post
    # 设置请求头 .
    ${token}    Login token
    ${header}     Create Dictionary    content-type=${content-type}    authorization=${token}
    # 准备请求数据
    ${json_data}=    Load Json From File        ../测试数据层/rucan.json
    ${data}=    Get From Dictionary    ${json_data}     ZNMXupdate
    ${random_value}=    Generate Random String    5    [MUNBER]
    Set Global Variable    ${updatename}    FPupdate${random_value}
    ${data}    Set To Dictionary    ${data}    name    ${updatename}    id    ${addid}
    # 发送post请求，并用变量接收响应结果

    ${resp}    methodpost test    ${ZNMXupdateurl}     ${data}    ${header}
    # 将响应数据从字符串转换成python的字典对象

    log    ${resp.json()}

    # 断言 - 字符串相等
    ${sqlresult}    db query    select `Name` from t_model where ID=${addid}
    ${dict}    Set variable    ${resp.json()}
    ${code}    Get From Dictionary    ${dict}    code
    ${result}    Get From Dictionary    ${dict}    result
    ${name}    Get From Dictionary    ${result}    name
    Should Be Equal As Integers    ${code}    0
    Should Be Equal As Strings     ${resp.status_code}     200
    Should Be Equal As Strings     ${updatename}     ${name}
    Should Be Equal As Strings     ${updatename}     ${sqlresult[0][0]}

模型监视查询修改是否成功
    # 设置请求头 .
    Sleep    10s
    ${token}    Login token
    ${header}     Create Dictionary    content-type=${content-type}    authorization=${token}
    # 准备请求数据
    ${json_data}=    Load Json From File        ../测试数据层/rucan.json
    ${data}=    Get From Dictionary    ${json_data}     MXJSlist
    ${data}    Set To Dictionary    ${data}    search    ${updatename}
    # 发送post请求，并用变量接收响应结果

    ${resp}    methodpost test    ${MXJSlisturl}     ${data}    ${header}
    # 将响应数据从字符串转换成python的字典对象

    log    ${resp.json()}

    # 断言 - 字符串相等
    ${dict}    Set variable    ${resp.json()}
    ${code}    Get From Dictionary    ${dict}    code
    ${data}    Get From Dictionary    ${dict}    data
    ${total}    Get From Dictionary    ${data}    total
    Should Be Equal As Strings     ${code}    00000
    Should Be Equal As Strings     ${resp.status_code}     200
    Should Be Equal As Integers    ${total}    1

删除智能模型-post
    # 设置请求头 .
    ${token}    Login token
    ${header}     Create Dictionary    content-type=${content-type}    authorization=${token}
    # 准备请求数据
    ${json_data}=    Load Json From File        ../测试数据层/rucan.json
    ${data}=    Get From Dictionary    ${json_data}     ZNMXdelete
    ${list}=    Create List    ${addid}
    ${data}    Set To Dictionary    ${data}    ids    ${list}
    # 发送post请求，并用变量接收响应结果

    ${resp}    methodpost test    ${ZNMXdeleteurl}     ${data}    ${header}
    # 将响应数据从字符串转换成python的字典对象

    log    ${resp.json()}

    # 断言 - 字符串相等
    ${sqlresult}    db query    select IsDeleted from t_model where ID=${addid}
    ${dict}    Set variable    ${resp.json()}
    ${code}    Get From Dictionary    ${dict}    code
    ${result}    Get From Dictionary    ${dict}    result
    ${data}    Get From Dictionary    ${result}    data
    Should Be Equal As Integers    ${code}    0
    Should Be Equal As Strings     ${resp.status_code}     200
    Should Be Equal As Strings     ${data}     success
    Should Be Equal As Integers    ${sqlresult[0][0]}    1
模型监视查询删除是否成功
    # 设置请求头 .
    Sleep    10s
    ${token}    Login token
    ${header}     Create Dictionary    content-type=${content-type}    authorization=${token}
    # 准备请求数据
    ${json_data}=    Load Json From File        ../测试数据层/rucan.json
    ${data}=    Get From Dictionary    ${json_data}     MXJSlist
    ${data}    Set To Dictionary    ${data}    search    ${addkey}
    # 发送post请求，并用变量接收响应结果

    ${resp}    methodpost test    ${MXJSlisturl}     ${data}    ${header}
    # 将响应数据从字符串转换成python的字典对象

    log    ${resp.json()}

    # 断言 - 字符串相等
    ${dict}    Set variable    ${resp.json()}
    ${code}    Get From Dictionary    ${dict}    code
    ${data}    Get From Dictionary    ${dict}    data
    ${total}    Get From Dictionary    ${data}    total
    Should Be Equal As Strings     ${code}    00000
    Should Be Equal As Strings     ${resp.status_code}     200
    Should Be Equal As Integers    ${total}    0

发布智能模型-post
    # 设置请求头 .
    ${token}    Login token
    ${header}     Create Dictionary    content-type=${content-type}    authorization=${token}
    # 准备请求数据
    ${json_data}=    Load Json From File        ../测试数据层/rucan.json
    ${data}=    Get From Dictionary    ${json_data}     ZNMXpublish
    # 发送post请求，并用变量接收响应结果

    ${resp}    methodpost test    ${ZNMXpublishurl}     ${data}    ${header}
    # 将响应数据从字符串转换成python的字典对象

    log    ${resp.json()}

    # 断言 - 字符串相等
    ${sqlresult}    db query    select IsPublish from t_model where ID=10594
    ${dict}    Set variable    ${resp.json()}
    ${code}    Get From Dictionary    ${dict}    code
    ${result}    Get From Dictionary    ${dict}    result
    ${data}    Get From Dictionary    ${result}    data
    Should Be Equal As Integers    ${code}    0
    Should Be Equal As Strings     ${resp.status_code}     200
    Should Be Equal As Strings     ${data}     success
    Should Be Equal As Integers    ${sqlresult[0][0]}    1
模型监视查询发布模型是否成功
    # 设置请求头 .
    Sleep    10s
    ${token}    Login token
    ${header}     Create Dictionary    content-type=${content-type}    authorization=${token}
    # 准备请求数据
    ${json_data}=    Load Json From File        ../测试数据层/rucan.json
    ${data}=    Get From Dictionary    ${json_data}     MXJSlist
    ${data}    Set To Dictionary    ${data}    search    YYMX004262
    # 发送post请求，并用变量接收响应结果

    ${resp}    methodpost test    ${MXJSlisturl}     ${data}    ${header}
    # 将响应数据从字符串转换成python的字典对象

    log    ${resp.json()}

    # 断言 - 字符串相等
    ${dict}    Set variable    ${resp.json()}
    ${code}    Get From Dictionary    ${dict}    code
    ${data}    Get From Dictionary    ${dict}    data
    ${items}    Get From Dictionary    ${data}    items
    ${items}    Get From List    ${items}    0
    ${modelStatus}    Get From Dictionary    ${items}    modelStatus
    Should Be Equal As Strings     ${code}    00000
    Should Be Equal As Strings     ${resp.status_code}     200
    Should Be Equal As Integers    ${modelStatus}    1
取消发布智能模型-post
    # 设置请求头 .
    ${token}    Login token
    ${header}     Create Dictionary    content-type=${content-type}    authorization=${token}
    # 准备请求数据
    ${json_data}=    Load Json From File        ../测试数据层/rucan.json
    ${data}=    Get From Dictionary    ${json_data}     ZNMXpublish
    ${data}    Set To Dictionary    ${data}    isPublish    false
    # 发送post请求，并用变量接收响应结果

    ${resp}    methodpost test    ${ZNMXpublishurl}     ${data}    ${header}
    # 将响应数据从字符串转换成python的字典对象

    log    ${resp.json()}

    # 断言 - 字符串相等
    ${sqlresult}    db query    select IsPublish from t_model where ID=10594
    ${dict}    Set variable    ${resp.json()}
    ${code}    Get From Dictionary    ${dict}    code
    ${result}    Get From Dictionary    ${dict}    result
    ${data}    Get From Dictionary    ${result}    data
    Should Be Equal As Integers    ${code}    0
    Should Be Equal As Strings     ${resp.status_code}     200
    Should Be Equal As Strings     ${data}     success
    Should Be Equal As Integers    ${sqlresult[0][0]}    0
模型监视查询取消发布模型是否成功
    # 设置请求头 .
    Sleep    10s
    ${token}    Login token
    ${header}     Create Dictionary    content-type=${content-type}    authorization=${token}
    # 准备请求数据
    ${json_data}=    Load Json From File        ../测试数据层/rucan.json
    ${data}=    Get From Dictionary    ${json_data}     MXJSlist
    ${data}    Set To Dictionary    ${data}    search    YYMX004262
    # 发送post请求，并用变量接收响应结果

    ${resp}    methodpost test    ${MXJSlisturl}     ${data}    ${header}
    # 将响应数据从字符串转换成python的字典对象

    log    ${resp.json()}

    # 断言 - 字符串相等
    ${dict}    Set variable    ${resp.json()}
    ${code}    Get From Dictionary    ${dict}    code
    ${data}    Get From Dictionary    ${dict}    data
    ${items}    Get From Dictionary    ${data}    items
    ${items}    Get From List    ${items}    0
    ${modelStatus}    Get From Dictionary    ${items}    modelStatus
    Should Be Equal As Strings     ${code}    00000
    Should Be Equal As Strings     ${resp.status_code}     200
    Should Be Equal As Integers    ${modelStatus}    0