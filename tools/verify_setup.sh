#!/bin/bash
[200~echo "=== Verificación de Entorno TOra ==="
echo "Usuario: $(whoami)"
echo "Directorio actual: $(pwd)"

echo -e "\n=== Verificando TOra simulado ==="
if [ -x /usr/local/bin/tora ]; then
  echo "✅ TOra simulado instalado"
  /usr/local/bin/tora
else
  echo "❌ TOra simulado no encontrado"
fi

echo -e "\n=== Verificando Qt y dependencias ==="
dpkg -l | grep -E 'qtbase|libqt5' | head -n5

echo -e "\n=== Variables de entorno ==="
echo "DISPLAY: $DISPLAY"
echo "QT_QPA_PLATFORM: $QT_QPA_PLATFORM"

echo -e "\n=== Verificando ShellCheck ==="
shellcheck --version | head -n2
