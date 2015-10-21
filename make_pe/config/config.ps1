$downloadfolder="C:\download"
$mountfolder="C:\mount"
$driverfolder="C:\PEdrivers"
$adkfolder = 'C:\Program Files (x86)\Windows Kits\8.0'
$puppetmaster = 'puppet.inf.ise.com'
$bitversion = "amd64"
$winpefolder="C:\WinPE_$bitversion"

$imagex = "$adkfolder\Assessment and Deployment Kit\Deployment Tools\$bitversion\DISM\imagex.exe"
$dism = "$adkfolder\Assessment and Deployment Kit\Deployment Tools\$bitversion\DISM\dism.exe"

$oscdimg = "$adkfolder\Assessment and Deployment Kit\Deployment Tools\$bitversion\Oscdimg\oscdimg.exe"

$zip1url= "https://s3-us-west-2.amazonaws.com/s3-2015-10-com-ise-pub/winpe/7z.exe"
$zip1file = "C:\download\7z.exe"
$zip2url= "https://s3-us-west-2.amazonaws.com/s3-2015-10-com-ise-pub/winpe/7z.dll"
$zip2file = "C:\download\7z.dll"


$rubyurl = "http://dl.bintray.com/oneclick/rubyinstaller/ruby-2.0.0-p645-x64-mingw32.7z?direct"
$rubyfile = "C:\download\ruby-2.0.0-p645-x64-mingw32.7z"

$devkit = "http://dl.bintray.com/oneclick/rubyinstaller/DevKit-mingw64-64-4.7.2-20130224-1432-sfx.exe"
$devkitfile = "C:\download\DevKit-mingw64-64-4.7.2-20130224-1432-sfx.exe"

$facter = "https://github.com/puppetlabs/facter/archive/2.4.4.zip"
$facterfile = "C:\download\2.4.4.zip"

$puppeturl = "https://github.com/puppetlabs/puppet/archive/3.8.3.zip"
$puppetfile = "c:\download\3.8.3.zip"

$dhcptoolurl = "http://files.thecybershadow.net/dhcptest/dhcptest-0.5-win64.exe"
$dhcptoolfile = "C:\download\dhcptest-0.5-win64.exe"


$patchurl = "http://downloads.sourceforge.net/project/gnuwin32/patch/2.5.9-7/patch-2.5.9-7-bin.zip?r=&ts=1362969672&use_mirror=voxel"
$patchfile = "C:\download\patch-2.5.9-7-bin.zip"

$gemlist = (
  #'http://rubygems.org/downloads/bundler-1.3.2.gem',
  'https://rubygems.org/downloads/ffi-1.9.5-x64-mingw32.gem',
  #'https://rubygems.org/downloads/sys-admin-1.5.6-x86-mingw32.gem',
  #'https://rubygems.org/downloads/win32-api-1.4.8-x86-mingw32.gem',
  'https://rubygems.org/downloads/win32-dir-0.4.9.gem',
  'https://rubygems.org/downloads/win32-eventlog-0.6.2.gem',
  'https://rubygems.org/downloads/win32-process-0.7.4.gem',
  'https://rubygems.org/downloads/win32-security-0.2.5.gem',
  'https://rubygems.org/downloads/win32-service-0.8.6.gem',
  #'https://rubygems.org/downloads/win32-taskscheduler-0.2.2.gem',
  #'https://rubygems.org/downloads/win32console-1.3.2-x86-mingw32.gem',
  #'https://rubygems.org/downloads/win32console-1.3.2.gem',
  #'https://rubygems.org/downloads/windows-api-0.4.2.gem',
  #'https://rubygems.org/downloads/windows-pr-1.2.2.gem',
  'https://rubygems.org/downloads/minitar-0.5.4.gem',
  'https://rubygems.org/downloads/json_pure-1.8.2.gem',
  #'https://rubygems.org/downloads/rgen-0.6.5.gem',
  'https://rubygems.org/downloads/hiera-1.3.4.gem'
  )

