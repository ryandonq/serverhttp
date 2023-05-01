
local http = game:GetService("HttpService")
local remoteFunction = Instance.new("RemoteFunction")
remoteFunction.Name = "HTTPServer
"
remoteFunction.Parent = game.ReplicatedStorage

remoteFunction.OnServerInvoke = function(player, request)
    local response = http:RequestAsync(request)
    return response
end

local request = {
    Url = "https://deno.com/manual@v1.33.0/runtime/http_server_apis",
    Method = "GET",
    Headers = {
        ["Content-Type"] = "application/json"
    }
}

local response = remoteFunction:InvokeServer(request)

if response.StatusCode == 200 then
    local responseBodyTable = http:JSONDecode(response.Body)
    print(responseBodyTable)
else
    print("Erro: Falha ao criar o servidor da loja online")
end