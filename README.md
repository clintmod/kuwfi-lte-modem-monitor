# kuwfi-lte-modem-monitor

A program to monitor a Kuwfi LTE modem and reboot it if necessary.

## Motivation

I'm load balancing 4 LTE modems and they are kind of flaky. 

I reboot them via telnet if they act up.

So I: 
- telnet in to the router and curl google.com every 10 seconds
- if curl fails I check to see if the plug has been rebooted in the last 2 minutes
- if not I reboot the modem

## Requirements

- docker

## Building the image

```
make build
```

## Running the program

```
make run
```
