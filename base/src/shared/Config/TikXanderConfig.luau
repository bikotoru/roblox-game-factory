--[[
    TikXanderConfig — Configuracion para el cliente HTTP de mensajes TikTok.
    API: tiktokcalls.tikxander.com
    Cada juego debe poner su GAME_ID y API_KEY.

    ⚠️ Credenciales actuales = PLACEHOLDER vacios. Configurar antes de usar.
]]

local TikXanderConfig = {
    BASE_URL = "https://tiktokcalls.tikxander.com",

    -- UUID del juego en TikXander.
    GAME_ID = ""  -- UUID del juego en TikXander,

    -- Clave API del juego.
    API_KEY = ""  -- Clave API TikXander,

    POLL_INTERVAL = 0.7,

    -- Segundos a esperar tras entrar el jugador ANTES de empezar a leer mensajes del backend.
    START_DELAY = 10,

    -- Forzar polling de un userId especifico (en vez del primer jugador conectado)
    MANUAL_USER_ID = "",
    USE_MANUAL_USER_ID = false,
}

return TikXanderConfig
