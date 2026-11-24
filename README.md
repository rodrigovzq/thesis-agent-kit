# Thesis Agent Kit

**English summary.** A multi-agent kit for writing an engineering thesis or dissertation in Spanish. It ships eleven coordinated agents, a Spanish academic style rule set and profile, and an installer for OpenCode and Claude Code. All content is generic: no personal data, no specific project, no model provider.

---

## Qué es y qué no es

Es un sistema de agentes para escribir una tesis o memoria de ingeniería en español académico.

Aporta tres cosas:

1. **Once agentes con roles separados**, cada uno con alcance acotado y un formato de handoff común.
2. **Un conjunto de reglas de estilo** más un perfil de escritura personalizable.
3. **Un instalador** que traduce los agentes al formato de OpenCode o de Claude Code.

No es una plantilla LaTeX. No es un generador de texto automático. No incluye datos, métricas ni bibliografía de ningún proyecto.
La plantilla del documento, su clase y su cadena de compilación las aporta el proyecto donde se instala.

Tampoco impone un proveedor de modelos: el kit no fija `model` ni credenciales. Cada harness usa el modelo que tenga configurado.

## Arquitectura

Once agentes. Uno delega, diez ejecutan.

| Agente | Rol | Qué produce |
|--------|-----|-------------|
| `thesis-orchestrator` | Delegador único | Plan de pasos, briefs y handoffs consolidados. No escribe. |
| `thesis-writer` | Redacción | Texto académico en español, editado de forma puntual en el archivo del capítulo. |
| `thesis-writing-reviewer` | Revisión de forma | Reporte con hallazgos por línea, corrección propuesta y veredicto. |
| `thesis-template-checker` | Revisión de estructura | Reporte de violaciones de estructura, paquetes, captions e índices. |
| `thesis-paper-researcher` | Bibliografía | Clave de cita por afirmación, entradas BibTeX propuestas y lista de afirmaciones sin respaldo. |
| `thesis-project-notes` | Memoria del proyecto | Justificaciones y cronología con la referencia documental de origen. |
| `thesis-implementation-expert` | Implementación | Datos de código, hardware y métricas on-device, con `archivo:línea`. |
| `thesis-model-expert` | Modelo | Datos de arquitectura, entrenamiento, datasets y cuantización, con `archivo:línea`. |
| `thesis-source-paper` | Artículo de origen | Tabla de correspondencia artículo a tesis y lista de temas por desarrollar. |
| `thesis-figure-designer` | Figuras | Código de figura insertado en el capítulo y veredicto visual propio. |
| `thesis-figure-reviewer` | Revisión de figuras | Reporte de legibilidad, precisión y consistencia, con evidencia visual. |

Cada agente declara su alcance y sus prohibiciones en su propio archivo.
Un agente no invade el alcance de otro: si detecta un problema ajeno, lo reporta y sigue.

## El flujo

```
plan → investigación → redacción → GATE de forma → estructura → GATE factual → figuras
```

Hay dos gates obligatorios.

**Gate 1, forma.** Después de cada handoff del redactor se despacha al revisor de forma.
Evalúa voz, persona, longitud de oración, naturalidad, patrones de IA y tipografía.
Si el veredicto no es `APROBADO`, el reporte vuelve al redactor y el gate se repite.
Ninguna sección se cierra sin aprobación de forma.

**Gate 2, verificación factual.** Antes de cerrar una sección se despacha al investigador bibliográfico.
Recorre cada afirmación técnica y verifica que tenga cita o dato propio documentado.
Lo que no se puede respaldar se cita, se reformula o se marca `[VERIFICAR]`.

El diagrama completo y las reglas de paralelismo están en `docs/WORKFLOW.md`.

## Instalación rápida

El instalador funciona con bash 3.2, la versión que trae macOS. No requiere dependencias.

### OpenCode

```bash
./scripts/install.sh --target opencode --scope user
```

Escribe en `~/.config/opencode/agents/` y `~/.config/opencode/skills/`.
Con `--scope project` escribe en `<proyecto>/.opencode/`.
El frontmatter generado incluye `mode` y un bloque `permission` derivado de la lista de herramientas.
Para el orquestador, la edición queda restringida a `TODO.taskpaper`.

### Claude Code

```bash
./scripts/install.sh --target claude --scope user
```

Escribe en `~/.claude/agents/` y `~/.claude/skills/`.
Con `--scope project` escribe en `<proyecto>/.claude/`.
El frontmatter generado incluye `name`, `description` y `tools`.

En ambos casos el instalador es idempotente: no sobrescribe archivos existentes salvo que se agregue `--force`.
Detalle en `docs/INSTALL-OPENCODE.md` y `docs/INSTALL-CLAUDE-CODE.md`.

## Qué archivos hay que crear en el proyecto

El kit instala agentes y skills. El proyecto aporta tres archivos.

### `AGENTS.md`

Es lo primero que leen los agentes. Declara el documento maestro, la estructura de capítulos, la cadena de compilación, las rutas de código, modelos y notas, los datasets y las versiones vigentes.
Sin este archivo, los agentes no saben dónde buscar y todo dato termina marcado `[VERIFICAR]`.

La plantilla del kit incluye todos los bloques con placeholders. Copiarla a la raíz del proyecto y completarla.

### `RULES.md`

