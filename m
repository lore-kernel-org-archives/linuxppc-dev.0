MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14800.62277.193434.173634@esb.bbn.com>
Date: Tue, 26 Sep 2000 15:04:37 -0400
From: R Shapiro <rshapiro@bbn.com>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 + ati driver with rage II/rage pro 
In-Reply-To: <Pine.LNX.4.10.10009251101410.28773-100000@opal.biophys.uni-duesseldorf.de>
References: <14798.23332.833379.615321@esb.bbn.com>
	<Pine.LNX.4.10.10009251101410.28773-100000@opal.biophys.uni-duesseldorf.de>
Reply-To: rshapiro@bbn.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz writes:
 > > 3.  On the same machine, the ati driver I built yesterday hoses linux
 > > completely and doesn't leave a core file.
 >
 > Does the X server complain about PCI resource conflicts when run as X
 > --probeonly? Anything about PCI problems in the server log?


"startx -- -probeonly" also crashes linux when the ati drivers are
selected.

Here's the log, which ends somewhat abruptly.  The final two lines
reject the two modes I generated with fbset.  Both are considered ok
by the fbdev driver.



XFree86 Version 4.0.1 / X Window System
(protocol Version 11, revision 0, vendor release 6400)
Release Date: 1 July 2000
	If the server is older than 6-12 months, or if your card is newer
	than the above date, look for a newer version before reporting
	problems.  (see http://www.XFree86.Org/FAQ)
Operating System: Linux 2.2.17pre10-ben2 ppc [ELF]
Module Loader present
(==) Log file: "/var/log/XFree86.0.log", Time: Tue Sep 26 14:44:57 2000
(==) Using config file: "/etc/X11/XF86Config"
Markers: (--) probed, (**) from config file, (==) default setting,
         (++) from command line, (!!) notice, (II) informational,
         (WW) warning, (EE) error, (??) unknown.
(==) ServerLayout "XFree86 Configured"
(**) |-->Screen "Screen0" (0)
(**) |   |-->Monitor "Monitor"
(**) |   |-->Device "device0"
(**) |-->Screen "Screen1" (1)
(**) |   |-->Monitor "Monitor"
(**) |   |-->Device "device1"
(**) |-->Screen "Screen2" (2)
(**) |   |-->Monitor "Monitor"
(**) |   |-->Device "device2"
(**) |-->Input Device "Mouse0"
(**) |-->Input Device "Keyboard0"
(**) Option "XkbModel" "macintosh_old"
(**) XKB: model: "macintosh_old"
(**) FontPath set to "unix/:7100,tcp/blatz:7100"
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
(II) PCI: 00:00:0: chip 1057,0002 card 0000,0000 rev 40 class 06,00,00 hdr 00
(II) PCI: 00:0d:0: chip 1002,4749 card 1002,0000 rev 5c class 03,00,00 hdr 00
(II) PCI: 00:0f:0: chip 1002,4749 card 1002,0000 rev 5c class 03,00,00 hdr 00
(II) PCI: 00:10:0: chip 106b,0010 card 0000,0000 rev 01 class ff,00,00 hdr 00
(II) PCI: 00:12:0: chip 1002,4754 card 0000,0000 rev 9a class 03,00,00 hdr 00
(II) PCI: End of PCI scan
(II) LoadModule: "scanpci"
(II) Loading /usr/X11R6/lib/modules/libscanpci.a
(II) Module scanpci: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.2
(II) UnloadModule: "scanpci"
(II) Unloading /usr/X11R6/lib/modules/libscanpci.a
(--) PCI: (0:13:0) ATI Mach64 GI rev 92, Mem @ 0x84000000/24, 0x81801000/12, I/O @ 0x0400/8
(--) PCI: (0:15:0) ATI Mach64 GI rev 92, Mem @ 0x83000000/24, 0x81800000/12, I/O @ 0x0400/8
(--) PCI: (0:18:0) ATI Mach64 GT rev 154, Mem @ 0x82000000/24, I/O @ 0x0400/8
(II) Addressable bus resource ranges are
	[0] -1	0x00000000 - 0xffffffff (0x0) MXB
	[1] -1	0x00000000 - 0x0000ffff (0x10000) IXB
(II) OS-reported resource ranges:
(II) Active PCI resource ranges:
	[0] -1	0xf3000000 - 0xf3ffffff (0x1000000) MXBE
	[1] -1	0x82000000 - 0x82ffffff (0x1000000) MXB(B)
	[2] -1	0x81820000 - 0x8183ffff (0x20000) MXB(B)
	[3] -1	0x81800000 - 0x81800fff (0x1000) MXB(B)
	[4] -1	0x83000000 - 0x83ffffff (0x1000000) MXB(B)
	[5] -1	0x81840000 - 0x8185ffff (0x20000) MXB(B)
	[6] -1	0x81801000 - 0x81801fff (0x1000) MXB(B)
	[7] -1	0x84000000 - 0x84ffffff (0x1000000) MXB(B)
	[8] -1	0x00000400 - 0x000004ff (0x100) IXB(B)
	[9] -1	0x00000400 - 0x000004ff (0x100) IXB(B)
	[10] -1	0x00000400 - 0x000004ff (0x100) IXB(B)
(II) Active PCI resource ranges after removing overlaps:
	[0] -1	0xf3000000 - 0xf3ffffff (0x1000000) MXBE
	[1] -1	0x82000000 - 0x82ffffff (0x1000000) MXB(B)
	[2] -1	0x81820000 - 0x8183ffff (0x20000) MXB(B)
	[3] -1	0x81800000 - 0x81800fff (0x1000) MXB(B)
	[4] -1	0x83000000 - 0x83ffffff (0x1000000) MXB(B)
	[5] -1	0x81840000 - 0x8185ffff (0x20000) MXB(B)
	[6] -1	0x81801000 - 0x81801fff (0x1000) MXB(B)
	[7] -1	0x84000000 - 0x84ffffff (0x1000000) MXB(B)
	[8] -1	0x00000400 - 0x000004ff (0x100) IXB(B)
	[9] -1	0x00000400 - 0x000004ff (0x100) IXB(B)
	[10] -1	0x00000400 - 0x000004ff (0x100) IXB(B)
(II) OS-reported resource ranges after removing overlaps with PCI:
(II) All system resource ranges:
	[0] -1	0xf3000000 - 0xf3ffffff (0x1000000) MXBE
	[1] -1	0x82000000 - 0x82ffffff (0x1000000) MXB(B)
	[2] -1	0x81820000 - 0x8183ffff (0x20000) MXB(B)
	[3] -1	0x81800000 - 0x81800fff (0x1000) MXB(B)
	[4] -1	0x83000000 - 0x83ffffff (0x1000000) MXB(B)
	[5] -1	0x81840000 - 0x8185ffff (0x20000) MXB(B)
	[6] -1	0x81801000 - 0x81801fff (0x1000) MXB(B)
	[7] -1	0x84000000 - 0x84ffffff (0x1000000) MXB(B)
	[8] -1	0x00000400 - 0x000004ff (0x100) IXB(B)
	[9] -1	0x00000400 - 0x000004ff (0x100) IXB(B)
	[10] -1	0x00000400 - 0x000004ff (0x100) IXB(B)
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
(II) LoadModule: "ati"
(II) Loading /usr/X11R6/lib/modules/drivers/ati_drv.o
(II) Module ati: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 5.3.5
	Module class: XFree86 Video Driver
	ABI class: XFree86 Video Driver, version 0.2
(II) LoadModule: "mouse"
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 1.0.0
	Module class: XFree86 XInput Driver
	ABI class: XFree86 XInput driver, version 0.1
(II) ATI: ATI driver (version 5.3.5) for chipsets: ati, ativga
(--) Chipset ATI Mach64 3D Rage Pro (BGA, PCI) found
(--) Chipset ATI Mach64 3D Rage Pro (BGA, PCI) found
(--) Chipset ATI Mach64 GT (PCI) found
(II) resource ranges after xf86ClaimFixedResources() call:
	[0] -1	0xf3000000 - 0xf3ffffff (0x1000000) MXBE
	[1] -1	0x82000000 - 0x82ffffff (0x1000000) MXB(B)
	[2] -1	0x81820000 - 0x8183ffff (0x20000) MXB(B)
	[3] -1	0x81800000 - 0x81800fff (0x1000) MXB(B)
	[4] -1	0x83000000 - 0x83ffffff (0x1000000) MXB(B)
	[5] -1	0x81840000 - 0x8185ffff (0x20000) MXB(B)
	[6] -1	0x81801000 - 0x81801fff (0x1000) MXB(B)
	[7] -1	0x84000000 - 0x84ffffff (0x1000000) MXB(B)
	[8] -1	0x00000400 - 0x000004ff (0x100) IXB(B)
	[9] -1	0x00000400 - 0x000004ff (0x100) IXB(B)
	[10] -1	0x00000400 - 0x000004ff (0x100) IXB(B)
Found a Mach64 on a PowerPC
(II) resource ranges after probing:
	[0] -1	0xf3000000 - 0xf3ffffff (0x1000000) MXBE
	[1] -1	0x82000000 - 0x82ffffff (0x1000000) MXB(B)
	[2] -1	0x81820000 - 0x8183ffff (0x20000) MXB(B)
	[3] -1	0x81800000 - 0x81800fff (0x1000) MXB(B)
	[4] -1	0x83000000 - 0x83ffffff (0x1000000) MXB(B)
	[5] -1	0x81840000 - 0x8185ffff (0x20000) MXB(B)
	[6] -1	0x81801000 - 0x81801fff (0x1000) MXB(B)
	[7] -1	0x84000000 - 0x84ffffff (0x1000000) MXB(B)
	[8] 0	0x000a0000 - 0x000affff (0x10000) MSB
	[9] 0	0x000b0000 - 0x000b7fff (0x8000) MSB
	[10] 0	0x000b8000 - 0x000bffff (0x8000) MSB
	[11] -1	0x00000400 - 0x000004ff (0x100) IXB(B)
	[12] -1	0x00000400 - 0x000004ff (0x100) IXB(B)
	[13] -1	0x00000400 - 0x000004ff (0x100) IXB(B)
	[14] 0	0x000003b0 - 0x000003bb (0xc) ISB
	[15] 0	0x000003c0 - 0x000003df (0x20) ISB
(II) Setting vga for screen 0.
(II) Loading sub module "fbdevhw"
(II) LoadModule: "fbdevhw"
(II) Loading /usr/X11R6/lib/modules/linux/libfbdevhw.a
(II) Module fbdevhw: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 0.0.1
	ABI class: XFree86 Video Driver, version 0.2
(**) ATI(0): Depth 8, (--) framebuffer bpp 8
(==) ATI(0): Default visual is PseudoColor
Mapping MMIO @ 0x847ff000 with size 0x1000
testing mmio w/ scratch regs...
SCRATCH_REG0 = 0x3d5d
SCRATCH_REG0 = 0x12345678
SCRATCH_REG1 = 0x0
SCRATCH_REG1 = 0xdeadbeef
Chip Type = 0x4749, Rev = 0x7c
(--) ATI(0): VideoRam: 1 kByte (EDO)
(==) ATI(0): Using gamma correction (1.0, 1.0, 1.0)
(II) ATI(0): Monitor: Using hsync range of   1.00-300.00 kHz
(II) ATI(0): Monitor: Using vrefresh range of   1.00-300.00 Hz
(II) ATI(0): Maximum clock: 120.00 MHz
(WW) ATI(0): Mode "1152x870" deleted (bad mode clock/interlace/doublescan)
(WW) ATI(0): Mode "1280x1024" deleted (bad mode clock/interlace/doublescan)





--
rshapiro@bbn.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
