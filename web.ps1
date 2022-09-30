# To create a new manifest:
#New-ModuleManifest .\data\module\manifest\ManifestName.psd1
# To import a module it has to be linked in manifest as root and then imported as this:
Import-Module ".\data\module\manifest\WebsiteConstructor.psd1" -Force
Import-Module ".\data\module\manifest\RequestHandler.psd1" -Force
# Import manifest:
$configJson = Get-Content "data/manifest.json"
# Convert to object
$configObject = $configJson |ConvertFrom-Json

$run = $true
$ip = "127.0.0.1"
$port = "8080"
# ───── ❝ WEB SERVER START ❞ ─────
# Http Server
$http = [System.Net.HttpListener]::new()
# Hostname and port to listen on
$http.Prefixes.Add("http://" + $ip + ":" + $port + "/")
# Start the Http Server 
$http.Start()

# INFINTE LOOP
# Used to listen for requests
while ($run) {
    # When a request is made in a web browser the GetContext() method will return a request object
    # Our route examples below will use the request object properties to decide how to respond
    $context = $http.GetContext()
    # http://127.0.0.1/
    if ($context.Request.HttpMethod -eq 'GET' -and $context.Request.RawUrl -eq '/') {

        # We can log the request to the terminal
        write-host "$($context.Request.UserHostAddress)  =>  $($context.Request.Url)" -f 'mag'
        
        [string]$html = 
        
        #resposed to the request
        $buffer = [System.Text.Encoding]::UTF8.GetBytes($html) # convert htmtl to bytes
        $context.Response.ContentLength64 = $buffer.Length
        $context.Response.OutputStream.Write($buffer, 0, $buffer.Length) #stream to broswer
        $context.Response.OutputStream.Close() # close the response
    }

    # http://127.0.0.1/some/post'
    # if ($context.Request.HttpMethod -eq 'POST' -and $context.Request.RawUrl -eq '/some/post') {
    # 
    #     # decode the form post
    #     # html form members need 'name' attributes as in the example!
    #     $FormContent = [System.IO.StreamReader]::new($context.Request.InputStream).ReadToEnd()
    # 
    #     # We can log the request to the terminal
    #     write-host "$($context.Request.UserHostAddress)  =>  $($context.Request.Url)" -f 'mag'
    #     Write-Host $FormContent -f 'Green'
    # 
    #     # the html/data
    #     [string]$html = "<h1>A Powershell Webserver</h1><p>Post Successful!</p>" 
    # 
    #     #resposed to the request
    #     $buffer = [System.Text.Encoding]::UTF8.GetBytes($html)
    #     $context.Response.ContentLength64 = $buffer.Length
    #     $context.Response.OutputStream.Write($buffer, 0, $buffer.Length)
    #     $context.Response.OutputStream.Close() 
    # }

    if ($context.Request.HttpMethod -eq 'GET' -and $context.Request.RawUrl -eq '/taskkill') {
        $run = $false
    }
}