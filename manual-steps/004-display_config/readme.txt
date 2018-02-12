Add scripts for docking/undocking events and brightness change
==============================================================

1. Copy 'display-config.sh' and 'backlight.sh' to /opt/bin

2. Execute as root:
    chown root:root /opt/bin/display-config.sh
    chown root:root /opt/bin/backlight.sh
    chmod 505 /opt/bin/display-config.sh
    chmod 505 /opt/bin/backlight.sh

3. Copy '99-power_management' to /etc/udev/rules.d

4. Enable backlight.sh script to be executed as root without password:
    a) Run "visudo" as root
    b) Add the following to the end of the newly opened file and save:
        ## Execute backlight.sh without password
        ALL ALL = NOPASSWD:/opt/bin/backlight.sh

5. Disable failing systemd service for acpi_video0 backlight:
    a) Append the following to kernel arguments:
        acpi_backlight=vendor
