function ConstructHTML {
    [CmdletBinding()]
    param(
        # Style and functionality (Location):
        [String] $JS_Template_Path,
        [String] $CSS_Template_Path,
        # HTML parts to be loaded:
        [String] $HTML_Header_Template_Path,
        [String] $HTML_Body_Template_Path,
        [String] $HTML_Footer_Template_Path,
        # Modifiers:
        # Number of posts defines how many times the body should be repeated in the final webpage
        # Deprecated: (Reason: Can count number of posts by counting the ; char in $HTML_Body_Regex)
        #[int] $NumberOfPosts,
        # Example: Name="dog",Value="frog";
        # What will this^ do ? it will find every word dog and replace it with frog
        [string] $HTML_Body_Regex,
        # Where is the result is supposed to be saved:
        [String] $Final_Page_Location,
        [String[]] $Values
    )
    #Load templates from folder:
    [String] $js = GetFromFile -RawUrl $JS_Template_Path -Surround "script"
    [String] $css = GetFromFile -RawUrl $CSS_Template_Path -Surround "style"
    [String] $html_header = GetFromFile -RawUrl $HTML_Header_Template_Path -Surround ""
    [String] $html_body = GetFromFile -RawUrl $HTML_Body_Template_Path -Surround ""
    [String] $html_footer = GetFromFile -RawUrl $HTML_Footer_Template_Path -Surround ""
    # Construct final
    $FinalBody = ConstructFinalBody  -js $js -css $css -HeaderTemplate $html_header -BodyTemplate $html_body -FooterTemplate $html_footer -Values $Values
    #TODO: REMOVE THIS!!:
    return $FinalBody
    #TODO: Add file saver if this shit works
}

function ConstructFinalBody{
    param($js,$css,$HeaderTemplate,$BodyTemplate,$FooterTemplate,$Values)
    # get number of bodies
    [String] $Final
    #[int] $NumberOfPosts = CountCharacters -String $HTML_Body_Regex -Char ";"
    [String[]] $Bodies
    # Iterates over array of names and values and replaces each name with value.
    Write-Host $Values
    # TODO: Or at least it should KEKW
    for ($i = 0; $i -lt $Values.Count; $i = $i + 2) {
        [String] $add = $BodyTemplate -replace $Values[$i], $Values[$i+1]
        $Bodies = $Bodies + $add
    }
    # Put them together :D
    [String] $return = $js + $css + $HeaderTemplate + [String]$Bodies + $FooterTemplate
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

function CountCharacters {
    param ($String, $Char)
    return ($String.ToCharArray() | Where-Object {$_ -eq $Char} | Measure-Object).Count
}

Export-ModuleMember -Function ConstructHTML