MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14801.4812.235660.20792@esb.bbn.com>
Date: Tue, 26 Sep 2000 17:19:08 -0400
From: R Shapiro <rshapiro@bbn.com>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
Cc: daenzerm@student.ethz.ch,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 + ati driver with rage II/rage pro
In-Reply-To: <Pine.LNX.4.10.10009262127370.21452-100000@zirkon.biophys.uni-duesseldorf.de>
References: <39D0F7EB.C0415571@relog.ch>
	<Pine.LNX.4.10.10009262127370.21452-100000@zirkon.biophys.uni-duesseldorf.de>
Reply-To: rshapiro@bbn.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz writes:
 > could you post the kernel boot messages again?

You mean the dmesg?  Here it is.  After that is the XF86Config.

dmesg
-----
device tree used 35560 bytes
Total memory = 128MB; using 512kB for hash table (at c0280000)
Linux version 2.2.15pre3 (benh@sawtooth.wanadoo.fr) (gcc version 2.95.2 19991024 (release/franzo)) #3 Sat Jan 29 18:02:45 CET 2000
PCI bus 0 controlled by pci at 80000000
Registered 1 feature controller(s)
System has 64 possible interrupts
via_calibrate_decr: decrementer_count = 167082 (1002497 ticks)
Console: colour dummy device 80x25
Calibrating delay loop... 534.12 BogoMIPS
Memory: 126664k available (1460k kernel code, 2796k data, 152k init) [c0000000,c8000000]
Dentry hash table entries: 16384 (order 5, 128k)
Buffer cache hash table entries: 131072 (order 7, 512k)
Page cache hash table entries: 32768 (order 5, 128k)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
adb devices: [2]: 2 2 [3]: 3 1
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 131072 bhash 65536)
NET4: AppleTalk 0.18 for Linux NET4.0
Starting kswapd v 1.5
OHCI USB Driver loading
usbcore: Registered new driver mouse
USB HID boot protocol mouse driver registered.
usbcore: Registered new driver keyboard
usbcore: Registered new driver hub
MacOS display is /pci/ATY,mach64_3DU
atyfb: 3D RAGE (GT) [0x4754 rev 0x9a] 2M SGRAM, 14.31818 MHz XTAL, 200 MHz PLL, 67 Mhz MCLK
BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL DSP_CONFIG DSP_ON_OFF
7b23a040 86010182 004215b3 25010001     03000200      002806e3   02100503
PLL ad d5 21 44 e8 13 80 b5 8e 9e 98 04 a6 1b 00 00
Console: switching to colour frame buffer device 160x64
fb0: ATY Mach64 frame buffer device on /pci/ATY,mach64_3DU
atyfb: 3D RAGE PRO (BGA, PCI) [0x4749 rev 0x7c] 4M SGRAM, 14.31818 MHz XTAL, 230 MHz PLL, 100 Mhz MCLK
BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL DSP_CONFIG DSP_ON_OFF
7b33a040 87010182 04651a77 75130c01     03000300      00280509   01f004f1
PLL ad d5 21 64 e4 13 80 b5 8e 9e 98 01 a6 1b 00 00
fb1: ATY Mach64 frame buffer device on /pci/ATY,XCLAIM3DPro
atyfb: 3D RAGE PRO (BGA, PCI) [0x4749 rev 0x7c] 4M SGRAM, 14.31818 MHz XTAL, 230 MHz PLL, 100 Mhz MCLK
BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL DSP_CONFIG DSP_ON_OFF
7b33a040 87010102 04651a77 75130c01     03000300      00280509   01f004f1
PLL ad d5 21 64 e4 13 80 b5 8e 9e 98 01 a6 1b 00 00
fb2: ATY Mach64 frame buffer device on /pci/ATY,XCLAIM3DPro
ADB keyboard at 2, handler set to 3
ADB mouse at 3, handler set to 4
PowerMac Z8530 serial driver version 2.0
tty00 at 0xf3013020 (irq = 15) is a Z8530 ESCC, port = modem
tty01 at 0xf3013000 (irq = 16) is a Z8530 ESCC, port = printer
pty: 256 Unix98 ptys configured
Macintosh ADB mouse driver installed.
Macintosh non-volatile memory driver v1.0
RAM disk driver initialized:  16 RAM disks of 4096K size
loop: registered device at major 7
pmac_ide: enabling IDE bus ID 0
pmac_ide: enabling IDE bus ID 1
hda: QUANTUM FIREBALL ST6400A, ATA DISK drive
hdc: MATSHITA CR-585, ATAPI CDROM drive
ide0 at 0xf5020000-0xf5020007,0xf5020160 on irq 13
ide1 at 0xf5021000-0xf5021007,0xf5021160 on irq 14
hda: Enabling MultiWord DMA 2
hda: QUANTUM FIREBALL ST6400A, 6149MB w/81kB Cache, CHS=13328/15/63, (U)DMA
hdc: Enabling MultiWord DMA 1
hdc: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CDROM driver Revision: 2.56
fd0: SWIM3 floppy controller
scsi0 : MESH
scsi : 1 host.
  Vendor: IOMEGA    Model: ZIP 100           Rev: J.03
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi removable disk sda at scsi0, channel 0, id 5, lun 0
scsi : detected 1 SCSI disk total.
sda : READ CAPACITY failed.
sda : status = 0, message = 00, host = 0, driver = 08
sda : extended sense code = 2
sda : block size assumed to be 512 bytes, disk size 1GB.
PPP: version 2.3.7 (demand dialling)
TCP compression code copyright 1989 Regents of the University of California
PPP line discipline registered.
eth0: BMAC at 00:05:02:ee:c7:32
Partition check:
 sda:scsidisk I/O error: dev 08:00, sector 0
 unable to read partition table
 hda: hda1 hda2 hda3 hda4 hda5 hda6 hda7 hda8 hda9 hda10
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 152k init 32k prep
Adding Swap: 99996k swap-space (priority -1)
grep uses obsolete /proc/pci interface
DMA sound driver installed, using 4 buffers of 32k.
phy registers:
 0000 0000 0000 0000 0000 0000 0000 0000
 0000 0000 0000 0000 0000 0000 0000 0000
 0000 0000 0000 0000 0000 0000 0000 0000
 0000 0000 0000 0000 0000 0000 0000 0000
