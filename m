In-Reply-To: <Pine.LNX.4.10.10007041630040.102-100000@shell.unixbox.com>
References: <Pine.LNX.4.10.10007041630040.102-100000@shell.unixbox.com>
Subject: Re: [ANN] New XFree86-pmac rsync tree
From: Kohkichi Hosoda <khosoda@venus.dti.ne.jp>
To: ajoshi@shell.unixbox.com
Cc: linuxppc-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Sat_Jul_15_11:33:19_2000_559)--"
Message-Id: <20000715113541Y.kohkichi@venus.dti.ne.jp>
Date: Sat, 15 Jul 2000 11:35:41 +0900
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


----Next_Part(Sat_Jul_15_11:33:19_2000_559)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

>>>>> On Tue, 4 Jul 2000 16:42:13 -0700 (PDT), Ani Joshi <ajoshi@shell.unixbox.com> said:

Joshi> With XFree86 4.x development speeding up, I have
Joshi> placed an rsync tree of my xfree86/ tree.  This rsync
Joshi> tree can be grabbed with:

Joshi> rsync -arvz penguinppc.org::xfree86-pmac .

Joshi> For detailed instructions and information, see:

Joshi> http://penguinppc.org/usr/xf4

Thanks a lot for providing such a bleeding edge.

I installed XFree86-4.0.1 accoriding to your site above.  My
machine is iMac revB (Mach64) with kernel 2.2.15pre19.  The
followings are results of x11perf -scroll500.

XFree86-3.3.3 (accelerated)

    200 reps @  36.5884 msec (    27.3/sec): Scroll 500x500 pixels
    200 reps @  36.2778 msec (    27.6/sec): Scroll 500x500 pixels
    200 reps @  36.2867 msec (    27.6/sec): Scroll 500x500 pixels
    200 reps @  36.3211 msec (    27.5/sec): Scroll 500x500 pixels
    200 reps @  36.2477 msec (    27.6/sec): Scroll 500x500 pixels
   1000 trep @  36.3443 msec (    27.5/sec): Scroll 500x500 pixels

XFree86-4.0 with fbdev

    100 reps @  57.1679 msec (    17.5/sec): Scroll 500x500 pixels
    100 reps @  52.5306 msec (    19.0/sec): Scroll 500x500 pixels
    100 reps @  54.1830 msec (    18.5/sec): Scroll 500x500 pixels
    100 reps @  55.1469 msec (    18.1/sec): Scroll 500x500 pixels
    100 reps @  52.4937 msec (    19.0/sec): Scroll 500x500 pixels
    500 trep @  54.3044 msec (    18.4/sec): Scroll 500x500 pixels

XFree86-4.0.1 with fbdev
    200 reps @  45.5985 msec (    21.9/sec): Scroll 500x500 pixels
    200 reps @  45.5996 msec (    21.9/sec): Scroll 500x500 pixels
    200 reps @  45.9694 msec (    21.8/sec): Scroll 500x500 pixels
    200 reps @  45.5282 msec (    22.0/sec): Scroll 500x500 pixels
    200 reps @  46.0706 msec (    21.7/sec): Scroll 500x500 pixels
   1000 trep @  45.7533 msec (    21.9/sec): Scroll 500x500 pixels

XFree86-4.0.1 with ati
    400 reps @  16.1530 msec (    61.9/sec): Scroll 500x500 pixels
    400 reps @  16.1180 msec (    62.0/sec): Scroll 500x500 pixels
    400 reps @  16.1207 msec (    62.0/sec): Scroll 500x500 pixels
    400 reps @  16.1127 msec (    62.1/sec): Scroll 500x500 pixels
    400 reps @  16.2172 msec (    61.7/sec): Scroll 500x500 pixels
   2000 trep @  16.1443 msec (    61.9/sec): Scroll 500x500 pixels

So, even fbdev seems to be a little bit accelerated compared
with 4.0.0.  :-)

Acceleration of ati is great.  The problem, however, is that
it can not be used.  When I used ati module, the color on X was
shifted to brown (or red?), and a lot of spectrum were
seen.

