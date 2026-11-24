# Instalación en OpenCode

## Requisitos

- OpenCode instalado y funcionando.
- `bash` disponible. El instalador funciona con bash 3.2, la versión que trae macOS.
- La raíz del proyecto, con los archivos del documento que se va a escribir.

## Instalación

Desde la raíz del kit:

```bash
# Alcance de usuario: disponible en todos los proyectos
./scripts/install.sh --target opencode --scope user

# Alcance de proyecto: solo dentro de un proyecto
./scripts/install.sh --target opencode --scope project --project-dir la/raiz/del/proyecto
```

Si se omite `--project-dir`, se usa el directorio actual.

## Destinos

| Alcance | Agentes | Skills |
|---------|---------|--------|
| `user` | `~/.config/opencode/agents/` | `~/.config/opencode/skills/` |
| `project` | `<proyecto>/.opencode/agents/` | `<proyecto>/.opencode/skills/` |

## Qué escribe el instalador

Los agentes del kit usan un frontmatter canónico con `name`, `description`, `mode` y `tools`.
Para OpenCode, el instalador lo convierte en:

```yaml
---
description: "..."
mode: subagent
permission:
  read: allow
  edit: allow
  glob: allow
  grep: allow
  bash: allow
  task: deny
  skill: allow
---
```

El bloque `permission` se deriva de la lista `tools` de cada agente.
Una herramienta que no está en la lista queda en `deny`.

Para `thesis-orchestrator` el bloque se ajusta: la edición queda denegada salvo en `TODO.taskpaper`.

```yaml
permission:
  edit:
    "*": deny
    "TODO.taskpaper": allow
```

## Idempotencia

El instalador no sobrescribe archivos existentes.
Si un agente o un skill ya existe, se omite y se informa en la salida.
Para reemplazarlo se agrega `--force`:

```bash
./scripts/install.sh --target opencode --scope project --project-dir la/raiz/del/proyecto --force
```

## Verificación

1. Confirmar que hay once archivos en el directorio de agentes:

```bash
ls ~/.config/opencode/agents/
```

2. Abrir uno y comprobar que el frontmatter tenga `mode` y `permission`:

```bash
head -16 ~/.config/opencode/agents/thesis-writer.md
```

3. Iniciar OpenCode y comprobar que los agentes aparecen en la lista.
4. Invocar al orquestador con una tarea chica y comprobar que delega en lugar de escribir.

## Desinstalación

Se eliminan los archivos instalados. Para alcance de usuario:

```bash
rm ~/.config/opencode/agents/thesis-*.md
rm -rf ~/.config/opencode/skills/thesis-writing-coach
```

Para alcance de proyecto, los mismos nombres dentro de `<proyecto>/.opencode/`.

`avoid-ai-writing` y `humanizer-es` se instalan desde el kit. Si ya estaban instalados antes, el instalador los omitió y no hay que eliminarlos.