MOL module inited


-----
XF86Config -- this is with the fbdev drivers, which works ok.  The
broken version is identical except fbdev->ati.
----

Section "ServerLayout"
	Identifier     "XFree86 Configured"
	Screen        "Screen0"
	Screen        "Screen1" RightOf "Screen0"
	Screen        "Screen2" LeftOf "Screen0"
	InputDevice    "Mouse0" "CorePointer"
	InputDevice    "Keyboard0" "CoreKeyboard"
EndSection

Section "InputDevice"
	Identifier  "Keyboard0"
	Driver      "keyboard"

	Option "XkbModel"       "macintosh_old"

#	Option "XkbLayout"      "de"
#	Option "XkbVariant"     "nodeadkeys"
EndSection

Section "InputDevice"
	Identifier  "Mouse0"
	Driver      "mouse"
	Option      "Protocol" "busmouse"
	Option      "Device" "/dev/adbmouse"

# wheel support
#	Option      "ZAxisMapping" "4 5"

EndSection


Section "Files"
# The location of the RGB database.  Note, this is the name of the
# file minus the extension (like ".txt" or ".db").  There is normally
# no need to change the default.

    RgbPath	"/usr/X11R6/lib/X11/rgb"

# Multiple FontPath entries are allowed (which are concatenated together),
# as well as specifying multiple comma-separated entries in one FontPath
# command (or a combination of both methods)

#    FontPath	"/usr/X11R6/lib/X11/fonts/local/"
#    FontPath	"/usr/X11R6/lib/X11/fonts/misc/"
#    FontPath	"/usr/X11R6/lib/X11/fonts/75dpi/:unscaled"
#    FontPath	"/usr/X11R6/lib/X11/fonts/100dpi/:unscaled"
#    FontPath	"/usr/X11R6/lib/X11/fonts/Type1/"
#    FontPath	"/usr/X11R6/lib/X11/fonts/CID/"
#    FontPath	"/usr/X11R6/lib/X11/fonts/Speedo/"
#    FontPath	"/usr/X11R6/lib/X11/fonts/75dpi/"
#    FontPath	"/usr/X11R6/lib/X11/fonts/100dpi/"
    FontPath    "unix/:7100"
    FontPath	"tcp/blatz:7100"

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


