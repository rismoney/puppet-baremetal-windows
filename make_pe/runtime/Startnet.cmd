wpeinit

rem add ruby to path
set path=X:\windows\system32;X:\ruby187\bin

rem we don't run ruby init because that will wipe config.yml
cd \devkit

ruby dk.rb install

rem add gems path
call gem install --local x:\gems\*.gem --no-rdoc --no-ri



cd \facter-1.6.x
ruby install.rb
cd \puppet-2.7.x
ruby install.rb

call X:\custom.cmd
