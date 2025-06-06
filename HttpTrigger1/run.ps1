using namespace System.Net
using namespace System.Web

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

$params = [HttpUtility]::ParseQueryString($Request.Body)

$BuildId = $params["BuildId"]
$Project = $params["Project"]
$BaseUri = $params["BaseUri"]
$AuthToken = $params["AuthToken"]

$body = @{
    status = 'successful'
    BuildId = $BuildId
    Project = $Project
    BaseUri = $BaseUri
    AuthToken = $AuthToken
}
$headers = @{
    "Content-Type"= "application/json"
    "Authorization" = $AuthToken
}

$uri = "$BaseUri$Project/_build/results?buildId=$BuildId&__rt=fps&__ver=2"
Write-Host $uri
$response = Invoke-WebRequest -Method Get -uri $uri -Headers $headers
Write-Host $response 


# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $body
})