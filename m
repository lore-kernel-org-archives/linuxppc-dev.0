Message-ID: <396D1C7B.AA6864F5@ucdavis.edu>
Date: Wed, 12 Jul 2000 21:33:47 -0400
From: Taylor Holliday <wtholliday@ucdavis.edu>
MIME-Version: 1.0
To: Linux PPC Developer List <linuxppc-dev@lists.linuxppc.org>
Subject: Xfree 4.0.1 dual head attempt
Content-Type: multipart/mixed;
 boundary="------------172057502ADDC05C6ED0A924"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------172057502ADDC05C6ED0A924
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi all

Attached is the latest XFree86.0.log as well as the XF86Config from my
recent build (yesterday) of 4.0.1 with the drivers rsync'ed from
penguinppc.org. Hey, at least it doesn't crash the machine (AGP G4, 2
r128) :-). Any suggestions on what to do or where to start debugging?

- Taylor

--------------172057502ADDC05C6ED0A924
Content-Type: text/plain; charset=us-ascii;
 name="XFree86.0.log"
Content-Disposition: inline;
 filename="XFree86.0.log"
Content-Transfer-Encoding: 7bit


XFree86 Version 4.0.1 / X Window System
(protocol Version 11, revision 0, vendor release 6400)
Release Date: 1 July 2000
	If the server is older than 6-12 months, or if your card is newer
	than the above date, look for a newer version before reporting
	problems.  (see http://www.XFree86.Org/FAQ)
Operating System: Linux 2.2.17pre7 ppc [ELF]
Module Loader present
(==) Log file: "/var/log/XFree86.0.log", Time: Wed Jul 12 01:06:20 2000
(==) Using config file: "/etc/X11/XF86Config"
Markers: (--) probed, (**) from config file, (==) default setting,
         (++) from command line, (!!) notice, (II) informational,
         (WW) warning, (EE) error, (??) unknown.
(==) ServerLayout "DualHead"
(**) |-->Screen "Screen0" (0)
(**) |   |-->Monitor "Monitor0"
(**) |   |-->Device "r128"
(**) |-->Screen "Screen1" (1)
(**) |   |-->Monitor "Monitor0"
(**) |   |-->Device "r128.1"
(==) |-->Input Device "Implicit Core Pointer"
(==) |-->Input Device "Implicit Core Keyboard"
(**) Option "Protocol" "Standard"
(**) Option "AutoRepeat" "100 25"
(**) Option "XkbRules" "xfree86"
(**) XKB: rules: "xfree86"
(**) Option "XkbModel" "pc106"
(**) XKB: model: "pc106"
(**) Option "XkbLayout" "us"
(**) XKB: layout: "us"
(**) FontPath set to "/usr/X11R6/lib/X11/fonts/local/,/usr/X11R6/lib/X11/fonts/misc/,/usr/X11R6/lib/X11/fonts/75dpi/:unscaled,/usr/X11R6/lib/X11/fonts/100dpi/:unscaled,/usr/X11R6/lib/X11/fonts/Type1/,/usr/X11R6/lib/X11/fonts/CID/,/usr/X11R6/lib/X11/fonts/Speedo/,/usr/X11R6/lib/X11/fonts/75dpi/,/usr/X11R6/lib/X11/fonts/100dpi/,unix/:-1"
(**) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(==) ModulePath set to "/usr/X11R6/lib/modules"
(--) using VT number 7

(II) Module ABI versions:
	XFree86 ANSI C Emulation: 0.1
	XFree86 Video Driver: 0.2
	XFree86 XInput driver : 0.1
	XFree86 Server Extension : 0.1
	XFree86 Font Renderer : 0.1
(II) Loader running on linux
(II) LoadModule: "bitmap"
(II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Module bitmap: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 1.0.0
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.1
(II) Loading font Bitmap
(II) LoadModule: "pcidata"
(II) Loading /usr/X11R6/lib/modules/libpcidata.a
(II) Module pcidata: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.2
(II) PCI: PCI scan (all values are in hex)
(II) PCI: 00:0b:0: chip 106b,0020 card 0000,0000 rev 00 class 06,00,00 hdr 00
(II) PCI: 00:0d:0: chip 1011,0026 card 0000,0000 rev 05 class 06,04,00 hdr 01
(II) PCI: 00:10:0: chip 1002,5246 card b530,0408 rev 00 class 03,00,00 hdr 00
(II) PCI: 01:02:0: chip 9004,5078 card 9004,7850 rev 03 class 01,00,00 hdr 00
(II) PCI: 01:03:0: chip 1002,5245 card b530,0408 rev 00 class 03,00,00 hdr 00
(II) PCI: 01:07:0: chip 106b,0022 card 0000,0000 rev 02 class ff,00,00 hdr 00
(II) PCI: 01:08:0: chip 106b,0019 card 0000,0000 rev 00 class 0c,03,10 hdr 00
(II) PCI: 01:09:0: chip 106b,0019 card 0000,0000 rev 00 class 0c,03,10 hdr 00
(II) PCI: 01:0a:0: chip 104c,8019 card 0000,0000 rev 00 class 0c,00,10 hdr 00
(II) PCI: 01:0b:0: chip 1011,0019 card 0000,0000 rev 41 class 02,00,00 hdr 00
(II) PCI: End of PCI scan
(II) LoadModule: "scanpci"
(II) Loading /usr/X11R6/lib/modules/libscanpci.a
(II) Module scanpci: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.2
(II) UnloadModule: "scanpci"
(II) Unloading /usr/X11R6/lib/modules/libscanpci.a
(II) Bus 1: bridge is at (0:13:0), (0,1,1), BCTRL: 0x00 (VGA_EN is cleared)
(II) Bus 1 I/O range:
	[0] -1	0x00001000 - 0x00001fff (0x1000) IXB
(II) Bus 1 non-prefetchable memory range:
	[0] -1	0x80000000 - 0x87ffffff (0x8000000) MXB
(II) Bus 1 prefetchable memory range:
(--) PCI: (0:16:0) ATI Rage 128 RF rev 0, Mem @ 0x94000000/26, 0x90000000/14, I/O @ 0x0400/8
(--) PCI: (1:3:0) ATI Rage 128 RE rev 0, Mem @ 0x84000000/26, 0x8008c000/14, I/O @ 0x1000/8
(II) Addressable bus resource ranges are
	[0] -1	0x00000000 - 0xffffffff (0x0) MXB
	[1] -1	0x00000000 - 0x0000ffff (0x10000) IXB
(II) OS-reported resource ranges:
(II) Active PCI resource ranges:
	[0] -1	0x800c0000 - 0x800fffff (0x40000) MXBE
	[1] -1	0x80080000 - 0x800fffff (0x80000) MXBE
	[2] -1	0x80082000 - 0x80083fff (0x2000) MXBE
	[3] -1	0x80083000 - 0x80083fff (0x1000) MXBE
	[4] -1	0x80000000 - 0xffffffff (0x80000000) MXBE
	[5] -1	0x80090000 - 0x8009ffff (0x10000) MXBE
	[6] -1	0x80084000 - 0x80087fff (0x4000) MXBE
	[7] -1	0x800a0000 - 0x800bffff (0x20000) MXB(B)
	[8] -1	0x8008c000 - 0x8008ffff (0x4000) MXB(B)
	[9] -1	0x84000000 - 0x87ffffff (0x4000000) MXB(B)
	[10] -1	0x90020000 - 0x9003ffff (0x20000) MXB(B)
	[11] -1	0x90000000 - 0x90003fff (0x4000) MXB(B)
	[12] -1	0x94000000 - 0x97ffffff (0x4000000) MXB(B)
	[13] -1	0x00001000 - 0x000010ff (0x100) IXBE
	[14] -1	0x00001000 - 0x000010ff (0x100) IXB(B)
	[15] -1	0x00000400 - 0x000004ff (0x100) IXB(B)
(II) Inactive PCI resource ranges:
	[0] -1	0x80088000 - 0x8008ffff (0x8000) MXBE
	[1] -1	0x80081000 - 0x80081fff (0x1000) MXBE
(II) PCI Memory resource overlap reduced 0x80080000 from 0x800fffff to 0x80081fff
(II) PCI Memory resource overlap reduced 0x80082000 from 0x80083fff to 0x80082fff
(II) PCI Memory resource overlap reduced 0x80000000 from 0xffffffff to 0x8007ffff
(II) Active PCI resource ranges after removing overlaps:
	[0] -1	0x800c0000 - 0x800fffff (0x40000) MXBE
	[1] -1	0x80080000 - 0x80081fff (0x2000) MXBE
	[2] -1	0x80082000 - 0x80082fff (0x1000) MXBE
	[3] -1	0x80083000 - 0x80083fff (0x1000) MXBE
	[4] -1	0x80000000 - 0x8007ffff (0x80000) MXBE
	[5] -1	0x80090000 - 0x8009ffff (0x10000) MXBE
	[6] -1	0x80084000 - 0x80087fff (0x4000) MXBE
	[7] -1	0x800a0000 - 0x800bffff (0x20000) MXB(B)
	[8] -1	0x8008c000 - 0x8008ffff (0x4000) MXB(B)
	[9] -1	0x84000000 - 0x87ffffff (0x4000000) MXB(B)
	[10] -1	0x90020000 - 0x9003ffff (0x20000) MXB(B)
	[11] -1	0x90000000 - 0x90003fff (0x4000) MXB(B)
	[12] -1	0x94000000 - 0x97ffffff (0x4000000) MXB(B)
	[13] -1	0x00001000 - 0x000010ff (0x100) IXBE
	[14] -1	0x00001000 - 0x000010ff (0x100) IXB(B)
	[15] -1	0x00000400 - 0x000004ff (0x100) IXB(B)
(II) OS-reported resource ranges after removing overlaps with PCI:
(II) All system resource ranges:
	[0] -1	0x800c0000 - 0x800fffff (0x40000) MXBE
	[1] -1	0x80080000 - 0x80081fff (0x2000) MXBE
	[2] -1	0x80082000 - 0x80082fff (0x1000) MXBE
	[3] -1	0x80083000 - 0x80083fff (0x1000) MXBE
	[4] -1	0x80000000 - 0x8007ffff (0x80000) MXBE
	[5] -1	0x80090000 - 0x8009ffff (0x10000) MXBE
	[6] -1	0x80084000 - 0x80087fff (0x4000) MXBE
	[7] -1	0x800a0000 - 0x800bffff (0x20000) MXB(B)
	[8] -1	0x8008c000 - 0x8008ffff (0x4000) MXB(B)
	[9] -1	0x84000000 - 0x87ffffff (0x4000000) MXB(B)
	[10] -1	0x90020000 - 0x9003ffff (0x20000) MXB(B)
	[11] -1	0x90000000 - 0x90003fff (0x4000) MXB(B)
	[12] -1	0x94000000 - 0x97ffffff (0x4000000) MXB(B)
	[13] -1	0x80088000 - 0x8008ffff (0x8000) MXBE
	[14] -1	0x80081000 - 0x80081fff (0x1000) MXBE
	[15] -1	0x00001000 - 0x000010ff (0x100) IXBE
	[16] -1	0x00001000 - 0x000010ff (0x100) IXB(B)
	[17] -1	0x00000400 - 0x000004ff (0x100) IXB(B)
(II) LoadModule: "GLcore"
(II) Loading /usr/X11R6/lib/modules/extensions/libGLcore.a
(II) Module GLcore: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.1
(II) LoadModule: "dbe"
(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a
(II) Module dbe: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension DOUBLE-BUFFER
(II) LoadModule: "extmod"
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension SHAPE
(II) Loading extension MIT-SUNDRY-NONSTANDARD
(II) Loading extension BIG-REQUESTS
(II) Loading extension SYNC
(II) Loading extension MIT-SCREEN-SAVER
(II) Loading extension XC-MISC
(II) Loading extension XFree86-VidModeExtension
(II) Loading extension XFree86-Misc
(II) Loading extension DPMS
(II) Loading extension FontCache
(II) Loading extension TOG-CUP
(II) Loading extension Extended-Visual-Information
(II) Loading extension XVideo
(II) LoadModule: "glx"
(II) Loading /usr/X11R6/lib/modules/extensions/libglx.a
(II) Module glx: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension GLX
(II) Loading sub module "GLcore"
(II) LoadModule: "GLcore"
(II) Reloading /usr/X11R6/lib/modules/extensions/libGLcore.a
(II) LoadModule: "pex5"
(II) Loading /usr/X11R6/lib/modules/extensions/libpex5.a
(II) Module pex5: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension X3D-PEX
(II) LoadModule: "record"
(II) Loading /usr/X11R6/lib/modules/extensions/librecord.a
(II) Module record: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 1.13.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension RECORD
(II) LoadModule: "xie"
(II) Loading /usr/X11R6/lib/modules/extensions/libxie.a
(II) Module xie: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension XIE
(II) LoadModule: "type1"
(II) Loading /usr/X11R6/lib/modules/fonts/libtype1.a
(II) Module type1: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 1.0.0
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.1
(II) Loading font Type1
(II) Loading font CID
(II) LoadModule: "speedo"
(II) Loading /usr/X11R6/lib/modules/fonts/libspeedo.a
(II) Module speedo: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 1.0.0
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.1
(II) Loading font Speedo
(II) LoadModule: "r128"
(II) Loading /usr/X11R6/lib/modules/drivers/r128_drv.o
(II) Module r128: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 3.1.1
	Module class: XFree86 Video Driver
	ABI class: XFree86 Video Driver, version 0.2
(II) LoadModule: "mouse"
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 1.0.0
	Module class: XFree86 XInput Driver
	ABI class: XFree86 XInput driver, version 0.1
(II) r128: Driver for ATI Rage 128 chipset: ATI Rage 128 RE (PCI),
	ATI Rage 128 RF (AGP), ATI Rage 128 RK (PCI), ATI Rage 128 RL (AGP),
	ATI Rage 128 Pro PF (AGP), ATI Rage 128 Mobility LE (PCI),
	ATI Rage 128 Mobility LF (AGP)
(--) Chipset ATI Rage 128 RF (AGP) found
(--) Chipset ATI Rage 128 RE (PCI) found
(II) resource ranges after xf86ClaimFixedResources() call:
	[0] -1	0x800c0000 - 0x800fffff (0x40000) MXBE
	[1] -1	0x80080000 - 0x80081fff (0x2000) MXBE
	[2] -1	0x80082000 - 0x80082fff (0x1000) MXBE
	[3] -1	0x80083000 - 0x80083fff (0x1000) MXBE
	[4] -1	0x80000000 - 0x8007ffff (0x80000) MXBE
	[5] -1	0x80090000 - 0x8009ffff (0x10000) MXBE
	[6] -1	0x80084000 - 0x80087fff (0x4000) MXBE
	[7] -1	0x800a0000 - 0x800bffff (0x20000) MXB(B)
	[8] -1	0x8008c000 - 0x8008ffff (0x4000) MXB(B)
	[9] -1	0x84000000 - 0x87ffffff (0x4000000) MXB(B)
	[10] -1	0x90020000 - 0x9003ffff (0x20000) MXB(B)
	[11] -1	0x90000000 - 0x90003fff (0x4000) MXB(B)
	[12] -1	0x94000000 - 0x97ffffff (0x4000000) MXB(B)
	[13] -1	0x80088000 - 0x8008ffff (0x8000) MXBE
	[14] -1	0x80081000 - 0x80081fff (0x1000) MXBE
	[15] -1	0x00001000 - 0x000010ff (0x100) IXBE
	[16] -1	0x00001000 - 0x000010ff (0x100) IXB(B)
	[17] -1	0x00000400 - 0x000004ff (0x100) IXB(B)
(II) resource ranges after xf86ClaimFixedResources() call:
	[0] -1	0x800c0000 - 0x800fffff (0x40000) MXBE
	[1] -1	0x80080000 - 0x80081fff (0x2000) MXBE
	[2] -1	0x80082000 - 0x80082fff (0x1000) MXBE
	[3] -1	0x80083000 - 0x80083fff (0x1000) MXBE
	[4] -1	0x80000000 - 0x8007ffff (0x80000) MXBE
	[5] -1	0x80090000 - 0x8009ffff (0x10000) MXBE
	[6] -1	0x80084000 - 0x80087fff (0x4000) MXBE
	[7] -1	0x800a0000 - 0x800bffff (0x20000) MXB(B)
	[8] -1	0x8008c000 - 0x8008ffff (0x4000) MXB(B)
	[9] -1	0x84000000 - 0x87ffffff (0x4000000) MXB(B)
	[10] -1	0x90020000 - 0x9003ffff (0x20000) MXB(B)
	[11] -1	0x90000000 - 0x90003fff (0x4000) MXB(B)
	[12] -1	0x94000000 - 0x97ffffff (0x4000000) MXB(B)
	[13] -1	0x80088000 - 0x8008ffff (0x8000) MXBE
	[14] -1	0x80081000 - 0x80081fff (0x1000) MXBE
	[15] -1	0x00001000 - 0x000010ff (0x100) IXBE
	[16] -1	0x00001000 - 0x000010ff (0x100) IXB(B)
	[17] -1	0x00000400 - 0x000004ff (0x100) IXB(B)
(WW) ****INVALID IO ALLOCATION**** b: 0x1000 e: 0x10ff correcting
(II) window:
	[0] -1	0x00001000 - 0x00001fff (0x1000) IXB
(II) resSize:
(II) window fixed:
	[0] -1	0x00001000 - 0x00001fff (0x1000) IXB
(WW) ****INVALID MEM ALLOCATION**** b: 0x8008c000 e: 0x8008ffff correcting
NonSys
	[0] -1	0x800c0000 - 0x800fffff (0x40000) MXB
	[1] -1	0x80080000 - 0x80081fff (0x2000) MXB
	[2] -1	0x80088000 - 0x8008ffff (0x8000) MXB
	[3] -1	0x80081000 - 0x80081fff (0x1000) MXB
	[4] -1	0x80082000 - 0x80082fff (0x1000) MXB
	[5] -1	0x80083000 - 0x80083fff (0x1000) MXB
	[6] -1	0x80000000 - 0x8007ffff (0x80000) MXB
	[7] -1	0x80090000 - 0x8009ffff (0x10000) MXB
	[8] -1	0x80084000 - 0x80087fff (0x4000) MXB
	[9] -1	0x00001000 - 0x000010ff (0x100) IXB
	[10] -1	0x00000000 - 0x00000000 (0x1) IXB
(II) window:
	[0] -1	0x80000000 - 0x87ffffff (0x8000000) MXB
(II) resSize:
	[0] -1	0x00000000 - 0xffffffff (0x0) MXB
(II) window fixed:
	[0] -1	0x80000000 - 0x87ffffff (0x8000000) MXB
(II) resource ranges after probing:
	[0] -1	0x80100000 - 0x80103fff (0x4000) MXB(B)
	[1] -1	0x800c0000 - 0x800fffff (0x40000) MXBE
	[2] -1	0x80080000 - 0x80081fff (0x2000) MXBE
	[3] -1	0x80082000 - 0x80082fff (0x1000) MXBE
	[4] -1	0x80083000 - 0x80083fff (0x1000) MXBE
	[5] -1	0x80000000 - 0x8007ffff (0x80000) MXBE
	[6] -1	0x80090000 - 0x8009ffff (0x10000) MXBE
	[7] -1	0x80084000 - 0x80087fff (0x4000) MXBE
	[8] -1	0x800a0000 - 0x800bffff (0x20000) MXB(B)
	[9] -1	0x84000000 - 0x87ffffff (0x4000000) MXB(B)
	[10] -1	0x90020000 - 0x9003ffff (0x20000) MXB(B)
	[11] -1	0x90000000 - 0x90003fff (0x4000) MXB(B)
	[12] -1	0x94000000 - 0x97ffffff (0x4000000) MXB(B)
	[13] -1	0x80088000 - 0x8008ffff (0x8000) MXBE
	[14] -1	0x80081000 - 0x80081fff (0x1000) MXBE
	[15] 0	0x000a0000 - 0x000affff (0x10000) MSB
	[16] 0	0x000b0000 - 0x000b7fff (0x8000) MSB
	[17] 0	0x000b8000 - 0x000bffff (0x8000) MSB
	[18] 1	0x000a0000 - 0x000affff (0x10000) MSB
	[19] 1	0x000b0000 - 0x000b7fff (0x8000) MSB
	[20] 1	0x000b8000 - 0x000bffff (0x8000) MSB
	[21] -1	0x00001400 - 0x000014ff (0x100) IXB(B)
	[22] -1	0x00001000 - 0x000010ff (0x100) IXB(B)
	[23] -1	0x00000400 - 0x000004ff (0x100) IXB(B)
	[24] 0	0x000003b0 - 0x000003bb (0xc) ISB
	[25] 0	0x000003c0 - 0x000003df (0x20) ISB
	[26] 1	0x000003b0 - 0x000003bb (0xc) ISB
	[27] 1	0x000003c0 - 0x000003df (0x20) ISB
(II) Setting vga for screen 0.
(II) Setting vga for screen 1.
(II) Loading sub module "vgahw"
(II) LoadModule: "vgahw"
(II) Loading /usr/X11R6/lib/modules/libvgahw.a
(II) Module vgahw: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.2
(II) r128(0): PCI bus 0 card 16 func 0
(**) r128(0): Depth 24, (--) framebuffer bpp 32
(II) r128(0): Pixel depth = 24 bits stored in 4 bytes (32 bpp pixmaps)
(==) r128(0): Default visual is TrueColor
(**) r128(0): Option "HWcursor"
(==) r128(0): RGB weight 888
(II) r128(0): Using 8 bits per RGB (8 bit DAC)
(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Loading /usr/X11R6/lib/modules/libint10.a
(II) Module int10: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.2
(II) r128(0): initializing int10
(EE) r128(0): Cannot read V_BIOS (4)
(--) r128(0): Chipset: "ATI Rage 128 RF (AGP)" (ChipID = 0x5246)
(--) r128(0): Linear framebuffer at 0x94000000
(--) r128(0): MMIO registers at 0x90000000
(--) r128(0): BIOS at 0x90020000
(--) r128(0): VideoRAM: 16384 kByte (128-bit SDR SGRAM 1:1)
(II) r128(0): PLL parameters: rf=2950 rd=26 min=12500 max=25000; xclk=10020
(==) r128(0): Using gamma correction (1.0, 1.0, 1.0)
(II) r128(0): Monitor0: Using hsync range of  30.00- 85.00 kHz
(II) r128(0): Monitor0: Using vrefresh range of  48.00-160.00 Hz
(II) r128(0): Clock range:  12.50 to 250.00 MHz
(WW) r128(0): Mode "1280x960" deleted (hsync out of range)
(WW) r128(0): Mode "1280x1024" deleted (hsync out of range)
(WW) r128(0): Mode "1600x1200" deleted (hsync out of range)
(WW) r128(0): Mode "1600x1200" deleted (hsync out of range)
(WW) r128(0): Mode "1600x1200" deleted (hsync out of range)
(WW) r128(0): Mode "1792x1344" deleted (bad mode clock/interlace/doublescan)
(WW) r128(0): Mode "1856x1392" deleted (hsync out of range)
(WW) r128(0): Mode "1856x1392" deleted (bad mode clock/interlace/doublescan)
(WW) r128(0): Mode "1920x1440" deleted (hsync out of range)
(WW) r128(0): Mode "1920x1440" deleted (bad mode clock/interlace/doublescan)
(--) r128(0): Virtual size is 1280x1024 (pitch 1280)
(**) r128(0): Default mode "1280x1024": 135.0 MHz, 80.0 kHz, 75.0 Hz
(==) r128(0): DPI set to (75, 75)
(II) Loading sub module "fb"
(II) LoadModule: "fb"
(II) Loading /usr/X11R6/lib/modules/libfb.a
(II) Module fb: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 1.0.0
	ABI class: XFree86 ANSI C Emulation, version 0.1
(II) Loading sub module "ramdac"
(II) LoadModule: "ramdac"
(II) Loading /usr/X11R6/lib/modules/libramdac.a
(II) Module ramdac: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.2
(II) Loading sub module "xaa"
(II) LoadModule: "xaa"
(II) Loading /usr/X11R6/lib/modules/libxaa.a
(II) Module xaa: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.2
(II) Loading sub module "vgahw"
(II) LoadModule: "vgahw"
(II) Reloading /usr/X11R6/lib/modules/libvgahw.a
(II) r128(1): PCI bus 1 card 3 func 0
(**) r128(1): Depth 8, (--) framebuffer bpp 8
(II) r128(1): Pixel depth = 8 bits stored in 1 byte (8 bpp pixmaps)
(==) r128(1): Default visual is PseudoColor
(II) r128(1): Using 8 bits per RGB (8 bit DAC)
(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Reloading /usr/X11R6/lib/modules/libint10.a
(II) r128(1): initializing int10
(EE) r128(1): Cannot read V_BIOS (4)
(--) r128(1): Chipset: "ATI Rage 128 RE (PCI)" (ChipID = 0x5245)
(--) r128(1): Linear framebuffer at 0x84000000
(--) r128(1): MMIO registers at 0x80100000
(--) r128(1): BIOS at 0x800a0000
(--) r128(1): VideoRAM: 16384 kByte (128-bit SDR SGRAM 1:1)
(II) r128(1): PLL parameters: rf=2950 rd=26 min=12500 max=25000; xclk=10001
(==) r128(1): Using gamma correction (1.0, 1.0, 1.0)
(II) r128(1): Monitor0: Using hsync range of  30.00- 85.00 kHz
(II) r128(1): Monitor0: Using vrefresh range of  48.00-160.00 Hz
(II) r128(1): Clock range:  12.50 to 250.00 MHz
(WW) r128(1): Mode "1280x960" deleted (hsync out of range)
(WW) r128(1): Mode "1280x1024" deleted (hsync out of range)
(WW) r128(1): Mode "1600x1200" deleted (hsync out of range)
(WW) r128(1): Mode "1600x1200" deleted (hsync out of range)
(WW) r128(1): Mode "1600x1200" deleted (hsync out of range)
(WW) r128(1): Mode "1792x1344" deleted (bad mode clock/interlace/doublescan)
(WW) r128(1): Mode "1856x1392" deleted (hsync out of range)
(WW) r128(1): Mode "1856x1392" deleted (bad mode clock/interlace/doublescan)
(WW) r128(1): Mode "1920x1440" deleted (hsync out of range)
(WW) r128(1): Mode "1920x1440" deleted (bad mode clock/interlace/doublescan)
(--) r128(1): Virtual size is 1024x768 (pitch 1024)
(**) r128(1): Default mode "1024x768": 94.5 MHz, 68.7 kHz, 85.0 Hz
(==) r128(1): DPI set to (75, 75)
(II) Loading sub module "fb"
(II) LoadModule: "fb"
(II) Reloading /usr/X11R6/lib/modules/libfb.a
(II) Loading sub module "ramdac"
(II) LoadModule: "ramdac"
(II) Reloading /usr/X11R6/lib/modules/libramdac.a
(II) Loading sub module "xaa"
(II) LoadModule: "xaa"
(II) Reloading /usr/X11R6/lib/modules/libxaa.a
(--) Depth 24 pixmap format is 32 bpp
(II) do I need RAC?  Yes, I do.
(II) LoadModule: "rac"
(II) Loading /usr/X11R6/lib/modules/librac.a
(II) Module rac: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.2
(II) resource ranges after preInit:
	[0] 1	0x80100000 - 0x80103fff (0x4000) MSB
	[1] 1	0x84000000 - 0x87ffffff (0x4000000) MSB
	[2] 0	0x90000000 - 0x90003fff (0x4000) MSB
	[3] 0	0x94000000 - 0x97ffffff (0x4000000) MSB
	[4] -1	0x80100000 - 0x80103fff (0x4000) MXB(B)
	[5] -1	0x800c0000 - 0x800fffff (0x40000) MXBE
	[6] -1	0x80080000 - 0x80081fff (0x2000) MXBE
	[7] -1	0x80082000 - 0x80082fff (0x1000) MXBE
	[8] -1	0x80083000 - 0x80083fff (0x1000) MXBE
	[9] -1	0x80000000 - 0x8007ffff (0x80000) MXBE
	[10] -1	0x80090000 - 0x8009ffff (0x10000) MXBE
	[11] -1	0x80084000 - 0x80087fff (0x4000) MXBE
	[12] -1	0x800a0000 - 0x800bffff (0x20000) MXB(B)
	[13] -1	0x84000000 - 0x87ffffff (0x4000000) MXB(B)
	[14] -1	0x90020000 - 0x9003ffff (0x20000) MXB(B)
	[15] -1	0x90000000 - 0x90003fff (0x4000) MXB(B)
	[16] -1	0x94000000 - 0x97ffffff (0x4000000) MXB(B)
	[17] -1	0x80088000 - 0x8008ffff (0x8000) MXBE
	[18] -1	0x80081000 - 0x80081fff (0x1000) MXBE
	[19] 0	0x000a0000 - 0x000affff (0x10000) MSB
	[20] 0	0x000b0000 - 0x000b7fff (0x8000) MSB
	[21] 0	0x000b8000 - 0x000bffff (0x8000) MSB
	[22] 1	0x000a0000 - 0x000affff (0x10000) MSB
	[23] 1	0x000b0000 - 0x000b7fff (0x8000) MSB
	[24] 1	0x000b8000 - 0x000bffff (0x8000) MSB
	[25] 1	0x00001400 - 0x000014ff (0x100) ISB
	[26] 0	0x00000400 - 0x000004ff (0x100) ISB
	[27] -1	0x00001400 - 0x000014ff (0x100) IXB(B)
	[28] -1	0x00001000 - 0x000010ff (0x100) IXB(B)
	[29] -1	0x00000400 - 0x000004ff (0x100) IXB(B)
	[30] 0	0x000003b0 - 0x000003bb (0xc) ISB
	[31] 0	0x000003c0 - 0x000003df (0x20) ISB
	[32] 1	0x000003b0 - 0x000003bb (0xc) ISB
	[33] 1	0x000003c0 - 0x000003df (0x20) ISB
(WW) r128(0): Cannot read colourmap from VGA.  Will restore with default
(II) r128(0): Memory manager initialized to (0,0) (1280,3276)
(II) r128(0): Reserved area from (0,1024) to (1280,1026)
(II) r128(0): Largest offscreen area available: 1280 x 2250
(==) r128(0): Backing store disabled
(II) r128(0): Using XFree86 Acceleration Architecture (XAA)
	Screen to screen bit blits
	Solid filled rectangles
	8x8 mono pattern filled rectangles
	Indirect CPU to Screen color expansion
	Solid Lines
	Dashed Lines
	Offscreen Pixmaps
	Setting up tile and stipple cache:
		32 128x128 slots
		14 256x256 slots
		5 512x512 slots
(II) r128(0): Acceleration enabled
(II) r128(0): Using hardware cursor (scanline 4104)
(II) r128(0): Largest offscreen area available: 1280 x 2248
(WW) r128(1): Cannot read colourmap from VGA.  Will restore with default
(II) r128(1): Memory manager initialized to (0,0) (1024,8191)
(II) r128(1): Reserved area from (0,768) to (1024,770)
(II) r128(1): Largest offscreen area available: 1024 x 7421
(==) r128(1): Backing store disabled
(II) r128(1): Using XFree86 Acceleration Architecture (XAA)
	Screen to screen bit blits
	Solid filled rectangles
	8x8 mono pattern filled rectangles
	Indirect CPU to Screen color expansion
	Solid Lines
	Dashed Lines
	Offscreen Pixmaps
	Setting up tile and stipple cache:
		32 128x128 slots
		32 256x256 slots
		16 512x512 slots
(II) r128(1): Acceleration enabled
(II) r128(1): Using hardware cursor (scanline 770)
(II) r128(1): Largest offscreen area available: 1024 x 7419
(II) Setting vga for screen 0.
(II) Setting vga for screen 1.
Screen 0 is using RAC for mem
Screen 0 is using RAC for io
Screen 1 is using RAC for mem
Screen 1 is using RAC for io
(II) Screen 0 shares mem & io resources
(II) Screen 1 shares mem & io resources
(II) Initializing built-in extension MIT-SHM
(II) Initializing built-in extension XInputExtension
(II) Initializing built-in extension XTEST
(II) Initializing built-in extension XKEYBOARD
(II) Initializing built-in extension LBX
(II) Initializing built-in extension XC-APPGROUP
(II) Initializing built-in extension SECURITY
(II) Initializing built-in extension XINERAMA
(II) Initializing built-in extension XFree86-Bigfont
(**) Option "Protocol" "IMPS/2"
(**) Implicit Core Pointer: Protocol: "IMPS/2"
(**) Option "CorePointer"
(**) Implicit Core Pointer: Core Pointer
(**) Option "Device" "/dev/usbmouse"
(==) Implicit Core Pointer: Buttons: 3
(II) Keyboard "Implicit Core Keyboard" handled by legacy driver
(II) XINPUT: Adding extended input device "Implicit Core Pointer" (type: MOUSE)
Couldn't load XKB keymap, falling back to pre-XKB keymap

Fatal server error:
Caught signal 11.  Server aborting


When reporting a problem related to a server crash, please send
the full server output, not just the last messages.
This can be found in the log file "/var/log/XFree86.0.log".

(II) Screen 0 shares mem & io resources
(II) Screen 1 shares mem & io resources

--------------172057502ADDC05C6ED0A924
Content-Type: text/plain; charset=us-ascii;
 name="XF86Config.r128.dual"
Content-Disposition: inline;
 filename="XF86Config.r128.dual"
Content-Transfer-Encoding: 7bit

Section "ServerLayout"
	Identifier     "DualHead"
	Screen         "Screen0"
	Screen	       "Screen1" RightOf "Screen0"
#	InputDevice    "Mouse0" "CorePointer"
#	InputDevice    "Keyboard0" "CoreKeyboard"
EndSection

Section "Files"
# The location of the RGB database.  Note, this is the name of the
# file minus the extension (like ".txt" or ".db").  There is normally
# no need to change the default.

    RgbPath	"/usr/X11R6/lib/X11/rgb"

# Multiple FontPath entries are allowed (which are concatenated together),
# as well as specifying multiple comma-separated entries in one FontPath
# command (or a combination of both methods)

    FontPath	"/usr/X11R6/lib/X11/fonts/local/"
    FontPath	"/usr/X11R6/lib/X11/fonts/misc/"
    FontPath	"/usr/X11R6/lib/X11/fonts/75dpi/:unscaled"
    FontPath	"/usr/X11R6/lib/X11/fonts/100dpi/:unscaled"
    FontPath	"/usr/X11R6/lib/X11/fonts/Type1/"
    FontPath	"/usr/X11R6/lib/X11/fonts/CID/"
    FontPath	"/usr/X11R6/lib/X11/fonts/Speedo/"
    FontPath	"/usr/X11R6/lib/X11/fonts/75dpi/"
    FontPath	"/usr/X11R6/lib/X11/fonts/100dpi/"
    FontPath    "unix/:-1"

# ModulePath can be used to set a search path for the X server modules.
# The default path is shown here.

#    ModulePath	"/usr/X11R6/lib/modules"

EndSection

Section "Module"
	Load  "GLcore"
	Load  "dbe"

# This loads the miscellaneous extensions module, and disables
# initialisation of the XFree86-DGA extension within that module.
    SubSection  "extmod"
      Option    "omit xfree86-dga"   # don't initialise the DGA extension
    EndSubSection

	Load  "glx"
	Load  "pex5"
	Load  "record"
	Load  "xie"
	Load  "type1"
	Load  "speedo"
EndSection

#Section "InputDevice"
#	Identifier  "Keyboard0"
#	Driver      "keyboard"
#        Option      "XkbDisable"
#	Option "XkbModel"  "macintosh"
#	Option "XkbLayout"  "us"
#EndSection

Section "Keyboard"
	Protocol    "Standard"
	XkbRules    "xfree86"
	XkbModel    "pc106"
	XkbLayout   "us"
	AutoRepeat  100 25
EndSection

#Section "InputDevice"
#	Identifier  "Mouse0"
#	Driver      "mouse"
#	Option      "Protocol" "IMPS/2"
#	Option      "Device" "/dev/usbmouse"
#EndSection

Section "Pointer"
	Protocol    "IMPS/2"
	Device	    "/dev/usbmouse"
EndSection

Section "Monitor"
	Identifier   "Monitor0"
	VendorName   "Apple Computer"
	ModelName    "Studio 17"
        HorizSync    30-85
        VertRefresh  48-160
EndSection

Section "Device"
	### Available Driver options are:-
        #Option     "NoAccel"
        #Option     "SWcursor"
        Option     "HWcursor"
        #Option     "Dac6Bit"
        #Option     "Dac8Bit"
        #Option     "UseFBDev"
	Identifier  "r128"
	Driver      "r128"
	BusID       "PCI:0:16:0"
EndSection

Section "Device"
	Identifier "r128.1"
	Driver     "r128"
	BusID      "PCI:1:3:0"
        #VideoRam   16384
        #MemBase   0x84000000
        #IOBase
EndSection

Section "Screen"
	Identifier "Screen0"
	Device     "r128"
	Monitor    "Monitor0"
        DefaultDepth      24
	SubSection "Display"
		Depth     1
		Modes "1280x1024"
	EndSubSection
	SubSection "Display"
		Depth     4
		Modes "1280x1024"
	EndSubSection
	SubSection "Display"
		Depth     8
		Modes "1280x1024"
	EndSubSection
	SubSection "Display"
		Depth     15
		Modes "1280x1024"
	EndSubSection
	SubSection "Display"
		Depth     16
		Modes "1280x1024"
	EndSubSection
	SubSection "Display"
		Depth     24
		Modes "1280x1024"
	EndSubSection
EndSection

Section "Screen"
	Identifier "Screen1"
	Device     "r128.1"
	Monitor    "Monitor0"
        DefaultDepth      8
	SubSection "Display"
		Depth     1
		Modes "1024x768"
	EndSubSection
	SubSection "Display"
		Depth     4
		Modes "1024x768"
	EndSubSection
	SubSection "Display"
		Depth     8
		Modes "1024x768"
	EndSubSection
	SubSection "Display"
		Depth     15
		Modes "1024x768"
	EndSubSection
	SubSection "Display"
		Depth     16
		Modes "1024x768"
	EndSubSection
	SubSection "Display"
		Depth     24
		Modes "1024x768"
	EndSubSection

EndSection

--------------172057502ADDC05C6ED0A924--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
