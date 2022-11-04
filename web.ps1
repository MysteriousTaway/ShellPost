# To create a new manifest:
#New-ModuleManifest .\data\module\manifest\ManifestName.psd1
# To import a module it has to be linked in manifest as root and then imported as this:
Import-Module ".\data\module\manifest\WebsiteConstructor.psd1" -Force -Verbose
Import-Module ".\data\module\manifest\SQLManager.psd1" -Force -Verbose
## Import manifest:
#$configJson = Get-Content "data/manifest.json"
## Convert to object
#$configObject = $configJson | ConvertFrom-Json
$run = $true
$ip = "127.0.0.1"
$port = "8080"
# ───── ❝ WEB SERVER START ❞ ─────
# Http Server
$http = [System.Net.HttpListener]::new()
# Hostname and port to listen on
$http.Prefixes.Add("http://$($ip):$($port)/")
# Start the Http Server 
$http.Start()

# INFINITE LOOP
# Used to listen for requests
while ($run) {
    $context = $http.GetContext()
    # http://127.0.0.1/
    if ($context.Request.HttpMethod -eq 'GET' -and $context.Request.RawUrl -eq '/') {

        # We can log the request to the terminal
        write-host "$($context.Request.UserHostAddress)  =>  $($context.Request.Url)" -f 'mag'
        
        [string]$html = GetFromFile -RawUrl "data/static/main.html" -Surround ""
        
        #responded to the request
        $buffer = [System.Text.Encoding]::UTF8.GetBytes($html) # convert html to bytes
        $context.Response.ContentLength64 = $buffer.Length
        $context.Response.OutputStream.Write($buffer, 0, $buffer.Length) #stream to browser
        $context.Response.OutputStream.Close() # close the response
    }

    if ($context.Request.HttpMethod -eq 'POST' -and $context.Request.RawUrl -eq '/') {
        $FormContent = [System.IO.StreamReader]::new($context.Request.InputStream).ReadToEnd()
    
        # We can log the request to the terminal
        write-host "$($context.Request.UserHostAddress)  =>  $($context.Request.Url)" -f 'mag'
        Write-Host $FormContent -f 'Green'

        $Title = $FormContent.Split("&")[0].Split("=")[1]
        $Username = $FormContent.Split("&")[1].Split("=")[1]
        $Text = $FormContent.Split("&")[2].Split("=")[1]
        # the html/data
        [string]$html = ConstructHTML -Title $Title -Username $Username -Text $Text
    
        #responded to the request
        $buffer = [System.Text.Encoding]::UTF8.GetBytes($html)
        $context.Response.ContentLength64 = $buffer.Length
        $context.Response.OutputStream.Write($buffer, 0, $buffer.Length)
        $context.Response.OutputStream.Close() 
    }

    if ($context.Request.HttpMethod -eq 'GET' -and $context.Request.RawUrl -eq '/taskkill') {
        $run = $false
        
        # We can log the request to the terminal
        write-host "$($context.Request.UserHostAddress)  =>  $($context.Request.Url)" -f 'mag'
        
        [string]$html = "<h1> SERVER SHUTDOWN </h1>"
        
        #responded to the request
        $buffer = [System.Text.Encoding]::UTF8.GetBytes($html) # convert html to bytes
        $context.Response.ContentLength64 = $buffer.Length
        $context.Response.OutputStream.Write($buffer, 0, $buffer.Length) #stream to browser
        $context.Response.OutputStream.Close() # close the response
    }
}
# stop the server
$http.Stop()