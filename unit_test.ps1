[Boolean[]]$Tests = $false,$false,$false
try {
$error.Clear()
# ───── ❝ TEST 0 ❞ ─────
# Import Modules
Import-Module ".\data\module\manifest\WebsiteConstructor.psd1" -Force -Verbose
Import-Module ".\data\module\manifest\RequestHandler.psd1" -Force -Verbose
Import-Module ".\data\module\manifest\SQLManager.psd1" -Force -Verbose
} catch {
    Write-Error "[MODULE IMPORT ERROR]" $_ -ForegroundColor Red
} finally {
    if (!$error) {
        Write-Host "[MODULE IMPORT SUCCESS]" -ForegroundColor Green
        $Tests[0] = $true
    }
    $error.Clear()
}
# Import manifest:
$configJson = Get-Content "data/manifest.json"
# Convert to object
$configObject = $configJson | ConvertFrom-Json
# ───── ❝ TEST 1 ❞ ─────
try {
    Remove-Item -Path "./dev/test/website_constructor.html" -Force -ErrorAction Ignore
    Write-Host "[DELETED ./dev/test/website_constructor.html]" -f 'Yellow'
    [String[]] $Values = "cow","word","cow","word"
    ConstructHTML -JS_Template_Path $configObject.Page.Multi.Main.JS -CSS_Template_Path $configObject.Page.Multi.Main.CSS -HTML_Template_Path $configObject.Page.Multi.Main.HTML -Final_Page_Location "./dev/test/website_constructor.html" -Values $Values -PageType "Multi"
    $Tests[1] = Test-Path -Path "./dev/test/website_constructor.html"
} catch {
    Write-Host "[TEST 1 ERROR] ` " $_ -ForegroundColor Red
    $Tests[1] = $false
}

# ───── ❝ TEST 2 ❞ ─────
try {
    $connection = ConnectToSQLServer -Server $configObject.SQL_test.Server -Database $configObject.SQL_test.Database -Username $configObject.SQL_test.Username -Password $configObject.SQL_test.Password
    $connection.Close()
} catch {
    Write-Host "[TEST 2 ERROR] ` " $_ -ForegroundColor Red
} finally {
    if (!$error) {
        $Tests[2] = $true
    }
    $error.Clear()
}
# ───── ❝ OUTPUT ❞ ─────
# Output test data per test:
$i = 0
$passed = 0
foreach($s in $Tests) {
    if($s -eq $true) {
        Write-Host "[TEST $($i)] => PASSED!" -ForegroundColor Green
        $passed++
    } else {
        Write-Host "[TEST $($i)] => FAILED!" -ForegroundColor Red
    }
    $i = $i + 1
}
# Color based on tests passed:
if ($passed -eq $Tests.Count) {
    Write-Host "[TESTS PASSED: $($passed)/$($Tests.Count)]" -ForegroundColor Green
} else {
    Write-Host "[TESTS PASSED: $($passed)/$($Tests.Count)]" -ForegroundColor Red
}