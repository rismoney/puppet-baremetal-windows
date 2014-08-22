wpeinit
REM see http://technet.microsoft.com/en-us/library/cc766390(v=ws.10).aspx 
REM drvload will add out of box drivers

for /f %%F in ('dir /s /b /OD x:\windows\inf\oem*.inf') do drvload %%F
rem add ruby to path
set path=X:\windows\system32;X:\Windows\System32\WindowsPowerShell\v1.0;X:\ruby193\bin;

REM  we don't run ruby init because that will wipe config.yml
cd \devkit

ruby dk.rb install

REM the process to install puppet from source was gleaned from here:
REM http://docs.puppetlabs.com/windows/from_source.html

rem add gems path
call gem install --no-ri --no-rdoc --local X:\gems\win32-api-1.4.8-x86-mingw32.gem
call gem install --no-ri --no-rdoc --local X:\gems\windows-api-0.4.2.gem
call gem install --no-ri --no-rdoc --local X:\gems\windows-pr-1.2.2.gem
call gem install --no-ri --no-rdoc --local X:\gems\win32-security-0.1.4.gem
call gem install --no-ri --no-rdoc --local X:\gems\ffi-1.9.0-x86-mingw32.gem
call gem install --no-ri --no-rdoc --local X:\gems\json_pure-1.8.1.gem
call gem install --no-ri --no-rdoc --local X:\gems\win32-dir-0.4.8.gem
call gem install --no-ri --no-rdoc --local X:\gems\json_pure-1.8.1.gem
call gem install --no-ri --no-rdoc --local X:\gems\*.gem
rem bundle install --gemfile X:\Gemfile

cd \facter-2.1.0
ruby install.rb
cd \puppet-3.6.2
ruby install.rb

REM call actual work script after PE, facter, and puppet is installed
powershell.exe -ExecutionPolicy Unrestricted x:\custom.ps1

echo sleeping for 20 seconds.  press control-c to terminate batch without reboot
sleep 20
exit

