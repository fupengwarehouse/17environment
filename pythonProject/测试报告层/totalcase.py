import xml.dom.minidom
import xml.etree.ElementTree

# 打开xml文档
dom = xml.dom.minidom.parse('C:\\Users\\fupeng\\Desktop\\pythoncase\\pythonProject\\测试用例层\\results\\output.xml')
root2 = xml.etree.ElementTree.parse('C:\\Users\\fupeng\\Desktop\\pythoncase\\pythonProject\\测试用例层\\results\\output.xml')

# 得到文档元素对象
root = dom.documentElement
total = root.getElementsByTagName('total');
total_len = len(total)
# total的stat节点个数
total2 = root2.getiterator("total")
total_stat_num = len(total2[total_len-1].getchildren())
statlist = root.getElementsByTagName('stat');

def get_total_statistics():
    list = []
    for i in range(0,total_stat_num):
        d = dict()
        d['fail'] = int(statlist[i].getAttribute("fail"))#失败用例数
        d['pass'] = int(statlist[i].getAttribute("pass"))#成功用例数
        d['total'] = d['fail']+d['pass']#用例总数
        d['percent'] = ('{:.2%}'.format(d['pass'] / d['total']))#用例百分比
        list.append(d)
    return list
