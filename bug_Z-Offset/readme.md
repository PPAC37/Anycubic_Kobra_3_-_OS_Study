
<!--
[https://discord.com/channels/966957505580236851/1262727644571762751](https://discord.com/channels/966957505580236851/1262727644571762751)

---

https://discord.com/channels/966957505580236851/1230084715185442857/1262727644571762751

> for others: do NOT adjust your z offset manually, until they make some sort of firmware change for it
>
> https://www.reddit.com/r/AnycubicOfficial/comments/1e4gmmo/comment/ldfluil/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button

---

https://www.reddit.com/r/AnycubicOfficial/comments/1e4gmmo/comment/ldfluil/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button

> 
> First print after factory reset was great.
> 
> One thing I noticed - when i started the print the z offset was 0, then after the printer did the little line at the bottom right corner of the bed the z offset increased to 0.11.
> 
> Looks like the z offset is automatically calculated at that point, and if you set it manually you'll mess it all up. Probably also need to make sure that corner is clean always for the calibration if that's what is happening


---


---
https://discord.com/channels/966957505580236851/1262727644571762751/1264295145784737933


Thank you for making this message. 

Because I had previously manually modified the Z-Offset and I had to manually modify it at the start of each print because it was almost never good. 

But, since I reset the printer and I no longer modify the Z-Offset manually, then, at the start of printing, after the nose of the nozzle passed the step on the "Heatbed Nozzle Wiper", now there are several probes in the center of the plate (probe step skipped before I reset on firmware V2.3.2.3_1.1.6_1.1.6_release) 

and since the reset and that I no longer manually modify the Z-Offset, the automatically determined Z-Offset is much better and consistent. ( Now around 0.07 - 0.11. Whereas before the reset I was for the Z-Offset with values ​​between 0.60 and 0.75 which I almost always had to adjust at the start of printing)

---

~~~
grep -F version /userdata/app/gk/version_log.txt
~~~
<pre>
root@Rockchip:~# grep -F version /userdata/app/gk/version_log.txt
version: 2.3.2.3
</pre>

---

TODO 

~~~
cat /userdata/app/gk/printer_mutable.cfg
~~~
<pre>

</pre>

---


~~~
grep -F offset /userdata/app/gk/printer_mutable.cfg
~~~
Avant que l'on ai modifié manuellement le Z-Offset via l'écran de controle :
<pre>
root@Rockchip:~# grep -F offset /userdata/app/gk/printer_mutable.cfg
		"auto_zoffset_on_off": "1"
		"z_offset": "-0.0750"
root@Rockchip:~# 
</pre>

Si on a modifié le 

<pre>
root@Rockchip:~# grep -F offset /userdata/app/gk/printer_mutable.cfg
		"auto_zoffset_on_off": "0"
		"z_offset": "-0.7275"
root@Rockchip:~# 
</pre>

![k3screen_1722329091](https://github.com/user-attachments/assets/79260cb7-2cf0-4b7a-a176-8552e27925fd)


------

-->

## Bidouille pour réinitialiser le Z-Offset sans avoir à faire un "reset"

Pour réactiver la détermination précise du Z-Offset  
(plusieurs palpages au centre du plateau, après passage sur le système de nettoyage du nez de buse à l'arrière du plateau)

Connecté en root sur la Kobra 3  
(  
via `adb connect <ip_Kobra3>` puis `adb shell` voir [https://github.com/Bushmills/Anycubic-Kobra-3-rooted/wiki/Gaining-access-to-the-printer](https://github.com/Bushmills/Anycubic-Kobra-3-rooted/wiki/Gaining-access-to-the-printer) -> [https://github.com/Bushmills/Anycubic-Kobra-3-rooted/wiki/shell-to-Kobra-3](https://github.com/Bushmills/Anycubic-Kobra-3-rooted/wiki/shell-to-Kobra-3)    
ou, si vous avez configuré le serveur ssh, via un `ssh root@<ip_Kobra3>`  
)

Adaptation de la méthode décrite sur  
[https://github.com/Bushmills/Anycubic-Kobra-3-rooted/wiki/shell-to-Kobra-3](https://github.com/Bushmills/Anycubic-Kobra-3-rooted/wiki/shell-to-Kobra-3)  
pour une distribution Linux Ubuntu 20.04.

Ici `192.168.1.35` est l'adresse IP affectée par le serveur DHCP par ma box internet a ma "Kobra 3" sur mon réseau local. (il vous faudra adapter les commande suivante, et éventuellement faire une règle d'association d'un IP fixe pour l'adresse MAC de votre "Kobra 3")

![k3screen_1722126141](https://github.com/user-attachments/assets/3bd65eaa-222b-46f4-b652-108e9a5f723c)


Connecter `adb` a votre "Kobra 3"
~~~
adb connect 192.168.1.35
~~~
Résultat de la commande sur ma machine ici une Ubuntu 20.04  
// Si le "service"/"daemon" adb n'était pas encore démmarré
<pre>
q6@q6-pc:~$ adb connect 192.168.1.35
* daemon not running; starting now at tcp:5037
* daemon started successfully
connected to 192.168.1.35:5555
q6@q6-pc:~$
</pre>
// Si le service adb etait déja démmaré et la connexion déja effectuée
<pre>
q6@q6-pc:~$ adb connect 192.168.1.35
already connected to 192.168.1.35:5555
q6@q6-pc:~$ 
</pre>


Après connexion réussie de `adb` a votre "Kobra 3",  
ouvrir un shell via la commande `adb shell`
~~~
adb shell
~~~
Résultat de la commande sur ma machine
<pre>
q6@q6-pc:~$ adb shell
root@Rockchip:/# 
</pre>


Vérifier la version du firmware
~~~
grep -F version /userdata/app/gk/version_log.txt
~~~
<pre>
root@Rockchip:~# grep -F version /userdata/app/gk/version_log.txt
version: 2.3.2.3
</pre>


De là, il s'agit de modifier le fichier  `/userdata/app/gk/printer_mutable.cfg`  
pour y mettre `"auto_zoffset_on_off" : ` a `"1"`  
et mettre une valeur cohérente pour `"z_offset": ` comme par exemple `"-0.0750"`.


La commande suivante créée un nouveau fichier `/userdata/app/gk/printer_mutable.cfg.new` avec les modifications précédament mentionnées, depuis le fichier `/userdata/app/gk/printer_mutable.cfg` actuelle.
~~~
cat /userdata/app/gk/printer_mutable.cfg | sed "s/\"auto_zoffset_on_off\": \"0\"/\"auto_zoffset_on_off\": \"1\"/" | sed "s/\"z_offset\": \".*\"/\"z_offset\": \"-0.0750\"/" > /userdata/app/gk/printer_mutable.cfg.new
~~~

Pour vérifier les modifications avant d'utiliser le nouveau fichier `/userdata/app/gk/printer_mutable.cfg.new` a la place du `/userdata/app/gk/printer_mutable.cfg` actuelle.  

(  

malheureusement, il n'y a pas la commande `diff` sur l'OS de la Kobra 3, il faut donc faire l'équivalent soi-même ...   
là, je regarde juste les lignes qui continnent le texte `offset`

~~~
grep -F offset /userdata/app/gk/printer_mutable.cfg
grep -F offset /userdata/app/gk/printer_mutable.cfg.new 

~~~
<pre>
root@Rockchip:~# grep -F offset /userdata/app/gk/printer_mutable.cfg
		"auto_zoffset_on_off": "0"
		"z_offset": "-0.7275"
root@Rockchip:~# grep -F offset /userdata/app/gk/printer_mutable.cfg.new 
		"auto_zoffset_on_off": "1"
		"z_offset": "-0.0750"
root@Rockchip:~# 
</pre>
)

Si tout semble OK, exécuter les trois commandes suivantes,  
pour, déplacer printer_mutable.cfg en le renommant avec un timestape de manière a le sauvegarder (si jamais),  
~~~
mv /userdata/app/gk/printer_mutable.cfg /userdata/app/gk/printer_mutable_`date "+%Y%m%d%H%M%S"`.cfg

~~~
puis, mettre le nouveau printer_mutable.cfg corrigé a la place,  
~~~
mv /userdata/app/gk/printer_mutable.cfg.new /userdata/app/gk/printer_mutable.cfg

~~~
et enfin, faire un reboot.  
~~~
reboot

~~~

Et là cela semble bon.   
Il y a bien plusieur plapages au centre en début d'impression et on a un Z-Offset automatiquement déterminé affiché de 0.07 a 0.11

![printing_k3screen_1722332357](https://github.com/user-attachments/assets/f1090cf6-e113-4116-984b-66c0a2dc4eb6)
![printing_settings_k3screen_1722331906](https://github.com/user-attachments/assets/f79c72c5-6542-4001-8899-5033873bc3ca)
![printing_settings_ZOffset_after_reset_k3screen_1722328827](https://github.com/user-attachments/assets/c0c48776-674c-407b-8363-8a9381b8017f)


Mais bien fair "Cancel" pour ne pas risquer de le modifier

---


  <!--
  
<pre>

</pre>

---

~~~

~~~
<pre>

</pre>

---

~~~

~~~
<pre>

</pre>

---

~~~

~~~
<pre>

</pre>

---

~~~

~~~
<pre>

</pre>

---

~~~

~~~
<pre>

</pre>

---

~~~

~~~
<pre>

</pre>

---

~~~

~~~
<pre>

</pre>

---

~~~

~~~
<pre>

</pre>

---

~~~

~~~
<pre>

</pre>


-->














