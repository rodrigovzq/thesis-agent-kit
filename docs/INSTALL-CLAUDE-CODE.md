# Instalación en Claude Code

## Requisitos

- Claude Code instalado y funcionando.
- `bash` disponible. El instalador funciona con bash 3.2, la versión que trae macOS.
- La raíz del proyecto, con los archivos del documento que se va a escribir.

## Instalación

Desde la raíz del kit:

```bash
# Alcance de usuario: disponible en todos los proyectos
./scripts/install.sh --target claude --scope user

# Alcance de proyecto: solo dentro de un proyecto
./scripts/install.sh --target claude --scope project --project-dir la/raiz/del/proyecto
```

Si se omite `--project-dir`, se usa el directorio actual.

## Destinos

| Alcance | Agentes | Skills |
|---------|---------|--------|
| `user` | `~/.claude/agents/` | `~/.claude/skills/` |
| `project` | `<proyecto>/.claude/agents/` | `<proyecto>/.claude/skills/` |

## Qué escribe el instalador

Los agentes del kit usan un frontmatter canónico con `name`, `description`, `mode` y `tools`.
Para Claude Code, el instalador conserva solo lo que ese harness necesita:

```yaml
---
name: thesis-writer
description: "..."
tools: Read, Write, Edit, Grep, Glob, Bash
---
```

El campo `mode` no se escribe porque Claude Code no lo distingue.
El campo `permission` tampoco se escribe: la lista `tools` ya acota lo que el agente puede hacer.

## Diferencia entre los dos harnesses

| Aspecto | OpenCode | Claude Code |
|---------|----------|-------------|
| Identificación | `description` | `name` y `description` |
| Rol del agente | `mode: primary` o `subagent` | No se declara |
| Permisos | Bloque `permission` derivado de `tools` | Solo `tools` |

El orquestador se instala como `primary` en OpenCode. En Claude Code se invoca por nombre, como cualquier otro agente.

## Idempotencia

El instalador no sobrescribe archivos existentes.
Si un agente o un skill ya existe, se omite y se informa en la salida.
Para reemplazarlo se agrega `--force`:

```bash
./scripts/install.sh --target claude --scope project --project-dir la/raiz/del/proyecto --force
```

## Verificación

1. Confirmar que hay once archivos en el directorio de agentes:

```bash
ls ~/.claude/agents/
```

2. Abrir uno y comprobar el frontmatter:

```bash
head -5 ~/.claude/agents/thesis-writer.md
```

Debe mostrar `name`, `description` y `tools`.

3. Abrir una sesión de Claude Code y comprobar que los agentes aparecen.
4. Invocar al orquestador con una tarea chica y comprobar que delega en lugar de escribir.

## Desinstalación

Para alcance de usuario:

```bash
rm ~/.claude/agents/thesis-*.md
rm -rf ~/.claude/skills/thesis-writing-coach
```

Para alcance de proyecto, los mismos nombres dentro de `<proyecto>/.claude/`.

Los skills `avoid-ai-writing` y `humanizer-es` se instalan desde el kit. Si ya existían, el instalador los omitió.
