#!/usr/bin/env bash

# Detect if online
is_online() {
    wget -q --spider http://google.com

    if [ $? -eq 0 ]; then
        echo "true"
    else
        echo "false"
    fi
}

# Generic pause, wait for user key input
pause() {
    read -s -n 1 -p ""
    echo ""
}

# Message displayed in console
message() {
    echo "No network access !"
    echo ""
    echo "To connect via Ethernet, plug the cable and press any key."
    echo ""
    echo "To connect via WiFi, press any key."
}

# Ask for Network connection if is not connected to network
while [ $(is_online) == "false" ]; do    
    message ; pause ; nmtui
done

# Launch Installer
cd /root/.yarp ; 

./rs-yarp | tee -a "/logs/YARP-DEBUG-$(date +'%d-%m-%Y')";
