To: debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Success! (was Re: External Monitor under Pismo)
References: <20010404092143.EFE4C2F01B@apollo.valhalla.net>
	<3ACB537B.99B851B9@netfall.com>
	<87hf0433qs.fsf@amadeus.openinformatics.com>
	<3ACB6167.3B2E0242@iiic.ethz.ch>
	<878zlg31mw.fsf@amadeus.openinformatics.com>
	<3ACB9611.C95D16A2@iiic.ethz.ch>
	<87ae5w1ce3.fsf@amadeus.openinformatics.com>
	<3ACB9EB3.2661FFCE@iiic.ethz.ch>
	<87u242zz7y.fsf@amadeus.openinformatics.com>
	<3ACCFFBB.58CC75D2@iiic.ethz.ch>
	<87itjmf7lf.fsf_-_@amadeus.openinformatics.com>
	<3AEDEF2D.4B823134@iiic.ethz.ch>
	<87wv7x984o.fsf@amadeus.openinformatics.com>
	<3AF1D91F.7030801@iiic.ethz.ch>
	<87hez1pjm1.fsf@amadeus.openinformatics.com>
	<3AF29AF6.9AC80F3E@iiic.ethz.ch>
	<87hez1hw97.fsf@amadeus.openinformatics.com>
From: jason@openinformatics.com (Jason E. Stewart)
Date: 04 May 2001 11:16:54 -0600
In-Reply-To: <87hez1hw97.fsf@amadeus.openinformatics.com>
Message-ID: <87d79phw55.fsf@amadeus.openinformatics.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--=-=-=

jason@openinformatics.com (Jason E. Stewart) writes:

> I'm attaching the whole log, as well as my config file.

no really, now I am.

jas.


--=-=-=
Content-Disposition: attachment; filename=XFree86.0.log
Content-Description: XFree error log


