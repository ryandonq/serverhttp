local HTTP = require("socket.http")
local ltn12 = require("ltn12")

local url = "https://github.com/ryandonq/serverhttp"

local requestBody = {
    action = "create_server",
    guid = http:GenerateGUID()
}

local requestBodyJson = http:JSONEncode(requestBody)

local headers = {
    ["Content-Type"] = "application/json",
    ["Content-Length"] = tostring(#requestBodyJson)
}

local responseBody = {}
local response, status = http.request{
    url = url,
    method = "POST",
    headers = headers,
    source = ltn12.source.string(requestBodyJson),
    sink = ltn12.sink.table(responseBody)
}

if status == 200 then
    local responseBodyTable = http:JSONDecode(table.concat(responseBody))
    print(responseBodyTable)
else
    print("Error: Failed to create online store server")
end
