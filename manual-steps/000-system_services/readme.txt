Enable systemd services
=======================

NOTE: Run all the commands as root

1. Enable periodical TRIM
    systemctl enable fstrim.timer

2. Enable xdm Display Manager
    systemctl enable xdm.service
