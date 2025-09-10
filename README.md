# TOra DevOps Toolkit 🛠️

Este proyecto documenta el proceso de blindaje y diagnóstico técnico para ejecutar TOra en Linux Mint, evitando colisiones con librerías GTK/GDK en entornos Qt.

## 🎯 Objetivo

Crear un entorno limpio y replicable para ejecutar TOra, detectando y previniendo errores causados por librerías compartidas en tiempo de ejecución.

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

```bash
chmod +x tora_clean_run.sh
./tora_clean_run.sh
Si TOra falla, se genera automáticamente un log técnico en logs/tora_strace.log.

👨‍💻 Autor
Jisus – Estudiante de Ingeniería en Sistemas en el Instituto Tecnológico de México, Campus Nochistlán. Apasionado por DevOps, accesibilidad y entornos blindados en Linux.

📌 Licencia
Este proyecto puede ser usado y adaptado libremente con fines educativos y técnicos.
