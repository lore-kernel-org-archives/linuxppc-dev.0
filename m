From: tom_gall@mac.com
Date: Fri, 28 Nov 2003 13:07:27 -0600
Subject: USB, 2.6-test11 and hot flaming death
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: benh@kernel.crashing.org
To: linuxppc-dev@lists.linuxppc.org
Message-Id: <1B4D801D-21D6-11D8-970C-0003939E069A@mac.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Greets,

I've seen this now with both test11 and test10 on Dual G5 hardware with
the 32 bit kernel direct from the benh bk tree. I have seen this on
more than one G5 so I at least know it's not my hardware.

Current pull of test11 and test10 will at boot up give the following
error messages :

hid: probe of 4-1.1:1.1 failed with error -5
hub 4-1:1.0: hub_port_status failed (err = -108)
hub 4-1:1.0: hub_port_status failed (err = -108)
hub 4-1:1.0: hub_hub_status failed (err = -108)
hub 4-1:1.0: get_hub_status failed
hub 4-1:1.0: hub_port_status failed (err = -108)
hub 4-1:1.0: hub_port_status failed (err = -108)
hub 4-1:1.0: hub_port_status failed (err = -108)
hub 4-1:1.0: hub_hub_status failed (err = -108)
hub 4-1:1.0: get_hub_status failed
usb 4-1: USB disconnect, address 2
usb 4-1.1: USB disconnect, address 3


After which point, the light in my Logitech mouse goes out and the
keyboard seems to be quite dead, altho otherwise my machine is quite
happy. Thank goodness for network login.

If I unplug and replug in the keyboard, it doesn't recover. I'm a bit
USB stupid so if there's some other command to try and another log I
should be dumping, please let me know!

Enclosed is the complete dmesg.

 >      640x480@72Hz
       640x480@75Hz
       800x600@56Hz
       800x600@60Hz
       800x600@72Hz
       800x600@75Hz
       832x624@75Hz
       1024x768@60Hz
       1024x768@70Hz
       1024x768@75Hz
       1280x1024@75Hz
       1152x870@75Hz
       Manufacturer's mask: 0
    Detailed Monitor Information
       108 MHz 1280 1328 1440 1688 1024 1025 1028 1066 +HSync +VSync

       HorizSync     : 30-82 KHz
       VertRefresh   : 50-75 Hz
       Max Pixelclock: 140 MHz
       Monitor Name  : NEC LCD1920NX
       Serial No     : 3152576QA
========================================
radeonfb: Monitor 2 type DFP found
radeonfb: EDID probed
========================================
Display Information (EDID)
========================================
    EDID Version 1.3
    Manufacturer: NEC Model: 65de Serial#: 16843009
    Year: 2003 Week 4
    Display Characteristics:
       Digital Display Input      Sync:
       Max H-size in cm: 38
       Max V-size in cm: 30
       Gamma: 2.40
       DPMS: Active yes, Suspend yes, Standby yes
       RGB Color Display
       Chromaticity: RedX:   0.648 RedY:   0.346
                     GreenX: 0.292 GreenY: 0.602
                     BlueX:  0.150 BlueY:  0.130
                     WhiteX: 0.313 WhiteY: 0.329
       First DETAILED Timing is preferred
    Standard Timings
       1152x864@75Hz
       1280x1024@60Hz
    Supported VESA Modes
       720x400@70Hz
       640x480@60Hz
       640x480@67Hz
       640x480@72Hz
       640x480@75Hz
       800x600@56Hz
       800x600@60Hz
       800x600@72Hz
       800x600@75Hz
       832x624@75Hz
       1024x768@60Hz
       1024x768@70Hz
       1024x768@75Hz
       1280x1024@75Hz
       1152x870@75Hz
       Manufacturer's mask: 0
    Detailed Monitor Information
       108 MHz 1280 1328 1440 1688 1024 1025 1028 1066 +HSync +VSync

       HorizSync     : 30-82 KHz
       VertRefresh   : 50-75 Hz
       Max Pixelclock: 140 MHz
       Monitor Name  : NEC LCD1920NX
       Serial No     : 3152576QA
