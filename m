Message-ID: <20011020183948.2117.qmail@kunk.jriver.com>
Subject: Re: XF4.1 and GCC 3
In-Reply-To: <20011021012542.Postino-016064@smtp01.highway.ne.jp>
	"from Kaoru Fukui at Oct 21, 2001 01:25:42 am"
To: Kaoru Fukui <k_fukui@highway.ne.jp>
Date: Sat, 20 Oct 2001 13:24:22 -0500 (CDT)
From: Robert E Brose II <bob@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello again Kaoru,

I thought I'd bounce this one to the dev list because the problem now
seems to me to be machine related...

I'm trying to run XFree86-4.1.99.1-1b on a 7500 with an ATI xclaim
video board. (NOTE: this WORKS with an rev C iMac which also uses a
3d Rage Pro). Here is the ID from lspci...


00:0f.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro (rev 5c) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0000
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 25
	Region 0: Memory at 81000000 (32-bit, prefetchable) [size=16M]
	Region 1: I/O ports at 0400 [disabled] [size=256]
	Region 2: Memory at 80800000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at 80820000 [disabled] [size=128K]


When bring up XFree86 I get a blank screen. If I switch back to the
console I see:

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
(==) Log file: "/var/log/XFree86.0.log", Time: Sat Oct 20 13:05:06 2001
(==) Using config file: "/etc/X11/XF86Config-4"
Markers: (--) probed, (**) from config file, (==) default setting,
         (++) from command line, (!!) notice, (II) informational,
         (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) ServerLayout "XFree86 Configured"
(**) |-->Screen "Screen0" (0)
(**) |   |-->Monitor "Monitor0"
(**) |   |-->Device "Card0"
(**) |-->Input Device "Mouse0"
(**) |-->Input Device "Keyboard0"
(--) Keyboard: CustomKeycode enabled
(WW) The directory "/usr/share/fonts/default/TrueType" does not exist.
	Entry deleted from font path.
(**) FontPath set to "unix/:7100,/usr/lib/X11/fonts/misc:unscaled,/usr/lib/X11/fonts/100dpi/:unscaled,/usr/lib/X11/fonts/75dpi/:unscaled,/usr/lib/X11/fonts/misc,/usr/lib/X11/fonts/cyrillic,/usr/lib/X11/fonts/Type1,/usr/lib/X11/fonts/Speedo,/usr/lib/X11/fonts/100dpi,/usr/lib/X11/fonts/75dpi,/usr/share/fonts/default/Type1"
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
(II) Loading /usr/X11R6/lib/modules/extensions/libGLcore.a
(II) Module GLcore: vendor="The XFree86 Project"
	compiled for 4.1.99.1, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a
(II) Module dbe: vendor="The XFree86 Project"
	compiled for 4.1.99.1, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/extensions/libdri.a
(II) Module dri: vendor="The XFree86 Project"
	compiled for 4.1.99.1, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/linux/libdrm.a
(II) Module drm: vendor="The XFree86 Project"
	compiled for 4.1.99.1, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor="The XFree86 Project"
	compiled for 4.1.99.1, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/extensions/libglx.a
(II) Module glx: vendor="The XFree86 Project"
	compiled for 4.1.99.1, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/extensions/libpex5.a
(II) Module pex5: vendor="The XFree86 Project"
	compiled for 4.1.99.1, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/extensions/librecord.a
(II) Module record: vendor="The XFree86 Project"
	compiled for 4.1.99.1, module version = 1.13.0
(II) Loading /usr/X11R6/lib/modules/extensions/libxie.a
(II) Module xie: vendor="The XFree86 Project"
	compiled for 4.1.99.1, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/libddc.a
(II) Module ddc: vendor="The XFree86 Project"
	compiled for 4.1.99.1, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/fonts/libfreetype.a
(II) Module freetype: vendor="The XFree86 Project"
	compiled for 4.1.99.1, module version = 1.1.10
(II) Loading /usr/X11R6/lib/modules/fonts/libspeedo.a
(II) Module speedo: vendor="The XFree86 Project"
	compiled for 4.1.99.1, module version = 1.0.1
(II) Loading /usr/X11R6/lib/modules/fonts/libtype1.a
(II) Module type1: vendor="The XFree86 Project"
	compiled for 4.1.99.1, module version = 1.0.1
(II) Loading /usr/X11R6/lib/modules/libvbe.a
(II) Module vbe: vendor="The XFree86 Project"
	compiled for 4.1.99.1, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/libint10.a
(II) Module int10: vendor="The XFree86 Project"
	compiled for 4.1.99.1, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/drivers/ati_drv.o
(II) Module ati: vendor="The XFree86 Project"
	compiled for 4.1.99.1, module version = 6.4.5
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor="The XFree86 Project"
	compiled for 4.1.99.1, module version = 1.0.0
