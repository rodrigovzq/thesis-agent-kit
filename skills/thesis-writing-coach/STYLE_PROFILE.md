# Perfil de escritura técnica y académica en español

> **Este perfil es genérico.** Describe un corpus de trabajos universitarios y documentos técnicos, y sirve como punto de partida, no como retrato de un autor concreto.
> Antes de usarlo en un documento real, reemplazar el contenido por el perfil propio. Ver la primera sección.

---

## Cómo personalizar este perfil

El perfil funciona: da conectores, plantillas y convenciones. Lo que no puede dar es la voz de una persona. Eso se extrae de sus propios textos.

### 1. Reunir el corpus

Reunir entre 20 y 50 documentos propios del mismo tipo: informes de laboratorio, monografías, artículos, trabajos prácticos.
Conviene que sean textos de los últimos años y que pertenezcan al mismo registro que la tesis.
Un corpus de correos o de publicaciones informales describe otra voz y no sirve.

### 2. Extraer la voz

Leer el corpus buscando cómo se resuelve el punto de vista.

- ¿Usa pasiva con «se», tercera persona o primera persona?
- ¿Hay variación o es uniforme?
- ¿Cómo introduce el propio trabajo: «Este trabajo presenta», «En el presente informe»?

Anotar los patrones con dos o tres ejemplos textuales. Los ejemplos valen más que la etiqueta.

### 3. Medir la longitud de oración

Contar palabras por oración en una muestra de diez párrafos.
Registrar tres valores: oración más corta, mediana y más larga.
Comparar con la regla de oraciones cortas. Si el corpus histórico usa oraciones largas, la regla nueva gana y el perfil lo registra como diferencia.

### 4. Listar los conectores

Armar una tabla como la de la sección 3 de este archivo, pero con los conectores que el autor usa de verdad.
Distinguir los que aparecen mucho de los que aparecen una sola vez.
Un conector que el autor nunca usa no se agrega al perfil para «mejorar» el texto.

### 5. Registrar las plantillas fraseológicas

Buscar las fórmulas que se repiten casi textualmente en tres o más documentos.
Suelen aparecer en las aperturas de sección, en los comentarios de datos y en las conclusiones.
Copiarlas con su contexto de uso. Una plantilla sin su contexto produce texto fuera de lugar.

### 6. Fijar el tratamiento de términos

Revisar cómo se tratan las siglas, los préstamos del inglés, el código y los nombres de herramientas.
Anotar mayúsculas, itálicas, expansión en la primera aparición y uso posterior.
Estas decisiones son las que hacen que un documento parezca escrito por una sola persona.

### 7. Reemplazar sin tocar los encabezados

El perfil se reemplaza sección por sección.
**Los encabezados se mantienen.** Las herramientas y los agentes buscan esos títulos: cambiarlos rompe la referencia.

Si una sección no aplica al autor, se deja el encabezado y se escribe «sin patrón identificable en el corpus». No se borra la sección.

### 8. Verificar contra las reglas

Al terminar, contrastar el perfil con `RULES.md`.
Donde el perfil y las reglas se contradigan, gana `RULES.md` y el perfil lo registra como diferencia a corregir, igual que la sección 8 de este archivo.

---

## 1. Voz y persona

### Patrón dominante: pasiva impersonal con «se»

Es el rasgo más consistente en un corpus técnico.
Cero instancias de primera persona.

- «Se implementó el módulo de adquisición de datos…»
- «Se diseñó el circuito de acondicionamiento de señal…»
- «Se montó el prototipo sobre una placa de pruebas…»
- «Se puede concluir que los resultados obtenidos…»
- «Se encontró que el error disminuye al aumentar la resolución…»
- «Se procedió a calibrar el instrumento…»
- «Se decidió utilizar una arquitectura de dos etapas…»

**Construcciones de observación frecuentes:** «Se puede ver que…», «Se observa que…», «Se puede notar que…», «Se puede apreciar…».

