---
name: thesis-writing-coach
description: Aplica las reglas de estilo y el perfil de escritura académica en español al redactar o revisar cualquier sección de una tesis o memoria de ingeniería, y detecta patrones de texto generado por IA. Se activa al escribir, revisar, editar o auditar prosa académica en español, o ante cualquier modificación de archivos .tex del documento.
---

# Thesis Writing Coach — Entrenador de escritura académica

## Descripción general

Este skill aplica dos capas a la vez:

1. **Las reglas prescriptivas** de `RULES.md`, que son la guía de estilo autoritativa del documento.
2. **El perfil de escritura** de `STYLE_PROFILE.md`, que aporta vocabulario, conectores y convenciones estructurales para que el texto tenga una voz propia y consistente.

**Cuando las reglas y el perfil entran en conflicto, gana `RULES.md`.**

El perfil que se distribuye con el kit es genérico.
Debe reemplazarse por el perfil del autor antes de usarlo en un documento real. Ver la primera sección de `STYLE_PROFILE.md`.

## Flujo de trabajo

Cuando se invoca para escribir o revisar texto:

1. **Leer el archivo objetivo** completo: el capítulo o la sección en la que se trabaja.
2. **Aplicar `RULES.md`.** Es obligatorio. Se verifica cada regla.
3. **Aplicar el perfil de estilo** de `STYLE_PROFILE.md`. Es lo que da voz al texto.
4. **Reportar las violaciones** agrupadas por severidad.

Al escribir, el orden es el inverso: primero el perfil para producir el texto, después las reglas para corregirlo, y al final una pasada de detección de patrones de IA.

## Checklist de cumplimiento de las reglas

Se aplican en este orden. Toda violación de las secciones marcadas como críticas es bloqueante.

### Voz y persona (crítico)

- ¿Hay primera persona? («nosotros», «nuestro», «desarrollamos», «yo») → **BLOQUEANTE. Reescribir en pasiva con «se».**
- ¿Se dirige al lector? («usted», «el lector», «nótese que», «como se puede observar») → **BLOQUEANTE. Eliminar.**
- ¿Usa voz pasiva o tercera persona impersonal? (correcto: «Este trabajo presenta…», «Se implementó…», «El sistema fue diseñado…»)

### Estructura de oraciones (crítico)

- ¿Cada oración ocupa una sola línea en el fuente? → Si no, separar.
- ¿Alguna oración ocupa más de tres líneas? → Dividir.
- ¿Una sola idea por oración? → Sí. Se admiten dos ideas en una misma oración solo si están ligadas por causa-efecto o contraste, y en ese caso se unen con un conector lógico explícito («por lo tanto», «sin embargo», «debido a»), alternando la longitud de las oraciones.
- ¿Las líneas del fuente tienen unos 80 caracteres como máximo? → Ajustar.

### Siglas y términos

- ¿Cada sigla se define en su primera aparición, con mayúscula inicial en cada palabra? (correcto: «Speech Emotion Recognition (SER)»)
- ¿Los términos en inglés están en `\textit{}` en su primera aparición?
- ¿La sigla se reutiliza lo suficiente? Si no, no se crea.

### Cifras y unidades

- ¿Los números menores a diez van en palabras? (salvo en tablas, mediciones y porcentajes)
- ¿Las unidades llevan espacio fino `~`? (correcto: `44.1~kHz`, `8~MB`, `240~MHz`)
- ¿Los porcentajes llevan `~\%`? (correcto: `71.4~\%`)
- ¿Los rangos usan guion medio `--`? (correcto: `35--63~\%`)

### Citas

- ¿Toda afirmación técnica tiene cita o está respaldada por datos propios?
- ¿El formato es numérico con `\cite{key}`?
- ¿Las citas no se usan como sustantivos? (incorrecto: «como en [3]» → correcto: «como describe Schuller~\cite{schuller2018speech}»)

### Figuras y tablas

- ¿El caption de la tabla va arriba?
- ¿El caption de la figura va abajo?
- ¿Toda figura y toda tabla se referencia en el texto antes de aparecer?
- ¿Las figuras están en formato vectorial cuando es posible?

### Tono

- ¿Es académico y no publicitario? Nada de «revolucionario» ni «increíble».
- ¿Es preciso y no vago? `5.6~segundos` en vez de «unos pocos segundos».
- ¿Es honesto con las limitaciones? Si algo no funciona, se dice.

