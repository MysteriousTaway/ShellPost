try {
# Import Modules
Import-Module ".\data\module\manifest\WebsiteConstructor.psd1" -Force
#Import-Module ".\data\module\manifest\RequestHandler.psd1" -Force
} catch {
    Write-Error "[MODULE IMPORT ERROR]"
}
# Import manifest:
$configJson = Get-Content "data/manifest.json"
# Convert to object
$configObject = $configJson | ConvertFrom-Json

[Boolean[]]$Tests = $false
#Test 0
try {
    Remove-Item -Path "./dev/test/website_constructor.html" -Force
    Write-Host "[DELETED ./dev/test/website_constructor.html]" -f 'Yellow'
    [String[]] $Values = "cow","word","cow","word"
    ConstructHTML -JS_Template_Path $configObject.Page.Multi.Main.JS -CSS_Template_Path $configObject.Page.Multi.Main.CSS -HTML_Template_Path $configObject.Page.Multi.Main.HTML -Final_Page_Location "./dev/test/website_constructor.html" -Values $Values -PageType "Multi"
} catch {
    Write-Host "[TEST 0 ERROR] ` " $_ -ForegroundColor Red
    $Tests[0] = $false
} finally {
    $Tests[0] = Test-Path -Path "./dev/test/website_constructor.html"
}

# Output test data:
$i = 0
foreach($s in $Tests) {
    if($s -eq $true) {
        Write-Host "[TEST $($i)] => PASSED!" -ForegroundColor Green
    } else {
        Write-Host "[TEST $($i)] => FAILED!" -ForegroundColor Red
    }
    $i = $i + 1
}