# Notas Técnicas de TORA DevOps

Este documento contiene hallazgos técnicos, soluciones a problemas encontrados y documentación detallada sobre aspectos específicos del proyecto TORA DevOps.

## Índice
1. [Integración con Travis CI](#integración-con-travis-ci)
2. [Interacciones entre Qt y GTK](#interacciones-entre-qt-y-gtk)
3. [Falsos Positivos en Seguridad](#falsos-positivos-en-seguridad)
4. [Integracion de suit de testing en un entorno real](#Integracion-de-suit-de-testing-en-un-entorno-real)

---

## Integración con Travis CI

### Configuración Inicial
La integración con Travis CI se realizó mediante un archivo `.travis.yml` diseñado para simular el entorno Linux Mint (tambien ubuntu) y ejecutar pruebas sobre el script `tora_clean_run.sh`.

### Falsos Positivos en Escaneo de Seguridad
**Fecha de identificación**: 2025-10-17

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
```
// Travis no acepta soluciones granulares haci que se modifico para los falsos positivos en general //

#### Implicaciones para el Proyecto
Este hallazgo confirma indirectamente nuestra teoría sobre la interacción entre los componentes Qt SQL y los plugins GTK, ya que las alertas se activaron específicamente en las líneas relacionadas con la instalación de `libqt5sql5`.

### Falsos Positivos en Escaneo de Seguridad
**Fecha de identificación**: 2025-10-21

Durante el escaneo de travis se detecto un un faslo positivo atribuido a una cadena de alta entropia probeniente del comando `` #!/bin/bash``:

#### Instancias Detectadas
1. Línea de comando: ``#!/bin/bash``

#### Análisis
Esta cadena en particular genera sospechas, dado que su reporte es valido y no afecta se considera como unn falso positivo, pero es de suma rareza el hecho de su aparicion una vez implementada la linea ``filter secrets: false``.

#### Solución Implementada
Aun sin identificar.

---

## Interacciones entre Qt y GTK

### Hipótesis de Trabajo
**Fecha de formulación**: 2025-10-15

Nuestra investigación indica que las bibliotecas Qt SQL (`libqt5sql5` y variantes) desencadenan una carga de plugins GTK/GDK que contaminan el entorno gráfico necesario para la ejecución limpia de TOra.

### Cadena Causal Identificada
```
libqt5sql5 → carga plugins Qt → carga adaptadores GTK/GDK → contamina entorno → TOra falla
```
### Confirmación de Relevancia de la Arquitectura AMD64
**Fecha de hallazgo**: 2023-10-17

Un patrón consistente en los falsos positivos de seguridad ha señalado específicamente la línea:
`Unpacking libqt5sql5-mysql:amd64 (5.12.8+dfsg-0ubuntu2.1) ...`

Este hallazgo es significativo porque:
1. Confirma la conexión con componentes Qt SQL específicos
2. Identifica la arquitectura AMD64 como parte del problema
3. Valida investigaciones previas que sugerían una relación entre los problemas de TOra y la arquitectura amd64

#### Implicaciones para la solución
Este hallazgo sugiere que nuestra solución debe considerar específicamente las interacciones entre:
- Los drivers SQL de Qt
- Las peculiaridades de implementación en arquitecturas AMD64
- Posibles diferencias en la carga de plugins entre arquitecturas

### Experimentos Agregados Recientemente
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

*Última actualización: 2025-11-05

---

## Integracion de suit de testing en un entorno real

### Notas pretesteo
Para rasegurar el funcionamiento optimo del script se a incorporado una suit de test unitarios para llevar acabo en un entorno real (no mock como en travis), la cual incluye:

``test_environment.sh"
test_variables.sh"
test_tora_execution.sh"
test_sql_drivers.sh"``

### Adiciones relevantes
Como parte de la fase de testeo se han incorporado una serie de archivos markdown para poder llevar de manera optima el registro de la ejecusion, se cuenta con 4 markdowns los cuales monitorean el entorno antes y despues de los test, los posibles ecenarios junto con planes de accion entre otros.

Consultar en la carpeta [technical](./docs/technical).

## Resultados esperados
En el mejor de los casos se espera que el script principal cumpla con su funcion o que por lo menos brinde de informacion nesesaria para poder determinar como poder abordar el problema de una manera optima.
