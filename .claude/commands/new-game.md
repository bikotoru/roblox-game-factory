---
description: Crear un juego nuevo copiando la base completa TikXander-ready
argument-hint: <nombre-kebab-del-juego>
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
---

Objetivo: crear `games/<nombre>/` con una copia limpia de `base/` lista para desarrollar.

## Paso 1 — Validar nombre

Argumento: "$ARGUMENTS"
- Debe ser kebab-case (ej: `neon-obby`, `cube-duel`).
- Si vacio → preguntar al usuario.

## Paso 2 — Copiar base

```bash
mkdir -p games
cp -R base "games/$ARGUMENTS"
```

## Paso 3 — Personalizar

1. Editar `games/$ARGUMENTS/default.project.json` → name = nombre del juego
2. Dejar `TikXanderConfig.luau` y `TikXanderSlotsConfig.luau` con GAME_ID/API_KEY vacios (el user los completa)
3. Crear `games/$ARGUMENTS/src/server/Services/<Game>Actions.luau` con esqueleto de registerAction
4. Crear ROADMAP.md inicial con `/roadmap-create` describiendo el genero
5. Actualizar `docs/INDEX.md` del juego

## Paso 4 — Confirmar

Listar estructura creada y recordar:
- Configurar GAME_ID + API_KEY
- Registrar acciones reales
- El GiftHUD / SettingsMenu / SlotEditor ya funcionan out-of-the-box
