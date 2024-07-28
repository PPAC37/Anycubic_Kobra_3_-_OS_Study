# Anycubic_Kobra_3_-_OS_Study
Mes notes sur le firmware / l'OS "KobraOS" de la "Kobra 3"

Merci à [https://github.com/Bushmills](https://github.com/Bushmills) pour le wiki de son dépôt [https://github.com/Bushmills/Anycubic-Kobra-3-rooted](https://github.com/Bushmills/Anycubic-Kobra-3-rooted)  
qui décrit une méthode pour accéder en root via `adb` au firmware/ a l'OS de la "Kobra 3" d'Anycubic.

(  
A cette date 2024-07-28, cette méthode semble fonctionner avec le firmware  
V2.3.**1**.3_1.1.3_1.1.3_release  
et  
V2.3.**2**.3_1.1.3_1.1.3_release  
de la "Kobra 3"  
)


Je travaille ici avec une "Kobra 3" ayant un firmware V2.3.**2**.3_1.1.3_1.1.3_release.


## Pré-requis

### Avoir connecté votre "Kobra 3" a votre réseau Wi-Fi et connaitre son adresse IP.

![k3screen_1722126141](https://github.com/user-attachments/assets/3bd65eaa-222b-46f4-b652-108e9a5f723c)


### Avoir un ordinateur client (ici sous Ubuntu 20.04) connecté sur le même réseau.

#### Avoir d'installé 'adb' ( Android Debug Bridge ) sur votre ordinateur client.

~~~
sudo apt-get install adb
~~~
<pre>
  ...
</pre>

## Se connecter et lancer un shell via 'adb' depuis votre ordinateur client.

Adaptation de la méthode décrite sur  
[https://github.com/Bushmills/Anycubic-Kobra-3-rooted/wiki/shell-to-Kobra-3](https://github.com/Bushmills/Anycubic-Kobra-3-rooted/wiki/shell-to-Kobra-3)  
pour une distribution Linux Ubuntu 20.04.

Ici `192.168.1.35` est l'adresse IP affectée par le serveur DHCP par ma box internet a ma "Kobra 3" sur mon réseau local. (il vous faudra adapter les commande suivante, et éventuellement faire une règle d'association d'un IP fixe pour l'adresse MAC de votre "Kobra 3")


Connecter `adb` a votre "Kobra 3"
~~~
sudo adb connect 192.168.1.35
~~~
<details>
 <summary>Résultat de la commande sur ma machine (Cliquez pour déplier !)</summary>
<pre>
q6@q6-pc:~$ sudo adb connect 192.168.1.35
[sudo] Mot de passe de q6 : 
* daemon not running; starting now at tcp:5037
* daemon started successfully
connected to 192.168.1.35:5555
q6@q6-pc:~$
</pre>
<pre>
q6@q6-pc:~$ sudo adb connect 192.168.1.35
already connected to 192.168.1.35:5555
q6@q6-pc:~$ 
</pre>
<pre>
$ sudo adb connect 192.168.1.35
connected to 192.168.1.35:5555
</pre>
</details>


Après connexion réussie de `adb` a votre "Kobra 3",  
ouvrir un shell via la commande `adb shell`
~~~
adb shell
~~~
Résultat de la commande sur ma machine
<pre>
$ adb shell
root@Rockchip:/# 
</pre>


### Configurer 'sshd' sur la Kobra 3

Adaptation de la méthode décrite sur  
[https://github.com/Bushmills/Anycubic-Kobra-3-rooted/wiki/setting-up-sshd](https://github.com/Bushmills/Anycubic-Kobra-3-rooted/wiki/setting-up-sshd)  
pour une distribution Linux Ubuntu 20.04.

~~~
cd /ac_lib/lib/openssh
~~~
<details>
 <summary>Résultat de la commande sur ma machine (Cliquez pour déplier!)</summary>
<pre>
root@Rockchip:/# cd /ac_lib/lib/openssh
root@Rockchip:/ac_lib/lib/openssh# 
</pre>
</details>



~~~
./sshd_start.sh
~~~
<details>
 <summary>Résultat de la commande sur ma machine (Cliquez pour déplier!)</summary>
<pre>
root@Rockchip:/ac_lib/lib/openssh# ./sshd_start.sh 
ssh_host_rsa_key file no exit, creating...
Generating public/private rsa key pair.
Your identification has been saved in /ac_lib/lib/openssh/etc/ssh_host_rsa_key
Your public key has been saved in /ac_lib/lib/openssh/etc/ssh_host_rsa_key.pub
The key fingerprint is:
SHA256:******************************************* root@Rockchip
The key's randomart image is:
+---[RSA 3072]----+
|*****************|
|*****************|
|*****************|
|*****************|
|*****************|
|*****************|
|*****************|
|*****************|
|*****************|
+----[SHA256]-----+
ssh_host_ecdsa_key file no exit, creating...
Generating public/private rsa key pair.
Your identification has been saved in /ac_lib/lib/openssh/etc/ssh_host_ecdsa_key
Your public key has been saved in /ac_lib/lib/openssh/etc/ssh_host_ecdsa_key.pub
The key fingerprint is:
SHA256:******************************************* root@Rockchip
The key's randomart image is:
+---[RSA 3072]----+
|*****************|
|*****************|
|*****************|
|*****************|
|*****************|
|*****************|
|*****************|
|*****************|
|*****************|
+----[SHA256]-----+
ssh_host_ed25519_key file no exit, creating...
Generating public/private rsa key pair.
Your identification has been saved in /ac_lib/lib/openssh/etc/ssh_host_ed25519_key
Your public key has been saved in /ac_lib/lib/openssh/etc/ssh_host_ed25519_key.pub
The key fingerprint is:
SHA256:******************************************* root@Rockchip
The key's randomart image is:
+---[RSA 3072]----+
|*****************|
|*****************|
|*****************|
|*****************|
|*****************|
|*****************|
|*****************|
|*****************|
|*****************|
+----[SHA256]-----+
no config, configing
root@Rockchip:/ac_lib/lib/openssh# 
</pre>
</details>


~~~
read pid < /var/run/sshd.pid
kill $pid
~~~
<!-- 
// PB le caractère inférieur qui me fait bugger le html  (non terminaison du block pre et details ? )
// &lt; n'aide pas.
// <code></code> n'aide pas.
// \<  n'aide pas.
// ??? https://www.markdownguide.org/basic-syntax/#characters-you-can-escape
<details>
 <summary>Résultat de la commande sur ma machine (Cliquez pour déplier!)</summary>
<pre>
root@Rockchip:/ac_lib/lib/openssh# read pid < /var/run/sshd.pid
root@Rockchip:/ac_lib/lib/openssh# kill $pid
root@Rockchip:/ac_lib/lib/openssh# 
</pre>
</detail>
-->
<pre>
root@Rockchip:/ac_lib/lib/openssh# read pid < /var/run/sshd.pid
root@Rockchip:/ac_lib/lib/openssh# kill $pid
root@Rockchip:/ac_lib/lib/openssh# 
</pre>

Modifier le fichier de configuration du serveur sshd
~~~
vi etc/sshd_config
~~~


> In that file, change the line
<pre>
AuthorizedKeysFile       .ssh/authorized_keys
</pre>
> by moving the cursor to the line and pressing the "i" key (allowing editing).
>
> Let it point to a file with an writable absolute location.
>
> That location could be on your thumb drive, or alternatively the ssh configuration directory.  
> In that case should that line be changed to:
~~~
AuthorizedKeysFile      /ac_lib/lib/openssh/etc/authorized_keys
~~~
> 
> Save the file (Esc:wq )

Note : Ici le `Esc:wq` signifie appuyer sur la touche "Echap", puis la touche ":" (permet de passer en mode commande sous `vi`), puis la touche "w" (pour écrire le fichier si en mode commande), puis la touche "q" (pour quiter `vi` si en mode commande).

---

Sur votre ordinateur client.  
Dans une nouvelle console bash.  
Générer vous (si pas déja fait) une clé RSA.
~~~
cd ~/.ssh/
~~~
~~~
ssh-keygen -t rsa
~~~
<details>
 <summary>Résultat de la commande sur ma machine (Cliquez pour déplier!)</summary>
<pre>
q6@q6-pc:~/.ssh$ ssh-keygen -t rsa
Generating public/private rsa key pair.
Enter file in which to save the key (/home/q6/.ssh/id_rsa): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/q6/.ssh/id_rsa
Your public key has been saved in /home/q6/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:******************************************* q6@q6-pc
The key's randomart image is:
+---[RSA 3072]----+
|*****************|
|*****************|
|*****************|
|*****************|
|*****************|
|*****************|
|*****************|
|*****************|
|*****************|
+----[SHA256]-----+
q6@q6-pc:~/.ssh$ 
</pre>
</details>

Toujours sous cette cette nouvelle console bash sous votre client.  
Transférer la clé public RSA vers la "Kobra 3" via `adb push` vers le fichier des clés authorisées.  
~~~
adb push id_rsa.pub /ac_lib/lib/openssh/etc/authorized_keys
~~~
<details>
 <summary>Résultat de la commande sur ma machine (Cliquez pour déplier!)</summary>
<pre>
q6@q6-pc:~/.ssh$ adb push id_rsa.pub /ac_lib/lib/openssh/etc/authorized_keys
id_rsa.pub: 1 file pushed. 0.1 MB/s (562 bytes in 0.004s)
q6@q6-pc:~/.ssh$ 
</pre>
</details>

---

Revenir sur la fenettre où l'on se trouve connecté sur un shell de la Kobra 3 via adb  
(Depuis la Kobra 3)  
~~~
chmod 600 etc/authorized_keys
~~~
<details>
 <summary>Résultat de la commande sur ma machine (Cliquez pour déplier!)</summary>
<pre>
root@Rockchip:/ac_lib/lib/openssh# chmod 600 etc/authorized_keys
root@Rockchip:/ac_lib/lib/openssh# 
</pre>
</details>



~~~
./sshd_start.sh
~~~
<details>
 <summary>Résultat de la commande sur ma machine (Cliquez pour déplier!)</summary>
<pre>
root@Rockchip:/ac_lib/lib/openssh# ./sshd_start.sh 
config
root@Rockchip:/ac_lib/lib/openssh# 
</pre>
</details>

Et là enfin votre poste client doit avoir la posibilité de se connecter a la Kobra 3 comme utilisateur root en SSH.  


(  


**Mais pour l'instant, le serveur sshd n'est pas re-lancé automatiquement et donc,  
si on redémmare la Kobra 3,  
il faudra relancer le serveur SSH via un shell adb connecté a la Kobra 3.**

~~~
sudo adb connect 192.168.1.35
~~~

<details>
 <summary>Résultat de la commande sur ma machine (Cliquez pour déplier!)</summary>
<pre>
$ sudo adb connect 192.168.1.35
connected to 192.168.1.35:5555
</pre>
</details>

~~~
adb shell
~~~

<details>
 <summary>Résultat de la commande sur ma machine (Cliquez pour déplier!)</summary>
<pre>
$ adb shell
root@Rockchip:/# 
</pre>
</details>


~~~
/ac_lib/lib/openssh/sshd_start.sh
~~~
<details>
 <summary>Résultat de la commande sur ma machine (Cliquez pour déplier!)</summary>
<pre>
root@Rockchip:/# ac_lib/lib/openssh/sshd_start.sh 
config
root@Rockchip:/# 
</pre>
</details>


)

### Bidouille pour lancer le serveur ssh lors du démarrage

Ajouter ce qui suit, 
~~~

# Ligne suivante ajouté par PPAC, Pour automatiquement lancer le serveur ssh
/ac_lib/lib/openssh/sshd_start.sh

~~~
en fin du fichier `/userdata/app/gk/start.sh` pour automatiquement démmaré le serveur ssh quand l'OS de l'imprimante démmare  
( car `/etc/init.d/S90_app_run` appel `/userdata/app/kenv/run.sh` qui lui même appel `/userdata/app/gk/start.sh` )



### Une fois tout cela fait, pour vous connecter depuis votre ordinateur client
~~~
ssh 192.168.1.35 -l root
~~~
ou 
~~~
ssh root@192.168.1.35
~~~

<details>
 <summary>Résultat de la commande sur ma machine (Cliquez pour déplier!)</summary>
  ( block suivant seulement lors de la première tentative de connexion )
<pre>
The authenticity of host '192.168.1.35 (192.168.1.35)' can't be established.
RSA key fingerprint is SHA256:*******************************************.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '192.168.1.35' (RSA) to the list of known hosts.
</pre>
<pre>
root@Rockchip:~# 
</pre>
</details>

ou  
graphiquement sous "Fichiers" (le gestionnaire de fichiers par défaut sur une Ubuntu 20.04)  
via "Autres emplacements", "Connexion à un serveur" (en bas de la fenetre) 
aprés avoir saisie,  
~~~
ssh://192.168.1.35
~~~
ou
~~~
sftp://192.168.1.35
~~~

![Capture d’écran de 2024-07-28 00-13-27](https://github.com/user-attachments/assets/861b73e5-78d5-4735-a422-7031207f229d)

cliquer sur "Se connecter"  

![Capture d’écran de 2024-07-28 03-04-10](https://github.com/user-attachments/assets/b3b9fe88-48e8-408e-87d9-ac93a170c68c)
pour le nom d'utilisateur utiliser alors 
~~~
root
~~~
( pas de mot de passe car on ne le connais pas et il n'est pas modifiable sur la "Kobra 3" (dans un squashfs non modifiable),  
mais on a précédament pris le temps d'ajouter la clé RSA de notre client dans les clés autorisées par le serveur ssh sur la "Kobra 3"  
et donc la connexion dois pouvoir se faire sans utiliser de mot de passe).


On arrive alors a plus simplement explorer/modifier certaine partie de l'arboressence de fichiers de la "Kobra 3".

![Capture d’écran de 2024-07-28 00-18-03](https://github.com/user-attachments/assets/61dcd320-a909-4319-b99e-6d0f3eddd154)


Chemin du fichier de configuration Klipper `printer.cfg` 
~~~
/userdata/app/gk/printer.cfg
~~~


Chemin du dossier où sont stocké les fichier d'impression ".gcode"
~~~
/useremain/app/gk/gcodes
~~~

---

## D'autre résultat de commandes

~~~
mount
~~~
<pre>
root@Rockchip:/# mount
/dev/root on / type squashfs (ro,relatime)
devtmpfs on /dev type devtmpfs (rw,relatime,size=115180k,nr_inodes=28795,mode=755)
proc on /proc type proc (rw,relatime)
devpts on /dev/pts type devpts (rw,relatime,gid=5,mode=620,ptmxmode=000)
tmpfs on /dev/shm type tmpfs (rw,relatime,size=115260k,nr_inodes=28815,mode=777)
tmpfs on /tmp type tmpfs (rw,relatime,size=115260k,nr_inodes=28815)
tmpfs on /run type tmpfs (rw,nosuid,nodev,relatime,size=115260k,nr_inodes=28815,mode=755)
sysfs on /sys type sysfs (rw,relatime)
debug on /sys/kernel/debug type debugfs (rw,relatime)
/dev/block/by-name/userdata on /userdata type ext4 (rw,relatime)
/dev/block/by-name/oem_b on /oem type squashfs (ro,relatime)
/dev/block/by-name/ac_lib_b on /ac_lib type ext4 (rw,relatime)
/dev/block/by-name/ac_app_b on /ac_app type ext4 (rw,relatime)
/dev/block/by-name/useremain on /useremain type ext4 (rw,relatime)
none on /sys/kernel/config type configfs (rw,relatime)
adb on /dev/usb-ffs/adb type functionfs (rw,relatime)
root@Rockchip:/# 
</pre>

---

~~~
df -h
~~~
<pre>
root@Rockchip:~# df -h
Filesystem                Size      Used Available Use% Mounted on
/dev/root                 6.3M      6.3M         0 100% /
devtmpfs                112.5M         0    112.5M   0% /dev
tmpfs                   112.6M         0    112.6M   0% /dev/shm
tmpfs                   112.6M     52.0K    112.5M   0% /tmp
tmpfs                   112.6M    220.0K    112.3M   0% /run
/dev/block/by-name/userdata
                        487.6M    129.2M    336.3M  28% /userdata
/dev/block/by-name/oem_b
                         16.0M     16.0M         0 100% /oem
/dev/block/by-name/ac_lib_b
                        237.9M    108.1M    113.5M  49% /ac_lib
/dev/block/by-name/ac_app_b
                         56.7M     16.0K     54.1M   0% /ac_app
/dev/block/by-name/useremain
                          5.8G    228.0M      5.3G   4% /useremain
root@Rockchip:~# 
</pre>

---


~~~
ls -la /dev/
~~~
<pre>
root@Rockchip:~# ls -la /dev/
crw-------    1 root     root      254,   0 gpiochip0
crw-------    1 root     root      254,   1 gpiochip1
crw-------    1 root     root      254,   2 gpiochip2
crw-------    1 root     root      254,   3 gpiochip3
crw-------    1 root     root      254,   4 gpiochip4
crw-rw-r--    1 root     root       10, 242 rfkill
crw-r-----    1 root     kmem        1,   1 mem
crw-rw-rw-    1 root     root        1,   3 null
crw-rw-rw-    1 root     root        1,   5 zero
crw-rw-rw-    1 root     root        1,   7 full
crw-rw-rw-    1 root     root        1,   8 random
crw-rw-rw-    1 root     root        1,   9 urandom
crw-r--r--    1 root     root        1,  11 kmsg
crw-rw-rw-    1 root     tty         5,   0 tty
crw-------    1 root     root        5,   1 console
crw-rw-rw-    1 root     tty         5,   2 ptmx
crw-rw----    1 root     dialout     4,  64 ttyS0
crw-rw----    1 root     dialout     4,  65 ttyS1
crw-rw----    1 root     dialout     4,  67 ttyS3
crw-------    1 root     root       10, 183 hwrng
drwxr-xr-x    2 root     root            60 rk_dma_heap
drwxr-xr-x    3 root     root            60 bus
drwxr-xr-x    4 root     root           160 input
crw-------    1 root     root       10, 223 uinput
crw-------    1 root     root       89,   4 i2c-4
crw-------    1 root     root      249,   0 iio:device0
crw-------    1 root     root       10, 127 cpu_dma_latency
crw-rw----    1 root     video      29,   0 fb0
drwxr-xr-x    3 root     root           100 dri
crw-------    1 root     root       10, 126 ubi_ctrl
crw-------    1 root     root      247,   0 mmcblk0rpmb
brw-rw----    1 root     disk      179,   0 mmcblk0
brw-rw----    1 root     disk      179,   1 mmcblk0p1
brw-rw----    1 root     disk      179,   2 mmcblk0p2
brw-rw----    1 root     disk      179,   3 mmcblk0p3
brw-rw----    1 root     disk      179,   4 mmcblk0p4
brw-rw----    1 root     disk      179,   5 mmcblk0p5
brw-rw----    1 root     disk      179,   6 mmcblk0p6
brw-rw----    1 root     disk      179,   7 mmcblk0p7
brw-rw----    1 root     disk      179,   8 mmcblk0p8
brw-rw----    1 root     disk      179,   9 mmcblk0p9
brw-rw----    1 root     disk      179,  10 mmcblk0p10
brw-rw----    1 root     disk      179,  11 mmcblk0p11
brw-rw----    1 root     disk      179,  12 mmcblk0p12
brw-rw----    1 root     disk      179,  13 mmcblk0p13
brw-rw----    1 root     disk      179,  14 mmcblk0p14
brw-rw----    1 root     disk      179,  15 mmcblk0p15
brw-rw----    1 root     disk      179,  16 mmcblk0p16
brw-rw----    1 root     disk      179,  17 mmcblk0p17
brw-rw----    1 root     disk      179,  64 mmcblk0boot1
brw-rw----    1 root     disk      179,  32 mmcblk0boot0
drwxr-xr-x    2 root     root             0 pts
drwxrwxrwx    2 root     root            40 shm
lrwxrwxrwx    1 root     root            13 fd -> /proc/self/fd
lrwxrwxrwx    1 root     root            15 stdin -> /proc/self/fd/0
lrwxrwxrwx    1 root     root            15 stdout -> /proc/self/fd/1
lrwxrwxrwx    1 root     root            15 stderr -> /proc/self/fd/2
drwxr-xr-x    2 root     root          1460 char
drwxr-xr-x    3 root     root           460 block
drwxr-xr-x    6 root     root           120 disk
drwxr-xr-x    3 root     root            60 usb-ffs
crw-rw----    1 root     video     250,   0 media0
crw-rw----    1 root     video      81,   0 video0
crw-rw----    1 root     video      81,   1 video1
crw-rw----    1 root     video      81,   2 video2
crw-rw----    1 root     video      81,   3 video3
crw-rw----    1 root     video      81,   4 video4
crw-rw----    1 root     video      81,   5 video5
crw-rw----    1 root     video      81,   6 video6
crw-rw----    1 root     video      81,   7 video7
crw-rw----    1 root     video      81,   8 video8
crw-rw----    1 root     video      81,   9 video9
crw-rw----    1 root     video      81,  10 v4l-subdev0
crw-------    1 root     root       10, 125 rga
crw-------    1 root     root      244,   0 mpp_service
crw-------    1 root     root      243,   0 vcodec
crw-------    1 root     root       10, 124 rknpu
drwxr-xr-x    2 root     root           260 mpi
drwxr-xr-x    4 root     root            80 v4l
crw-rw----    1 root     video      81,  11 video10
crw-rw----    1 root     video      81,  12 video11
crw-rw----    1 root     video     250,   1 media1
crw-rw----    1 root     dialout   166,   0 ttyACM0
drwxr-xr-x    4 root     root            80 serial
drwxr-xr-x   23 root     root           355 ..
drwxr-xr-x   15 root     root          1720 .
root@Rockchip:~# ls -la /dev/block/
179:0     179:11    179:14    179:17    179:32    179:6     179:8
179:1     179:12    179:15    179:2     179:4     179:64    179:9
179:10    179:13    179:16    179:3     179:5     179:7     by-name/
root@Rockchip:~# 
</pre>

---


~~~
ls -la /dev/block/by-name/
~~~
<pre>
root@Rockchip:~# ls -la /dev/block/by-name/
lrwxrwxrwx    1 root     root            14 env -> /dev/mmcblk0p1
lrwxrwxrwx    1 root     root            14 idblock -> /dev/mmcblk0p2
lrwxrwxrwx    1 root     root            14 uboot_a -> /dev/mmcblk0p3
lrwxrwxrwx    1 root     root            14 uboot_b -> /dev/mmcblk0p4
lrwxrwxrwx    1 root     root            14 misc -> /dev/mmcblk0p5
lrwxrwxrwx    1 root     root            14 boot_a -> /dev/mmcblk0p6
lrwxrwxrwx    1 root     root            14 boot_b -> /dev/mmcblk0p7
lrwxrwxrwx    1 root     root            14 system_a -> /dev/mmcblk0p8
lrwxrwxrwx    1 root     root            14 system_b -> /dev/mmcblk0p9
lrwxrwxrwx    1 root     root            15 oem_a -> /dev/mmcblk0p10
lrwxrwxrwx    1 root     root            15 oem_b -> /dev/mmcblk0p11
lrwxrwxrwx    1 root     root            15 userdata -> /dev/mmcblk0p12
lrwxrwxrwx    1 root     root            15 ac_lib_a -> /dev/mmcblk0p13
lrwxrwxrwx    1 root     root            15 ac_lib_b -> /dev/mmcblk0p14
lrwxrwxrwx    1 root     root            15 ac_app_a -> /dev/mmcblk0p15
lrwxrwxrwx    1 root     root            15 ac_app_b -> /dev/mmcblk0p16
lrwxrwxrwx    1 root     root            15 useremain -> /dev/mmcblk0p17
drwxr-xr-x    3 root     root           460 ..
drwxr-xr-x    2 root     root           380 .
root@Rockchip:~# 
</pre>

---



~~~
uname -a
~~~
<pre>
root@Rockchip:/# uname -a
Linux Rockchip 5.10.160 #1 Fri May 24 16:22:18 CST 2024 armv7l GNU/Linux
root@Rockchip:/# 
</pre>

---


~~~
lsusb
~~~
Avec un ACE Pro, et la caméra, mais sans clé USB, de connectés.
<pre>
root@Rockchip:/# lsusb
Bus 001 Device 001: ID 1d6b:0002
Bus 001 Device 004: ID 05e3:0610
Bus 001 Device 002: ID 05e3:0610
Bus 002 Device 001: ID 1d6b:0003
Bus 001 Device 003: ID 0c45:6366
Bus 001 Device 006: ID 28e9:018a
root@Rockchip:/# 
</pre>

---


~~~
ps
~~~
<pre>
root@Rockchip:/# ps
  PID USER       VSZ STAT COMMAND
    1 root      1212 S    init
    2 root         0 SW   [kthreadd]
    6 root         0 IW<  [mm_percpu_wq]
    7 root         0 SW   [ksoftirqd/0]
    8 root         0 SW   [kdevtmpfs]
    9 root         0 SW   [oom_reaper]
   10 root         0 IW<  [writeback]
   11 root         0 SW   [kcompactd0]
   12 root         0 SWN  [ksmd]
   40 root         0 IW<  [kblockd]
   41 root         0 IW<  [devfreq_wq]
   42 root         0 SW   [watchdogd]
   44 root         0 IW<  [rpciod]
   45 root         0 IW<  [kworker/u3:0-hc]
   46 root         0 IW<  [xprtiod]
   47 root         0 SW   [kswapd0]
   48 root         0 IW<  [nfsiod]
   50 root         0 SW   [irq/56-rockchip]
   52 root         0 SW   [hwrng]
   53 root         0 IW<  [stmmac_wq]
   56 root         0 IW   [kworker/u2:2-ev]
   57 root         0 SW<  [krfcommd]
   60 root         0 SW   [card0-crtc0]
   61 root         0 IW<  [mmc_complete]
   73 root      1580 S    /sbin/udevd -d
   88 root         0 IW<  [kworker/0:2H-kb]
  134 root         0 SW   [jbd2/mmcblk0p12]
  135 root         0 IW<  [ext4-rsv-conver]
  148 root         0 SW   [jbd2/mmcblk0p14]
  149 root         0 IW<  [ext4-rsv-conver]
  156 root         0 SW   [jbd2/mmcblk0p16]
  157 root         0 IW<  [ext4-rsv-conver]
  164 root         0 IW<  [ext4-rsv-conver]
  198 root         0 SW   [irq/44-ffa70000]
  214 root     18424 S    /usr/bin/adbd
  257 root         0 SW   [irq/36-rga2]
  259 root         0 SW   [queue_work0]
  260 root         0 SW   [queue_work1]
  261 root         0 SW   [irq/42-ffa50000]
  262 root         0 SW   [irq/43-ffa60000]
  263 root         0 SW   [vcodec_thread_0]
  265 root         0 IW<  [rknpu_power_off]
  270 root         0 DW   [vlog]
  271 root         0 DW   [vsys]
  272 root         0 DW   [vrga]
  273 root         0 DW   [vpss]
  274 root         0 DW   [vrgn]
  275 root         0 DW   [vmcu]
  330 root         0 SW   [irq/58-xpt7603]
  342 root      810m S    ./gklib -a /tmp/unix_uds1 printer.cfg
  343 root      794m S    ./gkapi
  344 root     43860 S    ./K3SysUi
  370 root         0 IW<  [cfg80211]
  374 root      1252 S    wpa_supplicant -Dnl80211 -i wlan0 -c /userdata/wifi_
  388 root         0 DW   [RTW_XMIT_THREAD]
  389 root         0 DW   [RTW_RECV_THREAD]
  390 root         0 DW   [RTW_CMD_THREAD]
  391 root         0 DW   [RTWHALXT]
  392 root         0 DW   [RTWHALXT]
  404 root     26456 S    ./gkcam
  413 dbus      1644 S    dbus-daemon --system
  437 root         0 IW<  [btfwwork]
  438 root         0 IW<  [bttimerwork]
  439 root       912 S    rtk_hciattach -n -s 115200 /dev/ttyS1 rtk_h5
  445 root         0 IW<  [kworker/u3:1-hc]
  460 root      3708 S    /usr/libexec/bluetooth/bluetoothd -n -f /ac_lib/lib/
 1368 root         0 IW   [kworker/0:2-eve]
 1937 root         0 IW   [kworker/u2:1-ev]
 2184 root         0 IW<  [kworker/0:0H-kb]
 2547 root         0 Z    [sh]
 2550 root      1212 R    ps
 3009 root      1232 S    /bin/sh -l
 3232 root         0 IW   [kworker/0:0-eve]
 3854 root         0 IW   [kworker/0:1-eve]
root@Rockchip:/# 
</pre>

---


~~~
env
~~~
<pre>
root@Rockchip:/# env
TSLIB_ROOT=/ac_lib/lib/tslib
TSLIB_TSDEVICE=/dev/input/event0
USER=root
TSLIB_TSEVENTTYPE=INPUT
LD_LIBRARY_PATH=/ac_lib/lib/third_lib:/ac_lib/lib/wireless_tools/lib:/ac_lib/app/kenv/third/ffi:/ac_lib/app/kenv/python/lib:/ac_lib/lib/v4l-utils/lib:/ac_lib/lib/tslib/lib:/ac_lib/lib/qt/lib:/ac_lib/lib/openssl/lib:/ac_lib/lib/curl/lib:/ac_lib/lib/zlib/lib:/oem/usr/lib:/oem/lib:/ac_lib/lib/third_lib:/ac_lib/lib/wireless_tools/lib:/ac_lib/app/kenv/third/ffi:/ac_lib/app/kenv/python/lib:/ac_lib/lib/v4l-utils/lib:/ac_lib/lib/tslib/lib:/ac_lib/lib/qt/lib:/ac_lib/lib/openssl/lib:/ac_lib/lib/curl/lib:/ac_lib/lib/zlib/lib:/oem/usr/lib:/oem/lib:
SHLVL=3
OLDPWD=/userdata
HOME=/oem
QT_ROOT=/ac_lib/lib/qt
user_debug=31
PAGER=/bin/more 
TSLIB_FBDEVICE=/dev/fb0
PS1=\u@\h:\w# 
TSLIB_PLUGINDIR=/ac_lib/lib/tslib/lib/ts
QT_QPA_PLATFORM_PLUGIN_PATH=/ac_lib/lib/qt/plugins/platforms
TSLIB_CONSOLEDEVICE=none
TERM=vt102
PATH=/ac_lib/lib/third_bin:/ac_lib/lib/wireless_tools/bin:/ac_lib/lib/sysstat/bin:/ac_lib/lib/openssh/bin:/ac_lib/lib/openssh/sbin:/ac_lib/app/kenv/python/bin:/ac_lib/lib/v4l-utils/bin:/ac_lib/lib/openssl/bin:/ac_lib/lib/curl/bin:/ac_lib/lib/firmware/bin:/bin:/sbin:/usr/bin:/usr/sbin:/oem:/oem/bin:/oem/usr/bin:/oem/sbin:/oem/usr/sbin
TSLIB_CONFFILE=/ac_lib/lib/tslib/etc/ts.conf
SHELL=/bin/sh
storagemedia=emmc
QT_QPA_FONTDIR=/ac_lib/lib/qt/fonts
QT_QPA_PLATFORM=linuxfb:fb=/dev/fb0:size=480x272:rotation=90:offset=0x0:nographicsmodeswitch
QT_QPA_FB_TSLIB=1
PWD=/
PYTHONPATH=/userdata/app/kenv/third
QT_PLUGIN_PATH=/ac_lib/lib/qt/plugins
TZ=CST-8
POINTERCAL_FILE=/ac_lib/lib/tslib/etc/pointercal
TSLIB_CALIBFILE=/ac_lib/lib/tslib/etc/pointercal
EDITOR=/bin/vi
root@Rockchip:/# 
</pre>

---




~~~
find . | grep -e ".cfg"
~~~
<pre>
root@Rockchip:/userdata# find . | grep -e ".cfg"
./app/kenv/third/pycparser/_c_ast.cfg
./app/gk/printer_mutable_20240720135034.cfg
./app/gk/printer_mutable.cfg
./app/gk/printer_mutable_20240720134230.cfg
./app/gk/printer.cfg.1
./app/gk/config/para.cfg
./app/gk/config/ams_config.cfg
./app/gk/config/api.cfg.1
./app/gk/config/api.cfg
./app/gk/printer.cfg
./app/gk/temperature_sensors.cfg
./app/gk/printer_mutable_20240727153553.cfg
./wifi_cfg
./wifi_cfg/wpa_supplicant.conf.bak
./wifi_cfg/wpa_supplicant.conf
root@Rockchip:/userdata# 
</pre>

---







<!--
// TODO // Code template a effacer mais que je garde cous le coude pour l'instant.

~~~

~~~
<pre>

</pre>

---


~~~

~~~
<details>
 <summary>Résultat de la commande sur ma machine (Cliquez pour déplier!)</summary>
<pre>

</pre>
</details>


-->
