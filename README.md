# Debian SteamOS Style (by davidboss2117-cyber)

**Nota importante:** Este repositorio está escrito totalmente en **español** porque es mi idioma y así lo quise =D 

Debian SteamOS Style

Guía para convertir una instalación mínima de Debian en una experiencia de juego tipo consola utilizando Gamescope y Steam, con enfoque en consistencia de frametime y control total del sistema.

**Descripción**

Este proyecto muestra cómo configurar un sistema basado en Debian desde cero para ejecutar juegos en un entorno aislado, evitando la carga de entornos de escritorio durante el uso de videojuegos.

El objetivo es ofrecer una alternativa educativa, transparente y completamente personalizable.

El enfoque de esta guía no es aumentar FPS, sino mejorar la estabilidad del frametime. Se incluyen comparaciones entre:

- Entorno de escritorio (por ejemplo KDE)
- Modo consola basado en TTY

**Características**

- Instalación mínima de Debian
- Separación entre modo escritorio y modo gaming
- Ejecución directa desde TTY
- Integración con Gamescope y Steam
- Soporte para AMD y NVIDIA (referencias en la guía)
- Uso de MangoHud para métricas de rendimiento

**Requisitos**

- PC con GPU AMD o NVIDIA
- Instalación limpia de Debian (probado en Debian 13)
- Conexión a internet
- Conocimientos básicos de terminal

**Instalación**

La guía completa se encuentra en el documento pdf **guia-debian-steamos-style.pdf**

1. Instalación mínima de Debian
2. Uso de archivos sh para instalación personalizada del sistema 
3. Compilación de Gamescope
4. Instalación de Steam
5. Configuración de MangoHud y GOverlay
6. Creación del modo consola mediante TTY y GRUB

**Modo consola**

- El sistema permite iniciar directamente en un entorno gaming sin cargar un entorno de escritorio. Esto reduce procesos en segundo plano y mejora la consistencia del frametime.
- El script ("consolemode.sh") lanza Steam dentro de Gamescope en modo Big Picture.


**Compatibilidad**

- AMD: funcionamiento más directo mediante Mesa, probado en una RX 6600xt
- NVIDIA: puede requerir ajustes adicionales dependiendo del driver, probado en una RTX 2050

**Notas adicionales**

- Esta guía está basada en Debian 13 y puede requerir ajustes en el futuro
- Algunos pasos pueden variar según hardware específico
- Se recomienda leer completamente la documentación antes de ejecutar los scripts

**Contribuciones**

Las contribuciones son bienvenidas. Puedes aportar con mejoras, correcciones o adaptaciones a otros sistemas.

**Licencia**

Este proyecto se distribuye con fines educativos y de uso libre.
