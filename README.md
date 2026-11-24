# Thesis Agent Kit

English summary. A multi-agent kit for writing a thesis, a dissertation or a technical document in Spanish.
It includes eleven coordinated agents, a binding style rule set with a customizable writing profile, and an installer for OpenCode and Claude Code.
The kit carries no project data, no bibliography, no model provider and no document template.

## Qué es

Es un sistema de once agentes para escribir documentos largos en español. Sirve para una tesis, una memoria o un documento técnico. El registro predominante es técnico. Las convenciones académicas se aplican cuando el documento se presenta como tesis.

Un agente delega y diez ejecutan. Cada uno tiene un rol, un alcance y un formato de handoff común. El kit no incluye datos, métricas ni bibliografía de ningún proyecto. Tampoco impone un proveedor de modelos. El proyecto donde se instala aporta la plantilla del documento, su clase y su cadena de compilación.

## Los once agentes

| Agente | Rol | Qué produce |
|--------|-----|-------------|
| `thesis-orchestrator` | Delegador único | Plan de pasos, briefs y handoffs consolidados. No escribe. |
| `thesis-writer` | Redacción | Texto en español académico, con edición puntual en el archivo del capítulo. |
| `thesis-writing-reviewer` | Revisión de forma | Reporte con hallazgos por línea, corrección propuesta y veredicto. |
| `thesis-template-checker` | Revisión de estructura | Reporte de violaciones de estructura, paquetes, captions e índices. |
| `thesis-paper-researcher` | Bibliografía | Clave de cita por afirmación, entradas BibTeX propuestas y lista de afirmaciones sin respaldo. |
| `thesis-project-notes` | Memoria del proyecto | Justificaciones y cronología con la referencia documental de origen. |
| `thesis-implementation-expert` | Implementación | Datos de código, hardware y métricas en el dispositivo, con `archivo:línea`. |
| `thesis-model-expert` | Modelo | Datos de arquitectura, entrenamiento, datasets y cuantización, con `archivo:línea`. |
| `thesis-source-paper` | Artículo de origen | Tabla de correspondencia entre el artículo y la tesis, y lista de temas por desarrollar. |
| `thesis-figure-designer` | Figuras | Código de figura insertado en el capítulo y veredicto visual propio. |
| `thesis-figure-reviewer` | Revisión de figuras | Reporte de legibilidad, precisión y consistencia, con evidencia visual. |

Cada archivo de agente declara sus herramientas, su alcance y sus prohibiciones. Un agente que detecta un problema ajeno lo reporta en el handoff y sigue con su tarea.

## El flujo

```
plan → investigación → redacción → GATE de forma → estructura → GATE factual → figuras
```

Hay dos gates obligatorios. El primero se ejecuta después de cada handoff del redactor y lo atiende `thesis-writing-reviewer`. Evalúa voz, persona, longitud de oración, naturalidad, patrones de IA y tipografía. Sin veredicto `APROBADO`, el reporte vuelve al redactor y el gate se repite. Ninguna sección se cierra sin aprobación de forma.

El segundo se ejecuta antes de cerrar la sección y lo atiende `thesis-paper-researcher`. Recorre cada afirmación técnica y comprueba que tenga cita o dato propio documentado. Lo que no se puede respaldar se cita, se reformula o se marca `[VERIFICAR]`. La investigación se paraleliza cuando los agentes no comparten archivos de salida. El redactor va después de consolidar la investigación, porque es el primero que escribe. El diagrama completo y las reglas de paralelismo están en `docs/WORKFLOW.md`.

## Instalación

El instalador funciona con bash 3.2, la versión que trae macOS. No requiere dependencias. Se ejecuta desde la raíz del kit.

```bash
# OpenCode, alcance de usuario
./scripts/install.sh --target opencode --scope user

# OpenCode, alcance de proyecto
./scripts/install.sh --target opencode --scope project --project-dir la/raiz/del/proyecto

# Claude Code, alcance de usuario
./scripts/install.sh --target claude --scope user

# Claude Code, alcance de proyecto
./scripts/install.sh --target claude --scope project --project-dir la/raiz/del/proyecto
```

El frontmatter de OpenCode incluye `mode` y un bloque `permission` derivado de la lista de herramientas. Para el orquestador, la edición queda restringida a `TODO.taskpaper`. El de Claude Code incluye `name`, `description` y `tools`.

### Destinos

| Destino | Agentes | Skills |
|---------|---------|--------|
| `opencode` + `user` | `~/.config/opencode/agents/` | `~/.config/opencode/skills/` |
| `opencode` + `project` | `<proyecto>/.opencode/agents/` | `<proyecto>/.opencode/skills/` |
| `claude` + `user` | `~/.claude/agents/` | `~/.claude/skills/` |
| `claude` + `project` | `<proyecto>/.claude/agents/` | `<proyecto>/.claude/skills/` |

Si se omite `--project-dir`, se usa el directorio actual. El instalador es idempotente. No sobrescribe archivos existentes salvo que se agregue `--force`. El detalle está en `docs/INSTALL-OPENCODE.md` y en `docs/INSTALL-CLAUDE-CODE.md`.

## Archivos que aporta el proyecto

El kit instala agentes y skills. El proyecto aporta `AGENTS.md`, `RULES.md` y `TODO.taskpaper`.

### `AGENTS.md`

Es el primero que leen los agentes. Declara el documento maestro, la estructura de capítulos, la cadena de compilación, las rutas de código, modelos y notas, los datasets y las versiones vigentes. Sin este archivo los agentes no saben dónde buscar y todo dato termina marcado `[VERIFICAR]`. La plantilla del kit trae todos los bloques con marcadores `<...>`. Se copia a la raíz del proyecto y se completa.

