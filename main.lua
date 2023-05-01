-- Import the necessary libraries
local HttpService = game:GetService("HttpService")
local ServerStorage = game:GetService("ServerStorage")

-- Define the function
local function createOnlineStoreServer()
    -- Define the products
    local products = {
        {
            name = "Sword",
            price = 100
        },
        {
            name = "Shield",
            price = 50
        },
        {
            name = "Potion",
            price = 25
        }
    }
    
    -- Create the server
    local server = HttpService:CreateServer(8080, function(req, res)
        -- Check if the request is for the store page
        if req.Method == "GET" and req.Path == "/store" then
            -- Create the HTML page
            local page = "<html><body><h1>Welcome to the online store!</h1><ul>"
            for i, product in ipairs(products) do
                page = page .. "<li>" .. product.name .. " - $" .. product.price .. " <a href='/buy/" .. i .. "'>Buy</a></li>"
            end
            page = page .. "</ul></body></html>"
            
            -- Send the response
            res.Body = page
            res.StatusCode = 200
        -- Check if the request is for a purchase
        elseif req.Method == "GET" and req.Path:sub(1, 4) == "/buy" then
            -- Get the product index from the URL
            local productIndex = tonumber(req.Path:sub(6))
            if not productIndex or productIndex < 1 or productIndex > #products then
                res.StatusCode = 400
                return
            end
            
            -- Get the product information
            local product = products[productIndex]
            
            -- Check if the player has enough money
            local player = game.Players:GetPlayerFromUserId(req.UserId)
            if not player then
                res.StatusCode = 401
                return
            end
            local money = ServerStorage:FindFirstChild(player.Name)
            if not money or money.Value < product.price then
                res.StatusCode = 402
                return
            end
            
            -- Deduct the money and give the player the item
            money.Value = money.Value - product.price
            player.Chatted:Connect(function(msg)
                if msg == ":add " then
                    player:Kick("You have been kicked for using a restricted word.")
                end
            end)
            
            -- Send the response
            res.Body = "You have purchased a " .. product.name .. "!"
            res.StatusCode = 200
        -- Return a 404 error for all other requests
        else
            res.StatusCode = 404
        end
    end)
    
    -- Start the server
    server:Start()
end