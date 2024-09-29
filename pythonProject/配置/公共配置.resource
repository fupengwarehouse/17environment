*** Variables ***
${hosturl}    http://192.167.0.17:5020
#${hosturl}    http://192.167.0.17:5021
${username}    admin_iif
${password}    QWRtaW5fMTIz
${content-type}    application/json
#登录
${loginurl}    /api/sys-manage/user/login
#查询测点数据
${seriesdataurl}    /api/exrun/v2/real-time/time-series-data
#查询测点实时值
${featuresvalueurl}    /api/exrun/v2/real-time/features-value
#批量获取参数的增量值
${featuresincrementingvalueurl}    /api/exrun/v2/real-time/features-incrementing-value
#新增智能模型
${ZNMXaddurl}    /api/kbmgr/model/control-model/add
#修改智能模型
${ZNMXupdateurl}    /api/kbmgr/model/control-model/update
#删除智能模型
${ZNMXdeleteurl}    /api/kbmgr/model/model/delete
#发布智能模型
${ZNMXpublishurl}    api/kbmgr/model/control-model/publish-control
#取消发布智能模型
${ZNMXdeleteurl11111}    /api/kbmgr/model/model/delete
#模型监视列表查询
${MXJSlisturl}    /api/exrun/v2/model-surveillance/model/list
*** Keywords ***
Login token
    &{header}     Create Dictionary     content-type=${content-type}
    Create Session     nmb     http://192.167.0.17:5020    headers=&{header}
    &{data}     Create Dictionary    account=${username}    password=${password}
    ${resp}     Post Request    nmb    ${loginurl}     data=&{data}
    ${dict}    Set variable    ${resp.json()}
    ${result}    Get From Dictionary    ${dict}    result
    ${result}    Evaluate    dict(${result})
    ${accessToken}    Get From Dictionary    ${result}    accessToken
    ${refreshToken}    Get From Dictionary    ${result}    refreshToken
    #${token}    Set variable    iif_u_p={%22u%22:%22YWRtaW5faWlm%22%2C%22p%22:%22QWRtaW5fMTIz%22}; iif_accessToken=${accessToken}; iif_refreshToken=${refreshToken}
    ${token}    Set variable    Bearer ${accessToken}
    Should Be Equal As Strings     ${resp.status_code}     200
    [Return]    ${token}