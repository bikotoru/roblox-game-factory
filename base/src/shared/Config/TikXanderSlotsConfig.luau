--[[
    TikXanderSlotsConfig — Configuracion para el sistema de slots/GUI.
    API: configgames.tikxander.com
    Cada juego debe poner su GAME_ID y API_KEY.
]]

local TikXanderSlotsConfig = {
    BASE_URL = "https://configgames.tikxander.com",
    GAME_ID = ""  -- UUID del juego en TikXander,
    API_KEY = ""  -- Clave API TikXander,

    TOTAL_SLOTS = 20,
    CONFIG_CHECK_INTERVAL = 3.0,

    CONFIG_USER_ID = "",

    -- Posiciones del HUD → {scaleX, offsetX, scaleY, offsetY}
    HUD_HEROES_POSITION = { 0.08, 0, 0.03, 0 },
    HUD_VILLAINS_POSITION = { 0.92, 0, 0.03, 0 },
    HUD_WIN_POSITION = { 0.5, 0, 0, 10 },
    HUD_COLUMN_HEIGHT = 0.94,

    HUD_EFFECTS = {
        pulse = { enabled = true, speed = 1.5, scale = 1.08 },
        shine = { enabled = true, speed = 1.4, intensity = 0.6 },
    },
}

return TikXanderSlotsConfig