========================================
Parsing EDID data for panel info
Setting up default mode based on panel info
radeonfb: ATI Radeon AP  SDR SGRAM 64 MB
radeonfb_pci_register END
bound device '0000:f0:10.0' to driver 'radeonfb'
bus of_platform: add device u3-i2c
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
hStart = 1328, hEnd = 1440, hTotal = 1688
vStart = 1025, vEnd = 1028, vTotal = 1066
h_total_disp = 0x9f00d2    hsync_strt_wid = 0xe052a
v_total_disp = 0x3ff0429           vsync_strt_wid = 0x30400
pixclock = 9259
freq = 10800
post div = 0x1
fb_div = 0x60
ppll_div_3 = 0x10060
lvds_gen_cntl: 08000008
Console: switching to colour frame buffer device 160x64
pty: 256 Unix98 ptys configured
Generic RTC Driver v1.07
Macintosh non-volatile memory driver v1.1
Linux agpgart interface v0.100 (c) Dave Jones
bus pci: add driver agpgart-uninorth
agpgart: Unsupported Apple chipset (device id: 004b).
pmac_zilog.c 0.5a (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
ttyS0 at MMIO 0x80013020 (irq = 22) is a PowerMac Zilog
ttyS1 at MMIO 0x80013000 (irq = 23) is a PowerMac Zilog
bus macio: add driver pmac_zilog
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
bus pci: add driver gem
sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:0a:95:98:19:ca
PHY ID: 2062e0, addr: 1
eth0: Found BCM5421-K2 PHY
bound device '0001:04:0f.0' to driver 'gem'
bus macio: add driver mace
bus macio: add driver bmac
bus pci: add driver de2104x
bus pci: add driver tulip
bus pci: add driver macio
MacIO PCI driver attached to K2 chipset
preparing mdev @c1790104, ofdev @c179010c, dev @c179011c, kobj @c1790144
bus macio: add device 0.80000000:mac-io
preparing mdev @c17019cc, ofdev @c17019d4, dev @c17019e4, kobj @c1701a0c
bus macio: add device 0.00040000:mpic
preparing mdev @c17015c0, ofdev @c17015c8, dev @c17015d8, kobj @c1701600
bus macio: add device 0.00000050:gpio
preparing mdev @c17011b4, ofdev @c17011bc, dev @c17011cc, kobj @c17011f4
bus macio: add device 0.00013000:escc
preparing mdev @c1700da8, ofdev @c1700db0, dev @c1700dc0, kobj @c1700de8
bus macio: add device 0.00018000:i2c
preparing mdev @c170099c, ofdev @c17009a4, dev @c17009b4, kobj @c17009dc
bus macio: add device 0.00010000:i2s
preparing mdev @c1700590, ofdev @c1700598, dev @c17005a8, kobj @c17005d0
bus macio: add device 0.00015000:timer
preparing mdev @c1700184, ofdev @c170018c, dev @c170019c, kobj @c17001c4
bus macio: add device 0.00016000:via-pmu
preparing mdev @c07ffa4c, ofdev @c07ffa54, dev @c07ffa64, kobj @c07ffa8c
bus macio: add device 0.0000004c:fans
preparing mdev @c07ff640, ofdev @c07ff648, dev @c07ff658, kobj @c07ff680
bus macio: add device 0.00013020:ch-a
bound device '0.00013020:ch-a' to driver 'pmac_zilog'
preparing mdev @c07ff234, ofdev @c07ff23c, dev @c07ff24c, kobj @c07ff274
bus macio: add device 0.00013000:ch-b
bound device '0.00013000:ch-b' to driver 'pmac_zilog'
bound device '0001:01:07.0' to driver 'macio'
bus macio: add driver media-bay
input: Macintosh mouse button emulation
apm_emu: APM Emulation 0.5 initialized.
PowerMac G5 Thermal control driver 0.7
bus of_platform: add device temperature
bus of_platform: add driver temperature
bus i2c: add driver therm_pm72
bound device 'temperature' to driver 'temperature'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
bus type 'ide' registered
bus pci: add driver CMD64x IDE
bus pci: add driver Promise Old IDE
bus pci: add driver Promise IDE
bus pci: add driver PCI IDE
bus pci: add driver ide-pmac
PCI: Enabling device 0001:03:0d.0 (0014 -> 0016)
adb: starting probe task...
adb: finished probe task...
ide0: Found Apple K2 ATA-6 controller, bus ID 3
Probing IDE interface ide0...
hda: SONY DVD RW DW-U10A, ATAPI CD/DVD-ROM drive
hda: Enabling Ultra DMA 2
Using anticipatory io scheduler
ide0 at 0xf5378000-0xf5378007,0xf5378160 on irq 39
bus ide: add device 0.0
bound device '0001:03:0d.0' to driver 'ide-pmac'
bus macio: add driver ide-pmac
bus ide: add driver ide-disk
end_request: I/O error, dev hda, sector 0
end_request: I/O error, dev hda, sector 0
hda: ATAPI 32X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
bus ide: add driver ide-cdrom
ide-floppy driver 0.99.newide
bus ide: add driver ide-floppy
bus pci: add driver aic7xxx
bus pci: add driver sym53c8xx
bus ide: add driver ide-scsi
mesh: configured for synchronous 5 MB/s
bus macio: add driver mesh
bus macio: add driver mac53c94
libata version 0.81 loaded.
bus pci: add driver ata_k2
ata_k2 version 1.04
ata1: SATA max UDMA/133 cmd 0xF537B000 ctl 0xF537B020 bmdma 0xF537B030
irq 0
ata2: SATA max UDMA/133 cmd 0xF537B100 ctl 0xF537B120 bmdma 0xF537B130
irq 0
ata3: SATA max UDMA/133 cmd 0xF537B200 ctl 0xF537B220 bmdma 0xF537B230
irq 0
ata4: SATA max UDMA/133 cmd 0xF537B300 ctl 0xF537B320 bmdma 0xF537B330
irq 0
ata1: dev 0 cfg 49:2f00 82:346b 83:5b01 84:4003 85:3469 86:1801 87:4003
88:007f
ata1: dev 0 ATA, max UDMA/133, 234441648 sectors
ata1: dev 0 configured for UDMA/133
scsi0 : ata_k2
ata2: no device found (phy stat 00000004)
ata2: thread exiting
scsi1 : ata_k2
ata3: no device found (phy stat 00000004)
ata3: thread exiting
scsi2 : ata_k2
ata4: no device found (phy stat 00000004)
ata4: thread exiting
scsi3 : ata_k2
   Vendor: ATA       Model: ST3120023AS       Rev: 0.81
   Type:   Direct-Access                      ANSI SCSI revision: 05
bus scsi: add device 0:0:0:0
bound device '0001:05:0c.0' to driver 'ata_k2'
st: Version 20030811, fixed bufsize 32768, s/g segs 256
bus scsi: add driver st
bus scsi: add driver sd
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
SCSI device sda: drive cache: write through
  sda: [mac] sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8 sda9 sda10 sda11
sda12 sda13 sda14 sda15
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
bound device '0:0:0:0' to driver 'sd'
bus scsi: add driver sr
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
bus type 'ieee1394' registered
bus ieee1394: add driver ieee1394_host
bus ieee1394: add driver ieee1394_node
bus pci: add driver ohci1394
ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
PCI: Enabling device 0001:03:0e.0 (0000 -> 0002)
ohci1394_0: Unexpected PCI resource length of 1000!
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[40]  MMIO=[80200000-802007ff]
Max Packet=[4096]
bus ieee1394: add device fw-host0
bound device 'fw-host0' to driver 'ieee1394_host'
bound device '0001:03:0e.0' to driver 'ohci1394'
Console: switching to colour frame buffer device 160x64
bus pci: add driver ehci_hcd
PCI: Enabling device 0001:02:0b.2 (0004 -> 0006)
ehci_hcd 0001:02:0b.2: EHCI Host Controller
ehci_hcd 0001:02:0b.2: irq 63, pci mem f5384000
ehci_hcd 0001:02:0b.2: new USB bus registered, assigned bus number 1
ehci_hcd 0001:02:0b.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
bus usb: add device usb1
bound device 'usb1' to driver 'usb'
bus usb: add device 1-0:1.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 5 ports detected
bound device '1-0:1.0' to driver 'hub'
bound device '0001:02:0b.2' to driver 'ehci_hcd'
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
bus pci: add driver ohci_hcd
PCI: Enabling device 0001:01:08.0 (0000 -> 0002)
ohci_hcd 0001:01:08.0: OHCI Host Controller
ohci_hcd 0001:01:08.0: irq 27, pci mem f5386000
ohci_hcd 0001:01:08.0: new USB bus registered, assigned bus number 2
bus usb: add device usb2
bound device 'usb2' to driver 'usb'
bus usb: add device 2-0:1.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
bus ieee1394: add device 000a95fffe9819ca
bound device '000a95fffe9819ca' to driver 'ieee1394_node'
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000a95fffe9819ca]
bound device '2-0:1.0' to driver 'hub'
bound device '0001:01:08.0' to driver 'ohci_hcd'
PCI: Enabling device 0001:01:09.0 (0000 -> 0002)
ohci_hcd 0001:01:09.0: OHCI Host Controller
ohci_hcd 0001:01:09.0: irq 28, pci mem f5388000
ohci_hcd 0001:01:09.0: new USB bus registered, assigned bus number 3
bus usb: add device usb3
bound device 'usb3' to driver 'usb'
bus usb: add device 3-0:1.0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
bound device '3-0:1.0' to driver 'hub'
bound device '0001:01:09.0' to driver 'ohci_hcd'
PCI: Enabling device 0001:02:0b.0 (0000 -> 0002)
ohci_hcd 0001:02:0b.0: OHCI Host Controller
ohci_hcd 0001:02:0b.0: irq 63, pci mem f538a000
ohci_hcd 0001:02:0b.0: new USB bus registered, assigned bus number 4
bus usb: add device usb4
bound device 'usb4' to driver 'usb'
bus usb: add device 4-0:1.0
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 3 ports detected
bound device '4-0:1.0' to driver 'hub'
bound device '0001:02:0b.0' to driver 'ohci_hcd'
PCI: Enabling device 0001:02:0b.1 (0000 -> 0002)
ohci_hcd 0001:02:0b.1: OHCI Host Controller
ohci_hcd 0001:02:0b.1: irq 63, pci mem f538c000
ohci_hcd 0001:02:0b.1: new USB bus registered, assigned bus number 5
bus usb: add device usb5
bound device 'usb5' to driver 'usb'
bus usb: add device 5-0:1.0
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
bound device '5-0:1.0' to driver 'hub'
bound device '0001:02:0b.1' to driver 'ohci_hcd'
bus usb: add driver hiddev
drivers/usb/core/usb.c: registered new driver hiddev
bus usb: add driver hid
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
bus i2c: add driver dev_driver
bus of_platform: add driver i2c-keywest
registering 4-002c
bus i2c: add device 4-002c
bound device '4-002c' to driver 'therm_pm72'
registering 4-002d
bus i2c: add device 4-002d
bound device '4-002d' to driver 'therm_pm72'
registering 4-004c
bus i2c: add device 4-004c
bound device '4-004c' to driver 'therm_pm72'
registering 4-004a
bus i2c: add device 4-004a
bound device '4-004a' to driver 'therm_pm72'
registering 5-002f
bus i2c: add device 5-002f
bound device '5-002f' to driver 'therm_pm72'
Found KeyWest i2c on "u3", 2 channels, stepping: 4 bits
bound device 'u3-i2c' to driver 'i2c-keywest'
bus macio: add driver i2c-keywest
Found KeyWest i2c on "mac-io", 1 channel, stepping: 4 bits
bound device '0.00018000:i2c' to driver 'i2c-keywest'
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
SCTP: Hash tables configured (established 65536 bind 65536)
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 180k init 4k chrp 8k prep
hub 4-0:1.0: new USB device on port 1, assigned address 2
bus usb: add device 4-1
bound device '4-1' to driver 'usb'
bus usb: add device 4-1:1.0
hub 4-1:1.0: USB hub found
hub 4-1:1.0: 3 ports detected
bound device '4-1:1.0' to driver 'hub'
hub 4-1:1.0: new USB device on port 1, assigned address 3
bus usb: add device 4-1.1
bound device '4-1.1' to driver 'usb'
bus usb: add device 4-1.1:1.0
ohci_hcd 0001:02:0b.0: OHCI Unrecoverable Error, disabled
drivers/usb/input/hid-core.c: ctrl urb status -2 received
ohci_hcd 0001:02:0b.0: HC died; cleaning up
drivers/usb/input/hid-core.c: timeout initializing reports