#source for adk offline download all files 
#http://forums.mydigitallife.info/threads/36370-Windows-8-ADK-Offline-Downloader-Tool/page3?p=691453&viewfull=1#post691453

# deptools is a subset and not used at this time.
$deptools = (
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/Windows Deployment Tools-x86_en-us.msi',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/0c48c56ca00155f992c30167beb8f23d.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/3b71855dfae6a44ab353293c119908b8.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/5d984200acbde182fd99cbfbe9bad133.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/36e3c2de16bbebad20daec133c22acb1.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/56dd07dea070851064af5d29cadfac56.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/69f8595b00cf4081c2ecc89420610cbd.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/413a073d16688e177d7536cd2a64eb43.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/500e0afd7cc09e1e1d6daca01bc67430.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/630e2d20d5f2abcc3403b1d7783db037.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/662ea66cc7061f8b841891eae8e3a67c.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/870d7f92116bc55f7f72e7a9f5d5d6e1.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/1439dbcbd472f531c37a149237b300fc.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/2517aec0259281507bfb693d7d136f30.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/8624feeaa6661d6216b5f27da0e30f65.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/9050f238beb90c3f2db4a387654fec4b.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/a7eb3390a15bcd2c80a978c75f2dcc4f.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/a011a13d3157dae2dbdaa7090daa6acb.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/abbeaf25720d61b6b6339ada72bdd038.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/b6758178d78e2a03e1d692660ec642bd.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/bbf55224a0290f00676ddc410f004498.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/c98a0a5b63e591b7568b5f66d64dc335.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/d2611745022d67cf9a7703eb131ca487.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/ea9c0c38594fd7df374ddfc620f4a1fd.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/eacac0698d5fa03569c86b25f90113b5.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/f2a850bce4500b85f37a8aaa71cbb674.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/f480ed0b7d2f1676b4c1d5fc82dd7420.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/fcc051e0d61320c78cac9fe4ad56a2a2.cab'
)

