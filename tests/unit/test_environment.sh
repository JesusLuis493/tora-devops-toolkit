#!/usr/bin/env bash
# tests/test_environment.sh
# Test unitario: Validar que el entorno gráfico funciona

set -u

echo "🧪 Test 1: Validación de Entorno Gráfico"
echo "=========================================="

# Test Case 1: DISPLAY debe existir
if [ -z "${DISPLAY:-}" ]; then
  echo "❌ FAIL: DISPLAY no está definido"
  exit 1
else
  echo "✅ PASS: DISPLAY = $DISPLAY"
fi

# Test Case 2: Xorg debe estar corriendo
if pgrep -x "Xorg" > /dev/null; then
  echo "✅ PASS: Xorg está corriendo"
else
  echo "❌ FAIL: Xorg no está corriendo"
  exit 1
fi

# Test Case 3: TOra debe existir
if command -v tora >/dev/null 2>&1; then
  echo "✅ PASS: TOra encontrado en $(which tora)"
else
  echo "❌ FAIL: TOra no está instalado"
  exit 1
fi

echo ""
echo "✅ Todos los tests de entorno pasaron"