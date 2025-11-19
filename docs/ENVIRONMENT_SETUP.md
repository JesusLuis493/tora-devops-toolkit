# Configuración del Entorno de Testing

## Máquina de Pruebas

### Sistema Operativo
- **Distribución**: Linux Mint [versión]
- **Base**: Ubuntu [versión]
- **Kernel**: [ejecutar: uname -r]
- **Arquitectura**: [ejecutar: uname -m]

### Entorno Gráfico
- **Display Server**: X11 / Wayland
- **Desktop Environment**: Cinnamon / MATE / Xfce
- **Gestor de Ventanas**: [ejecutar: wmctrl -m]

### TOra Instalado
- **Versión**: [ejecutar: tora --version]
- **Ubicación**: [ejecutar: which tora]
- **Método de instalación**: Compilado / Repositorio / AppImage

### Librerías Qt
- **Qt Version**: [ejecutar: qmake --version]
- **Ubicación**: [ejecutar: find /usr -name "libQt5*.so*" 2>/dev/null | head -5]