# AGENTS.md — Instrucciones del proyecto

> Plantilla. Copiar a la raíz del proyecto del documento y completar cada bloque marcado con `<...>`.
> Este archivo es lo primero que leen los agentes. Todo dato que no figure aquí se marca `[VERIFICAR]`.

## 1. Qué se está escribiendo

- Documento: `<tesis | memoria | informe>`
- Título de trabajo: `<título>`
- Carrera o programa: `<carrera>`
- Idioma del documento: español
- Extensión objetivo: `<N páginas>`
- Fecha de entrega: `<fecha>`

## 2. Estructura del documento

- Documento maestro: `<main.tex>`
- Carpeta de capítulos: `<Chapters/>`
- Carpeta de figuras: `<Figures/>`
- Archivo de bibliografía: `<references.bib>`
- Carpeta de anexos: `<Appendices/>`

Capítulos y contenido esperado:

| Archivo | Capítulo | Estado |
|---------|----------|--------|
| `<Chapters/Chapter1.tex>` | `<Introducción>` | `<sin empezar>` |
| `<Chapters/Chapter2.tex>` | `<Estado del arte>` | `<en borrador>` |
| `<Chapters/Chapter3.tex>` | `<Diseño y desarrollo>` | `<en revisión>` |
| `<Chapters/Chapter4.tex>` | `<Resultados>` | `<pendiente>` |
| `<Chapters/Chapter5.tex>` | `<Conclusiones>` | `<pendiente>` |

## 3. Compilación

Cadena de compilación:

```bash
<comando de compilación>
```

- Motor: `<pdflatex | xelatex | lualatex>`
- Bibliografía: `<bibtex | biber>`
- Salida esperada: `<archivo .pdf>`
- Errores conocidos que no se deben corregir: `<ninguno>`

## 4. Reglas de estilo

Las reglas vinculantes están en `RULES.md`.
El perfil de escritura está en `skills/thesis-writing-coach/STYLE_PROFILE.md` y debe estar personalizado antes de escribir.

Puntos que este proyecto agrega a las reglas generales:

- `<punto adicional>`
- `<punto adicional>`

## 5. Fuentes del proyecto

| Fuente | Ruta | Qué aporta |
|--------|------|------------|
| Código de implementación | `<ruta>` | Hardware, pipeline, métricas on-device |
| Repositorio de modelos | `<ruta>` | Arquitectura, entrenamiento, datasets |
| Notas del proyecto | `<ruta>` | Decisiones, cronología, justificaciones |
| Artículo de origen | `<ruta>` | Versión corta que se expande |
| Carpeta de referencias | `<ruta>` | PDF de los trabajos citados |

Regla: toda cifra que se escriba en el documento se verifica contra una de estas fuentes y se cita con `archivo:línea` o con `\cite{key}`.

## 6. Hardware y versiones vigentes

Si el proyecto tiene más de una placa, revisión o versión del modelo, declarar cuál es la vigente.
Los agentes responden con la vigente salvo pedido explícito de la otra.

| Elemento | Versión vigente | Versión histórica |
|----------|-----------------|-------------------|
| `<hardware>` | `<vigente>` | `<histórica>` |
| `<modelo>` | `<vigente>` | `<histórica>` |
| `<firmware>` | `<vigente>` | `<histórica>` |

## 7. Datasets

| Dataset | Idioma | Muestras | Uso |
|---------|--------|----------|-----|
| `<nombre>` | `<idioma>` | `<N>` | `<entrenamiento / validación / prueba>` |

Reglas del proyecto sobre datos:

- Partición: `<cómo se separa entrenamiento de validación>`
- Fuga de datos: `<cómo se evita que una muestra y su versión regrabada caigan en particiones distintas>`
- Datos que no se publican: `<cuáles>`

## 8. Convenciones de figuras

- Formato preferido: `<TikZ embebido | PDF vectorial>`
- Herramienta de trazado: `<pgfplots | otra>`
- Paleta: `<colores y su uso>`
- Tamaño de texto mínimo: `<tamaño>`
- Carpeta de salida: `<Figures/>`

## 9. Flujo de trabajo

- Plan de trabajo: `TODO.taskpaper`.
- El orquestador no escribe. Todo cambio de contenido se delega.
- El gate `writer` → `writing-reviewer` es obligatorio.
- La verificación factual con `paper-researcher` es obligatoria antes de cerrar una sección.
- Ante un bloqueo, se pregunta. No se supone.

Detalle del flujo en `docs/WORKFLOW.md`.

## 10. Prohibiciones del proyecto

- No inventar datos, fechas ni referencias.
- No citar de memoria: toda cita se verifica contra la fuente.
- No describir versiones descartadas como resultado final.
- No reescribir archivos completos. Se edita de forma puntual.
- No salir del alcance del brief.
- `<prohibición específica del proyecto>`

## 11. Memoria persistente (opcional)

Si el entorno ofrece un servidor MCP de memoria, se usa para recuperar el contexto de la sesión anterior y guardar decisiones.
Si no lo ofrece, se mantiene un archivo de notas con el mismo propósito.
Ningún agente depende de esta sección.

## 12. Glosario del proyecto

Términos con significado propio en este proyecto, para que el texto los use siempre igual.

| Término | Definición acordada |
|---------|---------------------|
| `<término>` | `<definición>` |
| `<término>` | `<definición>` |
