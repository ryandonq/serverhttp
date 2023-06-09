local HttpService = game:GetService("HttpService")

HttpService.HttpRequestCompleted:Connect(function(request, response, isSuccessful)
    print("HTTP Request Completed:")
    print("Request URL:", request.Url)
    print("Request Method:", request.Method)
    print("Request Headers:", HttpService:JSONEncode(request.Headers))
    print("Request Body:", request.Body)
    print("Response Status Code:", response.StatusCode)
    print("Response Headers:", HttpService:JSONEncode(response.Headers))
    print("Response Body:", response.Body)
end)
