Add 'display-config.sh' script to set display settings on login and docking/undocking events and 'backlight.sh' to control backlight
====================================================================================================================================

1. Copy 'display-config.sh' and 'backlight.sh' to /opt/bin

2. Execute as root:
    chown root:root /opt/bin/display-config.sh
    chown root:root /opt/bin/backlight.sh
    chmod 505 /opt/bin/display-config.sh
    chmod 505 /opt/bin/backlight.sh

3. Copy '99-power_management' to /etc/udev/rules.d
