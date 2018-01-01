Enable systemd services
=======================

NOTE: Run all the commands as root

1. Enable periodical TRIM
    systemctl enable fstrim.timer

2. Enable Network Manager
    systemctl enable NetworkManager.service

3. Enable lightdm Display Manager
    systemctl enable lightdm.service
