#!/bin/bash

echo "Configurando CPU en modo Performance..."
sudo cpupower frequency-set -g performance

echo "Iniciando sesión DBus..."
export XDG_RUNTIME_DIR=/run/user/$(id -u)

echo "Lanzando Gamescope + Steam Big Picture..."
#-e (hace que el foco de las ventanas funcione adecuadamente)
#-f (hace que gamescope ejecute los juegos en pantalla completa)
#-w indica el ancho de la pantalla aquí va el ancho de nuestro monitor / pantalla en este caso 1920 px
#-h indica la altura de nuestro monitor / pantalla en este caso 1080 px
#-r indica la frecuencia de actualización de la pantalla en este caso 144 hz, se recomienda poner el máximo que alcanza tu monitor / pantalla
# steam -bigpicture indica abrir steam en modo big picture 
dbus-run-session gamescope -e -f -w 1920 -h 1080 -r 144 -- steam -bigpicture

echo "Restaurando perfil de energía..."
sudo cpupower frequency-set -g schedutil

echo "Sesión de juego terminada."

