Enable systemd services
=======================

NOTE: Run all the commands as root

1. Enable periodical TRIM
    systemctl enable fstrim.timer

2. Enable lightdm Display Manager
    systemctl enable lightdm.service
