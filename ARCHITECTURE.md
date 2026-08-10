# Arquitectura del Game Factory

## Capas reutilizables (base/)

### 1. TikXander (server)

```
src/server/Services/TikXander/
  init.server.luau          ← orquestador (1 client por player)
  TikXanderClient.luau      ← HTTP polling puro + dedup
  TikXanderGameHandler.luau ← registerAction() dispatcher
  TikXanderConfigHandler.luau ← slots config API + push GiftHUD
```

Flujo:
1. Player entra → Client pollea `/api/{GAME_ID}/mensajes/{userId}`
2. Mensaje llega → GameHandler busca accion registrada
3. Handler del juego ejecuta (FireClient / spawn / etc.)
4. ConfigHandler pollea configgames → actualiza GiftHUD

### 2. GiftHUD (client)

```
src/client/UI/GiftHUD/
  init.client.luau       ← escucha GiftHUDUpdate + IsViewer
  GiftHUDBuilder.luau    ← construye columnas heroes/villains/win
  SlotEditor.luau        ← drag + snap 5% + persist ConfigBridge
  SlotStyles/            ← default, neon, gold, pixel, holo, limpio
  SlotObfuscation.luau   ← hide/pixelate/censor iconos de regalos
  GiftHUDEffects.luau    ← pulse + shine
  Constants.luau
```

### 3. SettingsMenu (client, tecla Q)

Tab Slot Config controla:
- SLOT_STYLE, SLOT_OBFUSCATION_MODE
- SLOT_TITLE_HEROES / VILLAINS
- HUD_*_SCALE, HUD_*_POS_X/Y
- SHOW_GIFT_SLOTS
- Boton Editar posiciones → SlotEditor.toggle()
- Boton Sync → TikXanderSyncEvent

### 4. ConfigBridge

Server autoritativo. Client `get/set/onChange`.
GiftHUD rebuild hot-swap cuando cambian claves de GameSettings.

### 5. AccessControl

IsViewer = true hasta primer mensaje TikTok → promoteToStreamer.
GiftHUD oculto mientras IsViewer.

## Como agregar una accion de juego

```lua
-- src/server/Services/MyGameActions.luau
local Handler = require(script.Parent.TikXander.TikXanderGameHandler)

Handler.registerAction("mi_accion", function(player, msg, slotConfig, nickname)
    -- logica del juego
end)
```

El nombre `mi_accion` se mapea en el dashboard TikXander al gift correspondiente.

## Leyes CLAUDE.md

1. Reutilizacion primero (Shared/Lib generico)
2. INDEX.md antes de crear
3. Max 500 LOC por archivo
4. ROADMAP + STATE + SPECS para features no triviales
