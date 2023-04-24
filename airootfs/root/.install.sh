#!/usr/bin/env bash

# Create log directory
mkdir /logs/

# Launch Installer
xfce4-terminal -e "zsh -c './.main.sh'" -T "YARP"
