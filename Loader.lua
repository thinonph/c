local Branch = "main"
local Source = "https://raw.githubusercontent.com/thinonph/c/" .. Branch .. "/"

local function LoadFile(Url, Name)
    local Code = game:HttpGet(Url)
    if #Code < 100 then
        error(Name .. " is empty or truncated (" .. #Code .. " bytes)")
    end
    local Func, Err = loadstring(Code, Name)
    if not Func then
        error(Name .. " syntax error: " .. tostring(Err))
    end
    return Func()
end

getgenv().Parvus = {
    Source = Source,
    Games = {
        ["Universal" ] = { Name = "Universal", Script = "Universal" },
        ["1168263273"] = { Name = "Bad Business", Script = "Games/BB" },
    }
}

Parvus.Utilities = LoadFile(Source .. "Utilities/Main.lua", "Main")
Parvus.Utilities.UI = LoadFile(Source .. "Utilities/UI.lua", "UI")
Parvus.Utilities.Physics = LoadFile(Source .. "Utilities/Physics.lua", "Physics")
Parvus.Utilities.Drawing = LoadFile(Source .. "Utilities/Drawing.lua", "Drawing")

Parvus.Game = Parvus.Games[tostring(game.GameId)] or Parvus.Games.Universal
LoadFile(Source .. Parvus.Game.Script .. ".lua", Parvus.Game.Script)
