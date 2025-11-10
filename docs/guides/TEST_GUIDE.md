### Guia para testing

## Paso 1:

antes de siquiera pensar en clonar el repositorio en nuestra maquina local, lo primordial es documenta de manera correcta el entorno (nuestra maquina) para poder tener los mas datos posibles en caso de algun problema.

--

## Paso 2:

El siguente paso es ejecutar ``environment_snapshot.sh`` con el fin de documentar el estado actual antes de llevar acabo los test unitarios.

--

## Paso 3:

Como ultimo paso para preparar la ejecusion de los test, lo mejor es revisar el documento [PRE_TESTING_CHECKLIST.md](docs/PRE_TESTING_CHECKLIST.md) para asegurar que todo este listo y dentro de nuestro control en la medida de lo psible.

--

## Paso 4:

Documentar los resultados en el documento [TEST_RESULTS_TEMPLATES.md](docs/TEST_RESULTS_TEMPLATES.md) y despues ejecutar los tests unitarios.

--

## Paso 5:

Captura los logs y realizar el analisis de:
- que funsiono?
- Que no funciono?
- Observaciones importantes
y finalmente llegar a las conclusiones, idealmente adjuntar las evidencias del testeo como screenshots, logs o videos (opcional). con el fin de mantener una buena documentacion.
Una vez realizados estos pasos para el testeo, consultar el documento [TESTING_SCENARIOS.md](docs/TESTING_SCENARIOS.md)