###连接tdengine数据库
import taos
from robot.api.deco import keyword


class TDengineLibrary(object):

    def __init__(self):
        self.host = '192.167.0.17'
        self.username = 'root'
        self.password = 'tfiif@2024v1'
        self.port = 22
        self.conn = None

    @keyword('Connect to TDengine')
    def connect_to_tdengine(self):
        self.conn = taos.connect(host=self.host, username=self.username, password=self.password, port=self.port)
        if self.conn:
            print("Connected to TDengine")

    @keyword('Execute Query')
    def execute_query(self, query):
        if self.conn:
            cursor = self.conn.cursor()
            cursor.execute(query)
            return cursor.fetchall()
        else:
            print("Not connected to TDengine")

    @keyword('Close Connection')
    def close_connection(self):
        if self.conn:
            self.conn.close()
            print("Connection to TDengine closed")
