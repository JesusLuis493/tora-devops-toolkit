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