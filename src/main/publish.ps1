$msbuild = join-path -path (Get-ItemProperty "HKLM:\software\Microsoft\MSBuild\ToolsVersions\14.0")."MSBuildToolsPath" -childpath "msbuild.exe"
&$msbuild .\interface\IWebsocketLite.PCL\IWebsocketClientLite.PCL.csproj /t:Build /p:Configuration="Release"
&$msbuild WebsocketClientLite.PCL.csproj /t:Build /p:Configuration="Release"

$version = [Reflection.AssemblyName]::GetAssemblyName((resolve-path '..\interface\IWebsocketLite.PCL\bin\Release\IWebsocketClientLite.PCL.dll')).Version.ToString(3)

Remove-Item .\NuGet -Force -Recurse
New-Item -ItemType Directory -Force -Path .\NuGet

NuGet.exe pack WebsocketClientLite.PCL.nuspec -Verbosity detailed -Symbols -OutputDir "NuGet" -Version $version

Nuget.exe push .\Nuget\WebsocketClientLite.PCL.$version.nupkg -Source https://www.nuget.org