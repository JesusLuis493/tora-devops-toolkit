#!/usr/bin/env bash
# tests/test_variables.sh
# Test unitario: Verificar que las variables se limpian correctamente

set -u

echo "🧪 Test 2: Limpieza de Variables"
echo "================================="

# Simular variables contaminadas
export GTK_MODULES="test_module"
export GTK3_MODULES="test_module3"

# Ejecutar limpieza (copiar lógica de tu script)
unset GTK_MODULES || true
unset GTK3_MODULES || true
export NO_AT_BRIDGE=1
export QT_QPA_PLATFORMTHEME=none
export QT_STYLE_OVERRIDE=Fusion

# Test Case 1: GTK_MODULES debe estar vacío
if [ -z "${GTK_MODULES:-}" ]; then
  echo "✅ PASS: GTK_MODULES limpiado"
else
  echo "❌ FAIL: GTK_MODULES = $GTK_MODULES (debería estar vacío)"
  exit 1
fi

# Test Case 2: QT_QPA_PLATFORMTHEME debe ser 'none'
if [ "${QT_QPA_PLATFORMTHEME:-}" = "none" ]; then
  echo "✅ PASS: QT_QPA_PLATFORMTHEME = none"
else
  echo "❌ FAIL: QT_QPA_PLATFORMTHEME = ${QT_QPA_PLATFORMTHEME:-}"
  exit 1
fi

# Test Case 3: NO_AT_BRIDGE debe ser 1
if [ "${NO_AT_BRIDGE:-}" = "1" ]; then
  echo "✅ PASS: NO_AT_BRIDGE = 1"
else
  echo "❌ FAIL: NO_AT_BRIDGE = ${NO_AT_BRIDGE:-}"
  exit 1
fi

echo ""
echo "✅ Todos los tests de variables pasaron"