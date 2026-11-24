#!/usr/bin/env bash
#
# Instalador de Thesis Agent Kit.
# Convierte los agentes del formato canónico del repositorio al formato de
# frontmatter que espera cada harness, y copia los skills.
#
# Uso:
#   ./scripts/install.sh --target opencode|claude --scope user|project [--project-dir DIR] [--force]
#
# Compatible con bash 3.2 (macOS). Sin arrays asociativos ni mapfile.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SRC_AGENTS="$REPO_ROOT/agents"
SRC_SKILLS="$REPO_ROOT/skills"

TARGET=""
SCOPE=""
PROJECT_DIR=""
FORCE=0

usage() {
    cat <<'EOF'
Uso:
  ./scripts/install.sh --target opencode|claude --scope user|project [--project-dir DIR] [--force]

Opciones:
  --target opencode|claude  Harness de destino.
  --scope user|project      Alcance de la instalación.
  --project-dir DIR         Raíz del proyecto. Por defecto, el directorio actual.
                            Solo se usa con --scope project.
  --force                   Sobrescribe archivos existentes.
  -h, --help                Muestra esta ayuda.

Destinos:
  opencode + user     ~/.config/opencode/agents   y  ~/.config/opencode/skills
  opencode + project  <proyecto>/.opencode/agents y  <proyecto>/.opencode/skills
  claude   + user     ~/.claude/agents            y  ~/.claude/skills
  claude   + project  <proyecto>/.claude/agents   y  <proyecto>/.claude/skills
EOF
}

die() {
    printf 'Error: %s\n' "$1" >&2
    exit 1
}

while [ "$#" -gt 0 ]; do
    case "$1" in
        --target)
            [ "$#" -ge 2 ] || die "falta el valor de --target"
            TARGET="$2"
            shift 2
            ;;
        --scope)
            [ "$#" -ge 2 ] || die "falta el valor de --scope"
            SCOPE="$2"
            shift 2
            ;;
        --project-dir)
            [ "$#" -ge 2 ] || die "falta el valor de --project-dir"
            PROJECT_DIR="$2"
            shift 2
            ;;
        --force)
            FORCE=1
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            printf 'Opción desconocida: %s\n\n' "$1" >&2
            usage >&2
            exit 1
            ;;
    esac
done

case "$TARGET" in
    opencode|claude) ;;
    "") die "falta --target (opencode o claude)" ;;
    *) die "target inválido: $TARGET (use opencode o claude)" ;;
esac

case "$SCOPE" in
    user|project) ;;
    "") die "falta --scope (user o project)" ;;
    *) die "scope inválido: $SCOPE (use user o project)" ;;
esac

[ -d "$SRC_AGENTS" ] || die "no se encuentra el directorio de agentes: $SRC_AGENTS"
[ -d "$SRC_SKILLS" ] || die "no se encuentra el directorio de skills: $SRC_SKILLS"

if [ "$SCOPE" = "project" ]; then
    if [ -z "$PROJECT_DIR" ]; then
        PROJECT_DIR="$(pwd)"
    fi
    [ -d "$PROJECT_DIR" ] || die "no existe el directorio del proyecto: $PROJECT_DIR"
    PROJECT_DIR="$(cd "$PROJECT_DIR" && pwd)"
fi

if [ "$SCOPE" = "user" ]; then
    case "$TARGET" in
        opencode) AGENTS_DEST="$HOME/.config/opencode/agents"; SKILLS_DEST="$HOME/.config/opencode/skills" ;;
        claude)   AGENTS_DEST="$HOME/.claude/agents";           SKILLS_DEST="$HOME/.claude/skills" ;;
    esac
else
    case "$TARGET" in
        opencode) AGENTS_DEST="$PROJECT_DIR/.opencode/agents"; SKILLS_DEST="$PROJECT_DIR/.opencode/skills" ;;
        claude)   AGENTS_DEST="$PROJECT_DIR/.claude/agents";   SKILLS_DEST="$PROJECT_DIR/.claude/skills" ;;
    esac
fi

# Extrae el bloque de frontmatter, sin los delimitadores.
read_frontmatter() {
    awk '
        /^---[[:space:]]*$/ { c++; next }
        c == 1 { print }
        c == 2 { exit }
    ' "$1"
}

# Extrae el cuerpo, sin el frontmatter.
# Solo se descartan los dos primeros delimitadores; las líneas `---`
# del cuerpo se conservan.
read_body() {
    awk '
        /^---[[:space:]]*$/ && started < 2 { started++; next }
        started == 2 { print }
    ' "$1"
}

