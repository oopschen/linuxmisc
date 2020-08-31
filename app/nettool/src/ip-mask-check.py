#!/usr/bin/env python3


"""
Usage:
  [script] ip-file

### ip-file 格式

####CSV 格式
net,net-mask,ip,ip,...
net,net-mask,ip,ip,...

"""

import ipaddress

def check_ip_mask(net, net_mask, ip_list):
  if None == net or None == net_mask or None == ip_list:
    return None

  network = ipaddress.ip_network((net, net_mask), False)

  return [ip for ip in ip_list if ipaddress.ip_address(ip) in network]


if __name__ == "__main__":
  import csv
  import sys

  if len(sys.argv) < 2:
    print("need a input file")
    sys.exit(1)

  with open(sys.argv[1], 'r') as input_file:
    reader = csv.reader(input_file)
    for row in reader:
      if len(row) < 3:
        continue

      net = row[0].strip()
      netmask = row[1].strip()
      ip_list = [x.strip() for x in row[2:] if x.strip() != '']

      try:
        filter_list = check_ip_mask(net, netmask, ip_list)
      except:
        print([*row, "ERROR"])
        continue


      check_list = [net, netmask]
      for ip in ip_list:
        if ip in filter_list:
          check_list.append("T")
        else:
          check_list.append("F")

      print(", ".join(check_list))


