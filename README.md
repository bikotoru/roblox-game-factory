# Roblox Game Factory (TikXander Standard)

Proyecto raiz para crear juegos Roblox **TikXander-ready** de forma completa y reutilizable.

Cada juego nuevo se crea copiando la carpeta `base/` → `games/<nombre>/` y solo agregando la logica especifica del genero.

## Que incluye la base (listo para copiar)

| Capa | Contenido |
|------|-----------|
| **TikXander** | Client HTTP polling, GameHandler (`registerAction`), ConfigHandler (slots API), init orquestador |
| **GiftHUD** | Columnas Heroes/Villains/WIN, 6 estilos (Default/Neon/Gold/Pixel/Holo/Limpio), ofuscacion de iconos, efectos pulse/shine |
| **SlotEditor** | Drag + grid snap 5% para mover las 3 columnas del HUD; persiste posiciones via ConfigBridge |
| **ConfigBridge** | Server autoritativo + persistencia + client hot-swap `onChange` |
| **UIKit** | Framework de menus (Tabs, Forms, Widgets: Slider, Combobox, Switch, Button…) |
| **SettingsMenu** | Menu tecla **Q** con tab Slot Config (estilo, ofuscacion, titulos, escalas, editar posiciones, show/hide) |
| **AccessControl** | Gate de streamer (IsViewer → promote al primer evento TikTok) |
| **Logger** | Sistema de logs (no usar print/warn) |
| **CLAUDE.md + commands** | Leyes (reutilizacion, ≤500 LOC, INDEX, ROADMAP/STATE/SPECS) + `/spec-start`, `/roadmap-create`, `/new-game` |

## Como se conecta TikXander

1. **Dashboard web** de TikXander: mapeas gift → nombre de accion (ej: `rose` → `tntc`)
2. **Roblox server** pollea `https://tiktokcalls.tikxander.com/api/{GAME_ID}/mensajes/{userId}`
3. **GameHandler** despacha a la accion registrada con `registerAction("tntc", handler)`
4. **Slots config** viene de `https://configgames.tikxander.com` → alimenta el GiftHUD

Configura `GAME_ID` + `API_KEY` en:
- `src/shared/Config/TikXanderConfig.luau`
- `src/shared/Config/TikXanderSlotsConfig.luau`

## Flujo de un juego nuevo

```bash
# 1. Copia la base
cp -R base games/mi-obby
cd games/mi-obby

# 2. Pon credenciales TikXander
# 3. Registra tus acciones en un *Actions.luau
# 4. Abre con Claude Code → sigue CLAUDE.md + /roadmap-create
```

O usa el comando del agente: `/new-game mi-obby`

## Leyes del agente (CLAUDE.md)

1. **Reutilizacion primero** — Shared/Lib generico, Services especificos
2. **INDEX primero** — revisar `docs/INDEX.md` antes de crear
3. **≤ 500 LOC** por archivo (hard limit)
4. **ROADMAP + STATE + SPECS** — ninguna feature no trivial sin spec

## Estructura

```
roblox-game-factory/
├── CLAUDE.md
├── README.md
├── .claude/commands/          # /spec-start, /roadmap-create, /new-game, /state...
├── specs/_templates/
├── base/                      # ← COPIAR ESTO a cada juego
│   ├── default.project.json
│   └── src/
│       ├── shared/Config + Lib
│       ├── server/Services/TikXander + ConfigBridge + AccessControl
│       └── client/Lib/UIKit + UI/GiftHUD + UI/SettingsMenu
└── games/                     # cada juego generado
    └── <nombre>/
```

## Menus y regalos (detalle)

- **Tecla Q** → SettingsMenu
- Tab **Slot Config**:
  - Estilo de slot (6 estilos)
  - Ofuscacion del icono del regalo
  - Titulos Heroes / Villains
  - Escala de columnas
  - Boton **Editar posiciones** → SlotEditor (drag + snap)
  - Toggle mostrar HUD
- El mapeo gift→accion **no** se edita en Roblox: esta en el dashboard TikXander
- Sync fuerza re-fetch de slots desde la API

## Origen

Extraido y sanitizado de los juegos reales TikXander Games:
- Subway Surf (GiftHUD + UIKit + SettingsMenu maduros)
- Cube vs Cube / Parkour Custom (mismo stack TikXander + CLAUDE.md laws)

Credenciales vacias a proposito. Pon las tuyas antes de usar.
