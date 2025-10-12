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

- Revicion tecnica:
- Investigacion:
- Benchmarking:
**Lecciones aprendidas:**
- TOra está cargando plugins como libqgtk3.so, libgtk-3.so.0, libatk-bridge-2.0.so.0, incluso si están desactivados (.disabled).

- El entorno Mint aplica temas GTK que contaminan el entorno Qt.

- El crash ocurre antes de que TOra pueda inicializar su GUI, por lo que no hay forma de interceptarlo desde el código fuente sin recompilación.

A continuacion las hitorias de usuario en el documento correspondiemte de este repo.
