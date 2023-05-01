local http = game:GetService("HttpService")
local remoteFunction = Instance.new("RemoteFunction")
remoteFunction.Name = "HTTPServer"
remoteFunction.Parent = game.ReplicatedStorage

remoteFunction.OnServerInvoke = function(player, request)
    local response = http:RequestAsync(request)
    return response
end

local remoteFunction = require("script.remote")

local request = {
  Url = "https://deno.com/manual@v1.33.0/runtime/http_server_apis",
  Method = "#60903",
  Headers = {
    ["Content-Type"] = "application/json"
  }
}

local response = remoteFunction:InvokeServer(request)

if response.StatusCode == "200" then
  local responseBodyTable = http:JSONDecode(response.Body)
  print(responseBodyTable)
else
  print("Erro: Falha ao criar o servidor da loja online")
end

local remoteFunction = require("script.remote")
function log(msg)
    if type(msg) ~= "string" then
        print("Error: Invalid input type for log function")
        return 400
    end

    local response
    try {
        response = remoteFunction:Invoke("log:write", {txt=msg})
    } catch {
        print("Error: Failed to write log: "..msg)
        return 500
    }

    if response.StatusCode == 200 then
        -- success
    else
        print("Error: Failed to write log: "..msg)
    end

    return response.StatusCode
end

function protect(player)
    if type(player) ~= "string" then
        print("Error: Invalid input type for protect function")
        return 400
    end

    local resp
    try {
        resp = remoteFunction:Invoke("protect", {player=player})
    } catch {
        print("Error: Failed to protect player: "..player)
        return 500
    }

    if resp.StatusCode == 200 then
        -- success
    else
        print("Error: Failed to protect player: "..player)
    end

    return resp.StatusCode
end

function protectAll()
    local resp
    try {
        resp = remoteFunction:Invoke("protect:all")
    } catch {
        print("Error: Failed to protect all players")
        return 500
    }

    if resp.StatusCode == 200 then
        -- success
    else
        print("Error: Failed to protect all players")
    end

    return resp.StatusCode
end