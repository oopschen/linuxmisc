#!/usr/bin/env python
import os.path
import requests

class BaseHostwindsAPI:
  def __init__(self, keyFile="./hostwinds.api.key"):
    if not os.path.exists(keyFile):
      raise Exception("keyfile not found: " + keyFile)

    with open(keyFile, 'r') as f:
      self.__key = f.read().replace('\r', '').replace('\n', '')

  def request(self, action, **kwargs):
    data = {"action": action, "API": self.__key}
    for key in kwargs:
      data[key] = kwargs[key]

    res = requests.post('https://clients.hostwinds.com/cloud/api.php', data=data)
    res.raise_for_status()
    return res.json()

if __name__ == '__main__':
  bapi = BaseHostwindsAPI("/tmp/key")
  res = bapi.request('get_instances')
  print(res)
