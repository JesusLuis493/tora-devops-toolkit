#!/bin/bash

echo " Ejecutando diagnóstico técnico con strace..."
echo " Detectando librerías GTK/GDK/ATK que se cargarían al ejecutar TOra..."

# Crear carpeta de logs si no existe
mkdir -p logs

# Ejecutar strace con filtro y guardar en log
strace -e trace=openat /usr/local/bin/tora 2>&1 | grep -Ei 'gtk|gdk|atk|glib' | tee logs/tora_strace.log

echo " Diagnóstico completado. Log guardado en logs/tora_strace.log"
