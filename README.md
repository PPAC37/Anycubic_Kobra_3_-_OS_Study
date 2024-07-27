# Anycubic_Kobra_3_-_OS_Study
Mes notes sur le firmware KobraOS de la "Kobra 3"

Merci a  
[https://github.com/Bushmills](https://github.com/Bushmills)  
pour son dépot (et surtout le wiki de son dépot)  
[https://github.com/Bushmills/Anycubic-Kobra-3-rooted](https://github.com/Bushmills/Anycubic-Kobra-3-rooted)  
qui décrit une méthode pour accéder en root via `adb` au firmware de la "Kobra 3" d'Anycubic.

## Pré-requis

### Avoir connecté votre "Kobra 3" a votre réseau Wi-Fi et connaitre son adresse IP.

### Avoir un ordinateur client (ici sous Ubuntu 20.04) connecté sur le même réseau.

#### Avoir d'installé 'adb' ( Android Debug Bridge ) sur votre ordinateur client.

~~~
sudo apt-get install adb
~~~
<pre>
  ...
</pre>

## Se connecter et ouvire un shell via 'adb' depuis votre ordinateur client.

Adaptation de la méthode décrite sur  
[https://github.com/Bushmills/Anycubic-Kobra-3-rooted/wiki/shell-to-Kobra-3](https://github.com/Bushmills/Anycubic-Kobra-3-rooted/wiki/shell-to-Kobra-3)  
pour une distribution Linux Ubuntu 20.04.

Ici `192.168.1.35` est l'adresse IP affecté par le serveur DHCP par ma box internet a ma Kobra 3 sur mon réseau local. (il vous faudra adapter les commande suivante)


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

 <!-- Vérifier ce que donne le caractère inférieur qui me fait bugger le html  (non terminaison du block pre et details) si je ne le convertie pas -->
~~~
read pid &lt; /var/run/sshd.pid
kill $pid
~~~
<details>
 <summary>Résultat de la commande sur ma machine (Cliquez pour déplier!)</summary>
  <!-- Vérifier ce que donne le caractère inférieur qui me fait bugger le html  (non terminaison du block pre et details) si je ne le convertie pas -->
<pre>
root@Rockchip:/ac_lib/lib/openssh# read pid &lt; /var/run/sshd.pid
root@Rockchip:/ac_lib/lib/openssh# kill $pid
root@Rockchip:/ac_lib/lib/openssh# 
</pre>
</detail>


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
Pour sauver le "(Esc:wq)" signifie appuyer sur la touche "Echap", puis la touche ":" (permet de passer en mode commande sous vi), puis la touche "w" (pour écrire le fichier si en mode commande), puis la touche "q" (pour quiter vi si en mode commande).


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

Toujours sous cette cette nouvelle consol bash sous votre client.  
Transférer la clé public RSA vers la Kobra 3 via adb vers le fichier des clé authorisées.  
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


Revenir sur la fenettre où l'on se trouve connecté sur un shell de la Kobra 3 via adb  
(Depuis la Kobra 3)  
~~~
chmod 600 etc/authorized_keys
~~~
<pre>
root@Rockchip:/ac_lib/lib/openssh# chmod 600 etc/authorized_keys
</pre>




~~~
./sshd_start.sh
~~~
<pre>
root@Rockchip:/ac_lib/lib/openssh# ./sshd_start.sh 
config
root@Rockchip:/ac_lib/lib/openssh# 
</pre>


Et là enfin votre post client doit avoir la posibilité de se connecter a la Kobra 3 comme utilisateur root en SSH.  
(Mais pour l'instant le serveur sshd n'est pas lancé automatiquement et donc si on redémmare la Kobra 3 il faudra relancer le serveur SSH via un shell adb connecté a la Kobra 3

~~~
sudo adb connect 192.168.1.35
~~~
<pre>
$ sudo adb connect 192.168.1.35
connected to 192.168.1.35:5555
</pre>


~~~
adb shell
~~~
<pre>
$ adb shell
root@Rockchip:/# 
</pre>


~~~
/ac_lib/lib/openssh/sshd_start.sh
~~~
<pre>
root@Rockchip:/# ac_lib/lib/openssh/sshd_start.sh 
config
root@Rockchip:/# 
</pre>

)


Enfin pour vous connecter depuis votre ordinateur client
~~~
ssh 192.168.1.35 -l root
~~~
ou 
~~~
ssh root@192.168.1.35
~~~

<pre>
The authenticity of host '192.168.1.35 (192.168.1.35)' can't be established.
RSA key fingerprint is SHA256:YDCcZNnyA+IHSdm9pt1PNBvNdKuer4bKHqCrxfq176M.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '192.168.1.35' (RSA) to the list of known hosts.
root@Rockchip:~# 
</pre>

Ou graphiquement sous "Fichiers" (le gestionnaire de fichier par défaut sur une Ubuntu 20.04) via "Autres emplacements", "Connexion à un serveur" (en bas de la fenetre) 
![Capture d’écran de 2024-07-28 00-13-27](https://github.com/user-attachments/assets/861b73e5-78d5-4735-a422-7031207f229d)
(Nom d'utilisateur root)
![Capture d’écran de 2024-07-28 00-18-03](https://github.com/user-attachments/assets/61dcd320-a909-4319-b99e-6d0f3eddd154)



<!--
~~~

~~~
<pre>

</pre>






~~~

~~~
<pre>

</pre>


<details>
 <summary>Résultat de la commande sur ma machine (Cliquez pour déplier!)</summary>
<pre>

</pre>
</details>


-->
