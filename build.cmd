setlocal
call %~dp0..\vc_setup.cmd
set BUILD=builds\windows\vc2022
call :do_build "Debug Multithreaded" d
call :do_build "Release Multithreaded"
set LIB=lib
if not exist %LIB% md %LIB%
copy objs\vc2022\x64\* %LIB%\
title Done building FreeType
NuGet.exe pack freetype.nuspec -OutputDirectory %PACKAGES%\nuget_packages
endlocal

goto:eof

:do_build
  title Building FreeType %1
  msbuild /m %BUILD%\freetype.sln -p:Configuration=%1
  goto:eof
