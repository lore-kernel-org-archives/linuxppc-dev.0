Message-ID: <20011108002902.4251.qmail@kunk.jriver.com>
Subject: XFree4.1 and Mach64 problem
To: linuxppcdev@lists.linuxppc.org
Date: Wed, 7 Nov 2001 18:26:57 -0600 (CST)
From: Robert E Brose II <bob@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm trying to get X working with my Mach 64 pci video card in a 7600.
I'm using XFree86-4.1.99.1-1b.

I grabbed the ati.o and atimisc_drv.o from Ani Joshi's folder on
devel.linuxppc.org. They are dated October 1st 2001. ati_drv.o and
atimisc_drv.o.

This works fine on my rev C imac which  has a rage pro chipset.
However the 7600 with a plugin xclaim card doesn't work...

The server appears to run but I get a blank screen. The keyboard is
active and I can get back to a text console by quitting out of X.
I have tried all resolutions and color depths.

Any ideas? Ani??

Here is the lspci video entry for the 7600...

00:0f.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro (rev 5c) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0000
        Flags: bus master, stepping, medium devsel, latency 32, IRQ 25
        Memory at 81000000 (32-bit, prefetchable) [size=16M]
        I/O ports at 0400 [disabled] [size=256]
        Memory at 80800000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at 80820000 [disabled] [size=128K]

Here is the debug output from the server startup...


