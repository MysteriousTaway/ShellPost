# To create a new manifest:
#New-ModuleManifest .\data\module\manifest\ManifestName.psd1

# To import a module it has to be linked in manifest as root and then imported as this:
Import-Module .\data\module\manifest\WebsiteConstructor.psd1 -Force