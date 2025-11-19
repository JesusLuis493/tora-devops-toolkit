#!/usr/bin/env bash
# tools/diagnostics/environment_snapshot.sh
# Captura completa del entorno para documentación

set -uo pipefail

SNAPSHOT_DIR="docs/environment_snapshots"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
SNAPSHOT_FILE="$SNAPSHOT_DIR/snapshot_$TIMESTAMP.txt"

mkdir -p "$SNAPSHOT_DIR"

echo "📸 Capturando snapshot del entorno..."
echo "Guardando en: $SNAPSHOT_FILE"
echo ""

{
  echo "=========================================="
  echo "SNAPSHOT DEL ENTORNO - $(date)"
  echo "=========================================="
  echo ""
  
  echo "### SISTEMA OPERATIVO ###"
  cat /etc/os-release
  echo ""
  uname -a
  echo ""
  
  echo "### ENTORNO GRÁFICO ###"
  echo "DISPLAY: ${DISPLAY:-NO DEFINIDO}"
  echo "WAYLAND_DISPLAY: ${WAYLAND_DISPLAY:-NO DEFINIDO}"
  echo "XDG_SESSION_TYPE: ${XDG_SESSION_TYPE:-NO DEFINIDO}"
  ps aux | grep -E "Xorg|wayland" | grep -v grep
  echo ""
  
  echo "### TORA ###"
  which tora || echo "TOra no encontrado en PATH"
  tora --version 2>&1 || echo "No se pudo obtener versión"
  file "$(which tora 2>/dev/null)" || echo "No se pudo analizar binario"
  echo ""
  
  echo "### LIBRERÍAS QT ###"
  dpkg -l | grep -i "qt5" | head -10
  echo ""
  find /usr/lib -name "libQt5*.so.5" 2>/dev/null | head -5
  echo ""
  
  echo "### LIBRERÍAS GTK/GDK ###"
  dpkg -l | grep -E "gtk|gdk" | grep -E "^ii" | head -10
  echo ""
  
  echo "### DRIVERS SQL ###"
  find /usr -name "*qsql*.so" 2>/dev/null
  echo ""
  
  echo "### VARIABLES DE ENTORNO RELEVANTES ###"
  env | grep -E "QT_|GTK|GDK|LD_|DISPLAY" | sort
  echo ""
  
  echo "### DEPENDENCIAS DE TORA ###"
  if command -v tora >/dev/null 2>&1; then
    ldd "$(which tora)" | grep -E "qt|gtk|gdk" || echo "Sin dependencias Qt/GTK visibles"
  fi
  echo ""
  
  echo "=========================================="
  echo "FIN DEL SNAPSHOT"
  echo "=========================================="
  
} > "$SNAPSHOT_FILE"

echo "✅ Snapshot guardado exitosamente"
echo ""
echo "📄 Contenido del snapshot:"
cat "$SNAPSHOT_FILE"