Section "Monitor"
	Identifier   "Monitor"
	VendorName   "Optiquest"
	ModelName    "Optiquest V95"

# Should really get these from the Optiquest spec
	HorizSync   1-300
	VertRefresh 1-300

	Mode "1152x870"
	    # D: 134.445 MHz, H: 86.183 kHz, V: 94.498 Hz
	    DotClock 134.446
	    HTimings 1152 1216 1328 1560
	    VTimings 870 871 874 912
	    Flags    "+HSync" "+VSync"
	EndMode



	Mode "1280x1024"
	    # D: 134.445 MHz, H: 79.647 kHz, V: 74.716 Hz
	    DotClock 134.446
	    HTimings 1280 1344 1456 1688
	    VTimings 1024 1025 1028 1066
	    Flags    "+HSync" "+VSync"
	EndMode



EndSection



# First Display

Section "Device"
	### Available Driver options are:-
        #Option     "NoAccel"
        #Option     "SWcursor"
        Option     "HWcursor"
        #Option     "Dac6Bit"
        #Option     "Dac8Bit"
        Option     "UseFBDev"
	Option	"fbdev" "/dev/fb0"
#	Option      "NoShadowFB"
	Identifier  "device0"
	Driver      "fbdev"
	BusID       "PCI:0:18:0"
EndSection



# For now default to 8bpp, in order to get 1280x1024 resolution.
# Change to 15 as soon as this card has more vram.
Section "Screen"
	Identifier "Screen0"
	Device     "device0"
	Monitor    "Monitor"
        DefaultDepth      8

	SubSection "Display"
		Depth     8
		Modes  "1280x1024"
	EndSubSection

	SubSection "Display"
		Depth     15
		Modes  "1152x870"
	EndSubSection
EndSection








# Second Display

Section "Device"
	### Available Driver options are:-
        #Option     "NoAccel"
        #Option     "SWcursor"
        Option     "HWcursor"
        #Option     "Dac6Bit"
        #Option     "Dac8Bit"
        Option     "UseFBDev"
	Option	"fbdev" "/dev/fb1"
#	Option      "NoShadowFB"
	Identifier  "device1"
	Driver      "fbdev"
	BusID       "PCI:0:13:0"
EndSection




# For now default to 8bpp, since Screen 0 is running at that depth (for 1280x1024 res)
# and xinerama can't run unless all three screen are at the same depth.
# Change to 15 as soon as Screen 0 gets more vram.
Section "Screen"
	Identifier "Screen1"
	Device     "device1"
	Monitor    "Monitor"
        DefaultDepth      8

	SubSection "Display"
		Depth     8
		Modes "1280x1024"
	EndSubSection

	SubSection "Display"
		Depth     15
		Modes "1280x1024"
	EndSubSection
EndSection







# Third Display


Section "Device"
	### Available Driver options are:-
        #Option     "NoAccel"
        #Option     "SWcursor"
        Option     "HWcursor"
        #Option     "Dac6Bit"
        #Option     "Dac8Bit"
        Option     "UseFBDev"
	Option	"fbdev" "/dev/fb2"
#	Option      "NoShadowFB"
	Identifier  "device2"
	Driver      "fbdev"
	BusID       "PCI:0:15:0"
EndSection





# For now default to 8bpp, since Screen 0 is running at that depth (for 1280x1024 res)
# and xinerama can't run unless all three screen are at the same depth.
# Change to 15 as soon as Screen 0 gets more vram.
Section "Screen"
	Identifier "Screen2"
	Device     "device2"
	Monitor    "Monitor"
        DefaultDepth      8

	SubSection "Display"
		Depth     8
		Modes "1280x1024"
	EndSubSection

	SubSection "Display"
		Depth     15
		Modes "1280x1024"
	EndSubSection
EndSection




--
rshapiro@bbn.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
