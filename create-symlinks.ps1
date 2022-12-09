Param(
    [Parameter(Mandatory = $false)]
    [String] $gmodPath = "",

    [Parameter(Mandatory = $false)]
    [Switch] $help
)

if ($help -eq $true) {
    Write-Output "`"create-symlinks`" - Creates symbolic links for all in-development addon folders located here into a specified gmod instance `"addons`" folder."
    Write-Output "`n-- Arguments --`n"

    Write-Output "-GmodPath `t The install directory for your gmod server instance."

    exit
}

$txt = "./gmodpath.txt"

if ($gmodPath -ne "") {
    if ((Test-Path -Path $txt -PathType Leaf) -eq $false) {
        Write-Output "Creating gmodpath.txt...`n"
        New-Item -path $txt
        Write-Output "`n"
    }

    Write-Output "Writing `"$gmodPath`" to `"$txt`""
    Set-Content -Path $txt -Value $gmodPath
}

Write-Output "Reading path..."
$gmodPath = Get-Content -Path $txt

$dirs = $(Get-ChildItem "./" -Directory -Force -ErrorAction SilentlyContinue)
$addonDir = "$gmodPath/garrysmod/addons/"

foreach($d in $dirs) {
    if ($d -like ".*") {continue}

    Write-Output "Creating symlink for `"$d`" in `"$addonDir/$d`"..."
    New-Item -ItemType SymbolicLink -Path "$addonDir/$d" -Target $d -Force
}

Write-Output "Done!"