# Checklist de Preparación para Testing

## ✅ Antes de Empezar

### 1. Respaldo
- [ ] Hacer backup de configuración actual de TOra
- [ ] Documentar configuración funcional (si existe)
- [ ] Crear punto de restauración del sistema (opcional)

### 2. Herramientas Necesarias
```bash
# Instalar herramientas de diagnóstico
sudo apt-get update
sudo apt-get install -y strace lsof ltrace shellcheck

# Verificar instalación
strace --version
lsof -v
shellcheck --version
```

### 3. Repositorio Local

- [ ] Clonar repositorio en máquina de pruebas
- [ ] Verificar que estás en la rama correcta (master)
- [ ] Hacer pull de últimos cambios

```bash
cd ~
git clone https://github.com/JesusLuis493/tora-devops-toolkit.git
cd tora-devops-toolkit
git status
```

### 4. Permisos

- [ ] Dar permisos de ejecución a scripts

```bash
chmod +x src/scripts/*.sh
chmod +x tools/diagnostics/*.sh
chmod +x tests/*.sh
```

### 5. Entorno Limpio

- [ ] Cerrar todas las aplicaciones no esenciales
- [ ] Asegurar que TOra NO esté corriendo

```bash
killall tora 2>/dev/null || true
ps aux | grep tora | grep -v grep
```