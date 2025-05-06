#!/bin/bash
# this is a helper script which launches various commands

TERM=xterm

case `basename $0` in
    _mc)
        $TERM -e mc
        ;;
    _hints)
        hints.sh "$@"
        ;;
    _base64decode)
        echo "$@" | base64 -d -
        ;;
    _xclip)
        xclip -o | xclip -selection clipboard
        ;;
    _dirty)
        cat /proc/meminfo | grep irty
        ;;
    _mountios-vlc)
        mkdir -p /tmp/ios-vlc \
        && ifuse --documents org.videolan.vlc-ios /tmp/ios-vlc
        ;;
    _umountios-vlc)
        fusermount -u /tmp/ios-vlc
        ;;
    _mountios-chunky)
        mkdir -p /tmp/ios-chunky \
        && ifuse --documents com.mike-ferenduros.Chunky-Comic-Reader /tmp/ios-chunky
        ;;
    _umountios-chunky)
        fusermount -u /tmp/ios-chunky
        ;;
    _mountios-dcim)
        mkdir -p /tmp/ios-dcim && ifuse /tmp/ios-dcim
        ;;
    _umountios-dcim)
        fusermount -u /tmp/ios-dcim
        ;;
    _startsmb)
        sudo systemctl start docker && sudo docker run --name="docker-smb" \
        -d --rm --entrypoint "" \
        -p 445:445 \
        -e "USER=samba" -e "PASS=secret" \
        -v `pwd`:/storage dockurr/samba \
        bash -c "echo vfs objects = fruit streams_xattr >> /etc/samba/smb.default && samba.sh"
        ;;
    _stopsmb)
        sudo docker stop docker-smb
        ;;
    *)
        exit 1
esac