## Perfil de estilo

El perfil completo está en `STYLE_PROFILE.md`. Referencia rápida:

### Conectores

| Propósito | Conectores preferidos |
|-----------|----------------------|
| Causación | «por lo que», «ya que», «por lo tanto», «por esta razón» |
| Contraste | «sin embargo», «a pesar de», «en cambio» |
| Adición | «además», «también», «por otro lado» |
| Secuenciación | «en primer lugar», «luego», «a continuación», «finalmente» |
| Consecuencia | «…, lo que provoca que…», «…, lo que resulta en…» |
| Clarificación | «es decir», «cabe aclarar que» |

### Plantillas fraseológicas recurrentes

- «Se puede concluir que…» (conclusiones)
- «Los resultados muestran que…» (datos)
- «Se encontró que…» (hallazgos)
- «Se procedió a…» (método)
- «Por lo que se…» (causal)

### Convenciones LaTeX

- `\textit{}` para términos clave y para palabras en inglés.
- `\texttt{}` para código, nombres de registros y funciones.
- Sin `\textbf{}` para términos clave en el cuerpo.
- Figuras: `[H]` o `[htbp]`, `\centering`, caption abajo.
- Tablas: `booktabs` con `\toprule`, `\midrule` y `\bottomrule`, caption arriba.

### Prohibiciones adicionales

- No se usa `\textbf{}` dentro de paréntesis aclaratorios ni sobre nombres de programas o marcos de trabajo.
- No se usan paréntesis enumerativos, como `(a, b, c)`. Se reescribe con prosa («desde… hasta…», «entre los que se incluyen…») o con una oración aparte.
- No se usa «materializar» como sinónimo de implementar, construir o desarrollar. Se usa el verbo directo.
- No se usa el patrón titular–especificación con dos puntos. Cuando la primera parte funciona como rótulo y la segunda como su especificación, se integran en una sola oración con coma, «ya que», «de modo que» o punto. Los dos puntos se reservan para enumeraciones introducidas por un cúmulo explícito, fórmulas, ecuaciones, títulos y citas textuales.
- En títulos y subtítulos, los dos puntos se admiten cuando unen un tema y un subtema que se leen por sí solos («Emociones: modelos y taxonomías»). Se evitan cuando la primera parte es una etiqueta genérica cuyo sentido solo se cierra con la segunda.

## Detección de patrones de IA

Se marcan y se reescriben estos patrones:

| Patrón | Reemplazo |
|--------|-----------|
| «Cabe destacar que…» abusado | Omitir o usar una sola vez por capítulo. |
| «Además» o «por otro lado» repetidos | Variar con «asimismo», «también», «a su vez». |
| «Esto sugiere que…» | «Esto indica que…» o «Los datos muestran que…». |
| «En conclusión» redundante al final | Ya se sabe que es la conclusión. |
| «Robusto», «integral», «crucial» como adjetivos vacíos | Eliminar o reemplazar por datos concretos. |
| Párrafo de una sola oración larga | Dividir. |
| Triple adverbio o triple enumeración | Máximo dos elementos, salvo que la enumeración sea exhaustiva. |
| «Profundizar en», «arrojar luz sobre» | Demasiado informales. Usar «analizar», «estudiar», «examinar». |

## Formato de reporte

```
## Revisión de [archivo]

### Bloqueantes (reglas)
- [Línea X]: problema → sugerencia

### Estilo (perfil)
- [Línea X]: patrón detectado → alternativa más natural

### Patrones de IA
- [Línea X]: patrón → reemplazo

### Estructura
- [Observaciones sobre flujo, transiciones y densidad de ideas]

### Veredicto
- APROBADO | APROBADO CON CAMBIOS | RECHAZADO
```

## Cómo extender las reglas

`RULES.md` es un documento vivo.
Cuando aparece un caso que las reglas no cubren, o cuando una regla produce un resultado peor que la alternativa:

1. No se cambia el texto al margen de la regla.
2. Se propone la regla nueva en `RULES.md` con un ejemplo correcto y uno incorrecto.
3. Se avisa al usuario del cambio antes de aplicarlo a todo el documento.
4. Si el cambio contradice una regla existente, se reemplaza la regla anterior, no se agrega una excepción silenciosa.

Nunca se relajan las reglas para justificar un texto ya escrito.
La regla se cambia para el documento completo, no para el párrafo que resultó incómodo.
