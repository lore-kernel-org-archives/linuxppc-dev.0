Message-ID: <393BEF5D.30EFC6A8@relog.ch>
Date: Mon, 05 Jun 2000 20:20:13 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: linux-apus-user@lists.sourceforge.net
CC: debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: New experimental X 4.0
Content-Type: multipart/mixed;
 boundary="------------D60BC041AC2BC4916ED220AB"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------D60BC041AC2BC4916ED220AB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



Hey all


The URL and filenames have changed a bit:

http://n.ethz.ch/student/daenzerm/download/XFree86/

This is 4.0b .


Good news for the Permedia2 people: DGA support is here. It's not tested
though...

The other important thing is support for the latest PowerBooks in the r128
driver.


Michel
--------------D60BC041AC2BC4916ED220AB
Content-Type: text/plain; charset=iso-8859-1;
 name="XFree86-srv-4.0-ppc.readme"
Content-Disposition: inline;
 filename="XFree86-srv-4.0-ppc.readme"
Content-Transfer-Encoding: 8bit




XFree86 4.0b server with Permedia2 hardware acceleration
--------------------------------------------------------

Please read the accompanying readmes for every tarball before continuing.



Contents
--------

This contains all the necessary files to get an XFree86 4.0b server up and
running.

- The glint driver provides sophisticated hardware acceleration for Permedia2
  graphics boards.

- The r128 driver does the same for Rage128 boards (support for all Rage128
  chips including the Rage Mobility M3 found in the latest PowerBooks)

- I have also included the ati driver for the Mach family of ATI chips.
  *NOTE* This is untested on PPC and will probably crash and burn! That's why
  I haven't prepared a Driver Section for it in the XF86Config.

- Finally, the fbdev driver enables everyone with a working framebuffer device
  to get the server running easily. However, it's not accelerated in any way.


Installing
----------

First of all, make a copy of your XF86Config. Its format has changed since
3.3.x and an example will be installed with the server (/etc/X11/XF86Config).
Please edit it to suit your system.

Extract the tarball to your root directory. Apart from the XF86Config issue,
it should be able to coexist with an existing X installation. (Check out the
server's -xf86config commandline option!) The new server executable is
/usr/X11R6/bin/XFree86, depending on your installation you'll have to make it
suid root (chmod u+s).


Read and edit the supplied XF86Config file!


*Important note for users with PCI gfx cards*

Apparently, you have to supply a BusID for the fbdev driver to work.



Features
--------

- Greatly enhanced hardware acceleration due to the new XAA (XFree
  Acceleration Architecture)

- Hardware cursor

- Modular design, single modules can be replaced without much hassle


Changes since 4.0a:

- DGA 2.0 support in the glint driver (untested)! Please report if it works.

- Support for all Rage128 chips in the r128 driver

- ati driver included (*UNTESTED*)

- documentation (manpages and HTML) for the server, XF86Config and drivers


Changes since 3.9.18:

- contains experimental support for the Xv extension, try
    http://n.ethz.ch/student/daenzerm/download/mpeg2play.bz2
  (don't forget the -b switch and maximizing the window :)
  Thanks to Michael Schimek for his code.

- problems with signal 4 are fixed

- new -libs- and -include- tarballs (not needed for normal usage)

- the r128 driver is included again. Kostas Gewrgiou <gewrgiou@imbc.gr> is an
  X developer working on r128/PowerMac support, contact him if it doesn't
  work.


Changes since 3.9.17f:

- I removed a few supposedly unused modules to make the tarballs smaller.
  If it complains about something missing, contact me

- Fixed all known acceleration bugs

- Fixed a bug which caused a crash (signal 11) with AfterStep's menu.
  If you experienced a sig 11 in another situation, this *might* be fixed as
  well...



Known Problems
--------------

- glint: 604e users apparently still have to enable
    Option "XAANoScanlineCPUToScreenColorExpandFill"
  in the XF86Config. I'm working on this and will provide an updated driver
  module once it's fixed.

- r128: Wrong colors after switching away and back with some chips

- fbdev: Some things are _very_ slow (Most notably the GNOME logout screen).
  If you want to help, send an xscope trace to me or
  Keith Packard <keithp@suse.com>

For problem reports etc. contact me, *NOT* XFree86! This is in no way an
official release!


Have fun,

Michel Dänzer <daenzerm@student.ethz.ch>



--------------D60BC041AC2BC4916ED220AB--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
