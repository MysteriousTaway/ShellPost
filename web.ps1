# To create a new manifest:
#New-ModuleManifest .\data\module\manifest\ManifestName.psd1

# To import a module it has to be linked in manifest as root and then imported as this:
Import-Module .\data\module\manifest\WebsiteConstructor.psd1 -Force
# Testing
$html = ConstructHTML -JS_Template_Path "./data/templates/Main.js" -CSS_Template_Path "./data/templates/Main.css" -HTML_Header_Template_Path "./data/templates/MainHeader.html" -HTML_Body_Template_Path "./data/templates/MainBody.html" -HTML_Footer_Template_Path "./data/templates/MainFooter.html" -HTML_Body_Regex "Name=`"cow`",Value=`"rabbit`";Name=`"cow`",Value=`"frog`";"
Write-Host $html