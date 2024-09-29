*** Settings ***

Resource    ../测试业务层/commonmethod.robot
Resource    ../测试业务层/sql.robot
Resource    ../测试数据层/rucan.json
Resource    ../配置/公共配置.resource
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary
Library    String
*** Test Cases ***
新增智能模型-post111
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

模型监视查询新增是否成功1111
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

Test Case Connect to TDengine1111
    Connect to TDengine
    ${result}    Execute Query    SHOW DATABASES
    Log    ${result}
    Close Connection

注册接口-post

    # 设置请求头 .

    &{header}=     Create Dictionary     Content-Type=application/x-www-form-urlencoded

    # 会话别名为 nmb 接口所在服务器域名地址为：test.lemonban.com

    Create Session     nmb     http://test.lemonban.com     headers=${header}

    # 准备请求数据

    &{data}=     Create Dictionary     username=18688710213     passwd=fe7ead29e825e0463d9d8fca37ee42f5

    # 发送post请求，并用变量接收响应结果

    ${resp}     Post Request     nmb     ningmengban/mvc/user/register.json

    # ${resp} = <Response [200]> 是一个python requests库当中的Response对象。我们需要从这个对象当中，拿到响应的具体数据。

    # 从python对象当中拿数据的方法:${python中Request的表达式}

    # 获取http请求的状态码

    Log ${resp.status_code}

    # 获取本次的响应数据

    Log ${resp.text}

    # 将响应数据从字符串转换成python的字典对象

    Log ${resp.json()}

    # 断言 - 字符串相等

    Should Be Equal As Strings     ${resp.text}     {"success":true,"message":"注册成功","content":null,"object":null}

    # 断言 - 从字典当中取出message的值，与 注册成功 是否相等。

    Should Be Equal As Strings     注册成功     ${resp.json()["message"]}
    
    
    
    
    
    
*** Settings ***

#Resource   ../测试业务层/commonmethod.robot
Library    ../测试业务层/run_method.py
Library    RequestsLibrary
Library    Collections
Resource    ../配置/公共配置.resource
*** Test Cases ***

登录-post111
    # 设置请求头 .

    &{header}     Create Dictionary     content-type=${content-type}
    # 设置请求url

    Create Session     nmb     ${hosturl}    headers=&{header}

    # 准备请求数据

    &{data}     Create Dictionary    account=${username}    password=${password}
    
    # 发送post请求，并用变量接收响应结果

    ${resp}     Post Request    nmb    /api/sys-manage/user/login     data=&{data}    header=&{header}
    # ${resp} = <Response [200]> 是一个python requests库当中的Response对象。我们需要从这个对象当中，拿到响应的具体数据。

    # 从python对象当中拿数据的方法:${python中Request的表达式}

    # 获取http请求的状态码

    #Log ${resp.code}

    # 获取本次的响应数据

   # Log ${resp.text}

    # 将响应数据从字符串转换成python的字典对象

    log    ${resp.json()}

    # 断言 - 字符串相等
    ${dict}    Set variable    ${resp.json()}
    ${code}    Get From Dictionary    ${dict}    code
    ${msg}    Get From Dictionary    ${dict}    message
    ${code}    Evaluate    0
    Should Be Equal    ${msg}    success

    Should Be Equal As Strings     ${resp.status_code}     200