# Lee un campo escalar del frontmatter.
field() {
    printf '%s\n' "$2" | sed -n "s/^$1:[[:space:]]*//p" | head -n 1
}

# Comprueba si una lista envuelta en comas contiene una herramienta.
has_tool() {
    case "$1" in
        *",$2,"*) return 0 ;;
        *) return 1 ;;
    esac
}

emit_allow_or_deny() {
    # $1: etiqueta, $2: 1 si está permitido, 0 si no
    if [ "$2" = "1" ]; then
        printf '  %s: allow\n' "$1"
    else
        printf '  %s: deny\n' "$1"
    fi
}

# Bloque permission derivado de la lista de herramientas.
emit_permission() {
    wrapped="$1"
    agent_name="$2"

    if has_tool "$wrapped" Read; then r=1; else r=0; fi
    if has_tool "$wrapped" Glob; then g=1; else g=0; fi
    if has_tool "$wrapped" Grep; then p=1; else p=0; fi
    if has_tool "$wrapped" Bash; then b=1; else b=0; fi
    if has_tool "$wrapped" Task; then t=1; else t=0; fi
    if has_tool "$wrapped" Edit || has_tool "$wrapped" Write; then e=1; else e=0; fi

    emit_allow_or_deny read "$r"

    # El orquestador solo edita el archivo de plan de trabajo.
    if [ "$agent_name" = "thesis-orchestrator" ]; then
        printf '  edit:\n'
        printf '    "*": deny\n'
        printf '    "TODO.taskpaper": allow\n'
    else
        emit_allow_or_deny edit "$e"
    fi

    emit_allow_or_deny glob "$g"
    emit_allow_or_deny grep "$p"
    emit_allow_or_deny bash "$b"
    emit_allow_or_deny task "$t"

    # Los agentes cargan skills de escritura de forma constante.
    printf '  skill: allow\n'
}

write_opencode_agent() {
    src="$1"
    dest="$2"
    fm="$(read_frontmatter "$src")"
    description="$(field description "$fm")"
    mode="$(field mode "$fm")"
    tools="$(field tools "$fm")"
    wrapped=",$(printf '%s' "$tools" | tr -d ' '),"

    {
        printf -- '---\n'
        printf 'description: "%s"\n' "$description"
        printf 'mode: %s\n' "${mode:-subagent}"
        printf 'permission:\n'
        emit_permission "$wrapped" "$(basename "$dest" .md)"
        printf -- '---\n'
        read_body "$src"
    } > "$dest"
}

write_claude_agent() {
    src="$1"
    dest="$2"
    fm="$(read_frontmatter "$src")"
    description="$(field description "$fm")"
    tools="$(field tools "$fm")"

    {
        printf -- '---\n'
        printf 'name: %s\n' "$(basename "$dest" .md)"
        printf 'description: "%s"\n' "$description"
        printf 'tools: %s\n' "$tools"
        printf -- '---\n'
        read_body "$src"
    } > "$dest"
}

mkdir -p "$AGENTS_DEST"

installed=0
skipped=0

for src in "$SRC_AGENTS"/*.md; do
    [ -f "$src" ] || continue
    name="$(basename "$src")"
    dest="$AGENTS_DEST/$name"

    if [ -e "$dest" ] && [ "$FORCE" -ne 1 ]; then
        printf 'omitido    %s (ya existe, use --force)\n' "$dest"
        skipped=$((skipped + 1))
        continue
    fi

    case "$TARGET" in
        opencode) write_opencode_agent "$src" "$dest" ;;
        claude)   write_claude_agent "$src" "$dest" ;;
    esac

    printf 'escrito    %s\n' "$dest"
    installed=$((installed + 1))
done

mkdir -p "$SKILLS_DEST"

for skill_src in "$SRC_SKILLS"/*; do
    [ -d "$skill_src" ] || continue
    skill_name="$(basename "$skill_src")"
    dest="$SKILLS_DEST/$skill_name"

    if [ -e "$dest" ] && [ "$FORCE" -ne 1 ]; then
        printf 'omitido    %s (ya existe, use --force)\n' "$dest"
        skipped=$((skipped + 1))
        continue
    fi

    mkdir -p "$dest"
    cp -R "$skill_src/." "$dest/"
    printf 'escrito    %s\n' "$dest"
    installed=$((installed + 1))
done

printf '\nListo: %s instalados, %s omitidos.\n' "$installed" "$skipped"
printf 'Agentes: %s\n' "$AGENTS_DEST"
printf 'Skills:  %s\n' "$SKILLS_DEST"

printf '\nSiguiente paso: copiar la plantilla AGENTS.md del kit a la raíz del proyecto\n'
printf 'y completar los datos que el proyecto necesita.\n'

