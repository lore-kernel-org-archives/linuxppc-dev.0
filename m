Message-ID: <BFC0587634C3D111AACB00805FA766FA02C1C636@exchny12.ny.smb.com>
From: "Velasquez, Carlos" <carlos.velasquez@ssmb.com>
To: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: Help! X video problems...
Date: Fri, 9 Jul 1999 12:12:32 -0400 
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

Well, after trying to unsuccessfully get X running (or Gnome or KDE)
on my S900 I thought I would post my problem to the Linux masses.....

Background info....
I have a Umax S900 604e @225Mhz mac clone running MacOS 8.1 with 162 Meg of
ram. My S900 came stock with an ixMicro (formerly Twin Turbo) 8Meg video
card and an NEC XV15" multisync monitor. I have linux installed and I
downloaded the latest XFree86 rpms from the web. I boot into
Linux via BootX v1.1.1 and have the "No Video Driver" option checked.

The first problem...
First thing I did was rpm -Uvh all the XFree86 packages. The fonts packages
all returned errors. More specifically, doing:
rpm -Uvh --force --nodeps /mnt/HDISK1/XFree86-75dpi-fonts-3.3.3.1.rpm
rpm -Uvh --force --nodeps /mnt/HDISK1/XFree86-100dpi-fonts-3.3.3.1.rpm
rpm -Uvh --force --nodeps /mnt/HDISK1/XFree86-cyrillic-fonts-3.3.3.1.rpm
all return the error message:
chkfontpath: bad argument -q:unknown option
What does this mean???

The second problem...
After running Xautoconfig and startx (in that order) I get back the
following:

XFree86 Version 3.3.3.1 / X Window System
  (protocol version 11, revision 0, vendor release 6300)
Release Date: January 4, 1999
  If the release date is older than 6-12 months, or if your card is
  newer the the above date, look for a newer version before reporting
  problems (see http://www.XFree86.org/FAQ)
Operating System: Linux 2.2.1 ppc [ELF]
Configured Drivers:
  FBDev: Server for frame buffer device
  (patch level 10): mfb, afb, cfb8, cfb16, cfb32, NCR 77C32BLT (accel), ATi
Mach 64 (accel), IMS Twin Turbo (accel)
  (using VT number 7)

XFree86Config: /usr/X11R6/lib/X11/XF86Config
 (**) stands for supplied,  (--) stands for probed/default values
 (**) XKB: disabled
 (**) Mouse: Type:BusMouse, device:/dev/mouse, buttons:3
 (**) FBDev: Graphics Device ID: "Generic Frame Buffer Device"
 (**) FBDev: Monitor ID: "Unknown"
 (**) FontPath set to "unix/:-1"
 (**) FBDev: Using XF86Config video mode database
 (--) FBDev: Frame Buffer Device: OFfb IMS,tt128m
 (--) FBDev: Video memory: 1536k@0x82000000
 (--) FBDev: MMIO Regs: 0k@(nil)
 (--) FBDev: Type 0 type_aux 0 bits_per_pixel 16
 (--) FBDev: Hardware accelarator: None
 (--) FBDev: No driver support for hardware acceleration
 bpp=16, depth = 15, BitsPerRGB = 5
 (--) FBDev: Using cfb16 driver

-FontTransSocketUNIXConnect: Can't connect: errno=111
failed to set default font path 'unix/:-1'
Fatal server error:
Could not  open default font 'fixed'

When reporting  a problem related to a server crash, please send
the full server output, not just the list messages.

X connection to :0,0 broken (explicit kill or server shutdown)

The weird thing is I ran Xconfigurator and the test went well. I was able to
see the test X screen and pressed the "Yes" button to the question "Can you
see the screen and buttons", but startx failed with the same error listed
above.

So what is going on here?? Can anyone help me out? I really want to get X
running on this machine!

Carlos

______________________________________________________________________
C.F. Velasquez
Asst. Vice President
Global Database and Technology Division
Salomon Smith Barney, Inc.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
