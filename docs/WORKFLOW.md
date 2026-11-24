# Flujo de trabajo

## Principio

El orquestador no escribe. Lee el plan, investiga por delegación y despacha la redacción.
Cada agente hace una cosa y devuelve un handoff con el mismo formato.

## Diagrama

```
TODO.taskpaper
      │
      ▼
┌──────────────────┐
│ orchestrator     │  lee el plan, arma el brief, delega
└────────┬─────────┘
         │
         │  FASE 1 — investigación (en paralelo si no comparten archivos)
         ├─────────────────────┬──────────────────────────┐
         ▼                     ▼                          ▼
┌─────────────────┐   ┌──────────────────────┐   ┌────────────────────┐
│ project-notes   │   │ implementation-expert│   │ model-expert       │
│ por qué / cuándo│   │ qué / cómo           │   │ arquitectura y datos│
└────────┬────────┘   └──────────┬───────────┘   └─────────┬──────────┘
         │                       │                          │
         └───────────┬───────────┴──────────────┬───────────┘
                     ▼                          ▼
              ┌─────────────────┐        ┌──────────────────┐
              │ source-paper    │        │ paper-researcher │
              │ qué expandir    │        │ qué fuente citar │
              └────────┬────────┘        └────────┬─────────┘
                       └────────────┬─────────────┘
                                    ▼
                         ┌──────────────────┐
                         │     writer       │   FASE 2 — redacción
                         └────────┬─────────┘
                                  │
                                  ▼
                    ╔═══════════════════════════╗
                    ║ GATE 1 — writing-reviewer ║   obligatorio
                    ╚═════════════┬═════════════╝
                                  │ APROBADO
                                  ▼
                         ┌──────────────────┐
                         │ template-checker │   estructura LaTeX
                         └────────┬─────────┘
                                  ▼
                    ╔═══════════════════════════╗
                    ║ GATE 2 — paper-researcher ║   verificación factual
                    ╚═════════════┬═════════════╝
                                  │ sin pendientes
                                  ▼
                         ┌──────────────────┐
                         │ figure-designer  │   si hacen falta figuras
                         └────────┬─────────┘
                                  ▼
                         ┌──────────────────┐
                         │ figure-reviewer  │   con visión real
                         └────────┬─────────┘
                                  ▼
                            sección cerrada
```

## Los dos gates obligatorios

Un gate es un punto de control que no se puede saltear.
Si el gate falla, el trabajo vuelve atrás. No se compensa con una revisión posterior.

### Gate 1 — `writer` → `writing-reviewer`

Se ejecuta después de cada handoff del redactor.

- Evalúa la forma: voz, persona, longitud de oración, naturalidad, patrones de IA, tipografía.
- No evalúa contenido, citas ni estructura LaTeX.
- Devuelve un veredicto: `APROBADO`, `APROBADO CON CAMBIOS` o `RECHAZADO`.

Si el veredicto no es `APROBADO`:

1. El orquestador pasa el reporte de vuelta al redactor.
2. El redactor aplica las correcciones puntuales.
3. Se repite el gate.

Ninguna sección se cierra sin un `APROBADO` del revisor de forma.

### Gate 2 — `paper-researcher` (verificación factual)

Se ejecuta al terminar la escritura de una sección, después del primer gate.

- Recorre cada afirmación técnica del texto producido.
- Verifica que tenga cita o dato propio documentado.
- Verifica que la cita corresponda al contenido de la fuente.
- Marca lo que no se puede respaldar.

Si quedan afirmaciones sin respaldo:

1. Se agrega la cita, se reformula la afirmación o se marca `[VERIFICAR]`.
2. El orquestador decide cuál de las tres salidas aplica. Si la decisión no es evidente, pregunta.

Ninguna sección se cierra con afirmaciones sin respaldo y sin marca `[VERIFICAR]`.

## Regla de paralelismo

Se paraleliza solo cuando los agentes no comparten archivos de salida.
Los agentes de investigación son de solo lectura: se pueden lanzar juntos.
El redactor es el primero que escribe, así que va después de consolidar la investigación.

Ante la duda, se prefiere el orden secuencial. Corregir un error de integración cuesta más que esperar un turno.

## Regla de bloqueo

Un handoff con `Status: blocked` o `Status: needs-decision` detiene el flujo.
El orquestador usa la herramienta de preguntas para resolverlo con el usuario.
No se avanza con una suposición sobre lo que el usuario quiso decir.

## Regla de alcance

Cada brief declara qué archivo y qué sección se tocan.
El agente que descubre trabajo adicional lo reporta en `Notes/risks` y no lo aplica.
El alcance se amplía por decisión del orquestador, no por iniciativa del subagente.

## Regla de datos

Un dato sin fuente no se escribe.

| Situación | Salida |
|-----------|--------|
| El dato está en el código | Se cita `archivo:línea` |
| El dato está en las notas | Se cita el documento |
| El dato está en una fuente bibliográfica | Se cita con `\cite{key}` |
| El dato no aparece en ninguna parte | Se marca `[VERIFICAR]` |

`[VERIFICAR]` es una marca de trabajo, no una salida definitiva. Antes de la entrega, cada marca se resuelve o se elimina junto con la afirmación.

## Flujos particulares

### Sección nueva

1. Investigación, en paralelo si se puede.
2. Redacción.
3. Gate de forma.
4. Verificación de plantilla.
5. Gate factual.
6. Figuras, si aplican.

### Revisión de un capítulo existente

1. Cargar `thesis-writing-coach` y aplicar su checklist.
2. Verificación de plantilla.
3. Verificación factual.
4. Si hay hallazgos de forma, redacción y gate de forma.

### Planificación de contenido

1. Mapear qué se expande desde el artículo de origen.
2. Recuperar objetivos y cronología de las notas.
3. Planificar figuras.
4. Presentar el plan con estimación de extensión, sin escribir todavía.