This is a pre-release version of XFree86, and is not supported in any
way.  Bugs may be reported to XFree86@XFree86.Org and patches submitted
to fixes@XFree86.Org.  Before reporting bugs in pre-release versions,
please check the latest version in the XFree86 CVS repository
(http://www.XFree86.Org/cvs)

XFree86 Version 4.1.99.1 / X Window System
(protocol Version 11, revision 0, vendor release 6510)
Release Date: xx September 2001
	If the server is older than 6-12 months, or if your card is
	newer than the above date, look for a newer version before
	reporting problems.  (See http://www.XFree86.Org/FAQ)
Build Operating System: Linux 2.4.10-B0a ppc [ELF]
Module Loader present
(==) Log file: "/var/log/XFree86.0.log", Time: Wed Nov  7 18:14:44 2001
(==) Using config file: "/etc/X11/XF86Config-4"
Markers: (--) probed, (**) from config file, (==) default setting,
         (++) from command line, (!!) notice, (II) informational,
         (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) ServerLayout "Simple Layout"
(**) |-->Screen "Screen 1" (0)
(**) |   |-->Monitor "foo"
(**) |   |-->Device "ati"
(**) |-->Input Device "Mouse1"
(**) |-->Input Device "Keyboard1"
(**) XKB: rules: "xfree86"
(**) XKB: model: "pc104"
(**) XKB: layout: "us"
(**) XKB: variant: "foo"
(--) Keyboard: CustomKeycode enabled
(**) FontPath set to "/usr/X11R6/lib/X11/fonts/local/,/usr/X11R6/lib/X11/fonts/misc/,/usr/X11R6/lib/X11/fonts/75dpi/:unscaled,/usr/X11R6/lib/X11/fonts/100dpi/:unscaled,/usr/X11R6/lib/X11/fonts/Type1/,/usr/X11R6/lib/X11/fonts/Speedo/,/usr/X11R6/lib/X11/fonts/75dpi/,/usr/X11R6/lib/X11/fonts/100dpi/"
(**) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(==) ModulePath set to "/usr/X11R6/lib/modules"
(--) using VT number 7

(II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Module bitmap: vendor="The XFree86 Project"
	compiled for 4.1.99.1, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/libpcidata.a
(II) Module pcidata: vendor="The XFree86 Project"
	compiled for 4.1.99.1, module version = 0.1.0
(II) Loading /usr/X11R6/lib/modules/libscanpci.a
(II) Module scanpci: vendor="The XFree86 Project"
	compiled for 4.1.99.1, module version = 0.1.0
(II) Unloading /usr/X11R6/lib/modules/libscanpci.a
(--) PCI: (0:15:0) ATI Mach64 GI rev 92, Mem @ 0x81000000/24, 0x80800000/12, I/O @ 0x0400/8, BIOS @ 0x80820000/17
(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a
(II) Module dbe: vendor="The XFree86 Project"
	compiled for 4.1.99.1, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor="The XFree86 Project"
	compiled for 4.1.99.1, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/fonts/libtype1.a
(II) Module type1: vendor="The XFree86 Project"
	compiled for 4.1.99.1, module version = 1.0.1
(II) Loading /usr/X11R6/lib/modules/fonts/libfreetype.a
(II) Module freetype: vendor="The XFree86 Project"
	compiled for 4.1.99.1, module version = 1.1.10
(II) Loading /usr/X11R6/lib/modules/drivers/ati_drv.o
(II) Module ati: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 6.3.6
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor="The XFree86 Project"
	compiled for 4.1.99.1, module version = 1.0.0
(II) ATI: ATI driver (version 6.3.6) for chipsets: ati
(II) R128: Driver for ATI Rage 128 chipsets: ATI Rage 128 RE (PCI),
	ATI Rage 128 RF (AGP), ATI Rage 128 RG (AGP), ATI Rage 128 RK (PCI),
	ATI Rage 128 RL (AGP), ATI Rage 128 Pro PD (PCI),
	ATI Rage 128 Pro PF (AGP), ATI Rage 128 Mobility LE (PCI),
	ATI Rage 128 Mobility LF (AGP), ATI Rage 128 Mobility MF (AGP),
	ATI Rage 128 Mobility ML (AGP)
(II) RADEON: Driver for ATI Radeon chipsets: ATI Radeon QD (AGP),
	ATI Radeon QE (AGP), ATI Radeon QF (AGP), ATI Radeon QG (AGP),
	ATI Radeon VE (AGP)
(WW) xf86UnMapVidMem: cannot find region for [0x30015c00,0x1c00]
(II) Loading /usr/X11R6/lib/modules/drivers/atimisc_drv.o
(II) Module atimisc: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 6.3.6
(==) ATI(0): Chipset:  "ati".
(**) ATI(0): Depth 8, (--) framebuffer bpp 8
PanelID = 0xffffffff
Hor = 0
(--) ATI(0): ATI 3D Rage Pro graphics controller detected.
(--) ATI(0): Chip type 4749 "GI", version 4, foundry UMC, class 0, revision 0x01.
(--) ATI(0): PCI bus interface detected;  block I/O base is 0x0400.
(--) ATI(0): ATI Mach64 adapter detected.
(--) ATI(0): Internal RAMDAC (subtype 1) detected.
(==) ATI(0): RGB weight 888
(==) ATI(0): Default visual is PseudoColor
(==) ATI(0): Using gamma correction (1.0, 1.0, 1.0)
(II) ATI(0): Using Mach64 accelerator CRTC.
(II) ATI(0): Storing hardware cursor image at 0x817FFC00.
(II) ATI(0): Using 8 MB linear aperture at 0x81800000.
(!!) ATI(0): Virtual resolutions will be limited to 8191 kB
 due to linear aperture size and/or placement of hardware cursor image area.
(II) ATI(0): Using Block 0 MMIO aperture at 0x817FF000.
(II) ATI(0): Using Block 1 MMIO aperture at 0x817FEC00.
(WW) ATI(0): xf86UnMapVidMem: cannot find region for [0x30017c00,0x1c00]
(II) ATI(0): MMIO write caching enabled.
(--) ATI(0): 8192 kB of SGRAM (1:1) detected (using 8191 kB).
(WW) ATI(0): Cannot shadow an accelerated frame buffer.
(--) ATI(0): Internal programmable clock generator detected.
(--) ATI(0): Reference clock 157.5/11 (14.318) MHz.
maxClock = 112000
(II) ATI(0): foo: Using hsync range of 30.00-64.00 kHz
(II) ATI(0): foo: Using vrefresh range of 50.00-100.00 Hz
(II) ATI(0): Maximum clock: 112.00 MHz
(II) ATI(0): Not using default mode "1024x768" (hsync out of range)
(II) ATI(0): Not using default mode "1152x864" (hsync out of range)
(II) ATI(0): Not using default mode "1280x960" (bad mode clock/interlace/doublescan)
(II) ATI(0): Not using default mode "1280x1024" (bad mode clock/interlace/doublescan)
(II) ATI(0): Not using default mode "1280x1024" (bad mode clock/interlace/doublescan)
(II) ATI(0): Not using default mode "1600x1200" (bad mode clock/interlace/doublescan)
(II) ATI(0): Not using default mode "1600x1200" (bad mode clock/interlace/doublescan)
(II) ATI(0): Not using default mode "1600x1200" (bad mode clock/interlace/doublescan)
(II) ATI(0): Not using default mode "1600x1200" (bad mode clock/interlace/doublescan)
(II) ATI(0): Not using default mode "1600x1200" (bad mode clock/interlace/doublescan)
(II) ATI(0): Not using default mode "1792x1344" (bad mode clock/interlace/doublescan)
(II) ATI(0): Not using default mode "1792x1344" (bad mode clock/interlace/doublescan)
(II) ATI(0): Not using default mode "1856x1392" (bad mode clock/interlace/doublescan)
(II) ATI(0): Not using default mode "1856x1392" (bad mode clock/interlace/doublescan)
(II) ATI(0): Not using default mode "1920x1440" (bad mode clock/interlace/doublescan)
(II) ATI(0): Not using default mode "1920x1440" (bad mode clock/interlace/doublescan)
(II) ATI(0): Not using default mode "1400x1050" (bad mode clock/interlace/doublescan)
(II) ATI(0): Not using default mode "1400x1050" (bad mode clock/interlace/doublescan)
(--) ATI(0): Virtual size is 800x600 (pitch 832)
(**) ATI(0): Default mode "640x480": 36.0 MHz, 43.3 kHz, 85.0 Hz
(**) ATI(0): Default mode "800x600": 56.3 MHz, 53.7 kHz, 85.1 Hz
(==) ATI(0): DPI set to (75, 75)
(II) Loading /usr/X11R6/lib/modules/libxaa.a
(II) Module xaa: vendor="The XFree86 Project"
	compiled for 4.1.99.1, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/libramdac.a
(II) Module ramdac: vendor="The XFree86 Project"
	compiled for 4.1.99.1, module version = 0.1.0
(II) Loading /usr/X11R6/lib/modules/libfb.a
(II) Module fb: vendor="The XFree86 Project"
	compiled for 4.1.99.1, module version = 1.0.0
(WW) ATI(0): xf86UnMapVidMem: cannot find region for [0x30019c00,0x1c00]
(II) ATI(0): Using XFree86 Acceleration Architecture (XAA)
	Screen to screen bit blits
	Solid filled rectangles
	8x8 mono pattern filled rectangles
	Indirect CPU to Screen color expansion
	Solid Lines
	Offscreen Pixmaps
	Setting up tile and stipple cache:
		32 128x128 slots
		32 256x256 slots
		16 512x512 slots
(==) ATI(0): Backing store disabled
(==) ATI(0): Silken mouse enabled
(**) Mouse1: Protocol: "MouseSystems"
(**) Mouse1: Core Pointer
(==) Mouse1: Buttons: 3
(**) Mouse1: BaudRate: 1200
(II) Keyboard "Keyboard1" handled by legacy driver
(II) XINPUT: Adding extended input device "Mouse1" (type: MOUSE)
Couldn't load XKB keymap, falling back to pre-XKB keymap
Could not init font path element /usr/X11R6/lib/X11/fonts/Speedo/, removing from list!
(WW) ATI(0): xf86UnMapVidMem: cannot find region for [0x3001bc00,0x1c00]

Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
