#!/usr/bin/env expect

set hostname [lindex $argv 0]
spawn telnet $hostname
expect "/ #"
send "reboot \n"
expect eof
