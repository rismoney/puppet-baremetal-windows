wpeinit

rem add ruby to path
set path=X:\windows\system32;X:\ruby187\bin

rem we don't run ruby init because that will wipe config.yml
cd \devkit

ruby dk.rb install

rem add gems path
call gem install --local X:\gems\win32-security-0.1.2.gem
call gem install --local X:\gems\*.gem
rem bundle install --gemfile X:\Gemfile

cd \facter-1.6.x
ruby install.rb
cd \puppet-2.7.x
ruby install.rb

X:\windows\system32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Unrestricted x:\custom.ps1