I attach XFree86.0.log when I used ati module.

Thanks for any help in advance.

Kohkichi Hosoda

E-mail address: khosoda@venus.dti.ne.jp

----Next_Part(Sat_Jul_15_11:33:19_2000_559)--
Content-Type: Text/Plain; charset=us-ascii
Content-Disposition: attachment; filename="XFree86.0.log.ati.strange.color"
Content-Transfer-Encoding: 7bit


XFree86 Version 4.0.1 / X Window System
(protocol Version 11, revision 0, vendor release 6400)
Release Date: 1 July 2000
	If the server is older than 6-12 months, or if your card is newer
	than the above date, look for a newer version before reporting
	problems.  (see http://www.XFree86.Org/FAQ)
Operating System: Linux 2.2.15pre19 ppc [ELF]
Module Loader present
(==) Log file: "/var/log/XFree86.0.log", Time: Sat Jul  8 21:01:06 2000
(==) Using config file: "/etc/XF86Config"
Markers: (--) probed, (**) from config file, (==) default setting,
         (++) from command line, (!!) notice, (II) informational,
         (WW) warning, (EE) error, (??) unknown.
(==) ServerLayout "XFree86 Configured"
(**) |-->Screen "Screen0" (0)
(**) |   |-->Monitor "iMac Monitor"
(**) |   |-->Device "ATY,RagePro_C"
(**) |-->Input Device "Mouse0"
(**) |-->Input Device "Keyboard0"
(**) Option "XkbDisable"
(**) XKB: disabled
(**) FontPath set to "/usr/X11R6/lib/X11/fonts/local/,/usr/X11R6/lib/X11/fonts/misc/,/usr/X11R6/lib/X11/fonts/75dpi/:unscaled,/usr/X11R6/lib/X11/fonts/100dpi/:unscaled,/usr/X11R6/lib/X11/fonts/Type1/,/usr/X11R6/lib/X11/fonts/CID/,/usr/X11R6/lib/X11/fonts/Speedo/,/usr/X11R6/lib/X11/fonts/75dpi/,/usr/X11R6/lib/X11/fonts/100dpi/,unix/:7100"
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
(II) PCI: 00:10:0: chip 106b,0017 card 0000,0000 rev 00 class ff,00,00 hdr 00
(II) PCI: 00:12:0: chip 1002,4750 card 0000,0000 rev 5c class 03,00,00 hdr 00
(II) PCI: 00:14:0: chip 1045,c861 card 1045,c861 rev 10 class 0c,03,10 hdr 00
(II) PCI: End of PCI scan
(II) LoadModule: "scanpci"
(II) Loading /usr/X11R6/lib/modules/libscanpci.a
(II) Module scanpci: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.2
(II) UnloadModule: "scanpci"
(II) Unloading /usr/X11R6/lib/modules/libscanpci.a
(--) PCI: (0:18:0) ATI Mach64 GP rev 92, Mem @ 0x81000000/24, 0x80881000/12, I/O @ 0x0c00/8
(II) Addressable bus resource ranges are
	[0] -1	0x00000000 - 0xffffffff (0x0) MXB
	[1] -1	0x00000000 - 0x0000ffff (0x10000) IXB
(II) OS-reported resource ranges:
(II) Active PCI resource ranges:
	[0] -1	0x80880000 - 0x808fffff (0x80000) MXBE
	[1] -1	0x80800000 - 0x80ffffff (0x800000) MXBE
	[2] -1	0x80881000 - 0x80881fff (0x1000) MXB(B)
	[3] -1	0x81000000 - 0x81ffffff (0x1000000) MXB(B)
	[4] -1	0x00000c00 - 0x00000cff (0x100) IXB(B)
(II) PCI Memory resource overlap reduced 0x80880000 from 0x808fffff to 0x80880fff
(II) PCI Memory resource overlap reduced 0x80800000 from 0x80ffffff to 0x8087ffff
(II) Active PCI resource ranges after removing overlaps:
	[0] -1	0x80880000 - 0x80880fff (0x1000) MXBE
	[1] -1	0x80800000 - 0x8087ffff (0x80000) MXBE
	[2] -1	0x80881000 - 0x80881fff (0x1000) MXB(B)
	[3] -1	0x81000000 - 0x81ffffff (0x1000000) MXB(B)
	[4] -1	0x00000c00 - 0x00000cff (0x100) IXB(B)
(II) OS-reported resource ranges after removing overlaps with PCI:
(II) All system resource ranges:
	[0] -1	0x80880000 - 0x80880fff (0x1000) MXBE
	[1] -1	0x80800000 - 0x8087ffff (0x80000) MXBE
	[2] -1	0x80881000 - 0x80881fff (0x1000) MXB(B)
	[3] -1	0x81000000 - 0x81ffffff (0x1000000) MXB(B)
	[4] -1	0x00000c00 - 0x00000cff (0x100) IXB(B)
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
(II) LoadModule: "record"
(II) Loading /usr/X11R6/lib/modules/extensions/librecord.a
(II) Module record: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 1.13.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension RECORD
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
(II) LoadModule: "freetype"
(II) Loading /usr/X11R6/lib/modules/fonts/libfreetype.a
(II) Module freetype: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 1.1.7
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.1
(II) Loading font FreeType
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
(--) Chipset ATI Mach64 3D Rage Pro (PQFP, PCI) found
(II) resource ranges after xf86ClaimFixedResources() call:
	[0] -1	0x80880000 - 0x80880fff (0x1000) MXBE
	[1] -1	0x80800000 - 0x8087ffff (0x80000) MXBE
	[2] -1	0x80881000 - 0x80881fff (0x1000) MXB(B)
	[3] -1	0x81000000 - 0x81ffffff (0x1000000) MXB(B)
	[4] -1	0x00000c00 - 0x00000cff (0x100) IXB(B)
Found a Mach64 on a PowerPC
(II) resource ranges after probing:
	[0] -1	0x80880000 - 0x80880fff (0x1000) MXBE
	[1] -1	0x80800000 - 0x8087ffff (0x80000) MXBE
	[2] -1	0x80881000 - 0x80881fff (0x1000) MXB(B)
	[3] -1	0x81000000 - 0x81ffffff (0x1000000) MXB(B)
	[4] 0	0x000a0000 - 0x000affff (0x10000) MSB
	[5] 0	0x000b0000 - 0x000b7fff (0x8000) MSB
	[6] 0	0x000b8000 - 0x000bffff (0x8000) MSB
	[7] -1	0x00000c00 - 0x00000cff (0x100) IXB(B)
	[8] 0	0x000003b0 - 0x000003bb (0xc) ISB
	[9] 0	0x000003c0 - 0x000003df (0x20) ISB
(II) Setting vga for screen 0.
(II) Loading sub module "fbdevhw"
(II) LoadModule: "fbdevhw"
(II) Loading /usr/X11R6/lib/modules/linux/libfbdevhw.a
(II) Module fbdevhw: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 0.0.1
	ABI class: XFree86 Video Driver, version 0.2
(**) ATI(0): Depth 15, (--) framebuffer bpp 16
(==) ATI(0): RGB weight 555
(==) ATI(0): Default visual is TrueColor
Mapping MMIO @ 0x817ff000 with size 0x1000
testing mmio w/ scratch regs...
SCRATCH_REG0 = 0x1869
SCRATCH_REG0 = 0x12345678
SCRATCH_REG1 = 0x0
SCRATCH_REG1 = 0xdeadbeef
Chip Type = 0x4750, Rev = 0x7c
(--) ATI(0): VideoRam: 2048 kByte (EDO)
(==) ATI(0): Using gamma correction (1.0, 1.0, 1.0)
(II) ATI(0): iMac Monitor: Using hsync range of  58.00- 62.00 kHz
(II) ATI(0): iMac Monitor: Using vrefresh range of  50.00-130.00 Hz
(II) ATI(0): Maximum clock:  80.00 MHz
(WW) ATI(0): Mode "640x350" deleted (hsync out of range)
(WW) ATI(0): Mode "640x400" deleted (hsync out of range)
(WW) ATI(0): Mode "720x400" deleted (hsync out of range)
(WW) ATI(0): Mode "1152x864" deleted (bad mode clock/interlace/doublescan)
(WW) ATI(0): Mode "1280x960" deleted (insufficient memory for mode)
(WW) ATI(0): Mode "1280x960" deleted (insufficient memory for mode)
(WW) ATI(0): Mode "1280x1024" deleted (insufficient memory for mode)
(WW) ATI(0): Mode "1280x1024" deleted (insufficient memory for mode)
(WW) ATI(0): Mode "1280x1024" deleted (insufficient memory for mode)
(WW) ATI(0): Mode "1600x1200" deleted (insufficient memory for mode)
(WW) ATI(0): Mode "1600x1200" deleted (insufficient memory for mode)
(WW) ATI(0): Mode "1600x1200" deleted (insufficient memory for mode)
(WW) ATI(0): Mode "1600x1200" deleted (insufficient memory for mode)
(WW) ATI(0): Mode "1600x1200" deleted (insufficient memory for mode)
(WW) ATI(0): Mode "1792x1344" deleted (insufficient memory for mode)
(WW) ATI(0): Mode "1792x1344" deleted (insufficient memory for mode)
(WW) ATI(0): Mode "1856x1392" deleted (insufficient memory for mode)
(WW) ATI(0): Mode "1856x1392" deleted (insufficient memory for mode)
(WW) ATI(0): Mode "1920x1440" deleted (insufficient memory for mode)
(WW) ATI(0): Mode "1920x1440" deleted (insufficient memory for mode)
modesFound = 3
(--) ATI(0): Virtual size is 1024x768 (pitch 1024)
(**) ATI(0): Mode "1024x768": 78.5 MHz, 59.9 kHz, 74.8 Hz
(**) ATI(0): Mode "800x600": 62.4 MHz, 60.0 kHz, 94.9 Hz
(**) ATI(0): Mode "640x480": 49.9 MHz, 60.0 kHz, 116.7 Hz
(==) ATI(0): DPI set to (75, 75)
loading cfb16 module...
(II) Loading sub module "cfb16"
(II) LoadModule: "cfb16"
(II) Loading /usr/X11R6/lib/modules/libcfb16.a
(II) Module cfb16: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 1.0.0
	ABI class: XFree86 ANSI C Emulation, version 0.1
(II) Loading sub module "cfb"
(II) LoadModule: "cfb"
(II) Loading /usr/X11R6/lib/modules/libcfb.a
(II) Module cfb: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 1.0.0
	ABI class: XFree86 ANSI C Emulation, version 0.1
(II) Loading sub module "mfb"
(II) LoadModule: "mfb"
(II) Loading /usr/X11R6/lib/modules/libmfb.a
(II) Module mfb: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 1.0.0
	ABI class: XFree86 ANSI C Emulation, version 0.1
(II) Loading sub module "xaa"
(II) LoadModule: "xaa"
(II) Loading /usr/X11R6/lib/modules/libxaa.a
(II) Module xaa: vendor="The XFree86 Project"
	compiled for 4.0.1, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.2
END - PreInit
Symbol regw8 from module /usr/X11R6/lib/modules/drivers/ati_drv.o is unresolved!
Symbol regw8 from module /usr/X11R6/lib/modules/drivers/ati_drv.o is unresolved!
Symbol regw8 from module /usr/X11R6/lib/modules/drivers/ati_drv.o is unresolved!
Symbol regw8 from module /usr/X11R6/lib/modules/drivers/ati_drv.o is unresolved!
Symbol regw8 from module /usr/X11R6/lib/modules/drivers/ati_drv.o is unresolved!
Symbol regw8 from module /usr/X11R6/lib/modules/drivers/ati_drv.o is unresolved!
Symbol regw8 from module /usr/X11R6/lib/modules/drivers/ati_drv.o is unresolved!
Symbol regw8 from module /usr/X11R6/lib/modules/drivers/ati_drv.o is unresolved!
Symbol regw8 from module /usr/X11R6/lib/modules/drivers/ati_drv.o is unresolved!
Symbol regw8 from module /usr/X11R6/lib/modules/drivers/ati_drv.o is unresolved!
Symbol regw8 from module /usr/X11R6/lib/modules/drivers/ati_drv.o is unresolved!
Symbol regw8 from module /usr/X11R6/lib/modules/drivers/ati_drv.o is unresolved!
Symbol regw8 from module /usr/X11R6/lib/modules/drivers/ati_drv.o is unresolved!
Symbol regw8 from module /usr/X11R6/lib/modules/drivers/ati_drv.o is unresolved!
Symbol regw8 from module /usr/X11R6/lib/modules/drivers/ati_drv.o is unresolved!
Symbol regw8 from module /usr/X11R6/lib/modules/drivers/ati_drv.o is unresolved!
Symbol regw8 from module /usr/X11R6/lib/modules/drivers/ati_drv.o is unresolved!
Symbol regw8 from module /usr/X11R6/lib/modules/drivers/ati_drv.o is unresolved!
Symbol regw8 from module /usr/X11R6/lib/modules/drivers/ati_drv.o is unresolved!
Symbol regw8 from module /usr/X11R6/lib/modules/drivers/ati_drv.o is unresolved!
Symbol regw8 from module /usr/X11R6/lib/modules/drivers/ati_drv.o is unresolved!
Symbol regw8 from module /usr/X11R6/lib/modules/drivers/ati_drv.o is unresolved!
Symbol regw8 from module /usr/X11R6/lib/modules/drivers/ati_drv.o is unresolved!
Symbol regw8 from module /usr/X11R6/lib/modules/drivers/ati_drv.o is unresolved!
Symbol regw8 from module /usr/X11R6/lib/modules/drivers/ati_drv.o is unresolved!
Symbol regw8 from module /usr/X11R6/lib/modules/drivers/ati_drv.o is unresolved!
Symbol regw8 from module /usr/X11R6/lib/modules/drivers/ati_drv.o is unresolved!
(II) do I need RAC?  No, I don't.
(II) resource ranges after preInit:
	[0] -1	0x80880000 - 0x80880fff (0x1000) MXBE
	[1] -1	0x80800000 - 0x8087ffff (0x80000) MXBE
	[2] -1	0x80881000 - 0x80881fff (0x1000) MXB(B)
	[3] -1	0x81000000 - 0x81ffffff (0x1000000) MXB(B)
	[4] 0	0x000a0000 - 0x000affff (0x10000) MSB
	[5] 0	0x000b0000 - 0x000b7fff (0x8000) MSB
	[6] 0	0x000b8000 - 0x000bffff (0x8000) MSB
	[7] -1	0x00000c00 - 0x00000cff (0x100) IXB(B)
	[8] 0	0x000003b0 - 0x000003bb (0xc) ISB
	[9] 0	0x000003c0 - 0x000003df (0x20) ISB
adjusted frame...
rgbbits = 8
seting visual types...
GEN_TEST_CNTL, BUS_CNTL = 0xd0, 0x4ca0
(II) ATI(0): Using XFree86 Acceleration Architecture (XAA)
	Screen to screen bit blits
	Solid filled rectangles
	8x8 mono pattern filled rectangles
	Solid Horizontal and Vertical Lines
(==) ATI(0): Backing store disabled
(II) Setting vga for screen 0.
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
(**) Mouse0: Protocol: "IMPS/2"
(**) Option "CorePointer"
(**) Mouse0: Core Pointer
(**) Option "Device" "/dev/usbmouse"
(==) Mouse0: Buttons: 3
(**) Option "ZAxisMapping" "4 5"
(**) Mouse0: ZAxisMapping: buttons 4 and 5
(II) Keyboard "Keyboard0" handled by legacy driver
(II) XINPUT: Adding extended input device "Mouse0" (type: MOUSE)
FreeFontPath: FPE "/usr/X11R6/lib/X11/fonts/misc/" refcount is 2, should be 1; fixing.

----Next_Part(Sat_Jul_15_11:33:19_2000_559)----

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
