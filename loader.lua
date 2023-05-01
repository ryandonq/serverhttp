local http = require("socket.http")
    local ltn12 = require("ltn12")
    
    -- Define the server URL
    local url = "https://github.com/ryandonq/serverhttp"
    
    -- Define the request body
    local requestBody = "{'action': 'create_server'}"
    
    -- Define the request headers
    local headers = {
        ["Content-Type"] = "application/json",
        ["Content-Length"] = tostring(#requestBody)
    }
    
    -- Send the request and get the response
    local responseBody = {}
    local response, status = http.request{
        url = url,
        method = "POST",
        headers = headers,
        source = ltn12.source.string(requestBody),
        sink = ltn12.sink.table(responseBody)
    }
    
    -- Check if the request was successful
    if status == 200 then
        -- Log the response
        print(table.concat(responseBody))
    else
        -- Log the error
        print("Error: Failed to create online store server")
    end
end
