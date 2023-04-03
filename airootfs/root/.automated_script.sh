#!/usr/bin/env bash

script_cmdline ()
{
    local param
    for param in $(< /proc/cmdline); do
        case "${param}" in
            script=*) echo "${param#*=}" ; return 0 ;;
        esac
    done
}

automated_script ()
{
    local script rt
    script="$(script_cmdline)"
    if [[ -n "${script}" && ! -x /tmp/startup_script ]]; then
        if [[ "${script}" =~ ^((http|https|ftp)://) ]]; then
            curl "${script}" --location --retry-connrefused --retry 10 -s -o /tmp/startup_script >/dev/null
            rt=$?
        else
            cp "${script}" /tmp/startup_script
            rt=$?
        fi
        if [[ ${rt} -eq 0 ]]; then
            chmod +x /tmp/startup_script
            /tmp/startup_script
        fi
    fi
}

# Enable network manager
systemctl start NetworkManager.service

# Shutdown menu popup
chmod +x /root/.config/.scripts/shutdown-menu.sh

# Installation startup scripts
chmod +x /root/.main.sh
chmod +x /root/.install.sh

# Installer application
chmod +x /root/.yarp/rs-yarp

if [[ $(tty) == "/dev/tty1" ]]; then
    # Add 12G of cowspace
    mount -o remount,size=12G /run/archiso/cowspace
    
    # Launch automated script
    automated_script

    # Start i3 desktop
    startx
fi
