# !/usr/bin/python
# -*- coding: utf-8 -*-
import smtplib, time, os
from email.mime.text import MIMEText
from email.header import Header
import generate

def send_mail_html(file):
    sender = 'ccc@fulu.com' #发件人
    mail_to =['aa@fulu.com','bb@fulu.com] #收件人
    t = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())  #获取当前时间
    subject = '战娃利润中心指标自动化测试报告' + t  #邮件主题
    smtpserver = 'smtp.qiye.aliyun.com' #发送服务器地址
    username = 'cc@fulu.com' #用户名
    password = '123456' #密码
    f = open(file, 'rb')
    mail_body = f.read()
    f.close()


    msg = MIMEText(mail_body, _subtype='html', _charset='utf-8')
    msg['Subject'] = Header(subject, 'utf-8')
    msg['From'] = sender
    msg['To'] = ";".join(mail_to)

    try:
        smtp = smtplib.SMTP()
        smtp.connect(smtpserver)
        smtp.login(username, password)
        smtp.sendmail(sender, mail_to, msg.as_string())
    except:
        print("邮件发送失败！")
    else:
        print("邮件发送成功！")
    finally:
        smtp.quit()

def result():
    file = 'result.html' #渲染后的html报告文件
    result = {}
    generate.generate_html(result)
   # send_mail_html(file)

result()
