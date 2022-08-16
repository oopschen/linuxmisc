#!/usr/bin/env bash


function print_help {
  echo -e "avail command list:\n\t load(ld) [number|name]: load a file\n\t list(ls): list avail configuration\n\t exit(e): exit this commandline\n\t help|h: show this help"
}


print_help

isStop=0
while [[ "0" == "$isStop" ]]; do
  echo -e "Input command: "
  read -r cmd cmdArg
  case "$cmd" in
    list|ls)
      cfgfiles=$(find ~/.tmuxp/ -type f -iname '*.yaml' | sed -re 's@^.*/([^.]+).yaml@\1@ig' | sort -d)
      i=1
      for cfg in $cfgfiles
      do
        echo -e "$i. $cfg"
        i=$(expr 1 + $i)
      done
      echo -e ""
      ;;

    load|ld)
      inFile=$cmdArg
      cfgfiles=$(find ~/.tmuxp/ -type f -iname '*.yaml' | sed -re 's@^.*/([^.]+).yaml@\1@ig')
      if [ -f ~/.tmuxp/$inFile.yaml ]; then
        tmuxp load $inFile
        break
      fi

      i=1
      for cfg in $cfgfiles
      do
        if [ "$i" -eq "$inFile" ]; then
          tmuxp load $cfg
          break
        fi
        i=$(expr 1 + $i)
      done
      echo -e ""
      ;;

    e)
      isStop=1
      ;;

    *)
      print_help
      ;;
  esac

done

