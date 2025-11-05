#!/usr/bin/env bash
# tests/test_sql_drivers.sh
# Test unitario: Comparar comportamiento con/sin drivers SQL

set -u

echo "🧪 Test 4: Impacto de Drivers SQL"
echo "=================================="

# Función para ejecutar TOra con configuración específica
test_tora_with_config() {
  local config_name=$1
  local sql_path=$2
  
  echo ""
  echo "Probando configuración: $config_name"
  echo "QT_SQL_DRIVERS_PATH=$sql_path"
  
  export QT_SQL_DRIVERS_PATH="$sql_path"
  
  # Ejecutar con timeout
  timeout 3s /usr/local/bin/tora 2>&1 | head -5
  local exit_code=$?
  
  if [ $exit_code -eq 124 ]; then
    echo "✅ TOra corrió (timeout alcanzado - normal)"
    return 0
  elif [ $exit_code -eq 0 ]; then
    echo "✅ TOra terminó normalmente"
    return 0
  else
    echo "❌ TOra falló (exit code: $exit_code)"
    return 1
  fi
}

# Test Case 1: Sin drivers SQL
test_tora_with_config "SIN drivers SQL" "/dev/null"
RESULT_WITHOUT=$?

# Test Case 2: Con drivers SQL
test_tora_with_config "CON drivers SQL" ""
RESULT_WITH=$?

# Comparar resultados
echo ""
echo "📊 Resumen:"
echo "  Sin drivers SQL: $([ $RESULT_WITHOUT -eq 0 ] && echo '✅ OK' || echo '❌ FAIL')"
echo "  Con drivers SQL: $([ $RESULT_WITH -eq 0 ] && echo '✅ OK' || echo '❌ FAIL')"

if [ $RESULT_WITHOUT -eq 0 ] && [ $RESULT_WITH -ne 0 ]; then
  echo ""
  echo "💡 Conclusión: Los drivers SQL causan el problema"
  exit 0
elif [ $RESULT_WITHOUT -ne 0 ] && [ $RESULT_WITH -eq 0 ]; then
  echo ""
  echo "💡 Conclusión: TOra necesita los drivers SQL"
  exit 0
else
  echo ""
  echo "⚠️ Conclusión: Comportamiento inconsistente, revisar logs"
  exit 1
fi