Enable systemd services
=======================

NOTE: Run all the commands as root

1. Enable periodical TRIM
    systemctl enable fstrim.timer

2. Enable xdm Display Manager
    systemctl enable xdm.service

3. Enable timesync
    systemctl enable systemd-timesyncd.service