(II) ATI: ATI driver (version 6.4.5) for chipsets: ati
(II) R128: Driver for ATI Rage 128 chipsets: ATI Rage 128 RE (PCI),
	ATI Rage 128 RF (AGP), ATI Rage 128 RG (AGP), ATI Rage 128 RK (PCI),
	ATI Rage 128 RL (AGP), ATI Rage 128 SM (AGP),
	ATI Rage 128 Pro PD (PCI), ATI Rage 128 Pro PF (AGP),
	ATI Rage 128 Pro PR (PCI), ATI Rage 128 Pro ULTRA TF (AGP),
	ATI Rage 128 Pro ULTRA TL (AGP), ATI Rage 128 Pro ULTRA TR (AGP),
	ATI Rage 128 Mobility LE (PCI), ATI Rage 128 Mobility LF (AGP),
	ATI Rage 128 Mobility MF (AGP), ATI Rage 128 Mobility ML (AGP)
(II) RADEON: Driver for ATI Radeon chipsets: ATI Radeon QD (AGP),
	ATI Radeon QE (AGP), ATI Radeon QF (AGP), ATI Radeon QG (AGP),
	ATI Radeon VE QY (AGP), ATI Radeon VE QZ (AGP),
	ATI Radeon Mobility LW (AGP), ATI Radeon Mobility LY (AGP),
	ATI Radeon Mobility LZ (AGP)
(WW) xf86UnMapVidMem: cannot find region for [0x30015c00,0x1c00]
(II) Loading /usr/X11R6/lib/modules/drivers/atimisc_drv.o
(II) Module atimisc: vendor="The XFree86 Project"
	compiled for 4.1.99.1, module version = 6.4.5
(==) ATI(0): Chipset:  "ati".
(**) ATI(0): Depth 24, (--) framebuffer bpp 32
(--) ATI(0): ATI 3D Rage Pro graphics controller detected.
(--) ATI(0): Chip type 4749 "GI", version 4, foundry UMC, class 0, revision 0x01.
(--) ATI(0): PCI bus interface detected;  block I/O base is 0x0000.
(--) ATI(0): ATI Mach64 adapter detected.
(--) ATI(0): Internal RAMDAC (subtype 1) detected.
(==) ATI(0): RGB weight 888
(==) ATI(0): Default visual is TrueColor
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
(II) ATI(0): Monitor0: Using hsync range of 31.50-48.50 kHz
(II) ATI(0): Monitor0: Using vrefresh range of 35.00-60.00 Hz
(II) ATI(0): Maximum clock:  96.00 MHz
.
.
(II) ATI(0): Not using default mode "1600x1024" (width too large for virtual size)
.
.

(**) ATI(0): Virtual size is 1024x768 (pitch 1024)
(**) ATI(0): Mode "1024x768": 65.0 MHz, 48.4 kHz, 60.0 Hz
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
(--) Depth 24 pixmap format is 32 bpp
(II) ATI(0): Using XFree86 Acceleration Architecture (XAA)
	Screen to screen bit blits
	Solid filled rectangles
	8x8 mono pattern filled rectangles
	Indirect CPU to Screen color expansion
	Solid Lines
	Offscreen Pixmaps
	Setting up tile and stipple cache:
		32 128x128 slots
		10 256x256 slots
(==) ATI(0): Backing store disabled
(==) ATI(0): Silken mouse enabled
(**) Mouse0: Protocol: "ps/2"
(**) Mouse0: Core Pointer
(**) Mouse0: ZAxisMapping: buttons 4 and 5
(**) Mouse0: Buttons: 5
(II) Keyboard "Keyboard0" handled by legacy driver
(II) XINPUT: Adding extended input device "Mouse0" (type: MOUSE)
Couldn't load XKB keymap, falling back to pre-XKB keymap
(WW) ATI(0): xf86UnMapVidMem: cannot find region for [0x3001bc00,0x1c00]


Any idea of what is causing this?

Regards,
Bob

User Kaoru Fukui says:
> From: Robert E Brose II <bob@kunk.jriver.com>
> To: linuxppc-user@lists.linuxppc.org
> Subject: XF4.1 and GCC 3
> Date: Sat, 20 Oct 2001 11:04:25 -0500 (CDT)
>
> >
> > I'm trying to use Kaoru's latest GlibC 2.2 version of XF4 and GCC 3.0.
> > I get the following error...
> >
> > root# /usr/X11R6/bin/XFree86
> > /usr/X11R6/bin/XFree86: /lib/libc.so.6: version `GCC_3.0' not found (required
> by /usr/X11R6/bin/XFree86)
>
> >
> > Any idea what's up Kaoru?
>
> The X package is working well on my machine.
> My using gcc-3.0.x and glibc-2.2.4 are all in my directory.
> And  those RPM's are not special one.
>
> it seem that glibc require gcc-3.0.
> probably your using glibc which is compiled gcc-3.0.
>
> So, try to install all glibc-2.2.4, all gcc-3.0.2 from my dir.
>
> Kaoru

Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
