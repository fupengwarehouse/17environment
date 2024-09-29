import xml.dom.minidom
import xml.etree.ElementTree

# 打开xml文档
dom = xml.dom.minidom.parse('C:\\Users\\fupeng\\Desktop\\pythoncase\\pythonProject\\测试用例层\\results\\output.xml')
root2 = xml.etree.ElementTree.parse('C:\\Users\\fupeng\\Desktop\\pythoncase\\pythonProject\\测试用例层\\results\\output.xml')
tree3=root2.getroot()
# 获取suite下的子节点
def getcase():
    casedict = {}
    testlist2 = []
    for elem in tree3.iterfind('suite/suite'):
        a = elem.attrib
        suitedict = {}
        testlist2.append(suitedict) #每一个用例集合存入列表
        testlist = []
        suitename = a['name']#获取用例结合的名字
        for test in elem.iter(tag='test'):
            b=test.attrib
            for data in test.iterfind('status'):
                 casename = b['name'] #获取用例的名字
                 c=data.attrib
                 status=c['status'] #获取每条用例的执行结果
                 casedict['casename'] = casename #用例名字存入字典
                 casedict['status'] = status #用例执行结果存入字典
            testlist.append(casedict) #每一条用例的名字和执行结果作为字典存入列表
            casedict = {}
            suitedict['suitename']=suitename
            suitedict['test']=testlist
    return testlist2   #最终返回的就是[{'suitename': 'xxx', 'test': [{'casename': '01 xxx', 'status': 'PASS'},
                                      #{'casename': '02 xxx', 'status': 'PASS'}
