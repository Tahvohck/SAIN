# Fetch the version from EscapeFromTarkov.exe
$tarkovPath = 'S:\Games\Fika - SPT 3.11.x\EscapeFromTarkov.exe' -f $PSScriptRoot
$tarkovVersion = (Get-Item -Path $tarkovPath).VersionInfo.FileVersionRaw.Revision

# Update AssemblyVersion
$pluginSourcePath = '{0}\..\SAINPlugin.cs' -f $PSScriptRoot
Write-Host $pluginSourcePath
$versionPattern = '^([ \t]+public const int TarkovVersion = )\d+;'
(Get-Content $pluginSourcePath) | ForEach-Object {
    if ($_ -match $versionPattern){
        '{0}{1};' -f $matches[1],$tarkovVersion
    } else {
        $_
    }
} | Set-Content $pluginSourcePath