# RULES — Estilo de escritura académica

> Estas reglas aplican a **todas** las secciones del documento.
> En caso de duda, consultar antes de escribir.

---

## 1. Idioma

- **Español académico.** No mezclar con inglés salvo términos técnicos consolidados.
- Los términos técnicos en inglés se escriben en itálica en su primera aparición si no tienen traducción aceptada.
- Las citas textuales en inglés mantienen el idioma original, entre comillas.

---

## 2. Punto de vista

- **Nunca usar primera persona** (singular o plural): nada de «nosotros», «nuestro equipo», «desarrollamos», «yo».
- **Voz pasiva o tercera persona impersonal:**
  - ✅ «Este trabajo presenta…»
  - ✅ «El sistema fue diseñado…»
  - ✅ «Se implementó un pipeline…»
  - ❌ «Nosotros diseñamos…»
  - ❌ «Implementé un pipeline…»
- **No dirigirse al lector:** nada de «usted», «el lector», «nótese que», «como se puede observar».

---

## 3. Oraciones

- **Sujeto cerca del verbo.** Evitar cláusulas subordinadas largas al principio.
- **Voz activa solo cuando sea más clara que la pasiva**, y siempre en tercera persona.
  - ✅ «El micrófono captura el audio a 44.1~kHz.»
  - ✅ «El audio es capturado a 44.1~kHz.»
  - ❌ «Capturamos el audio a 44.1~kHz.»
- **Una idea por oración.** Si hay dos o más ideas complejas, separarlas. Se admite una segunda idea en la misma oración solo si ambas están íntimamente ligadas por causa-efecto o contraste. En ese caso, unirlas con conectores lógicos explícitos («por lo tanto», «sin embargo», «debido a»), alternando la longitud de las oraciones para mantener el ritmo del texto.
- **Líneas de ~80 caracteres máximo** en el fuente `.tex`.

---

## 4. Puntuación

- **Prohibido** el uso de rayas largas. Usar comas, paréntesis o punto y seguido en su lugar.
- Paréntesis para información complementaria.
- **Prohibido el punto y coma en la prosa.** Si dos ideas son independientes, separarlas con punto y seguido. Si están encadenadas, usar coma.
- Guiones solo dentro de palabras compuestas (ej.: «tiempo real», «bajo consumo»).

---

## 5. Acrónimos y siglas

- **Solo se crea sigla si el término se reutiliza** dentro del documento.
- **Al definir:** cada palabra del término con mayúscula inicial.
  - ✅ «Speech Emotion Recognition (SER)»
  - ❌ «speech emotion recognition (SER)»
- Las siglas en español siguen las reglas de la RAE: solo la primera letra en mayúscula si se pronuncian como palabra (ej.: «ovni», «sida»).
- **En el resumen:** sigla solo si el término aparece dos o más veces en el resumen mismo.
- **En el cuerpo:** definir desde cero, sin asumir que el lector leyó el resumen.

---

## 6. Cifras y unidades

- **Números menores a diez:** en palabras («siete emociones», no «7 emociones»), salvo en tablas, mediciones y porcentajes.
- **Unidades con espacio fino:** usar `~` en LaTeX: `44.1~kHz`, `8~MB`, `240~MHz`.
- **Porcentajes:** `12.5~\%`, siempre con número, espacio fino y `\%`.
- **Rangos:** `35--63~\%` con guion medio, no guion corto.

---

## 7. Citas y referencias

- **Todas las afirmaciones técnicas llevan cita** o están respaldadas por datos propios.
- **Formato numérico:** `\cite{key}` con estilo `[1]`, `[2]`, etc.
- **No usar citas como sustantivos:** ❌ «como se muestra en [3]» → ✅ «como describe Schuller~\cite{schuller2018speech}».

---

## 8. Tablas y figuras

- **Caption arriba de la tabla.**
- **Caption abajo de la figura.**
- **Toda figura y toda tabla se referencian en el texto** antes de aparecer.
- **Figuras en formato vectorial** (PDF) cuando sea posible. PNG o JPG solo para fotografías.

---

## 9. Tono general

- **Académico, no publicitario.** Nada de «revolucionario», «increíble», «poderoso».
- **Preciso, no vago.** `5.6~segundos` en vez de «unos pocos segundos».
- **Honesto con las limitaciones.** Si algo no funciona, se dice y se explica por qué.
- **Resumen:** autónomo, resume el documento sin referencias a secciones ni a figuras.

---

## 10. Construcciones prohibidas

- **Negrita en el cuerpo.** No se usa negrita para términos clave. Se usa `\textit{}` para términos clave y técnicos. Tampoco se admite negrita dentro de un paréntesis que aclara o expande un término, ni sobre nombres de programas, marcos de trabajo o herramientas.
- **Paréntesis enumerativos.** No escribir listas entre paréntesis, como `(a, b, c)`. Reescribir con prosa, por ejemplo «desde… hasta…», «entre los que se incluyen…», o una oración aparte.
- **«Materializar» como sinónimo de implementar, construir o desarrollar.** Usar el verbo directo: «implementar», «construir», «desarrollar» o «representar».
- **Patrón titular–especificación con dos puntos.** Cuando la primera parte de la oración funciona como rótulo o anuncio y la segunda como su especificación, integrar ambas en una única oración continua con coma, «ya que», «de modo que» o punto. Los dos puntos se reservan para las enumeraciones introducidas por un cúmulo explícito («tres criterios:», «las siguientes etapas:»), las fórmulas y ecuaciones, los títulos y las citas textuales.
  Ejemplo: «El diagnóstico es claro: un filtro pasa-altos.» → «El diagnóstico es claro, ya que responde a un filtro pasa-altos.»
- **Dos puntos en títulos y subtítulos.** Se admiten cuando unen un tema y un subtema que ambos se leen por sí solos («Emociones: modelos y taxonomías», «Inferencia en dispositivos embebidos: límites prácticos»). Se evitan cuando la primera parte es una etiqueta genérica cuyo sentido solo se cierra con la segunda («Periféricos: display circular y LEDs» → «Periféricos del sistema»).
