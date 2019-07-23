[CmdletBinding()]

param
(
	[string]$connectionString #The connection string as per CRM Sdk
)

$ErrorActionPreference = "Continue" #
 $VerbosePreference = "Continue"
#Script Location
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
Write-Verbose "Script Path: $scriptPath"

$pw = Read-Host -assecurestring  -Prompt 'enter password'
$pw = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pw))




$connectionString = "AuthType=Office365;Url=https://sandbox.crm9.dynamics.com;Username=sheins@dhs.state.ia.us;Password=$pw"
$pw = ""

#Write-Verbose "ConnectionString = $connectionString"


$solutionname = "FACS"
Write-Verbose "Solution Name= $solutionname"

& "$scriptPath\Lib\xRMCIFramework\ExtractCustomizations.ps1" -Verbose -solutionPackager "$scriptPath\Lib\xRMCIFramework\SolutionPackager.exe" -solutionFilesFolder "$scriptPath\SolutionFiles" -mappingFile "$scriptPath\XrmCIFrameworkSampleMapping.xml" -solutionName $solutionname -connectionString $connectionString -TreatPackWarningsAsErrors $false

#Get-ChildItem *.* -Recurse | Unblock-File
#must be run in 64 bit ISE not 32 bit (X86) ISE - otherwise could not load file or dependencie because dlls are 64bit

$connectionString = ""