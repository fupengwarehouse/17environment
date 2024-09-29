import requests

class run_method(object):

    def get_main(self,url,data=None,header=None):
        res=None
        if header is not None:
            res=requests.get(url=url,data=data,headers=header).json()
        else:
            res = requests.get(url=url, data=data).json()
        return res

    def post_main(self,url,data,header=None):
        res=None
        if header is not None:
            res=requests.post(url=url,data=data,headers=header).json()
        else:
            res = requests.post(url=url, data=data).json()
        return res

    def run_main(self,url,method,data=None,header=None):
        res=None
        if method.lower()=='post':
            res=self.post_main(url,data,header)
        elif method.lower() == 'get':
            res = self.get_main(url, data, header)
        else:
            return "what ??????"
        return res