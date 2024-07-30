
https://github.com/Bushmills/Anycubic-Kobra-3-rooted/discussions/2#discussioncomment-10119012

> * The ACE appears to be a USB device.
>   * as witnessed by executing  `ls /dev/serial/by_id/*`:  
>   /dev/serial/by-id/usb-ANYCUBIC_ACE_0-if00 -> ../../ttyACM0
> * indeed is the device node created by udev when ACE is powered, as  /dev/ttyACM0
>
> 
> ~~~
> netstat
> ~~~
>  on Kobra3 shows:
> 
>
<pre>
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address Foreign Address State 
tcp 0 0 127.0.0.1:5037 0.0.0.0:* LISTEN 
tcp 0 0 0.0.0.0:5555 0.0.0.0:* LISTEN ### adb over tcp listener 
tcp 0 0 127.0.0.1:3893 0.0.0.0:* LISTEN 
tcp 0 0 0.0.0.0:18086 0.0.0.0:* LISTEN 
tcp 0 0 192.168.1.100:55006 3.20.176.66:8883 ESTABLISHED ### connection to Anycubic cloud per MQTT 
tcp 0 0 127.0.0.1:18086 127.0.0.1:35650 ESTABLISHED 
tcp 0 0 127.0.0.1:35664 127.0.0.1:18086 ESTABLISHED 
tcp 0 101 192.168.1.100:5555 192.168.1.6:52642 ESTABLISHED ### my current shell on K3 
tcp 0 0 127.0.0.1:35650 127.0.0.1:18086 ESTABLISHED 
tcp 0 0 127.0.0.1:18086 127.0.0.1:35664 ESTABLISHED
</pre>
> 
> That is, Kobra only listens to the already mentioned port 5555 (adb over tcp), and maintains a connection with the cloud @ Amazon which may be a connection to a remote MQTT broker.
> 
> Most notable processes which I can spot in the output of ps are those relating to "gk..." stuff, which appear to be printer and peripherals control software. lib, api, cam are the largest files of those, each one close or beyond 8 MB, found in /userdata/app/gk.
>
> The only "Copyright (C)' I can find in any of those files is: "Copyright (C) 1991-2024 The libjpeg-turbo Project and many others".
>
> No relevant "GPL" matches, two identical "GNU" matches: "GCC: (GNU) 3.3.2 20031005 (Debian prerelease)".
>
> Search for "Anycubic" finds references to Kobra 2 Pro, apart from matching Kobra 3 and ACM.
>
> And indeed is port 8883 above used to connect to an MQTT broker, as these found lines indicate:
> 
> * mqttBroker : ssl://mqtt-test.anycubic.com:8883
> * mqttBroker : ssl://mqtt.anycubic.com:8883
> * mqttBroker : ssl://mqtt-universe-testnew.anycubic.com:8883
> * mqttBroker : ssl://mqtt-universe.anycubic.com:8883
> 
> I could hook up PulseView on the USB lines and run the protocol analyzer with it, maybe the transmitted and received data gives any clue about the nature and contents of communication.

