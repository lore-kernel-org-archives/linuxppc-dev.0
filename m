Mime-Version: 1.0
Message-Id: <p04310105b507c981404f@[192.168.240.10]>
In-Reply-To: <200003291145.DAA39678@bromo.med.uc.edu>
References: <200003291145.DAA39678@bromo.med.uc.edu>
Date: Wed, 29 Mar 2000 17:06:19 +0200
To: howarth@bromo.med.uc.edu (Jack Howarth)
From: Alain RICHARD <alain.richard@equation.fr>
Subject: Re:new XFree86 4.0 rpms
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="iso-8859-1" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>    There are newer XFree86 4.0 rpms (-0.2j) available in my public_html pages
>at http://entropy.crashing.org/~howarth/XFree86_v4.0/. There are only two
>changes this time. The glint drivers are now built at the request of the
>Amiga folks. Also a missing symlink for /usr/include/X11 was added to the
>spec file list so Python will build.
>                         Jack
>

I have tried several version of your packages and was unable to get
it working on my iBook.

I have made a configuration that seems to be working (the screen,
resolution and fbdev driver is loading without any error), but the
screen is erased and remains black.

The only X server working so far is the Xpmac one.

Also I would like to test the ati module that is supposed to
recognized the ATI Rage Mobility, but you haven't build it.

You'll find here the XFree86 output :


[root@pbagr /root]# XFree86

XFree86 Version 4.0 / X Window System
(protocol Version 11, revision 0, vendor release 6400)
Release Date: 8 March 2000
         If the server is older than 6-12 months, or if your card is newer
         than the above date, look for a newer version before reporting
         problems.  (see http://www.XFree86.Org/FAQ)
Operating System: Linux 2.2.15pre11 ppc [ELF]
Module Loader present
(==) Log file: "/var/log/XFree86.0.log", Time: Wed Mar 29 19:00:03 2000
(==) Using config file: "/etc/X11/XF86Config"
Markers: (--) probed, (**) from config file, (==) default setting,
          (++) from command line, (!!) notice, (II) informational,
          (WW) warning, (EE) error, (??) unknown.
(==) ServerLayout "Simple Layout"
(**) |-->Screen "Screen 1" (0)
(**) |   |-->Monitor "lcd"
(**) |   |-->Device "Frame buffer"
(**) |-->Input Device "Mouse1"
(**) |-->Input Device "Keyboard1"
(**) XKB: rules: "xfree86"
(**) XKB: model: "pc101"
(**) XKB: layout: "us"
(**) FontPath set to
"/usr/X11R6/lib/X11/fonts/local/,/usr/X11R6/lib/X11/fonts/misc/,/usr/X11R6/lib/X11/fonts/75dpi/:uns
caled,/usr/X11R6/lib/X11/fonts/100dpi/:unscaled,/usr/X11R6/lib/X11/fonts/Type1/,/usr/X11R6/lib/X11/fonts/Speedo/,/usr/X1
1R6/lib/X11/fonts/75dpi/,/usr/X11R6/lib/X11/fonts/100dpi/"
(**) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(==) ModulePath set to "/usr/X11R6/lib/modules"
(--) using VT number 7

(II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Module bitmap: vendor="The XFree86 Project"
         compiled for 4.0, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/libpcidata.a
(II) Module pcidata: vendor="The XFree86 Project"
         compiled for 4.0, module version = 0.1.0
(II) Loading /usr/X11R6/lib/modules/libscanpci.a
(II) Module scanpci: vendor="The XFree86 Project"
         compiled for 4.0, module version = 0.1.0
(II) Unloading /usr/X11R6/lib/modules/libscanpci.a
(--) PCI: (0:16:0) ATI Mach64 LN rev 100, Mem @ 0x91000000/24,
0x90000000/12, I/O @ 0x0400/8
(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a
(II) Module dbe: vendor="The XFree86 Project"
         compiled for 4.0, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor="The XFree86 Project"
         compiled for 4.0, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/fonts/libtype1.a
(II) Module type1: vendor="The XFree86 Project"
         compiled for 4.0, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/fonts/libfreetype.a
(II) Module freetype: vendor="The XFree86 Project"
         compiled for 4.0, module version = 1.1.7
(II) Loading /usr/X11R6/lib/modules/drivers/fbdev_drv.o
(II) Module fbdev: vendor="The XFree86 Project"
         compiled for 4.0, module version = 0.1.0
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor="The XFree86 Project"
         compiled for 4.0, module version = 1.0.0
(II) FBDev: driver for framebuffer: fbdev, afb
(II) Loading /usr/X11R6/lib/modules/linux/libfbdevhw.a
(II) Module fbdevhw: vendor="The XFree86 Project"
         compiled for 4.0, module version = 0.0.1
(II) FBDev(1): using default device
(**) FBDev(0): Depth 8, (--) framebuffer bpp 8
(==) FBDev(0): Default visual is PseudoColor
(==) FBDev(0): Using gamma correction (1.0, 1.0, 1.0)
(II) FBDev(0): Hardware: OFfb ATY,RageM_ (vidmem: 468k)
(==) FBDev(0): Option ShadowFB is on
(II) FBDev(0): Checking Modes against framebuffer device...
(II) FBDev(0):  mode "800x600" ok
(II) FBDev(0): Checking Modes against monitor...
(--) FBDev(0): Virtual size is 800x600 (pitch 800)
(**) FBDev(0): Default mode "800x600": 36.0 MHz (scaled from 0.0
MHz), 35.2 kHz, 56.2 Hz
(==) FBDev(0): DPI set to (75, 75)
(II) Loading /usr/X11R6/lib/modules/libfb.a
(II) Module fb: vendor="The XFree86 Project"
         compiled for 4.0, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/libshadowfb.a
(II) Module shadowfb: vendor="The XFree86 Project"
         compiled for 4.0, module version = 1.0.0
(==) FBDev(0): Backing store disabled
(**) Mouse1: Protocol: "Microsoft"
(**) Mouse1: Core Pointer
(==) Mouse1: Buttons: 3
(**) Mouse1: Emulate3Buttons, Emulate3Timeout: 50
(II) Keyboard "Keyboard1" handled by legacy driver
(II) XINPUT: Adding extended input device "Mouse1" (type: MOUSE)
Removing /usr/X11R6/lib/X11/fonts/Speedo/ from the valid list of fontpaths

--
-------------------------------------------------------
Alain RICHARD <mailto:alain.richard@equation.fr>
EQUATION SA <http://www.equation.fr/>
Tel : +33 477 79 48 00	 Fax : +33 477 79 48 01
Applications client/serveur, ingénierie réseau et Linux

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
