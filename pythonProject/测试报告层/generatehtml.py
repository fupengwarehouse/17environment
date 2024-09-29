from jinja2 import Environment, FileSystemLoader
import parsexml


def generate_html(data):
    env = Environment(loader=FileSystemLoader('./'))   # 加载模板
    template = env.get_template('report.html')
    # template.stream(body).dump('result.html', 'utf-8')
    data=parsexml.get_total_statistics()#获取解析的xml的用例统计数据
    data2=parsexml.getcase()#获取测试用例信息和执行结果
    with open("result.html", 'w',encoding='utf-8') as fout:
        html_content = template.render(data=data,data2=data2)
        fout.write(html_content)    #  写入模板 生成html
