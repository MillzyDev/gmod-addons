local commands = {}

/* ========================== COMMAND HANDLER ========================== */

local function handle_command(sender, text)
    if (text:find("^/") ~= nil) then 
        local args = {}

        for w in text:gmatch("%w+") do 
            table.insert(args, w)
        end

        local command = string.sub(args[1], 1, -1)    
        table.remove(args, 1)

        local exec = commands[command]

        if (exec == nil) then
            return text
        end

        exec(sender, args)

        return ""
    end

    return text
end

local function player_say(sender, text, _) 
    return handle_command(sender, text)
end

hook.Add("PlayerSay", "StaticMe:CommandHandler", player_say)