Son las reglas de estilo vinculantes. El kit trae una versión completa y genérica en `skills/thesis-writing-coach/RULES.md`.
Basta con copiarla a la raíz del proyecto. Si el proyecto agrega convenciones propias, se suman ahí.

### `TODO.taskpaper`

Es el plan de trabajo y la interfaz entre el usuario y el orquestador.
El orquestador lo lee al arrancar, elige el ítem de mayor prioridad y lo actualiza al avanzar.
Hay un ejemplo genérico en `examples/TODO.taskpaper`.

Los tags reconocidos son `@pri(N)`, `@pages(N-M)`, `@agents(...)` y `@done(fecha)`.

## Personalizar el perfil de escritura

**El perfil que viene en `skills/thesis-writing-coach/STYLE_PROFILE.md` es genérico. Reemplazarlo por el propio antes de escribir.**

Describe un corpus de trabajos universitarios de ingeniería, no la voz de una persona concreta.
El archivo abre con una sección que explica el procedimiento:

1. Reunir entre 20 y 50 documentos propios del mismo registro.
2. Extraer la voz y el punto de vista con ejemplos textuales.
3. Medir la longitud de oración en una muestra.
4. Listar los conectores que el autor usa de verdad.
5. Registrar las plantillas fraseológicas que se repiten.
6. Fijar el tratamiento de siglas, préstamos y código.
7. Reemplazar el contenido manteniendo los encabezados.
8. Contrastar el resultado con `RULES.md`.

Los encabezados no se tocan: las herramientas y los agentes los buscan.
Donde el perfil y las reglas se contradicen, gana `RULES.md`.

## Adaptar los agentes de dominio a otro proyecto

Cuatro agentes asumen un proyecto de ingeniería con código, un modelo entrenado y un artículo previo.
Los cuatro se adaptan cambiando rutas y fuentes, no la estructura.

| Agente | Qué adaptar |
|--------|-------------|
| `thesis-project-notes` | La ruta de la carpeta de notas. Si no hay notas, el historial de versiones del código es la fuente. |
| `thesis-implementation-expert` | La ruta del repositorio de código y la del archivo de configuración por variante. |
| `thesis-model-expert` | La ruta del repositorio de modelos y la del pipeline de entrenamiento. |
| `thesis-source-paper` | La ruta del artículo de origen. Si el proyecto no tiene artículo previo, este agente no se despacha. |

Las rutas se declaran en `AGENTS.md`. El agente las lee de ahí.

Si el proyecto no tiene modelo entrenado ni artículo previo, se eliminan esos dos agentes de la tabla del orquestador y el resto del flujo sigue igual.

## Skills de terceros que no se incluyen

El kit incluye `avoid-ai-writing` (MIT, Conor Bronsdon) y `humanizer-es` (MIT, mattc95). La atribución está en `THIRD-PARTY.md`.

Estos skills útiles quedan fuera del kit:

| Skill | Motivo |
|-------|--------|
| `humanizar-texto-es` | Licencia GPL-2.0, incompatible con la licencia MIT del kit. |
| `latex-document` | Depende de una cadena LaTeX completa y de decisiones de plantilla que el proyecto debe tomar. |
| `latex-build` | Atado a un motor y a una cadena de compilación concretos. |
| `latex-tables` | Específico de un paquete de tablas; el proyecto puede usar otro. |
| `academic-paper` | Orientado a publicaciones, no a una tesis con capítulos. |
| `research-literature` | Depende de servicios externos de búsqueda académica y de credenciales. |

Cada uno se puede instalar por separado con el gestor de skills del harness.

## Limitaciones

- **El instalador no valida el contenido.** Copia y traduce frontmatter. No verifica que el proyecto esté bien documentado.
- **El kit no compila.** La compilación depende de la plantilla y de las herramientas del proyecto.
- **La calidad depende del perfil.** Con el perfil genérico, el texto suena correcto pero impersonal.
- **Los agentes de dominio leen código.** Si el código no está disponible en la ruta declarada, esos agentes devuelven `[VERIFICAR]`.
- **No hay memoria entre sesiones garantizada.** Si el harness ofrece memoria, se usa. Si no, el contexto vive en `TODO.taskpaper` y en las notas del proyecto.

## Filosofía

**El orquestador no escribe.** Lee, planifica y delega. Esa restricción es lo que mantiene el sistema predecible: un solo agente decide el orden, y ningún agente mezcla decisiones con redacción.

**Cada agente tiene un alcance estrecho.** Un revisor de forma no opina sobre citas. Un experto de implementación no redacta. Cuando un agente detecta algo fuera de su alcance, lo reporta en vez de arreglarlo.

**Ningún dato se inventa.** Si un valor no está en el código, en las notas o en una fuente bibliográfica, se marca `[VERIFICAR]`.
La marca es visible a propósito: obliga a resolver el hueco antes de la entrega.

**Los gates no se negocian.** Una sección con estilo aprobado pero sin respaldo factual está tan incompleta como una con citas perfectas y voz en primera persona.
Los dos gates existen porque cada uno cubre lo que el otro no ve.

**El texto se edita, no se regenera.** Un agente que reescribe un archivo completo destruye trabajo ajeno.
La regla anti-destrucción está en cada agente con permiso de escritura.

## Licencia

MIT. Ver `LICENSE`.
Los skills de terceros conservan su licencia original. Ver `THIRD-PARTY.md`.
