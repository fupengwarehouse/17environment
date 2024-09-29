*** Settings ***

Library    RequestsLibrary
Resource    ../配置/公共配置.resource
Library    Collections
*** Keywords ***

methodpost test
    [Arguments]    ${url}   ${data}    ${header}
    # 设置请求头 .

   # &{header}     Create Dictionary     content-type=${content-type}
    # 设置请求url

    Create Session     nmb     ${hosturl}    headers=${header}
    #${resp}=    Set Variable    None

    # 准备请求数据

  #  &{data}     Create Dictionary    account=${username}    password=${passwork}
    ${resp1}=    Post Request    nmb    ${url}     data=${data}
    # 发送post请求，并用变量接收响应结果
  #  Run Keyword If    '${method}'=='post'    ${resp1}=    Post Request    nmb    ${url}     data=${data}
  #  ELSE IF    '${method}'=='get'    ${resp1}=    Get Request    nmb    ${url}
  #  ELSE    ${resp1}    Set variable    None
   # END
    #else:
    #      [Return]    "what ??????"
    [Return]    ${resp1}
methodget test
    [Arguments]    ${url}    ${header}
    # 设置请求头 .
    Create Session     nmb     ${hosturl}    headers=${header}
    #${resp}=    Set Variable    None

    # 准备请求数据
    ${resp1}=    Get Request    nmb    ${url}
    [Return]    ${resp1}
