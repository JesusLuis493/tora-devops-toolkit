# TOra DevOps Toolkit 🛠️
[![Build Status](https://travis-ci.com/github/JesusLuis493/tora-devops-toolkit.svg?branch=main)](https://travis-ci.com/github/JesusLuis493/tora-devops-toolkit)

Este proyecto documenta el proceso de blindaje y diagnóstico técnico para ejecutar TOra en Linux Mint, evitando colisiones con librerías GTK/GDK en entornos Qt.

## 🎯 Objetivo

Crear un entorno limpio y replicable para ejecutar TOra, detectando y previniendo errores causados por librerías compartidas en tiempo de ejecución.

## 🧠 Fallos no documentados en GitHub: diagnóstico original

Hasta la fecha, no se han encontrado repositorios en GitHub que documenten los fallos de TOra en Linux Mint. Este proyecto busca llenar ese vacío, ofreciendo scripts, diagnósticos y soluciones replicables para entornos contaminados por GTK en sistemas Qt.

Referencias:
- [TOra Developer Thread – SourceForge](https://sourceforge.net/p/tora/mailman/tora-develop/thread/9eb44e5c50dcd7f5ca3c9d2bb4e06699%40office.scribus.info/)
- [Linux Mint Community – TOra](https://community.linuxmint.com/software/view/tora)


## 📁 Scripts incluidos

- `tora_clean_run.sh`: Ejecuta TOra en un entorno blindado, desactivando módulos conflictivos.
- `tora_strace_diag.sh`: Diagnóstico técnico con `strace` para detectar librerías GTK/GDK cargadas dinámicamente.
- `toolkit/qt_env_template.sh`: Plantilla para blindar otras apps Qt en Linux Mint.

## 🧪 Requisitos

- Linux Mint 21+
- Qt5 instalado
- TOra compilado e instalado en `/usr/local/bin/tora`
- Permisos de ejecución para los scripts

## 🚀 Uso

bash
``chmod +x tora_clean_run.sh
./tora_clean_run.sh``
- Si TOra falla, se genera automáticamente un log técnico en ``logs/tora_strace.log``.

## 🧪 Diagnóstico técnico con strace

Este script permite analizar qué librerías se cargarían al ejecutar TOra, sin necesidad de lanzar el binario. Ideal para entornos rotos o pruebas previas.

bash
``chmod +x tora_strace_diag.sh``

``./tora_strace_diag.sh``


👨‍💻 Autor
Jisus – Estudiante de Ingeniería en Sistemas en el Instituto Tecnológico de México, Campus Nochistlán. Apasionado por DevOps, accesibilidad y entornos blindados en Linux.

📌 Licencia
Este proyecto puede ser usado y adaptado libremente con fines educativos y técnicos.
