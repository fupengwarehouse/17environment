*** Settings ***

Library    RequestsLibrary
Resource    ../配置/数据库.resource
Library    Collections
Library    DatabaseLibrary
Library    pymysql
*** Keywords ***

db query
    [Arguments]    ${dbquery}
    # 连接数据库 .
 #   Connect To Database Using Custom Params    pymysql    database=${dbname},user=${dbusername},password=${dbpassword},host=${dbhost},port=${dbport}
    Connect To Database Using Custom Params    pymysql    database='${dbname}',user='${dbusername}',password='${dbpassword}',host='${dbhost}',port=${dbport}
    # 发送sql请求

    ${result}    query    ${dbquery}
   # ${length}=  Get Length  ${query_result}
    Disconnect From Database
    [Return]    ${result}