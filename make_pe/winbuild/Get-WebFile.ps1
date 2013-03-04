## Function Get-WebFile (aka wget for PowerShell)
## Author: Joel Bennett and
## Peter Kriegel http://www.admin-source.de
## Original : http://poshcode.org/417
##
##############################################################################################################
## Downloads a file or page from the web
## History:
## v3.7 - Add Proxy support, check if a proxy is required and get credentials for it
##        -ProxyAdress to Set the Adress of a Proxy Server
##        -ProxyPort to Set the Port of a Proxy Server
##        -ProxyUserName to Set the Username for the Proxy Server
##        -ProxyUserPassword to Set the Password for the Proxy Server
##        -ProxyUserDomain to Set the Domain which is used with the user for the Proxy Server
##        -$userAgent cookie container to prevent the error with too many automatic redirections using a httpWebRequest in .NET
##        Author: Peter Kriegel
## v3.6 - Add -Passthru switch to output TEXT files
## v3.5 - Add -Quiet switch to turn off the progress reports ...
## v3.4 - Add progress report for files which don't report size
## v3.3 - Add progress report for files which report their size
## v3.2 - Use the pure Stream object because StreamWriter is based on TextWriter:
##        it was messing up binary files, and making mistakes with extended characters in text
## v3.1 - Unwrap the filename when it has quotes around it
## v3   - rewritten completely using HttpWebRequest + HttpWebResponse to figure out the file name, if possible
## v2   - adds a ton of parsing to make the output pretty
##        added measuring the scripts involved in the command, (uses Tokenizer)
##############################################################################################################
Function Get-WebFile {
   [CmdletBinding(SupportsShouldProcess=$False)]
   param(
      [Parameter(Mandatory=$true)]
      [String]$url,
      [Parameter(Mandatory=$false)]
      [String]$fileName,
          [String]$ProxyAdress = $Null,
          [Int]$ProxyPort = 0,
          [String]$ProxyUserName = '',
          [String]$ProxyUserPassword = '',
          [String]$ProxyUserDomain = '',
          [String]$userAgent = 'JoelBennett417Get-WebFile',
      [switch]$Passthru,
      [switch]$quiet
   )
 
   $req = [System.Net.HttpWebRequest]::Create($url);
       
        $webclient = new-object System.Net.WebClient
       
        If($ProxyAdress.length -eq 0){ # no Proxy is given by the User
                # check if a proxy is required
                If (!$webclient.Proxy.IsBypassed($url)) {
                        $creds = [net.CredentialCache]::DefaultCredentials
                    if ($creds -eq $null) {
                      Write-Debug "Default credentials were null. Attempting backup method"
                      $cred = get-credential
                      $creds = $cred.GetNetworkCredential()
                    }
                    $proxyaddress = $webclient.Proxy.GetProxy($url).Authority
                    Write-Verbose "Using this proxyserver: $proxyaddress"
                    $proxy = New-Object System.Net.WebProxy($proxyaddress)
                    $proxy.credentials = $creds
                    $req.proxy = $proxy
                }
        }
        Else { # Proxy was given by the User
                 If($ProxyPort -gt 0){
                                $proxy = New-Object System.Net.WebProxy($ProxyAdress,$ProxyPort)
                        }
                        Else {
                                $proxy = New-Object System.Net.WebProxy($ProxyAdress)
                        }
                       
                        If($ProxyUserName.length -gt 0){
                                # if username is given we create the credentials
                                $creds = New-Object System.Net.NetworkCredential($ProxyUserName,$ProxyUserPassword,$ProxyUserDomain)   
                        }
                        Else {
                                # if no username is given try to get the default credentials
                                $creds = [net.CredentialCache]::DefaultCredentials
                        }
                       
                    if ($creds -eq $null) {
                          # no credentials given or found so we as for it
                      Write-Debug "Default credentials were null. Attempting backup method"
                      $cred = get-credential
                      $creds = $cred.GetNetworkCredential()
                    }
                       
                        $proxy.credentials = $creds
                    $req.proxy = $proxy
        }
       
        #http://stackoverflow.com/questions/518181/too-many-automatic-redirections-were-attempted-error-message-when-using-a-httpw
        $req.CookieContainer = New-Object System.Net.CookieContainer
    if ($userAgent -ne $null) {
         Write-Debug "Setting the UserAgent to `'$userAgent`'"
         $req.UserAgent = $userAgent
    }
 
    $res = $req.GetResponse();
 
 
   if($fileName -and !(Split-Path $fileName)) {
      $fileName = Join-Path (Get-Location -PSProvider "FileSystem") $fileName
   }
   elseif((!$Passthru -and ($fileName -eq $null)) -or (($fileName -ne $null) -and (Test-Path -PathType "Container" $fileName)))
   {
      [string]$fileName = ([regex]'(?i)filename=(.*)$').Match( $res.Headers["Content-Disposition"] ).Groups[1].Value
      $fileName = $fileName.trim("\/""'")
      if(!$fileName) {
         $fileName = $res.ResponseUri.Segments[-1]
         $fileName = $fileName.trim("\/")
         if(!$fileName) {
            $fileName = Read-Host "Please provide a file name"
         }
         $fileName = $fileName.trim("\/")
         if(!([IO.FileInfo]$fileName).Extension) {
            $fileName = $fileName + "." + $res.ContentType.Split(";")[0].Split("/")[1]
         }
      }
      $fileName = Join-Path $env:TEMP $fileName
   }
   if($Passthru) {
      $encoding = [System.Text.Encoding]::GetEncoding($res.CharacterSet ) # 'utf-8'
      [string]$output = ""
   }
 
   if($res.StatusCode -eq 200) {
      [int]$goal = $res.ContentLength
      $reader = $res.GetResponseStream()
      if($fileName) {
         $writer = new-object System.IO.FileStream $fileName, "Create"
      }
      [byte[]]$buffer = new-object byte[] 1048576
      [int]$total = [int]$count = 0
      do
      {
         $count = $reader.Read($buffer, 0, $buffer.Length);
         if($fileName) {
            $writer.Write($buffer, 0, $count);
         }
         if($Passthru){
            $output += $encoding.GetString($buffer,0,$count)
         } elseif(!$quiet) {
            $total += $count
            if($goal -gt 0) {
               Write-Progress "Downloading $url" "Saving $total of $goal" -id 0 -percentComplete (($total/$goal)*100)
            } else {
               Write-Progress "Downloading $url" "Saving $total bytes..." -id 0
            }
         }
      } while ($count -gt 0)
 
      $reader.Close()
      if($fileName) {
         $writer.Flush()
         $writer.Close()
      }
      if($Passthru){
         $output
      }
   }
   $res.Close();
   if($fileName) {
      ls $fileName
   }
}