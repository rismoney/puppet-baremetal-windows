function Unzip7-File {
  param (
  [string] $ZipFile = $(throw "ZipFile must be specified."),
  [string] $OutputDir = $(throw "OutputDir must be specified.")
  )

  $zipcommand = join-path "$downloadfolder" "7z.exe"

  if (!(Test-Path $ZipCommand)) {
    throw "7z.exe was not found at $ZipCommand."
  }
  set-alias zip $ZipCommand


  if (!(Test-Path($ZipFile))) {
    throw "Zip filename does not exist: $ZipFile"
    return
  }

  zip x -y "-o$OutputDir" $ZipFile "-aos"
  if (!$?) {
    throw "7-zip returned an error unzipping the file."
  }
}