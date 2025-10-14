##Plan de inicio

**Este plan esta trasado con el fin de poder sacar a flote este proyecto estableciendo los pasos a seguir**

--

##Objetivos

**Objetivo principal**
- Ejecutar TORA en Linux Mint de manera fluida a través de un script.
**Objetivos espesificos**
- El script deve notificar cuando ocurra una falla en la ejecusion del programa.
- Permitir el uso del programa sin nesesidad de mucha configuracion.
- Se considerara como exitoso cuando se pueda usar tora de manera local. 

--

##Analisis

- **Revicion tecnica**:
  -Colicion entre Qt y GTK/GDK:
TOra está basado en Qt, pero Linux Mint aplica temas GTK por defecto.
Esto provoca que se carguen librerías como ``libgtk-3.so``, ``libatk-bridge-2.0.so``, incluso si están desactivadas.
El crash típico ocurre en ``GdkDisplayManager``, indicando que TOra intenta usar componentes GTK aunque no debería.
  -CArga automatica de plugins conflictivos:
Qt intenta cargar ``libqgtk3.so`` desde ``/usr/lib/qt/plugins/platformthemes/``, incluso si está renombrado como .disabled.
Esto se podria evitarse con variables como:
``export QT_QPA_PLATFORMTHEME=""
export QT_PLUGIN_PATH=""``
  -Entorno grafico contaminado:
Linux Mint aplica temas, íconos y estilos que interfieren con la ejecución de apps Qt puras.
  -Dependencias rotas o mal compiladas:
Si TOra fue compilado manualmente, puede tener enlaces rotos a librerías como ``libpq``, ``libssl``, ``libcrypto``.
  -Falta de permisos o rutas incorrectas:
TOra puede fallar si no tiene permisos de ejecución o si se instala fuera del ``$PATH``.
- **Investigacion**:
- **Benchmarking**:

--

**Lecciones aprendidas:**

- TOra está cargando plugins como libqgtk3.so, libgtk-3.so.0, libatk-bridge-2.0.so.0, incluso si están desactivados (.disabled).

- El entorno Mint aplica temas GTK que contaminan el entorno Qt.

- El crash ocurre antes de que TOra pueda inicializar su GUI, por lo que no hay forma de interceptarlo desde el código fuente sin recompilación.

A continuacion las hitorias de usuario en el documento correspondiemte de este repo.
