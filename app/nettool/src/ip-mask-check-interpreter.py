#!/usr/bin/env python3

ip_mask_check = __import__("ip-mask-check")

def input_value(text, exit_val, is_exit_when_valid = True, is_exit_when_valid_func=None):
  val = None
  while True:
    val = input(text).strip()
    if val == "EXIT":
      break
    elif val == "" or None == val:
      continue

    if is_exit_when_valid:
      break
    elif is_exit_when_valid_func != None:
      if not is_exit_when_valid_func(val):
        break

  return val


if __name__ == "__main__":
  exit_input = "EXIT"

  while True:
    net = input_value("net ip:", exit_input)
    netmask = input_value("netmask :", exit_input)


    def ip_check_func(input_ip):
      try:
        check_list = ip_mask_check.check_ip_mask(net, netmask, [input_ip])
      except:
        print("%s is incorrect"% input_ip)
        return True

      if input_ip in check_list:
        print("%s(%s/%s): T" % (input_ip, net, netmask))
      else:
        print("%s(%s/%s): F" % (input_ip, net, netmask))

      return True

    input_value("ip address(EXIT for new start):", exit_input, False, ip_check_func)
