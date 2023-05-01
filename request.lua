local HttpService = game:GetService("HttpService")

local function makeRequest(url, method, data)
    local requestData = {
        Url = url,
        Method = method or "GET",
    }

    if data then
        requestData.Body = HttpService:JSONEncode(data)
    end

    local success, response = pcall(function()
        return HttpService:RequestAsync(requestData)
    end)

    if success then
        return HttpService:JSONDecode(response.Body)
    else
        warn("Request failed: " .. tostring(response))
        return nil
    end
end

local url = "https://github.com/ryandonq/serverhttp"
local method = "GET"
local data = nil

local response = makeRequest(url, method, data)
if response then
    print("Request succeeded:")
    for key, value in pairs(response) do
        print(key, value)
    end
else
    print("Request failed")
end

local function fetchTitle(jsonData)
    return jsonData.title
end

local function printTitle(title)
    print("Title: " .. title)
end

local url = "https://jsonplaceholder.typicode.com/todos/1"
local method = "GET"
local data = nil
local headers = {["Content-Type"] = "application/json"}

local response = makeRequest(url, method, data, headers)
local jsonResponse = handleResponse(response)

local title = fetchTitle(jsonResponse)
printTitle(title)