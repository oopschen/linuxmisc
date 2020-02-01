#!/usr/bin/env python

import argparse
from hostwinds.alert import BandWidthAlert

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--key-file", help="hostwinds key file location", default="/tmp/hostwinds.key")
    parser.add_argument("--alert-thresholds", help="hostwinds bandwidth alert thresholds", default=0.9)
    args = parser.parse_args()

    hw = BandWidthAlert(args.key_file, args.alert_thresholds)

    for alertInfo in hw.alert():
      if type(alertInfo[1]) == str:
        print("{}({})".format(alertInfo[0], alertInfo[1]))
      else:
        print("{}({:2f}%%)".format(alertInfo[0], alertInfo[1] * 100))


if __name__ == '__main__':
    main()
