Date: Fri, 08 Jan 1999 16:40:03 -0500
From: Beecher Greenman <rbg6038@ritvax.isc.rit.edu>
Subject: Pre-Rc Install
To: linuxppc-dev@lists.linuxppc.org
Message-id: <01J6AZH6MVB2GM3Y0P@ritvax.isc.rit.edu>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm on a rev3 G3/300 desktop with the standard video (though I put four 
more megs of VRAM in it), 64 MB RAM, and 128M swap. I'm trying to install 
LinuxPPC Pre-R5 on an internal 2 GB hard drive which already has R4 
installed (I can stand to format the drive if need be). Anyway, when I 
went to try running the installer, I ren into a few problems...

1) The kernel rejects the live installer out of hand. It claims there's 
something wrong with the ramdisk image, giving about 5 gazillion errors 
to that effect and then halting the boot process (though the kernel does 
not appear to freeze).
2) FTP install doesn't work from ftp.linuxppc.org or biggi.linuxppc.org, 
under DHCP or static IP.
3) I managed to download the RedHat directory from biggi.linuxppc.org and 
put it on an external SCSI hard drive. When I try to mount it in the 
installer, however, I get an "invalid argument" error and can't proceed 
any further. Note that when running under LinuxPPC R4 this drive mounts 
just fine.

After seeing the large number of e-mails about this install process on 
the list, I figured I'm doing something wrong, but none of the mails 
appear to match up with this situation. Anyone have any ideas? Also, is 
there a HOWTO anywhere on the Net about this? Thanks!

-Beecher Greenman

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
