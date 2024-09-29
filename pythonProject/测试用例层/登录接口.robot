*** Settings ***

Resource    ../测试业务层/commonmethod.robot
Resource    ../测试数据层/rucan.json
Resource    ../配置/公共配置.resource
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary
*** Test Cases ***

登录-post
    # 设置请求头 .

    ${header}     Create Dictionary     content-type=${content-type}
    # 设置请求url

  #  Create Session     nmb     ${hosturl}    headers=&{header}

    # 准备请求数据

    #${data}     Create Dictionary    account=${username}    password=${password}
   # ${data}    Get Value From Json    rucan    login
    #${data}    Evaluate    dict(${data})
    ${json_data}=    Load Json From File        ../测试数据层/rucan.json
    ${data}=    Get From Dictionary    ${json_data}     login
    ${data}    Set To Dictionary    ${data}    account=${username}    password=${password}
    # 发送post请求，并用变量接收响应结果

    ${resp}    methodpost test    ${loginurl}     ${data}    ${header}
   # ${resp}     run_main    http://192.167.0.17:5020/api/sys-manage/user/login    post     &{data}    &{header}
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
    Should Be Equal    ${msg}    success
    Should Be Equal As Integers    ${code}    0
    Should Be Equal As Strings     ${resp.status_code}     200

登录-post-账号密码错误
    # 设置请求头 .

    ${header}     Create Dictionary     content-type=${content-type}

    # 准备请求数据

    ${json_data}=    Load Json From File        ../测试数据层/rucan.json
    ${data}=    Get From Dictionary    ${json_data}     login
    ${data}    Set To Dictionary    ${data}    account=34221   password=8754
    # 发送post请求，并用变量接收响应结果

    ${resp}    methodpost test    ${loginurl}     ${data}    ${header}

    log    ${resp.json()}

    # 断言 - 字符串相等
    ${dict}    Set variable    ${resp.json()}
    ${code}    Get From Dictionary    ${dict}    code
    ${msg}    Get From Dictionary    ${dict}    message
    Should Be Equal As Integers    ${code}    1001
    Should Be Equal    ${msg}    该账号不存在