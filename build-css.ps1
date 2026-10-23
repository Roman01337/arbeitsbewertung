# Erzeugt vendor/tailwind.css aus den in index.html verwendeten Klassen.
# Nach jeder Änderung an Tailwind-Klassen in index.html erneut ausführen.
# Lädt beim ersten Aufruf die Tailwind-CLI (v3.4.17, ca. 40 MB) nach tools/ herunter.

$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot

$cli = Join-Path $PSScriptRoot 'tools\tailwindcss.exe'
if (-not (Test-Path $cli)) {
  New-Item -ItemType Directory -Force (Split-Path $cli) | Out-Null
  Invoke-WebRequest 'https://github.com/tailwindlabs/tailwindcss/releases/download/v3.4.17/tailwindcss-windows-x64.exe' -OutFile $cli
}

& $cli -c tailwind.config.js -i tailwind.input.css -o vendor/tailwind.css --minify
