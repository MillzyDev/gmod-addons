static_me = {}

local function player_spawn(player, transition)
    local steamID = player:SteamID()

    if (static_me[steamID] == nil) then
        
    end
end

hook.Add("PlayerSpawn", "StaticMe:PanelMaker", player_spawn)