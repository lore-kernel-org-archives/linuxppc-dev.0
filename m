From: Konstantinos Margaritis <kmargar@cc.uoa.gr>
To: linuxppc-dev@lists.linuxppc.org
Subject: xserver-fbdev 3.3.3.1 error
Date: Tue, 4 May 1999 20:01:42 +0300
Content-Type: text/plain
Cc: debian-powerpc@lists.debian.org
MIME-Version: 1.0
Message-Id: <99050420073900.08450@proton>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


-----BEGIN PGP SIGNED MESSAGE-----


Well I seem to have a problem with my xserver. Other people don't seem to
have such a problem, however. So it's either my setup or the fbdev driver
(valkyrie). Here is the output of startx with the 3.3.3.1-2 xserver (I am
using a debian glibc 2.1 distribution). The window manager is kwm (kde)
but I am experiencing similar problems with enlightnement, windowmaker,
icewm, etc. although not directly at startup.Any ideas are welcome.Many
other programs are showing this behaviour even if I manage to boot up
a window manager. The strange thing is that I CAN use xserver 3.3.2.3
without any problems, apart from the MIT-SHM extension is for some reason
missing on this one, plus it is kind of buggy.


XFree86 Version 3.3.3.1 / X Window System
(protocol Version 11, revision 0, vendor release 6300)
Release Date: January 4 1999
	If the server is older than 6-12 months, or if your card is newer
	than the above date, look for a newer version before reporting
	problems.  (see http://www.XFree86.Org/FAQ)
Operating System: Linux 2.2.5 ppc [ELF] 
Configured drivers:
   FBDev: Server for frame buffer device
   (Patchlevel 10): mfb, afb, cfb8, cfb16, cfb32
(using VT number 7)

XF86Config: /etc/X11/XF86Config
(**) stands for supplied, (--) stands for probed/default values
(**) XKB: disabled
(**) Mouse: type: BusMouse, device: /dev/mouse, buttons: 3
(**) FBDev: Graphics device ID: "Linux/m68k Frame Buffer Device"
(**) FBDev: Monitor ID: "Generic Monitor"
(**) FontPath set to "/usr/X11R6/lib/X11/fonts/misc/,/usr/X11R6/lib/X11/fonts/75dpi/:unscaled,/usr/X11R6/lib/X11/fonts/100dpi/:unscaled,/usr/X11R6/lib/X11/fonts/Type1/,/usr/X11R6/lib/X11/fonts/Speedo/,/usr/X11R6/lib/X11/fonts/75dpi/,/usr/X11R6/lib/X11/fonts/100dpi/"
(**) FBDev: Using default frame buffer video mode
(--) FBDev: Frame buffer device: valkyrie
(--) FBDev: Video memory: 768K @ 0xf1001000
(--) FBDev: MMIO regs: 0K @ 0xf130a000
(--) FBDev: Type 0 type_aux 0 bits_per_pixel 8
(--) FBDev: Hardware accelerator: None
(--) FBDev: No driver support for hardware acceleration
(--) FBDev: Using cfb8 driver
kwm: X_PutImage(0x1c00011): BadLength (poly request too large or internal Xlib length error)
kwm: failure during initialisation; aborting

waiting for X server to shut down kaudioserver: Captured signal 1.
kaudioserver: disconnectChild() with pid 8240
            Return = 0
kaudioserver: Captured signal 17.
kaudioserver: disconnectChild() with pid 8240
            Return = 0
kaudioserver: Exiting on myExit(1).
Starting audio server with talk id 2696.




- --
Konstantinos Margaritis

-----BEGIN PGP SIGNATURE-----
Version: 2.6.3ia
Charset: noconv

iQCVAwUBNy8pX/alfJok8qABAQFHRAP9FObn4v7z8ACw66MXMYDl+qgi8P7wp0mA
FPgIa8YJHKzM68qLN1zJyWcwb2Jjlj0eHoZ+BNG8kLHF/oU+UyPlENnbDpMxBtUc
ff3X9LhKPVt+9Q3j7Z9deP5YvGQDV2QoBwfIS9Rt3XC49V268tr57Sr8kVhigc1D
WJa2m4cY3gY=
=tJam
-----END PGP SIGNATURE-----

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
