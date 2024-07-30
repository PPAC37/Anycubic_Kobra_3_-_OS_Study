
# Anycubic Slicer Beta (0.1.0 et 0.2.0)

## Choses a modifier dans le profile de la Kobra 3 de 

### Pause G-code

M600 (et non M601) mais il faudrait aussi modifier la position de park lors d'une pause. (Et il n'y a pas de mise en température de standby de la buse lors de la pause donc il y a une suintement et il n'y a pas de purge en sorti de la pause)

### Wipe Tower

Multimaterial -> Single extrusion multimaterial parameters -> Extra loading distance : -2 mm

Extruder -> Retraction when switching material -> Length 0 mm


---


## VRAC



[https://discord.com/channels/966957505580236851/1230084715185442857/1266220582794694758](https://discord.com/channels/966957505580236851/1230084715185442857/1266220582794694758)


It's better that way. All these tears I've shed need a grand entrance lol
￼
1
[04:32]
This specific gcode is the issue. This is just after a filament change right after it gets to the tower. It spends a brief moment extruding 1mm.  I scoured the internet and came across a post for filament changes on a Neptune 4 Pro and found the settings needed to change the extra
￼
[04:32]
Under your printer settings in both extruder and multimaterial, edit it to this
￼Screenshot_2024-07-25_212626.webp
Single extrusion multimaterial parameters
Filament parking position 1 mm
Multimaterial -> Single extrusion multimaterial parameters -> Extra loading distance : -2 mm
￼Screenshot_2024-07-25_212639.webp
Extruder -> Retraction when switching material -> Length 0 mm

[04:33]
The code then becomes this, with a retraction of 1mm at that spot versus an extrusion
￼
￼
Comar2557 — Aujourd’hui à 04:36
Little before and after. Ole blobby made it 5 or so swaps in before I stopped it from the scraping. Mr. Flatpack was 23(?) swaps and smooth as butter
￼

---


https://forum.makeronline.com/topic/What%20are%20your%20experiences%20with%20step%20loss-1350.html

Hi! 
Sorry to see this.
I speak without really knowing. As I have not yet made a big print like you with Anycubic Slicer Beta 0.2.0.

But, if you have big smudges that accumulate on the wipe tower, then it seems that on the Anycubic discord a user has proposed two modifications to make in the profile of the Kobra 3 under Anycubic Slicer Beta, to prevent the smudges that accumulate from causing the wipe tower to come loose when the nozzle/print head hits it.

Multimaterial -> Single extrusion multimaterial parameters -> Extra loading distance : -2 mm
Extruder -> Retraction when switching material -> Length 0 mm

Original message on Anycubic Discord
https://discord.com/channels/966957505580236851/1230084715185442857/1266221607161036822


---





