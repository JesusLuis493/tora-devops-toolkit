#!/bin/bash

echo "🔧 Iniciando entorno limpio para TOra..."

# Validación de entorno gráfico
if [ -z "$DISPLAY" ]; then
  echo "❌ No estás en sesión gráfica. Aborta."
  exit 1
fi

# Limpieza de variables conflictivas
unset GTK_MODULES
unset GTK3_MODULES
export NO_AT_BRIDGE=1
export QT_QPA_PLATFORMTHEME=none
export QT_STYLE_OVERRIDE=Fusion
export QT_PLUGIN_PATH=/dev/null
export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libQt5Widgets.so.5
export QT_SQL_DRIVERS_PATH=/dev/null

# Diagnóstico previo
echo " Librerías GTK detectadas en el sistema:"
ldd /usr/local/bin/tora | grep -Ei 'gtk|gdk|atk|glib'

# Lanzamiento
echo " Ejecutando TOra..."
if /usr/local/bin/tora; then
  echo " TOra se ejecutó correctamente."
else
  echo " TOra falló. Revisa los logs o ejecuta con strace para más detalles."
fi
#!/bin/bash
echo "Inicializando entorno limpip para TOra..."
#validacion del entorno grafico
if [ -z "$DISPLAY" ]; then
	echo "no estas en sesion grafica, abortar"
	exit 1
fi

#Limpieza de variables conflictivas
unset GTK_MODULES
unset GTK3_MODULES
export NO_AT_BRIDGE=1
export QT_QPA_PLATFORMTHEME=none
export QT_STYLE_OVERRIDE=Fusion
export QT_PLUGIN_PATH=/dev/null
export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libQt5Widgets.so.5

# Configuración de drivers SQL
if [ "$ENABLE_SQL_DRIVERS" != "true" ]; then
	echo "Ejecutando TOra sin drivers SQL adicionales..."
	export QT_SQL_DRIVERS_PATH=/dev/null
else
	echo "Ejecutando TOra con funcionalidad SQL completa..."
	# Aquí iría la ruta real de los drivers si los tienes
	# export QT_SQL_DRIVERS_PATH=/usr/lib/qt5/plugins/sqldrivers
fi

#lazamiento
echo "Ejecutando TOra..."
if /usr/local/bin/tora; then
	echo "TOra se ejecuto correctamente.."
else
	echo "TOra fallo, revisa los logs o ejecuta con strace para mas detalles."
  # Diagnóstico automático
  echo "📋 Ejecutando diagnóstico con strace..."
  strace -e trace=openat /usr/local/bin/tora 2>&1 | grep -Ei 'gtk|gdk|atk|glib' | tee tora_strace.log
  echo "📁 Diagnóstico guardado en tora_strace.log"
fi
