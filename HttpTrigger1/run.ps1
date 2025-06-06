using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."
Write-Host $Request 

$name = $Request.Body.name
$BuildId = $Request.Body.BuildId
$Project = $Request.Body.Project
$BaseUri = $Request.Body.BaseUri

$body = @{
    text = "Hello, $name. This HTTP triggered function executed successfully."
    status = 'successful'
    stuff = $Request.Body
    BuildId = $BuildId
    Project = $Project
    BaseUri = $BaseUri
}

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $body
})