This is a pre-release version of XFree86, and is not supported in any
way.  Bugs may be reported to XFree86@XFree86.Org and patches submitted
to fixes@XFree86.Org.  Before reporting bugs in pre-release versions,
please check the latest version in the XFree86 CVS repository
(http://www.XFree86.Org/cvs)

XFree86 Version 4.0.99.3 / X Window System
(protocol Version 11, revision 0, vendor release 6510)
Release Date: 26 April 2001
	If the server is older than 6-12 months, or if your card is
	newer than the above date, look for a newer version before
	reporting problems.  (See http://www.XFree86.Org/FAQ)
Operating System: Linux 2.4.4-pre7 ppc [ELF]
Module Loader present
(==) Log file: "/var/log/XFree86.0.log", Time: Fri May  4 10:42:21 2001
(==) Using config file: "/etc/X11/XF86Config"
Markers: (--) probed, (**) from config file, (==) default setting,
         (++) from command line, (!!) notice, (II) informational,
         (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) ServerLayout "Laptop Only"
(**) |-->Screen "External Screen" (0)
(**) |   |-->Monitor "Viewsonic21"
(**) |   |-->Device "Rage128 External"
(**) |-->Input Device "Mouse1"
(**) |-->Input Device "Mouse2"
(**) |-->Input Device "Keyboard1"
(**) Option "AutoRepeat" "500 5"
(**) Option "XkbRules" "xfree86"
(**) XKB: rules: "xfree86"
(**) Option "XkbModel" "macintosh"
(**) XKB: model: "macintosh"
(**) Option "XkbOptions" "ctrl:nocaps"
(**) XKB: options: "ctrl:nocaps"
(--) Keyboard: CustomKeycode enabled
(WW) The directory "/usr/X11R6/lib/X11/fonts/local/" does not exist.
	Entry deleted from font path.
(**) FontPath set to "tcp/localhost:7100,/usr/X11R6/lib/X11/fonts/misc/,/usr/X11R6/lib/X11/fonts/75dpi/:unscaled,/usr/X11R6/lib/X11/fonts/100dpi/:unscaled,/usr/X11R6/lib/X11/fonts/Type1/,/usr/X11R6/lib/X11/fonts/Speedo/,/usr/X11R6/lib/X11/fonts/75dpi/,/usr/X11R6/lib/X11/fonts/100dpi/"
(**) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(==) ModulePath set to "/usr/X11R6/lib/modules"
(**) Option "BlankTime" "5"
(**) Option "StandbyTime" "7"
(**) Option "SuspendTime" "10"
(**) Option "OffTime" "15"
(--) using VT number 8

(WW) Cannot open APM
(II) Module ABI versions:
	XFree86 ANSI C Emulation: 0.1
	XFree86 Video Driver: 0.4
	XFree86 XInput driver : 0.2
	XFree86 Server Extension : 0.1
	XFree86 Font Renderer : 0.2
(II) Loader running on linux
(II) LoadModule: "bitmap"
(II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Module bitmap: vendor="The XFree86 Project"
	compiled for 4.0.3, module version = 1.0.0
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.2
(II) Loading font Bitmap
(II) LoadModule: "pcidata"
(II) Loading /usr/X11R6/lib/modules/libpcidata.a
(II) Module pcidata: vendor="The XFree86 Project"
	compiled for 4.0.3, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.3
(II) PCI: PCI scan (all values are in hex)
(II) PCI: 00:0b:0: chip 106b,0020 card 0000,0000 rev 00 class 06,00,00 hdr 00
(II) PCI: 00:10:0: chip 1002,4c46 card 1002,4c46 rev 02 class 03,00,00 hdr 00
(II) PCI: 01:0b:0: chip 106b,001f card 0000,0000 rev 00 class 06,00,00 hdr 00
(II) PCI: 01:17:0: chip 106b,0022 card 0000,0000 rev 02 class ff,00,00 hdr 00
(II) PCI: 01:18:0: chip 106b,0019 card 0000,0000 rev 00 class 0c,03,10 hdr 00
(II) PCI: 01:19:0: chip 106b,0019 card 0000,0000 rev 00 class 0c,03,10 hdr 00
(II) PCI: 01:1a:0: chip 104c,ac1e card 1000,0000 rev 00 class 06,07,00 hdr 02
(II) PCI: 06:0b:0: chip 106b,001e card 0000,0000 rev 00 class 06,00,00 hdr 00
(II) PCI: 06:0f:0: chip 106b,0021 card 0000,0000 rev 01 class 02,00,00 hdr 00
(II) PCI: End of PCI scan
(II) LoadModule: "scanpci"
(II) Loading /usr/X11R6/lib/modules/libscanpci.a
(II) Module scanpci: vendor="The XFree86 Project"
	compiled for 4.0.3, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.3
(II) UnloadModule: "scanpci"
(II) Unloading /usr/X11R6/lib/modules/libscanpci.a
(II) Host-to-PCI bridge:
(II) Host-to-PCI bridge:
(II) Host-to-PCI bridge:
(II) Host-to-PCI bridge:
(II) Host-to-PCI bridge:
(II) Host-to-PCI bridge:
(II) Host-to-PCI bridge:
(II) Bus 0: bridge is at (0:0:0), (-1,0,0), BCTRL: 0x08 (VGA_EN is set)
(II) Bus 0 I/O range:
	[0] -1	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 0 non-prefetchable memory range:
	[0] -1	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 0 prefetchable memory range:
	[0] -1	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 1: bridge is at (0:0:0), (-1,1,0), BCTRL: 0x08 (VGA_EN is set)
(II) Bus 1 I/O range:
	[0] -1	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 1 non-prefetchable memory range:
	[0] -1	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 1 prefetchable memory range:
	[0] -1	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 2: bridge is at (0:0:0), (-1,2,0), BCTRL: 0x08 (VGA_EN is set)
(II) Bus 2 I/O range:
	[0] -1	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 2 non-prefetchable memory range:
	[0] -1	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 2 prefetchable memory range:
	[0] -1	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 3: bridge is at (0:0:0), (-1,3,0), BCTRL: 0x00 (VGA_EN is cleared)
(II) Bus 3 I/O range:
	[0] -1	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 3 non-prefetchable memory range:
	[0] -1	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 3 prefetchable memory range:
	[0] -1	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 4: bridge is at (0:0:0), (-1,4,0), BCTRL: 0x00 (VGA_EN is cleared)
(II) Bus 4 I/O range:
	[0] -1	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 4 non-prefetchable memory range:
	[0] -1	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 4 prefetchable memory range:
	[0] -1	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 5: bridge is at (0:0:0), (-1,5,0), BCTRL: 0x00 (VGA_EN is cleared)
(II) Bus 5 I/O range:
	[0] -1	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 5 non-prefetchable memory range:
	[0] -1	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 5 prefetchable memory range:
	[0] -1	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 6: bridge is at (0:0:0), (-1,6,0), BCTRL: 0x00 (VGA_EN is cleared)
(II) Bus 6 I/O range:
	[0] -1	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 6 non-prefetchable memory range:
	[0] -1	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 6 prefetchable memory range:
	[0] -1	0x00000000 - 0xffffffff (0x0) MX[B]
(--) PCI:*(0:16:0) ATI Rage 128 Mobility LF rev 2, Mem @ 0xa4000000/26, 0xa0000000/14, I/O @ 0x0400/8
(II) Addressable bus resource ranges are
	[0] -1	0x00000000 - 0xffffffff (0x0) MX[B]
	[1] -1	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) OS-reported resource ranges:
	[0] -1	0xffffffff - 0xffffffff (0x1) MX[B]
	[1] -1	0x00000000 - 0x00000000 (0x1) MX[B]
	[2] -1	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[3] -1	0x00000000 - 0x00000000 (0x1) IX[B]
(II) Active PCI resource ranges:
	[0] -1	0xf5200000 - 0xf53fffff (0x200000) MX[B]
	[1] -1	0x80081000 - 0x80081fff (0x1000) MX[B]
	[2] -1	0x80082000 - 0x80082fff (0x1000) MX[B]
	[3] -1	0x80000000 - 0x8007ffff (0x80000) MX[B]
	[4] -1	0xa0020000 - 0xa003ffff (0x20000) MX[B](B)
	[5] -1	0xa0000000 - 0xa0003fff (0x4000) MX[B](B)
	[6] -1	0xa4000000 - 0xa7ffffff (0x4000000) MX[B](B)
	[7] -1	0x00000400 - 0x000004ff (0x100) IX[B](B)
(II) Active PCI resource ranges after removing overlaps:
	[0] -1	0xf5200000 - 0xf53fffff (0x200000) MX[B]
	[1] -1	0x80081000 - 0x80081fff (0x1000) MX[B]
	[2] -1	0x80082000 - 0x80082fff (0x1000) MX[B]
	[3] -1	0x80000000 - 0x8007ffff (0x80000) MX[B]
	[4] -1	0xa0020000 - 0xa003ffff (0x20000) MX[B](B)
	[5] -1	0xa0000000 - 0xa0003fff (0x4000) MX[B](B)
	[6] -1	0xa4000000 - 0xa7ffffff (0x4000000) MX[B](B)
	[7] -1	0x00000400 - 0x000004ff (0x100) IX[B](B)
(II) OS-reported resource ranges after removing overlaps with PCI:
	[0] -1	0xffffffff - 0xffffffff (0x1) MX[B]
	[1] -1	0x00000000 - 0x00000000 (0x1) MX[B]
	[2] -1	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[3] -1	0x00000000 - 0x00000000 (0x1) IX[B]
(II) All system resource ranges:
	[0] -1	0xffffffff - 0xffffffff (0x1) MX[B]
	[1] -1	0x00000000 - 0x00000000 (0x1) MX[B]
	[2] -1	0xf5200000 - 0xf53fffff (0x200000) MX[B]
	[3] -1	0x80081000 - 0x80081fff (0x1000) MX[B]
	[4] -1	0x80082000 - 0x80082fff (0x1000) MX[B]
	[5] -1	0x80000000 - 0x8007ffff (0x80000) MX[B]
	[6] -1	0xa0020000 - 0xa003ffff (0x20000) MX[B](B)
	[7] -1	0xa0000000 - 0xa0003fff (0x4000) MX[B](B)
	[8] -1	0xa4000000 - 0xa7ffffff (0x4000000) MX[B](B)
	[9] -1	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[10] -1	0x00000000 - 0x00000000 (0x1) IX[B]
	[11] -1	0x00000400 - 0x000004ff (0x100) IX[B](B)
(II) LoadModule: "dbe"
(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a
(II) Module dbe: vendor="The XFree86 Project"
	compiled for 4.0.3, module version = 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension DOUBLE-BUFFER
(II) LoadModule: "extmod"
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor="The XFree86 Project"
	compiled for 4.0.3, module version = 1.0.0
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
(II) Loading extension XFree86-DGA
(II) Loading extension DPMS
(II) Loading extension FontCache
(II) Loading extension TOG-CUP
(II) Loading extension Extended-Visual-Information
(II) Loading extension XVideo
(II) LoadModule: "glx"
(II) Loading /usr/X11R6/lib/modules/extensions/libglx.a
(II) Module glx: vendor="The XFree86 Project"
	compiled for 4.0.3, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension GLX
(II) Loading sub module "GLcore"
(II) LoadModule: "GLcore"
(II) Loading /usr/X11R6/lib/modules/extensions/libGLcore.a
(II) Module GLcore: vendor="The XFree86 Project"
	compiled for 4.0.3, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.1
(II) LoadModule: "r128"
(II) Loading /usr/X11R6/lib/modules/drivers/r128_drv.o
(II) Module r128: vendor="The XFree86 Project"
	compiled for 4.0.3, module version = 4.0.1
	Module class: XFree86 Video Driver
	ABI class: XFree86 Video Driver, version 0.3
(II) LoadModule: "ati"
(II) Loading /usr/X11R6/lib/modules/drivers/ati_drv.o
(II) Module ati: vendor="The XFree86 Project"
	compiled for 4.0.3, module version = 6.2.3
	Module class: XFree86 Video Driver
	ABI class: XFree86 Video Driver, version 0.3
(II) LoadModule: "mouse"
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor="The XFree86 Project"
	compiled for 4.0.3, module version = 1.0.0
	Module class: XFree86 XInput Driver
	ABI class: XFree86 XInput driver, version 0.1
(II) ATI: ATI driver (version 6.2.3) for chipsets: ati
(II) R128: Driver for ATI Rage 128 chipsets: ATI Rage 128 RE (PCI),
	ATI Rage 128 RF (AGP), ATI Rage 128 RG (AGP), ATI Rage 128 RK (PCI),
	ATI Rage 128 RL (AGP), ATI Rage 128 Pro PD (AGP),
	ATI Rage 128 Pro PF (AGP), ATI Rage 128 Mobility LE (PCI),
	ATI Rage 128 Mobility LF (AGP), ATI Rage 128 Mobility MF (AGP),
	ATI Rage 128 Mobility ML (AGP)
(II) RADEON: Driver for ATI Radeon chipsets: ATI Radeon QD (AGP),
	ATI Radeon QE (AGP), ATI Radeon QF (AGP), ATI Radeon QG (AGP)
(II) Primary Device is: PCI 00:10:0
(--) Chipset ATI Rage 128 Mobility LF (AGP) found
(II) Loading sub module "r128"
(II) LoadModule: "r128"
(II) Reloading /usr/X11R6/lib/modules/drivers/r128_drv.o
(II) resource ranges after xf86ClaimFixedResources() call:
	[0] -1	0xffffffff - 0xffffffff (0x1) MX[B]
	[1] -1	0x00000000 - 0x00000000 (0x1) MX[B]
	[2] -1	0xf5200000 - 0xf53fffff (0x200000) MX[B]
	[3] -1	0x80081000 - 0x80081fff (0x1000) MX[B]
	[4] -1	0x80082000 - 0x80082fff (0x1000) MX[B]
	[5] -1	0x80000000 - 0x8007ffff (0x80000) MX[B]
	[6] -1	0xa0020000 - 0xa003ffff (0x20000) MX[B](B)
	[7] -1	0xa0000000 - 0xa0003fff (0x4000) MX[B](B)
	[8] -1	0xa4000000 - 0xa7ffffff (0x4000000) MX[B](B)
	[9] -1	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[10] -1	0x00000000 - 0x00000000 (0x1) IX[B]
	[11] -1	0x00000400 - 0x000004ff (0x100) IX[B](B)
(II) resource ranges after probing:
	[0] -1	0xffffffff - 0xffffffff (0x1) MX[B]
	[1] -1	0x00000000 - 0x00000000 (0x1) MX[B]
	[2] -1	0xf5200000 - 0xf53fffff (0x200000) MX[B]
	[3] -1	0x80081000 - 0x80081fff (0x1000) MX[B]
	[4] -1	0x80082000 - 0x80082fff (0x1000) MX[B]
	[5] -1	0x80000000 - 0x8007ffff (0x80000) MX[B]
	[6] -1	0xa0020000 - 0xa003ffff (0x20000) MX[B](B)
	[7] -1	0xa0000000 - 0xa0003fff (0x4000) MX[B](B)
	[8] -1	0xa4000000 - 0xa7ffffff (0x4000000) MX[B](B)
	[9] 0	0x000a0000 - 0x000affff (0x10000) MS[B]
	[10] 0	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[11] 0	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[12] -1	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[13] -1	0x00000000 - 0x00000000 (0x1) IX[B]
	[14] -1	0x00000400 - 0x000004ff (0x100) IX[B](B)
	[15] 0	0x000003b0 - 0x000003bb (0xc) IS[B]
	[16] 0	0x000003c0 - 0x000003df (0x20) IS[B]
(II) Setting vga for screen 0.
(II) Loading sub module "vgahw"
(II) LoadModule: "vgahw"
(II) Loading /usr/X11R6/lib/modules/libvgahw.a
(II) Module vgahw: vendor="The XFree86 Project"
	compiled for 4.0.3, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.3
(II) R128(0): PCI bus 0 card 16 func 0
(**) R128(0): Depth 16, (--) framebuffer bpp 16
(II) R128(0): Pixel depth = 16 bits stored in 2 bytes (16 bpp pixmaps)
(==) R128(0): Default visual is TrueColor
(==) R128(0): RGB weight 565
(II) R128(0): Using 6 bits per RGB (8 bit DAC)
(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Loading /usr/X11R6/lib/modules/libint10.a
(II) Module int10: vendor="The XFree86 Project"
	compiled for 4.0.3, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.3
(II) R128(0): initializing int10
(EE) R128(0): Cannot read V_BIOS (4)
(--) R128(0): Chipset: "ATI Rage 128 Mobility LF (AGP)" (ChipID = 0x4c46)
(--) R128(0): Linear framebuffer at 0xa4000000
(--) R128(0): MMIO registers at 0xa0000000
(--) R128(0): BIOS at 0xa0020000
(--) R128(0): VideoRAM: 8192 kByte (128-bit SDR SGRAM 1:1)
(II) R128(0): Using flat panel for display
(WW) R128(0): Video BIOS not detected in PCI space!
(WW) R128(0): Attempting to read Video BIOS from legacy ISA space!
(WW) R128(0): Video BIOS not found!
(II) R128(0): PLL parameters: rf=2950 rd=59 min=12500 max=25000; xclk=10500
(II) Loading sub module "ddc"
(II) LoadModule: "ddc"
(II) Loading /usr/X11R6/lib/modules/libddc.a
(II) Module ddc: vendor="The XFree86 Project"
	compiled for 4.0.3, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.3
(==) R128(0): Using gamma correction (1.0, 1.0, 1.0)
(II) R128(0): Viewsonic21: Using hsync range of 31.50-64.30 kHz
(II) R128(0): Viewsonic21: Using vrefresh range of 50.00-90.00 Hz
(II) R128(0): Clock range:  12.50 to 250.00 MHz
(II) R128(0): Not using default mode "1152x864" (hsync out of range)
(II) R128(0): Not using default mode "1280x960" (hsync out of range)
(II) R128(0): Not using default mode "1600x1200" (hsync out of range)
(II) R128(0): Not using default mode "1600x1200" (hsync out of range)
(II) R128(0): Not using default mode "1600x1200" (hsync out of range)
(II) R128(0): Not using default mode "1600x1200" (hsync out of range)
(II) R128(0): Not using default mode "1600x1200" (hsync out of range)
(II) R128(0): Not using default mode "1792x1344" (hsync out of range)
(II) R128(0): Not using default mode "1792x1344" (bad mode clock/interlace/doublescan)
(II) R128(0): Not using default mode "1856x1392" (hsync out of range)
(II) R128(0): Not using default mode "1856x1392" (bad mode clock/interlace/doublescan)
(II) R128(0): Not using default mode "1920x1440" (hsync out of range)
(II) R128(0): Not using default mode "1920x1440" (bad mode clock/interlace/doublescan)
(II) R128(0): Not using default mode "1400x1050" (hsync out of range)
(--) R128(0): Virtual size is 1280x1024 (pitch 1280)
(**) R128(0): Mode "1280x1024": 110.0 MHz, 64.0 kHz, 59.3 Hz
(II) R128(0): Modeline "1280x1024"  110.00  1280 1368 1552 1720  1024 1025 1028 1078 +hsync +vsync
(**) R128(0): Mode "1024x768": 85.0 MHz, 62.7 kHz, 76.2 Hz
(II) R128(0): Modeline "1024x768"   85.00  1024 1076 1196 1356  768 780 783 823 +hsync +vsync
(**) R128(0): Default mode "800x600": 56.3 MHz, 53.7 kHz, 85.1 Hz
(II) R128(0): Modeline "800x600"   56.30  800 832 896 1048  600 601 604 631 +hsync +vsync
(**) R128(0): Default mode "640x480": 36.0 MHz, 43.3 kHz, 85.0 Hz
(II) R128(0): Modeline "640x480"   36.00  640 696 752 832  480 481 484 509 -hsync -vsync
(++) R128(0): DPI set to (100, 100)
(II) Loading sub module "fb"
(II) LoadModule: "fb"
(II) Loading /usr/X11R6/lib/modules/libfb.a
(II) Module fb: vendor="The XFree86 Project"
	compiled for 4.0.3, module version = 1.0.0
	ABI class: XFree86 ANSI C Emulation, version 0.1
(II) Loading sub module "ramdac"
(II) LoadModule: "ramdac"
(II) Loading /usr/X11R6/lib/modules/libramdac.a
(II) Module ramdac: vendor="The XFree86 Project"
	compiled for 4.0.3, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.3
(II) Loading sub module "xaa"
(II) LoadModule: "xaa"
(II) Loading /usr/X11R6/lib/modules/libxaa.a
(II) Module xaa: vendor="The XFree86 Project"
	compiled for 4.0.3, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.3
(II) do I need RAC?  No, I don't.
(II) resource ranges after preInit:
	[0] 0	0xa0000000 - 0xa0003fff (0x4000) MS[B]
	[1] 0	0xa4000000 - 0xa7ffffff (0x4000000) MS[B]
	[2] -1	0xffffffff - 0xffffffff (0x1) MX[B]
	[3] -1	0x00000000 - 0x00000000 (0x1) MX[B]
	[4] -1	0xf5200000 - 0xf53fffff (0x200000) MX[B]
	[5] -1	0x80081000 - 0x80081fff (0x1000) MX[B]
	[6] -1	0x80082000 - 0x80082fff (0x1000) MX[B]
	[7] -1	0x80000000 - 0x8007ffff (0x80000) MX[B]
	[8] -1	0xa0020000 - 0xa003ffff (0x20000) MX[B](B)
	[9] -1	0xa0000000 - 0xa0003fff (0x4000) MX[B](B)
	[10] -1	0xa4000000 - 0xa7ffffff (0x4000000) MX[B](B)
	[11] 0	0x000a0000 - 0x000affff (0x10000) MS[B]
	[12] 0	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[13] 0	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[14] 0	0x00000400 - 0x000004ff (0x100) IS[B]
	[15] -1	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[16] -1	0x00000000 - 0x00000000 (0x1) IX[B]
	[17] -1	0x00000400 - 0x000004ff (0x100) IX[B](B)
	[18] 0	0x000003b0 - 0x000003bb (0xc) IS[B]
	[19] 0	0x000003c0 - 0x000003df (0x20) IS[B]

Fatal server error:
Caught signal 11.  Server aborting


When reporting a problem related to a server crash, please send
the full server output, not just the last messages.
This can be found in the log file "/var/log/XFree86.0.log".
Please report problems to xfree86@xfree86.org.


--=-=-=
Content-Disposition: attachment; filename=XF86Config
Content-Description: XF config

Section "DRI"
#	Mode 0666
EndSection


Section "Files"
    RgbPath	"/usr/X11R6/lib/X11/rgb"

   FontPath     "tcp/localhost:7100"

    FontPath	"/usr/X11R6/lib/X11/fonts/local/"
    FontPath	"/usr/X11R6/lib/X11/fonts/misc/"
    FontPath	"/usr/X11R6/lib/X11/fonts/75dpi/:unscaled"
    FontPath	"/usr/X11R6/lib/X11/fonts/100dpi/:unscaled"
    FontPath	"/usr/X11R6/lib/X11/fonts/Type1/"
#     FontPath	"/usr/X11R6/lib/X11/fonts/CID/"
    FontPath	"/usr/X11R6/lib/X11/fonts/Speedo/"
    FontPath	"/usr/X11R6/lib/X11/fonts/75dpi/"
    FontPath	"/usr/X11R6/lib/X11/fonts/100dpi/"

#    ModulePath	"/usr/XF86-DRI/lib/modules"
EndSection


Section "Module"
    Load	"dbe"
    Load	"extmod"
    Load	"glx"
#    Load	"dri"

# You can load other modules as well of course
EndSection


Section "ServerFlags"
    Option	"blank time"	"5"
    Option	"standby time"	"7"
    Option	"suspend time"	"10"
    Option	"off time"	"15"
EndSection


Section "InputDevice"
    Identifier	"Keyboard1"
    Driver	"keyboard"
    Option	"AutoRepeat"	"500 5"
#    Option	"XkbDisable"
    Option	"XkbOptions"	"ctrl:nocaps"
    Option	"XkbRules"	"xfree86"
    Option	"XkbModel"	"macintosh"
#    Option	"XkbLayout"	"us"
#    Option	"XkbVariant"	""
#    Option	"XkbOptions"	""
EndSection


Section "InputDevice"
    Identifier	"Keyboard2"
    Driver	"keyboard"
    Option	"AutoRepeat"	"500 5"
#    Option	"XkbDisable"
    Option	"XkbOptions"	"ctrl:nocaps"
    Option	"XkbRules"	"xfree86"
    Option	"XkbModel"	"pc"
#    Option	"XkbLayout"	"us"
#    Option	"XkbVariant"	""
#    Option	"XkbOptions"	""
EndSection


# ADB mouse
Section "InputDevice"
    Identifier	"Mouse1"
    Driver	"mouse"
    Option	"Protocol"	"BusMouse"
    Option	"Device"	"/dev/mouse"
EndSection

# USB mouse
Section "InputDevice"
    Identifier	"Mouse2"
    Driver	"mouse"
    Option	"Protocol"	"IMPS/2"
    Option	"Device"	"/dev/mouse"
    Option      "Buttons"       "5"
    Option      "ZAxisMapping"  "4 5"
EndSection

#TrackBall
Section "InputDevice"
    Identifier	"Mouse3"
    Driver	"mouse"
#    Option	"Protocol"	"ThinkingMouse"
    Option	"Protocol"	"IMPS/2"
    Option	"Device"	"/dev/mouse"
    Option      "Buttons"       "3"
EndSection


Section "Monitor"
    Identifier	"PowerBook Display"
    HorizSync	30-64         # multisync
    VertRefresh	50-100        # multisync
    Option	"dpms" "on"

    Mode "1024x768"
	# D: 78.740 MHz, H: 60.015 kHz, V: 75.019 Hz
	DotClock 78.741
	HTimings 1024 1058 1154 1312
	VTimings 768 769 772 800
	Flags    "+HSync" "+VSync"
    EndMode
EndSection


Section "Monitor"
   Identifier      "Viewsonic21"
   VendorName      "Viewsonic"
   ModelName       "Unknown"
   HorizSync       31.5-64.3
   VertRefresh     50-90
   Mode "1024x768"
	DotClock 85.00
	HTimings  1024 1076 1196 1356
	VTimings 768 780 783 823
	Flags    "+HSync" "+VSync"
  EndMode
  Mode  "1280x1024"
      DotClock 110.00
      HTimings 1280 1368 1552 1720
      VTimings 1024 1025 1028 1078
      Flags    "+HSync" "+VSync"
  EndMode
#    Modeline  "1200x900"  100.00 1200 1259 1418 1554 900 901 911 940
#    Modeline  "1152x864"   92.00 1152 1208 1368 1506 864 865 875 911
#    Modeline  "800x600"    60.75 800 852 916 1060 600 604 609 637 -hsync -vsync
#    Modeline  "640x480"    36.00 640 680 736 860 480 481 484 513 -hsync -vsync
EndSection

Section "Device"
    Identifier	"Rage128 Mobility"
    Driver	"r128"
    BusID	"PCI:0:16:0"
#    Option	"CRTOnly"
#    Option	"Display" "CRT"

# Remove this option if there is AGP GART support
    Option	"ForcePCIMode"

# Enable flat panel (especially for Pismos)
#     Option      "ProgramFPRegs" "No"
#     Option	"EnableFP"
#     Option	"PanelX" "1024"
#     Option	"PanelY" "768"

    Option	"XAANoDashedBresenhamLine"

# fbdev doesn't look good in 16 bit currently
    Option	"UseFBDev"
EndSection

Section "Device"
    Identifier	"Rage128 External"
    Driver	"r128"
    BusID	"PCI:0:16:0"
#     Option	"Display" "CRT"
    Option	"CRTOnly"

# Remove this option if there is AGP GART support
    Option	"ForcePCIMode"

# Enable flat panel (especially for Pismos)
#     Option      "ProgramFPRegs" "No"
#     Option	"EnableFP"
#     Option	"PanelX" "1024"
#     Option	"PanelY" "768"

    Option	"XAANoDashedBresenhamLine"

# fbdev doesn't look good in 16 bit currently
#    Option	"UseFBDev"
EndSection


Section "Screen"
    Identifier	"Screen 1"
    Device	"Rage128 Mobility"
    Monitor	"PowerBook Display"
    DefaultDepth 24

# Only depth 16 and 24 (fbbpp 32) are supported for DRI
    SubSection "Display"
	Depth		16
        Modes		"1024x768" "800x600" "640x480"
    EndSubSection
    SubSection "Display"
	Depth		24
	Fbbpp		32
        Modes		"1024x768" "800x600" "640x480"
    EndSubSection
EndSection

Section "Screen"
    Identifier	"External Screen"
    Device	"Rage128 External"
    Monitor	"Viewsonic21"
    DefaultDepth 16

    SubSection "Display"
	  Depth		8
	  Modes		"1024x768" "1280x1024" "800x600" "640x480"
    EndSubSection

# Only depth 16 and 24 (fbbpp 32) are supported for DRI
    SubSection "Display"
	  Depth		16
	  Modes		"1280x1024" "1024x768" "800x600" "640x480"
    EndSubSection
    SubSection "Display"
	  Depth		24
	  Fbbpp		32
	  Modes		"1280x1024" "1024x768" "800x600" "640x480"
    EndSubSection
EndSection


Section "ServerLayout"
    Identifier	"Laptop Only"
    Screen	"External Screen"
#     Screen	"Screen 1"
    InputDevice	"Mouse1" "CorePointer"
    InputDevice	"Mouse2" "SendCoreEvents"
#    InputDevice	"Mouse3" "CorePointer"
    InputDevice "Keyboard1" "CoreKeyboard"
EndSection

# Section "ServerLayout"
#     Identifier	"External Monitor"
#     Screen	"External Screen"
#     InputDevice	"Mouse1" "CorePointer"
#     InputDevice	"Mouse2" "SendCoreEvents"
#     InputDevice "Keyboard2" "CoreKeyboard"
# EndSection


--=-=-=--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
