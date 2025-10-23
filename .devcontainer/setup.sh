#!/bin/bash
set -e

echo "===== Configurando entorno de desarrollo TOra ====="

echo "🔹 Actualizando lista de paquetes..."
sudo apt-get update

echo "🔹 Instalando herramientas de desarrollo..."
# Paquetes Qt para Ubuntu más reciente (qt5-default está obsoleto)
sudo apt-get install -y qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools libqt5widgets5

echo "🔹 Instalando dependencias Qt y bases de datos..."
# Paquetes Qt5 para Ubuntu más reciente (qt5-default está obsoleto)
sudo apt-get install -y qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools libqt5widgets5 || echo "Advertencia: Algunos paquetes Qt no están disponibles"
sudo apt-get install -y libqt5sql5 libqt5sql5-mysql libqt5sql5-psql

echo "🔹 Instalando servidor X virtual para pruebas gráficas..."
sudo apt-get install -y xvfb
# Configurar variable DISPLAY para aplicaciones gráficas
echo "export DISPLAY=:99" >> ~/.bashrc

echo "🔹 Configurando TOra simulado para pruebas..."
sudo mkdir -p /usr/local/bin
cat > /tmp/tora << 'EOF'
#!/bin/bash
echo "TOra simulado iniciado"
echo "Simulando interfaz gráfica..."
sleep 1
echo "TOra simulado finalizado"
exit 0
EOF
sudo mv /tmp/tora /usr/local/bin/tora
sudo chmod +x /usr/local/bin/tora

# Versión que falla para pruebas de manejo de errores
cat > /tmp/tora-fail << 'EOF'
#!/bin/bash
echo "TOra simulado con error"
echo "Error: No se puede inicializar la interfaz" >&2
exit 1
EOF
sudo mv /tmp/tora-fail /usr/local/bin/tora-fail
sudo chmod +x /usr/local/bin/tora-fail

echo "🔹 Configurando variables de entorno para Qt..."
echo "export QT_QPA_PLATFORM=offscreen" >> ~/.bashrc
echo "export QT_QPA_PLATFORMTHEME=none" >> ~/.bashrc
echo "export QT_PLUGIN_PATH=/dev/null" >> ~/.bashrc

echo "✅ Entorno de desarrollo TOra configurado correctamente"
echo "   Reinicia la terminal para aplicar todas las variables de entorno"