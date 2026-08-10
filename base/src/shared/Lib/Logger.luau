--[[
    Logger — Sistema de logs con niveles.
    Formato: [NIVEL][NombreServicio] mensaje
    Nunca usar print/warn directo en código de juego.
]]

local Logger = {}
Logger.__index = Logger

local LEVELS = {
    DEBUG = 1,
    INFO = 2,
    WARN = 3,
    ERROR = 4,
    PROD = 5,
}

local currentLevel = LEVELS.INFO

function Logger.setGlobalLevel(levelName)
    if LEVELS[levelName] then
        currentLevel = LEVELS[levelName]
    end
end

function Logger.new(serviceName)
    local self = setmetatable({}, Logger)
    self._name = serviceName or "Unknown"
    return self
end

local function emit(self, levelName, fmt, ...)
    local level = LEVELS[levelName] or 2
    if level < currentLevel then return end
    local ok, msg = pcall(string.format, tostring(fmt), ...)
    if not ok then msg = tostring(fmt) end
    local line = string.format("[%s][%s] %s", levelName, self._name, msg)
    if levelName == "ERROR" then
        warn(line)
    else
        print(line)
    end
end

function Logger:debug(fmt, ...) emit(self, "DEBUG", fmt, ...) end
function Logger:info(fmt, ...) emit(self, "INFO", fmt, ...) end
function Logger:warn(fmt, ...) emit(self, "WARN", fmt, ...) end
function Logger:error(fmt, ...) emit(self, "ERROR", fmt, ...) end

return Logger
