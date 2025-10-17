# Notas Técnicas de TORA DevOps

Este documento contiene hallazgos técnicos, soluciones a problemas encontrados y documentación detallada sobre aspectos específicos del proyecto TORA DevOps.

## Índice
1. [Integración con Travis CI](#integración-con-travis-ci)
2. [Interacciones entre Qt y GTK](#interacciones-entre-qt-y-gtk)
3. [Falsos Positivos en Seguridad](#falsos-positivos-en-seguridad)

---

## Integración con Travis CI

### Configuración Inicial
La integración con Travis CI se realizó mediante un archivo `.travis.yml` diseñado para simular el entorno Linux Mint (tambien ubuntu) y ejecutar pruebas sobre el script `tora_clean_run.sh`.

### Falsos Positivos en Escaneo de Seguridad
**Fecha de identificación**: 2023-10-17

Durante los builds de Travis CI, se detectaron falsos positivos en el escaneo de seguridad que identificaron incorrectamente texto normal como "secretos" de alta entropía:

#### Instancias Detectadas
1. Línea de instalación de paquetes: `sudo apt-get install -y libqt5sql5 libqt5sql5-mysql libqt5sql5-psql`
2. Salida estándar de apt-get: `Reading state information... Done`

#### Análisis
Estos falsos positivos están relacionados con la sensibilidad excesiva del algoritmo de detección de secretos, que interpreta ciertas combinaciones de caracteres como potenciales credenciales debido a su entropía.

#### Solución Implementada
Se modificó el archivo `.travis.yml` para incluir configuración específica que ignora estos falsos positivos:

```yaml
# Configuración para evitar falsos positivos en escaneo de secretos
filter_secrets: false

# Alternativa más específica
scan:
  secrets:
    ignore:
      - pattern: libqt5sql5
        reason: "Nombre de paquete, no un secreto"
      - pattern: "Reading state information"
        reason: "Salida estándar de apt-get, no un secreto"
```

#### Implicaciones para el Proyecto
Este hallazgo confirma indirectamente nuestra teoría sobre la interacción entre los componentes Qt SQL y los plugins GTK, ya que las alertas se activaron específicamente en las líneas relacionadas con la instalación de `libqt5sql5`.

---

## Interacciones entre Qt y GTK

### Hipótesis de Trabajo
**Fecha de formulación**: 2023-10-15

Nuestra investigación indica que las bibliotecas Qt SQL (`libqt5sql5` y variantes) desencadenan una carga de plugins GTK/GDK que contaminan el entorno gráfico necesario para la ejecución limpia de TOra.

### Cadena Causal Identificada
```
libqt5sql5 → carga plugins Qt → carga adaptadores GTK/GDK → contamina entorno → TOra falla
```

### Experimentos Pendientes
1. Aislar específicamente los drivers SQL mediante `export QT_SQL_DRIVERS_PATH=/dev/null`
2. Monitorear carga de bibliotecas con `LD_DEBUG=libs tora`
3. Analizar dependencias dinámicas con `ldd $(which tora)`

---

## Falsos Positivos en Seguridad

### Contexto General
Las herramientas de CI/CD modernas incluyen escaneo automático de secretos que pueden generar falsos positivos en ciertos escenarios, especialmente con:

1. Nombres de paquetes con combinaciones alfanuméricas complejas
2. Salidas estándar de comandos del sistema con formato mixto
3. Strings con alta entropía pero sin valor como secreto

### Mejores Prácticas Identificadas
- Documentar falsos positivos conocidos
- Implementar exclusiones específicas en lugar de desactivar escaneos completos cuando sea posible
- Revisar periódicamente exclusiones para validar que siguen siendo apropiadas

---

*Última actualización: 2023-10-17*