**Nota:** las reglas de estilo prohíben «como se puede observar» y similares. Reemplazar por «Los resultados muestran que…», «Los datos indican que…», «En la Fig. X se presenta…».

---

## 2. Estructura de oraciones

### En informes de laboratorio: oraciones largas, multiclausulares

Ejemplo típico de cinco cláusulas en una oración:

> «Al medir la salida del amplificador se verificó que la tensión de desbalance fuera menor a 5~mV, al medir se encontró que este valor era de 2~mV, por lo que se decidió que la corrección por software era innecesaria.»

### En artículos: más cortas por restricción de columna

> «Los sistemas embebidos de bajo consumo se han difundido rápidamente en los últimos años como una solución que reduce el costo energético y facilita el despliegue de sensores distribuidos.»

### En monografías: longitud media, tono expositivo y técnico

> «En los últimos años, los dispositivos de Internet de las Cosas (IoT) se han vuelto herramientas muy populares tanto para aficionados como para profesionales.»

### Para documentos formales: oraciones cortas

Una idea por oración. Una oración por línea en el fuente `.tex`.
Esto es un cambio respecto del estilo histórico del corpus, pero es vinculante para el documento que se está escribiendo.

### Dos puntos: no al patrón titular–especificación

En prosa, cuando la primera parte de la oración funciona como rótulo y la segunda como su especificación, integrar ambas en una única oración continua con coma, «ya que», «de modo que» o punto.
Los dos puntos se reservan para las enumeraciones introducidas por un cúmulo explícito, las fórmulas y ecuaciones, los títulos y las citas textuales.

Ejemplo: «El diagnóstico es claro: un filtro pasa-altos.» → «El diagnóstico es claro, ya que responde a un filtro pasa-altos.»

### Dos puntos en títulos

Un título es un titular por definición, de modo que los dos puntos se admiten cuando unen un tema y un subtema que ambos se leen por sí solos («Emociones: modelos y taxonomías»).
Se evita cuando la primera parte es una etiqueta genérica cuyo sentido solo se cierra con la segunda.

---

## 3. Conectores y transiciones

| Categoría | Conectores de alta frecuencia |
|-----------|-------------------------------|
| Visual y observación | «Se puede ver que», «Se observa que», «como se ve en», «se puede apreciar» |
| Causación | «por lo que», «por lo tanto», «por ello», «ya que», «esto se debe a que», «lo que provoca que» |
| Secuenciación | «En primer lugar», «Luego», «A continuación», «Finalmente», «Para comenzar» |
| Adición | «Además», «También», «Por otro lado», «Asimismo» |
| Contraste | «Sin embargo», «En cambio», «A pesar de», «No obstante» |
| Clarificación | «Es decir», «Esto es», «Cabe aclarar que» |
| Método y propósito | «Para ello», «Con el objetivo de», «De esta manera», «De esta forma» |
| Logro | «Se logró», «Se consiguió», «Se pudo» |
| Necesidad | «Se debe», «Es necesario», «Se necesita» |

---

## 4. Plantillas fraseológicas recurrentes

Estas aparecen casi textualmente en tres o más documentos del corpus:

- «Se puede concluir que…» (apertura de conclusiones)
- «Se observa que…» o «Se puede observar que…» (comentario de datos)
- «Se procedió a…» + infinitivo (método)
- «En la(s) siguiente(s) figura(s) o tabla(s) se…» (referencia cruzada)
- «…como se muestra o se mencionó en…» (referencia cruzada)
- «Se encontró que…» o «se encontraron…» (hallazgos)
- «Por lo que se + [verbo en tercera persona]» (causal)
- «A pesar de» + sustantivo o infinitivo (concesión)
- «…, lo que + [verbo]…» (cláusula de resultado)

---

## 5. Tratamiento de términos técnicos

### Siglas y acrónimos

Patrón: término en español primero y sigla en `\textit{}`.
En trabajos previos se usaba la negrita, hoy prohibida por las reglas de estilo.

