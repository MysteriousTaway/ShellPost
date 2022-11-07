function ConstructHTML {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)] [string]$Title,
        [Parameter(Mandatory=$true)] [string]$Username,
        [Parameter(Mandatory=$true)] [string]$Text,
        [Parameter(Mandatory=$true)] [string]$ENV
    )
    $HTML_URL = "$($ENV)data/template/page.html"
    $STYLE_URL = "$($ENV)data/template/style.css"
    $SCRIPT_URL = "$($ENV)data/template/script.js"

    $HTML += GetFromFile -RawUrl $HTML_URL
    $HTML = $HTML.Replace("{{title}}", $Title)
    $HTML = $HTML.Replace("{{username}}", $Username)
    $HTML = $HTML.Replace("{{text}}", $Text)
    $HTML += GetFromFile -RawUrl $STYLE_URL -Surround "style"
    $HTML += GetFromFile -RawUrl $SCRIPT_URL -Surround "script"
    
    return $HTML
}

function GetFromFile {
    param (
        [Parameter(Mandatory=$true)] [string]$RawUrl,
        [string]$Surround = ""
    )
    $raw = Get-Content -Raw $RawUrl
    if($Surround -ne "") {
        $return = "<" + $Surround + ">" + $raw + "</" + $Surround + ">"
    } else {
        $return = $raw
    }
    return $return
}

Export-ModuleMember -Function GetFromFile
Export-ModuleMember -Function ConstructHTML