### `RULES.md`

Contiene las reglas de estilo vinculantes. El kit trae una versión completa y genérica en `skills/thesis-writing-coach/RULES.md`. Se copia a la raíz del proyecto. Las convenciones propias del proyecto se agregan ahí.

### `TODO.taskpaper`

Es el plan de trabajo y la interfaz entre el usuario y el orquestador. El orquestador lo lee al arrancar, elige el ítem de mayor prioridad y lo actualiza al avanzar. Hay un ejemplo en `examples/TODO.taskpaper`. Los tags reconocidos son `@pri(N)`, `@pages(N-M)`, `@agents(...)` y `@done(fecha)`.

## Personalizar el perfil de escritura

El perfil de `skills/thesis-writing-coach/STYLE_PROFILE.md` es genérico. Describe un corpus de trabajos universitarios, no la voz de una persona concreta. Conviene reemplazarlo por un perfil extraído del corpus del autor antes de escribir.

1. Reunir entre 20 y 50 documentos propios del mismo registro.
2. Extraer la voz y el punto de vista con ejemplos textuales.
3. Medir la longitud de oración en una muestra.
4. Listar los conectores que el autor usa de verdad.
5. Registrar las plantillas fraseológicas que se repiten.
6. Fijar el tratamiento de siglas, préstamos y código.
7. Reemplazar el contenido sin tocar los encabezados.
8. Contrastar el resultado con `RULES.md`.

Los encabezados se mantienen porque las herramientas y los agentes los buscan. Donde el perfil y las reglas se contradicen, gana `RULES.md`.

## Adaptar los agentes de dominio

Cuatro agentes leen fuentes del proyecto: las notas, el código, el modelo entrenado y el artículo previo. Se adaptan cambiando rutas y fuentes. La estructura no cambia.

| Agente | Qué adaptar |
|--------|-------------|
| `thesis-project-notes` | La ruta de la carpeta de notas. Si no hay notas, el historial de versiones del código es la fuente. |
| `thesis-implementation-expert` | La ruta del repositorio de código y la del archivo de configuración por variante. |
| `thesis-model-expert` | La ruta del repositorio de modelos y la del pipeline de entrenamiento. |
| `thesis-source-paper` | La ruta del artículo de origen. Si el proyecto no tiene artículo previo, este agente no se despacha. |

Las rutas se declaran en `AGENTS.md`. Si el proyecto no tiene modelo entrenado ni artículo previo, se quitan esos dos agentes de la tabla del orquestador y el resto del flujo sigue igual.

## Skills incluidos

| Skill | Autor | Licencia | Uso |
|-------|-------|----------|-----|
| `thesis-writing-coach` | Este repositorio | MIT | Reglas de estilo y perfil de escritura. |
| `avoid-ai-writing` | Conor Bronsdon, versión 3.3.1 | MIT | Auditoría de prosa generada por IA en el redactor y en el revisor de forma. |
| `humanizer-es` | mattc95 | MIT | Detección de señales de escritura generada por IA en español. |

Las atribuciones y las modificaciones constan en `THIRD-PARTY.md`.

## Skills opcionales que no se incluyen

Estos skills quedan fuera del kit. Cada uno se puede instalar por separado con el gestor de skills del harness.

| Skill | Motivo |
|-------|--------|
| `humanizar-texto-es` | Licencia GPL-2.0-or-later, incompatible con la licencia MIT del kit. |
| `latex-document` | Depende de una cadena LaTeX completa y de decisiones de plantilla que el proyecto debe tomar. |
| `latex-build` | Atado a un motor y a una cadena de compilación concretos. |
| `latex-tables` | Específico de un paquete de tablas. El proyecto puede usar otro. |
| `academic-paper` | Orientado a publicaciones, no a un documento con capítulos. |
| `research-literature` | Depende de servicios externos de búsqueda académica y de credenciales. |

## Reglas de diseño

1. El orquestador no redacta. Su permiso de edición se limita a `TODO.taskpaper`.
2. Cada agente declara herramientas y alcance en su archivo. El trabajo fuera de alcance se reporta en el handoff y no se aplica.
3. Los dos gates condicionan el cierre de la sección. El de forma exige el veredicto `APROBADO`. El factual exige que no queden afirmaciones sin respaldo ni marcas `[VERIFICAR]`.
4. Toda cifra del documento lleva referencia `archivo:línea` o `\cite{key}`. Sin fuente, se marca `[VERIFICAR]`.
5. Los cambios se aplican con edición puntual sobre el archivo existente. Ningún agente reescribe un archivo completo.
6. El alcance de cada tarea lo fija el brief del orquestador. El subagente no lo amplía por iniciativa propia.

## Limitaciones

- El instalador no valida el contenido. Copia archivos, traduce el frontmatter de los agentes y deja los skills sin cambios.
- El kit no compila. La compilación depende de la plantilla y de las herramientas del proyecto.
- Con el perfil genérico, el texto resulta correcto pero impersonal.
- Los agentes de dominio leen las fuentes del proyecto. Si una fuente no está en la ruta declarada, esos agentes devuelven `[VERIFICAR]`.
- La memoria entre sesiones depende del harness. Si no hay memoria disponible, el contexto vive en `TODO.taskpaper` y en las notas del proyecto.

## Licencia

MIT. Ver `LICENSE`. Los skills de terceros conservan su licencia original. Ver `THIRD-PARTY.md`.
