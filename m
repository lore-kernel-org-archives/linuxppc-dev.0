Date: Tue, 8 Dec 1998 00:46:23 -0600
From: Ted Whalen <tew@nwu.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: misdetected vram on pb2400
Message-ID: <19981208004623.A737@wish.acns.nwu.edu>
Reply-To: tew@nwu.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


XFree86 Version 3.3.2.3 / X Window System
(protocol Version 11, revision 0, vendor release 6300)
Release Date: July 15 1998
	If the server is older than 6-12 months, or if your card is newer
	than the above date, look for a newer version before reporting
	problems.  (see http://www.XFree86.Org/FAQ)
Operating System: Linux 2.1.126 ppc [ELF] 
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
(**) FontPath set to "/usr/X11R6/lib/X11/fonts/misc/,/usr/X11R6/lib/X11/fonts/freefont/"
(**) FBDev: Using default frame buffer video mode
(--) FBDev: Frame buffer device: C&T 65550
(--) FBDev: Video memory: 468K @ 0x81000000
(--) FBDev: MMIO regs: 0K @ 0xf2000000
(--) FBDev: Type 0 type_aux 0 bits_per_pixel 16
(--) FBDev: Hardware accelerator: None
(--) FBDev: No driver support for hardware acceleration
(--) FBDev: Using cfb16 driver

Fatal server error:
Caught signal 11.  Server aborting


When reporting a problem related to a server crash, please send
the full server output, not just the last messages

X connection to :0.0 broken (explicit kill or server shutdown).

*** snip ***

I'm running the latest vger kernel with the 2400 patch promulgated on
this list.  I'm running the debian package of XFree86.  

-- 
             Is "Princess" your real name?
                Ted Whalen - tew@nwu.edu

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
