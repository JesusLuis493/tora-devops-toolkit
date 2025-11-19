#!/usr/bin/env bash
# tests/test_tora_execution.sh
# Test unitario: Ejecutar TOra REAL y verificar resultado

set -u

echo "🧪 Test 3: Ejecución Real de TOra"
echo "=================================="

# Configurar entorno (como en tu script)
unset GTK_MODULES || true
unset GTK3_MODULES || true
export NO_AT_BRIDGE=1
export QT_QPA_PLATFORMTHEME=none
export QT_STYLE_OVERRIDE=Fusion
export QT_PLUGIN_PATH=/dev/null
export QT_SQL_DRIVERS_PATH=/dev/null

# Test Case 1: TOra debe ejecutarse sin errores
echo "Intentando ejecutar TOra..."

# Timeout de 5 segundos (para que no se quede colgado)
timeout 5s /usr/local/bin/tora &
TORA_PID=$!

# Esperar 2 segundos
sleep 2

# Verificar si el proceso sigue corriendo
if ps -p $TORA_PID > /dev/null 2>&1; then
  echo "✅ PASS: TOra se ejecutó y está corriendo (PID: $TORA_PID)"
  
  # Capturar logs de stderr
  echo ""
  echo "📋 Logs de TOra (stderr):"
  # TOra debería estar generando logs si hay problemas
  
  # Matar el proceso
  kill $TORA_PID 2>/dev/null || true
  
  exit 0
else
  echo "❌ FAIL: TOra terminó abruptamente o falló al iniciar"
  
  # Intentar capturar error
  echo ""
  echo "📋 Intentando capturar error con strace..."
  timeout 3s strace -e trace=open,openat /usr/local/bin/tora 2>&1 | \
    grep -E "gtk|gdk|ENOENT|error" | head -20
  
  exit 1
fi