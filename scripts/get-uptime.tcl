#!/usr/bin/env expect
set hostname [lindex $argv 0]
log_file -noappend workdir/$hostname.uptime.txt
spawn -noecho telnet $hostname
expect "/ #"
send "cat /proc/uptime | awk '{print \$1}'\r"
send_user "$expect_out(buffer)"
expect "/ #"
send "exit\r"
expect eof
