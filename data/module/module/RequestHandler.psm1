Import-Module ".\data\module\manifest\WebsiteConstructor.psd1" -Force
function HandleGET {
    param(
        [String] $RawURL,
        $jsonManifest
    )
    if($RawURL -eq "/") { $RawURL = "Main"}
    return GetFile -RawUrl $jsonManifest.Location.$($RawUrl)
}

function GetFile {
    param ($RawUrl)
    return Get-Content -Raw $RawUrl
}

Export-ModuleMember -Function HandleGET