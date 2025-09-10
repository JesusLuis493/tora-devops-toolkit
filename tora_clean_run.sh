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

# Diagnóstico previo
echo " Librerías GTK detectadas en el sistema:"
ldd /usr/local/bin/tora | grep -Ei 'gtk|gdk|atk|glib'

# Lanzamiento
echo " Ejecutando TOra..."
/usr/local/bin/tora

# Resultado
if [ $? -eq 0 ]; then
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

#lazamiento
echo "Ejecutando TOra..."
/usr/local/bin/tora

#Resultado
if [ $? -eq 0 ]; then
	echo "TOra se ejecuto correctamente.."
else
	echo "TOra fallo, revisa los logs o ejecuta con strace para mas detalles."
  # Diagnóstico automático
  echo "📋 Ejecutando diagnóstico con strace..."
  strace -e trace=openat /usr/local/bin/tora 2>&1 | grep -Ei 'gtk|gdk|atk|glib' | tee tora_strace.log
  echo "📁 Diagnóstico guardado en tora_strace.log"
fi
