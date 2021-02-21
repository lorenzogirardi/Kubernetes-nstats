#!/bin/bash
/usr/sbin/iftop -nNb -i $(grep IFACE /code/env.sh |cut -d= -f2) -s 10 -o 10s -t -L 100 2>/dev/null |/usr/bin/awk -f /code/parse.awk |/usr/bin/python3 /code/format.py |/usr/bin/curl -i -XPOST 'http://'"$(grep INFLUX /code/env.sh |cut -d= -f2)"'/write?db=test' --data-binary @- 
