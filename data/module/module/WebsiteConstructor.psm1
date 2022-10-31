function ConstructHTML {
    [CmdletBinding()]
    param(
        # Style and functionality (Location):
        [Parameter(Mandatory=$true)]
        [String] $JS_Template_Path,
        [Parameter(Mandatory=$true)]
        [String] $CSS_Template_Path,
        # Where is the result is supposed to be saved:
        [Parameter(Mandatory=$true)]
        [String] $Final_Page_Location,
        [Parameter(Mandatory=$true)]
        [String] $PageType,
        # HTML parts to be loaded:
        # HTML file location:
        [Parameter(Mandatory=$true)]
        [String] $HTML_Template_Path,
        # Modifiers:
        # Values to be replaced in multi-mode for main page:
        [String[]] $Values
    )
    #Load templates from folder:
    [String] $js = GetFromFile -RawUrl $JS_Template_Path -Surround "script"
    [String] $css = GetFromFile -RawUrl $CSS_Template_Path -Surround "style"
    [String] $html = GetFromFile -RawUrl $HTML_Template_Path -Surround ""
    #[String] $html_header = GetFromFile -RawUrl $HTML_Header_Template_Path -Surround ""
    #[String] $html_body = GetFromFile -RawUrl $HTML_Body_Template_Path -Surround ""
    #[String] $html_footer = GetFromFile -RawUrl $HTML_Footer_Template_Path -Surround ""
    if ($PageType -eq "Multi") {
        # Construct final multi
        [String] $FinalBody = ConstructFinalBody_Multi  -js $js -css $css -HTMLTemplate $html -Values $Values
    } else {
        # Load main page:
        [String] $FinalBody = GetFromFile -RawUrl $HTML_Template_Path -Surround ""
    }
    
    # Save to file
    $FinalBody | Out-File -FilePath $Final_Page_Location -Encoding utf8 -Verbose 
}

function ConstructFinalBody_Multi{
    param($js,$css,$HTMLTemplate,$Values)
    # Split html template into header, body and footer using regex
    [String[]] $HTMLTemplateSplit = $HTMLTemplate -split "<!--SPLIT-->"
    # Replace values in body from values array
    for ($i = 0; $i -lt $Values.Count; $i = $i + 2) {
        [String] $add = $HTMLTemplateSplit[1] -replace $Values[$i], $Values[$i+1]
        # Verbose debug
        Write-Host "[DEBUG: WebsiteConstructor, ConstructFinalBody_Multi] Replaced $($Values[$i]) with $($Values[$i+1])" -ForegroundColor Yellow
        $Bodies = $Bodies + $add
    }
    [String] $return = $js + $css + $HTMLTemplateSplit[0] + [String]$Bodies + $HTMLTemplateSplit[2]
    # Write-Host "[DEBUG: WebsiteConstructor, ConstructFinalBody_Multi] Final html: $return" -ForegroundColor Yellow
    return $return
}

function GetFromFile {
    param ($RawUrl, $Surround)
    $raw = Get-Content -Raw $RawUrl
    if($Surround -ne "") {
        $return = "<" + $Surround + ">" + $raw + "</" + $Surround + ">"
    } else {
        $return = $raw
    }
    return $return
}

#function CountCharacters {
#    param ($String, $Char)
#    return ($String.ToCharArray() | Where-Object {$_ -eq $Char} | Measure-Object).Count
#}

Export-ModuleMember -Function ConstructHTML