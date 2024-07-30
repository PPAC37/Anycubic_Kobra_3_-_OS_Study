
# Anycubic Slicer Beta (0.1.0 et 0.2.0)

## Choses a modifier dans le profile de la Kobra 3 de 

### Pause G-code

M600 (et non M601) mais il faudrait aussi modifier la position de park lors d'une pause. (Et il n'y a pas de mise en température de standby de la buse lors de la pause donc il y a une suintement et il n'y a pas de purge en sorti de la pause)

### Wipe Tower

Multimaterial -> Single extrusion multimaterial parameters -> Extra loading distance : -2 mm

Extruder -> Retraction when switching material -> Length 0 mm
