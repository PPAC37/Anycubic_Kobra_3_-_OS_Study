#!/bin/bash
# version:     0.0.2 (.0 as mod by PPAC)
#PPAC: Source of the original version : https://github.com/Bushmills/Anycubic-Kobra-3-rooted/wiki/other-perks
# description: grab kobra 3 framebuffer, convert to png
# examples:   k3screen           # let script choose file name
#             k3screen name      # specify file name

#PPAC: 
kobra3="192.168.1.35"

dim="480x272"
name="${1:-k3screen_$EPOCHSECONDS}"
in="$name.raw"
out="$name.png"

# A revoir l'idée c'est faire le adb connect si pas deja fait. mais avant il faudrait même proposer de faire un sudo apt-get install adb si adb n'est pas dispo sur le système
#
# q6@q6-pc:~$ sudo adb connect 192.168.1.35
# [sudo] Mot de passe de q6 : 
# * daemon not running; starting now at tcp:5037
# * daemon started successfully
# connected to 192.168.1.35:5555
# q6@q6-pc:~$ adb shell
# root@Rockchip:/# /ac_lib/lib/openssh/sshd_start.sh
# config
# root@Rockchip:/# 
# ---
# $ adb devices
# List of devices attached
# 192.168.1.35:5555	device
# ---
adb_connected_check=`adb devices | grep -o "$kobra3:"`
echo $adb_connected_check
if (test "X$adb_connected_check" == "X$kobra3:"); then echo OK ; else echo PB ; sudo adb connect $kobra3; fi

#DEBUG
echo ssh root@$kobra3   cp /dev/fb0 "/userdata/$in"

ssh root@$kobra3   cp /dev/fb0 "/userdata/$in"

#PPAC: étrangement si j'utilise scp cela me fait un "not fond" un truc dois m'échaper.
#echo scp "root@$kobra3:/userdata/$in" .
#scp "root@$kobra3:/userdata/$in" .

#DEBUG
echo adb pull /userdata/$in

adb pull /userdata/$in


#PPAC: 
#ffmpeg -y -display_rotation 90 -pix_fmt rgb32 -s $dim -i "$in" "$out" && rm "$in"
## Unrecognized option 'display_rotation'.

# DEBUG
echo ffmpeg -y -pix_fmt rgb32 -s $dim -i "$in" "$out" 
echo rm "$in"

# "-loglevel -8" // = quiet (no output)
ffmpeg -loglevel -8 -y -pix_fmt rgb32 -s $dim -i "$in" "$out" && rm -v "$in"

# A faire sudo apt-get install imagemagic si pas de commande convert de disponible sur le système

#DEBUG
echo convert "$out" -rotate -90 "$out"

#
convert "$out" -rotate -90 "$out"


