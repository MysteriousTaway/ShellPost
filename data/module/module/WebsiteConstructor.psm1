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
        [int] $NumberOfPosts,
        # Example: [Name="kokot",Value="kokos"]
        # What will this^ do ? it will find every word kokot and replace it with kokos
        [string] $HTML_Body_Regex,
        # Where is the result is supposed to be saved:
        [String] $Final_Page_Location
    )
    #Load templates from folder:
    $js = GetFromFile -RawUrl $JS_Template_Path -Surround "script"
    $css = GetFromFile -RawUrl $CSS_Template_Path -Surround "style"
    $html_header = GetFromFile -RawUrl $HTML_Header_Template_Path -Surround ""
    $html_body = GetFromFile -RawUrl $HTML_Header_Template_Path -Surround ""
    $html_footer = GetFromFile -RawUrl $HTML_Header_Template_Path -Surround ""
}

function GetFromFile {
    param ($RawUrl, $Surround)
    $raw = Get-Content -Raw $location
    if($Surround -ne "") {
        $return = "<" + $Surround + ">" + $raw + "</" + $Surround + ">"
    } else {
        $return = $raw
    }
    return $return
}

Export-ModuleMember -Function ConstructHTML