- «interfaz de usuario (\textit{IU})»
- «sistema de adquisición de datos (\textit{SAD})»

### Préstamos del inglés

Siempre en `\textit{}`, nunca traducidos cuando no existe equivalente aceptado.

- *dataset*, *framework*, *real-time*, *pipeline*, *firmware*, *gateway*
- *software*, *hardware*, *debug*, *loop*, *polling*
- *performance*, *paper*, *layout*

### Código y registros

Siempre en `\texttt{}`.

- `\texttt{REG_CONFIG}`, `\texttt{REG_STATUS}`, `\texttt{Python}`
- `\texttt{ADC1}`, `\texttt{UART0}`

---

## 6. Figuras, tablas y ecuaciones

### Figuras

- Caption abajo, frase nominal corta y descriptiva.
- `[H]`, `[!t]` o `[ht]` para el posicionamiento.
- `\includegraphics[width=...]` con `\centering`.
- Referencia en el texto: «en la Fig. \ref{}».
- Subfiguras con `subfig` o `subcaption`.

### Tablas

- Caption arriba.
- `booktabs` con `\toprule`, `\midrule` y `\bottomrule`.
- `siunitx` con columnas de tipo S cuando hay unidades.
- Referencia en el texto: «en la Tabla \ref{}».

### Ecuaciones

- Numeradas con `\label{}` y referenciadas con `\eqref{}`.
- Variables explicadas en prosa inmediatamente antes o después.
- `siunitx` con `\si{}` y `\SI{}{}` para las unidades.

---

## 7. Estructura de documentos

### Informes de laboratorio

1. Carátula con logo institucional, materia, autor y fecha.
2. Índice.
3. Enunciado.
4. Desarrollo con secciones numeradas.
5. Conclusiones.
6. Bibliografía y anexos.

### Artículo de conferencia

1. Título y autores.
2. Resumen y palabras clave.
3. Introducción.
4. Secciones temáticas paralelas.
5. Conclusión.
6. Referencias.

### Tesis o memoria

1. Portada y metadatos.
2. Resumen y palabras clave.
3. Índices de contenido, figuras y tablas.
4. Introducción con problema, objetivos y contribuciones.
5. Estado del arte.
6. Diseño y desarrollo.
7. Resultados.
8. Conclusiones y trabajo futuro.
9. Bibliografía.
10. Anexos.

---

## 8. Fortalezas e idiosincrasias

### Fortalezas

- Disciplina con la voz impersonal.
- Referencias cruzadas sistemáticas a figuras, tablas y ecuaciones.
- Separación clara de fases: diseño, análisis y resultados.
- Honestidad con las limitaciones y los resultados inesperados.

### Idiosincrasias a corregir en documentos formales

- Oraciones excesivamente largas, de cuatro a seis cláusulas. Las reglas exigen oraciones cortas.
- Uso de «se puede ver» y «se puede observar», que las reglas catalogan como dirigirse al lector.
- Fuente `.tex` sin separación de oraciones por línea.
- Errores gramaticales ocasionales, del tipo «mejormente conocido» en lugar de «más conocido».
- Uso histórico de negrita para referencias a figuras en el texto. Hoy la negrita no se usa para términos clave.

---

## 9. Alineación con las reglas de estilo

| Directriz | Práctica histórica | Acción para el documento formal |
|-----------|--------------------|---------------------------------|
| Nunca primera persona | Cumple. | Mantener. |
| No dirigirse al lector | Parcial. Usa «se puede ver». | Prohibir «se puede observar» y «se puede ver». Usar alternativas. |
| Oraciones cortas | No cumple. | Dividir. Máximo tres líneas. |
| Una oración por línea | No cumple. | Aplicar estrictamente. |
| Términos en inglés en itálica | Mayormente cumple. | Ser consistente. |
| Caption de tabla arriba y de figura abajo | Cumple. | Mantener. |
| Referenciar antes de mostrar | Cumple. | Mantener. |
