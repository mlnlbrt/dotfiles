Install packages
----------------

1. Install packages from repository by executing the following as root:
    pacman -S - < pkg.list

2. Install packages from AUR:
    a) Open "aur.pkg.list" file
    b) Go to https://aur.archlinux.org/
    c) Find package, download snapshot and install it using "makepkg -sri"
    d) Repeat c) for each package in "aur.pkg.list"
