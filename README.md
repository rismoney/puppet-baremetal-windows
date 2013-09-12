puppet-baremetal-windows
========================

member of the rismoney suite of Puppet

## tl;dr: manage windows from baremetal to bar none

This project aims to integrate Puppet into WinPE 4.0 (the 'live' image from the Windows ADK).

This will bring total puppet coverage for a Windows node from baremetal all the way to the fully application
layered OS.


## How do I use this?
This is how I am using it.  This needs to be cleaned up into a single configuration point.
Right now I forked this from an internal project.

Edit relevant sections in make_pe\config.ps1

Edit puppetmaster in host-enforce.ps1 L55 (I am using my production puppet agent script until i refactor)

Edit runtime\custom.ps1 [1]

Put oem PE drivers in $driverfolder - default C:\PEDrivers [2]


## Status
This is now operational.  Puppet executes properly under Windows PE with this build
The ISO has been fully tested on VMWare, and baremetal via pxe servers (SysLinux)

Further tests are needed on other hypervisors ie VirtualBox, HyperV, etc

## Goals - automate everything: 
1. PXE boot to WinPE - Done!
2. Run Puppet under WinPE - Done!
3. OS installation - Done!
4. Run Puppet - EASY PEASY ONE TO THREESY - Done!


What is [Puppet] (www.puppetlabs.com)? 

Puppet is IT automation software that helps system administrators manage infrastructure throughout its lifecycle, from provisioning and configuration to patch management and compliance. Using Puppet, you can easily automate repetitive tasks, quickly deploy critical applications, and proactively manage change, scaling from 10s of servers to 1000s, on-premise or in the cloud.

## What is [ADK] 
(http://www.microsoft.com/en-us/download/details.aspx?id=30652)
Windows Deployment is for OEMs and IT professionals who customize and automate the large-scale installation of Windows, such as on a factory floor or across an organization. The Windows ADK supports this work with the deployment tools that were previously released as part of the OEM Preinstallation Kit (OPK) and the Windows Automated Installation Kit (AIK) and include Windows Preinstallation Environment, Deployment Imaging, Servicing and Management, and Windows System Image Manager. 

## Requirements - 
Minimum Win7+ Build host (I use a vanilla win7 VM to build iso)

The following will be downloaded and installed automatically via make_pe:
1. Windows ADK for Windows 8 (I chose this so we are not building around Win7/2008/older revs)
2. Facter from Source
3. Puppet from Source
4. Ruby 1.87 (Puppet on Windows only supports 1.8.7 currently)
5. Gems - see the list here https://github.com/rismoney/puppet-baremetal-windows/blob/master/make_pe/config/config.ps1#L24-L35
6. Gnu patch.exe - to workaround the minimalistic nature of the WinPE live image

## Relevant tidbits:
SysWow64 is not present in WinPE_x64 so we will use x86.  We will use imagex to deploy OS 32/64 bit OS, and not
run setup.exe.  This is ideal and fastest way to install.
EventViewer is not present in WinPE so we will patch puppet source (destinations.rb L254-258)
PXE server is your choice and is outside of scope for now
Testing has been on Win2008 R2 deployment but it could be any OS


# TODO 

## Operating System Build:

### optimization ideas
1. strip down winPE to only include bare minimum for speed - currently at ~350MB - could probably be ~150MB


# WHY?
I currently have complex build processes for our nodes.  Its awesome, and I hope to open source it one day.
But it is unnecessarily complex, because we want our cake and eat it too.  Every host permutation conceivable
is what we do.  I want disparate perfect unattended builds on unique hardware everytime.
The same build bootstrap system for desktops, laptops, servers, etc.  And I want it DONE with 1 command to set 
set it all up.  

Currently I have a minimalist sysprep, and perform a series of tasks post setup based on a series of 
version controlled files csv, yaml and txt file.  This process is now 15 steps, and requires a ton of reboots.
Everything from domain joins, renames, driver loads requires rebooting, dot net 4, you name it.
To have one data source - hiera yaml files.  To eliminate powershell scripts wherever possible.
To leverage the logic needed to build any type of host you want, just by editing a file
stored in version control.

[1] I use a custom facter fact that allows mocking host names.  This allows me to impersonate any host and not worry about MININT-###
I opensourced 2 mocking components as relevant config items.

[2] WinPE Drivers (the big 3)
HP puts theirs  http://h18004.www1.hp.com/products/servers/management/toolkit/stk/index.html
Dell puts theirs http://www.dell.com/support/drivers/us/en/555/DriverDetails?driverId=FPKJR&fileId=2731119569
IBM Puts theirs http://www-947.ibm.com/support/entry/portal/docdisplay?lndocid=migr-5082208
