#!/bin/bash

swaymsg -t get_outputs | jq -r '.[] | select(.focused)' | jq -r '.name' | awk '{if ($1 == "HDMI-A-1") print "0"; else print "1"}'
