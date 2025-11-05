#!/usr/bin/env bash
# tests/run_all_tests.sh
# Ejecutar todos los tests unitarios

set -u

echo "🚀 Ejecutando Suite de Tests Unitarios"
echo "======================================="
echo ""

TESTS_DIR="$(dirname "$0")"
PASSED=0
FAILED=0

run_test() {
  local test_script=$1
  local test_name=$(basename "$test_script" .sh)
  
  echo "🔹 Ejecutando: $test_name"
  
  if bash "$test_script"; then
    ((PASSED++))
    echo "✅ $test_name PASÓ"
  else
    ((FAILED++))
    echo "❌ $test_name FALLÓ"
  fi
  
  echo ""
}

# Ejecutar todos los tests
run_test "$TESTS_DIR/test_environment.sh"
run_test "$TESTS_DIR/test_variables.sh"
run_test "$TESTS_DIR/test_tora_execution.sh"
run_test "$TESTS_DIR/test_sql_drivers.sh"

# Resumen final
echo "======================================="
echo "📊 Resumen de Tests:"
echo "  ✅ Pasaron: $PASSED"
echo "  ❌ Fallaron: $FAILED"
echo "  📈 Total: $((PASSED + FAILED))"
echo ""

if [ $FAILED -eq 0 ]; then
  echo "🎉 ¡Todos los tests pasaron!"
  exit 0
else
  echo "⚠️ Algunos tests fallaron. Revisa los logs arriba."
  exit 1
fi