# full adk not needed.  but left here for reference
$adklist= (
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/adksetup.exe',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/035c64a427383070735ec20952cb2f4b.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/036c618de505eeb40cca35afad6264f5.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/0765ac62eb011b854b5a09f807cf3ae1.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/0a3a39d2f8a258e1dea4e76da0ec31b8.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/0b63b7c537782729483bff2d64a620fa.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/0c48c56ca00155f992c30167beb8f23d.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/0ce2876e9da7f82aac8755701aecfa64.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/0d981f062236baed075df3f42b1747db.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/0e46101fbce444baccdd11de8eeb0912.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/11bdc4a4637c4d7ab86107fd13dcb9c6.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/13d6f0cdd9f32c850d1f4c4509494184.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/1439dbcbd472f531c37a149237b300fc.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/158211324176e5cb114e21c6716d44a5.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/1620efa4ffe2a6563530bd0158b17fe6.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/17c9d60f2bc5bc54c58782d614afcbf0.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/18d24450bddd70c148f86bcfceacf59d.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/18da5aa8b15cb7ace8598742eb63ce18.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/18e5e442fc73caa309725c0a69394a46.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/23ca402f61cda3f672b3081da79dab63.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/24b9e5f1f97c2f05aa95ee1f671fd3cc.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/2517aec0259281507bfb693d7d136f30.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/268b1a41f6bd2906449944b964bf7393.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/28ee6e1d002e82e00e15dc241e27a3d7.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/2f7e63a939046379735382c19c0f2247.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/3585b51691616d290315769bec85eb6f.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/3611bd81544efa3deb061718f15aee0c.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/36e3c2de16bbebad20daec133c22acb1.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/377a2b6b26ea305c924c25cf942400d6.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/3814eaa1d4e897c02ac4ca93e7e7796a.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/38d93b8047d5efb04cf01ab7ec66d090.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/39837d43d71c401e7edc9ba3e569cd69.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/3b71855dfae6a44ab353293c119908b8.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/3d610ba2a5a333717eea5f9db277718c.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/3dc1ed76e5648b575ed559e37a1052f0.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/3e8ac538609776347ea14be446d458a4.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/413a073d16688e177d7536cd2a64eb43.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/450f8c76ee138b1d53befd91b735652b.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/4d15138ec839ce36f5b68c16b332920a.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/4d2878f43060bacefdd6379f2dae89b0.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/4e56c6c11e546d4265da4e9ff7686b67.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/4fc82a5cedaab58e43b487c17f6ef6f3.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/500e0afd7cc09e1e1d6daca01bc67430.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/527b957c06e68ebb115b41004f8e3ad0.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/56dd07dea070851064af5d29cadfac56.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/56e5d88e2c299be31ce4fc4a604cede4.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/57007192b3b38fcd019eb88b021e21cc.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/5775a15b7f297f3e705a74609cb21bbc.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/5ac1863798809c64e85c2535a27a3da6.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/5d984200acbde182fd99cbfbe9bad133.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/625aa8d1c0d2b6e8cf41c50b53868ecd.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/630e2d20d5f2abcc3403b1d7783db037.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/662ea66cc7061f8b841891eae8e3a67c.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/6894c1e1e549c4ab533078e3ff2e92af.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/690b8ac88bc08254d351654d56805aea.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/69f8595b00cf4081c2ecc89420610cbd.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/6bdcd388323175da70d836a25654aa92.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/6d2cfb2c5343c33c8d9e54e7d1f613f9.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/6d3c63e785ac9ac618ae3f1416062098.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/6dc62760f8235e462db8f91f6eaa1d90.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/7011bf2f8f7f2df2fdd2ed7c82053d7f.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/7410e4c16d4e8319de73d79027b1d4c8.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/77adc85e5c49bbd36a91bb751dc55b39.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/781e7c95c1b6b277057c9b53b7b5a044.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/795573623ce59474b561fc40f38986eb.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/7ab29d7f105f1e7814198f23b60f8e5d.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/7c11b295fb7f25c6d684b1957e96a226.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/7c195d91008a0a6ad16e535ac228467d.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/83bd1072721871ea0bdc4fab780d9382.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/8624feeaa6661d6216b5f27da0e30f65.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/86ae476dfe0498a5b5d1b6f3076412c7.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/870d7f92116bc55f7f72e7a9f5d5d6e1.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/8a7f515d1665d4120c1be4b4f9d78b92.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/8c27542f7954c25af62730fbb1e211d2.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/9050f238beb90c3f2db4a387654fec4b.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/93ed81ef8cf2e77c6ebc8aba5d95b9cf.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/94cae441bc5628e21814208a973bbb9d.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/9722214af0ab8aa9dffb6cfdafd937b7.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/a011a13d3157dae2dbdaa7090daa6acb.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/a03686381bcfa98a14e9c579f7784def.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/a1d26d38d4197f7873a8da3a26fc351c.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/a30d7a714f70ca6aa1a76302010d7914.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/a32918368eba6a062aaaaf73e3618131.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/a40aea453ac3e9dd8951c2b125a5fd6f.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/a4d2213cc44fd2ac2de44c6ad98e88ce.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/a565f18707816c0d052281154b768ac0.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/a7eb3390a15bcd2c80a978c75f2dcc4f.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/aa25d18a5fcce134b0b89fb003ec99ff.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/aa4db181ead2227e76a3d291da71a672.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/ab3291752bc7a02f158066789e9b0c03.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/abadc0ace44c6ba5cad01e2d1408a45f.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/abbeaf25720d61b6b6339ada72bdd038.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/ac9ff098e23012b74624db792b538132.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/Application Compatibility Toolkit-x64_en-us.msi',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/Application Compatibility Toolkit-x86_en-us.msi',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/Assessments on Client-x86_en-us.msi',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/Assessments on Server-x86_en-us.msi',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/b0189bdfbad208b3ac765f88f21a89df.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/b3892d561b571a5b8c81d33fbe2d6d24.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/b5227bb68c3d4641d71b769e3ac606a1.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/b6758178d78e2a03e1d692660ec642bd.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/bbf55224a0290f00676ddc410f004498.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/bc1fef9daa903321722c08ce3cf51261.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/bd748d6fbff59b2a58cebdb99c3c6747.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/be7ebc1ac434ead4ab1cf36e3921b70e.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/c0f42c479da796da513cc5592f0759d3.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/c6babfeb2e1e6f814e70cacb52a0f923.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/c98a0a5b63e591b7568b5f66d64dc335.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/ccf0b1fb9a1f20998b153c44684575a9.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/cd23bfdfd9e3dfa8475bf59c2c5d6901.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/cfb8342932e6752026b63046a8d93845.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/d2611745022d67cf9a7703eb131ca487.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/d3a3cb9f097a2b86cba7143489e77275.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/d562ae79e25b943d03fc6aa7a65f9b81.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/d5ab5e5d3b38824af1c714c289999949.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/d5abe4833b23e13dc7038bde9c525069.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/dotNetFx40_Full_x86_x64.exe',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/e5f4f4dc519b35948be4500a7dfeab14.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/e65f08c56c86f4e6d7e9358fa99c4c97.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/ea9c0c38594fd7df374ddfc620f4a1fd.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/eacac0698d5fa03569c86b25f90113b5.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/ed711e0a0102f1716cc073671804eb4c.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/eebe1a56de59fd5a57e26205ff825f33.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/f17080a8c785c47fe4714b7ad2c797e2.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/f18258d399eda9b42c75b358b9e9fc62.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/f2a850bce4500b85f37a8aaa71cbb674.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/f480ed0b7d2f1676b4c1d5fc82dd7420.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/f678c5f13eb8d66bba79685df79a5fa7.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/f7699e5a82dcf6476e5ed2d8a3507ace.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/fa7c072a4c8f9cf0f901146213ebbce7.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/fbcf182748fd71a49becc8bb8d87ba92.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/fcc051e0d61320c78cac9fe4ad56a2a2.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/fd5778f772c39c09c3dd8cd99e7f0543.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/fe43ba83b8d1e88cc4f4bfeac0850c6c.cab',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/Kits Configuration Installer-x86_en-us.msi',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/Microsoft Compatibility Monitor-x86_en-us.msi',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/SQLEXPR_x86_ENU.exe',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/Toolkit Documentation-x86_en-us.msi',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/User State Migration Tool-x86_en-us.msi',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/Volume Activation Management Tool-x86_en-us.msi',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/wasinstaller.exe',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/WimMountAdkSetupAmd64.exe',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/WimMountAdkSetupX86.exe',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/Windows Assessment Services - Client (AMD64 Architecture Specific, Client SKU)-x86_en-us.msi',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/Windows Assessment Services - Client (AMD64 Architecture Specific, Server SKU)-x86_en-us.msi',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/Windows Assessment Services - Client (Client SKU)-x86_en-us.msi',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/Windows Assessment Services - Client (Server SKU)-x86_en-us.msi',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/Windows Assessment Services - Client (X86 Architecture Specific, Client SKU)-x86_en-us.msi',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/Windows Assessment Services-x86_en-us.msi',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/Windows Assessment Toolkit (AMD64 Architecture Specific)-x86_en-us.msi',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/Windows Assessment Toolkit (X86 Architecture Specific)-x86_en-us.msi',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/Windows Assessment Toolkit-x86_en-us.msi',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/Windows Deployment Customizations-x86_en-us.msi',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/Windows Deployment Tools-x86_en-us.msi',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/Windows PE x86 x64 wims-x86_en-us.msi',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/Windows PE x86 x64-x86_en-us.msi',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/Windows System Image Manager on amd64-x86_en-us.msi',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/Windows System Image Manager on x86-x86_en-us.msi',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/WPT Redistributables-x86_en-us.msi',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/WPTarm-arm_en-us.msi',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/WPTx64-x86_en-us.msi',
  'http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/Installers/WPTx86-x86_en-us.msi'
)
