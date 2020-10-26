#!/usr/bin/env expect
set hostname [lindex $argv 0]
log_file -noappend workdir/$hostname.connection.txt
spawn telnet $hostname
expect "/ #"
send "date '+%Y-%m-%d %H:%M:%S' \n"
expect "/ #"
set timeout 5
send "curl -sL -m 5 google.com | grep -o \"<title>.*</title>\" \n"
expect "<title>Google</title>" {exit 0} timeout {exit 3}