drivers/usb/input/hid-ff.c: hid_ff_init could not find initializer
input: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB
Keyboard] on usb-0001:02:0b.0-1.1
bound device '4-1.1:1.0' to driver 'hid'
bus usb: add device 4-1.1:1.1
hid: probe of 4-1.1:1.1 failed with error -5
hub 4-1:1.0: hub_port_status failed (err = -108)
hub 4-1:1.0: hub_port_status failed (err = -108)
hub 4-1:1.0: hub_hub_status failed (err = -108)
hub 4-1:1.0: get_hub_status failed
hub 4-1:1.0: hub_port_status failed (err = -108)
hub 4-1:1.0: hub_port_status failed (err = -108)
hub 4-1:1.0: hub_port_status failed (err = -108)
hub 4-1:1.0: hub_hub_status failed (err = -108)
hub 4-1:1.0: get_hub_status failed
usb 4-1: USB disconnect, address 2
usb 4-1.1: USB disconnect, address 3
bus usb: remove device 4-1.1:1.0
bus usb: remove device 4-1.1:1.1
bus usb: remove device 4-1.1
ohci_hcd 0001:02:0b.0: leak ed c04bd040 (#2) state 0 (has tds)
bus usb: remove device 4-1:1.0
bus usb: remove device 4-1
hub 5-0:1.0: new USB device on port 2, assigned address 2
bus usb: add device 5-2
bound device '5-2' to driver 'usb'
bus usb: add device 5-2:1.0
Adding 524280k swap on /dev/sda13.  Priority:-1 extents:1
EXT3 FS on sda12, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda14, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda15, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
PHY ID: 2062e0, addr: 1
eth0: Link is up at 100 Mbps, full-duplex.
eth0: Pause is enabled (rxfifo: 10240 off: 7168 on: 5632)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
