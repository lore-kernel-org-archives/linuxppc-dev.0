Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 63FB4679FB
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2006 03:09:16 +1100 (EST)
Date: Mon, 27 Feb 2006 17:09:11 +0100
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: copying /sys causes fans to spin up 
Message-ID: <20060227160911.GA17569@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben, 


some tool copies /sys, and while doing it, the fans start to spin up on
my G5. Any idea how to fix it, other than not reading from /sys? Have to
find the exact file.



Page orders: linear mapping = 24, others = 12
Found initrd at 0xc000000001100000:0xc0000000013e8000
Found U3 memory controller & host bridge @ 0xf8000000 revision: 0x32
Mapped at 0xd000080080000000
Found a K2 mac-io controller, rev: 32, mapped at 0xd000080080041000
PowerMac motherboard: PowerMac G5
Using native/NAP idle loop
DART: table not allocated, using direct DMA
Starting Linux PPC64 #1 SMP Mon Feb 20 15:56:05 UTC 2006
-----------------------------------------------------
ppc64_pft_size                = 0x0
ppc64_interrupt_controller    = 0x1
platform                      = 0x400
physicalMemorySize            = 0x10000000
ppc64_caches.dcache_line_size = 0x80
ppc64_caches.icache_line_size = 0x80
htab_address                  = 0xc00000000f800000
htab_hash_mask                = 0x7fff
-----------------------------------------------------
[boot]0100 MM Init
[boot]0100 MM Init Done
Linux version 2.6.16-rc4-3-ppc64 (geeko@buildhost) (gcc version 4.1.0 20060218 (prerelease) (SUSE Linux)) #1 SMP Mon Feb 20 15:56:05 UTC 2006
[boot]0012 Setup Arch
Top of RAM: 0x10000000, Total RAM: 0x10000000
Memory hole size: 0MB
Found U3-AGP PCI host bridge.  Firmware bus number: 240->255
Can't get bus-range for /ht@0,f2000000, assume bus 0
Found U3-HT PCI host bridge.  Firmware bus number: 0->239
PCI Host 0, io start: 400000; io end: bfffff
PCI Host 1, io start: 0; io end: 3fffff
via-pmu: Server Mode is disabled
PMU driver v2 initialized for Core99, firmware: 0c
nvram: Checking bank 0...
nvram: gen0=445, gen1=444
nvram: Active bank is: 0
nvram: OF partition at 0x410
nvram: XP partition at 0x1020
nvram: NR partition at 0x1120
On node 0 totalpages: 65536
  DMA zone: 65536 pages, LIFO batch:15
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0
[boot]0015 Setup Done
Built 1 zonelists
Kernel command line: quiet sysrq=1 root=/dev/disk/by-path/pci-0001:05:0c.0-scsi-0:0:0:0-part11 root=/dev/sda11 
mpic: Setting up MPIC " MPIC 1   " version 1.2 at 80040000, max 4 CPUs
mpic: ISU size: 120, shift: 7, mask: 7f
mpic: Initializing for 120 sources
mpic: Setting up MPIC " MPIC 2   " version 1.2 at f8040000, max 4 CPUs
mpic: ISU size: 120, shift: 7, mask: 7f
mpic: Initializing for 120 sources
PID hash table entries: 2048 (order: 11, 65536 bytes)
time_init: decrementer frequency = 33.333333 MHz
time_init: processor frequency   = 1600.000000 MHz
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
freeing bootmem node 0
Memory: 242736k/262144k available (4336k kernel code, 19408k reserved, 1952k data, 851k bss, 256k init)
Calibrating delay loop... 66.56 BogoMIPS (lpj=332800)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 256
checking if image is initramfs... it is
Freeing initrd memory: 2976k freed
PowerMac SMP probe found 1 cpus
Brought up 1 CPUs
migration_cost=0
NET: Registered protocol family 16
KeyWest i2c @0xf8001003 irq 170 /u3@0,f8000000/i2c@f8001000
 channel 0 bus <multibus>
 channel 1 bus <multibus>
KeyWest i2c @0x80018000 irq 26 /ht@0,f2000000/pci@3/mac-io@7/i2c@18000
 channel 0 bus <multibus>
PMU i2c /ht@0,f2000000/pci@3/mac-io@7/via-pmu@16000/pmu-i2c
 channel 1 bus <multibus>
 channel 2 bus <multibus>
Installing base platform functions...
Installing MMIO functions for macio /ht@0,f2000000/pci@3/mac-io@7
Installing GPIO functions for macio /ht@0,f2000000/pci@3/mac-io@7
Calling initial GPIO functions for macio /ht@0,f2000000/pci@3/mac-io@7
Do write 0x82 to GPIO /ht@0,f2000000/pci@3/mac-io@7/gpio@50/line-input-detect@c (d00008008004105c)
Do write 0x80 to GPIO /ht@0,f2000000/pci@3/mac-io@7/gpio@50/line-output-detect@16 (d000080080041066)
Do write 0x82 to GPIO /ht@0,f2000000/pci@3/mac-io@7/gpio@50/headphone-detect@17 (d000080080041067)
Installing functions for UniN /u3@0,f8000000
All base functions installed
PCI: Probing PCI hardware
Can't get ranges for PCI-PCI bridge /ht@0,f2000000/pci@2
mapping IO f0000000 -> d000080000400000, size: 800000
mapping IO f4000000 -> d000080000000000, size: 400000
PCI: Probing PCI hardware done
Registering pmac pic with sysfs...
usbcore: registered new driver usbfs
usbcore: registered new driver hub
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
IBM eBus Device Driver
nvram_init: Could not find nvram partition for nvram buffered error logging.
Registering G5 CPU frequency driver
Frequency method: i2c/pfunc, Voltage method: i2c/pfunc
Low: 1301 Mhz, High: 1600 Mhz, Cur: 1600 MHz
audit: initializing netlink socket (disabled)
audit(1141055721.759:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
nvidiafb: PCI id - 10de0321
nvidiafb: Actual id - 10de0321
nvidiafb: nVidia device/chipset 10DE0321
nvidiafb: CRTC0 analog not found
nvidiafb: CRTC1 analog not found
nvidiafb: EDID found from BUS2
nvidiafb: CRTC 1 is currently programmed for DFP
nvidiafb: Using DFP on CRTC 1
Panel size is 1680 x 1050
nvidiafb: Flat panel dithering disabled
Console: switching to colour frame buffer device 210x65
nvidiafb: PCI nVidia NV32 framebuffer (64MB @ 0xA8000000)
vio_register_driver: driver hvc_console registering
HVSI: registered 0 devices
Generic RTC Driver v1.07
pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
ttyS0 at MMIO 0x80013020 (irq = 22) is a Z85c30 ESCC - Serial port
ttyS1 at MMIO 0x80013000 (irq = 23) is a Z85c30 ESCC - Serial port
RAMDISK driver initialized: 16 RAM disks of 123456K size 1024 blocksize
MacIO PCI driver attached to K2 chipset
input: Macintosh mouse button emulation as /class/input/input0
PowerMac G5 Thermal control driver 1.2b2
adb: starting probe task...
adb: finished probe task...
Detected fan controls:
  0: PWM fan, id 1, location: BACKSIDE,SYS CTRLR FAN
  1: RPM fan, id 2, location: DRIVE BAY
  2: PWM fan, id 2, location: SLOT,PCI FAN
  3: RPM fan, id 3, location: CPU A INTAKE
  4: RPM fan, id 4, location: CPU A EXHAUST
  5: RPM fan, id 5, location: CPU B INTAKE
  6: RPM fan, id 6, location: CPU B EXHAUST
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PCI: Enabling device: (0001:03:0d.0), cmd 16
ide0: Found Apple K2 ATA-6 controller, bus ID 3, irq 39
Probing IDE interface ide0...
hda: PIONEER DVD-RW DVR-106D, ATAPI CD/DVD-ROM drive
hda: Enabling Ultra DMA 2
ide0 at 0xd0000800872eb000-0xd0000800872eb007,0xd0000800872eb160 on irq 39
PCI: Enabling device: (0001:02:0b.2), cmd 6
ehci_hcd 0001:02:0b.2: EHCI Host Controller
ehci_hcd 0001:02:0b.2: new USB bus registered, assigned bus number 1
ehci_hcd 0001:02:0b.2: irq 63, io mem 0x80100000
ehci_hcd 0001:02:0b.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.16-rc4-3-ppc64 ehci_hcd
usb usb1: SerialNumber: 0001:02:0b.2
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 5 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
PCI: Enabling device: (0001:01:08.0), cmd 2
ohci_hcd 0001:01:08.0: OHCI Host Controller
ohci_hcd 0001:01:08.0: new USB bus registered, assigned bus number 2
ohci_hcd 0001:01:08.0: irq 27, io mem 0x80081000
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.16-rc4-3-ppc64 ohci_hcd
usb usb2: SerialNumber: 0001:01:08.0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PCI: Enabling device: (0001:01:09.0), cmd 2
ohci_hcd 0001:01:09.0: OHCI Host Controller
ohci_hcd 0001:01:09.0: new USB bus registered, assigned bus number 3
ohci_hcd 0001:01:09.0: irq 28, io mem 0x80080000
usb usb3: new device found, idVendor=0000, idProduct=0000
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: OHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.16-rc4-3-ppc64 ohci_hcd
usb usb3: SerialNumber: 0001:01:09.0
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PCI: Enabling device: (0001:02:0b.0), cmd 2
ohci_hcd 0001:02:0b.0: OHCI Host Controller
ohci_hcd 0001:02:0b.0: new USB bus registered, assigned bus number 4
ohci_hcd 0001:02:0b.0: irq 63, io mem 0x80102000
usb usb4: new device found, idVendor=0000, idProduct=0000
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: OHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.16-rc4-3-ppc64 ohci_hcd
usb usb4: SerialNumber: 0001:02:0b.0
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 3 ports detected
PCI: Enabling device: (0001:02:0b.1), cmd 2
ohci_hcd 0001:02:0b.1: OHCI Host Controller
ohci_hcd 0001:02:0b.1: new USB bus registered, assigned bus number 5
ohci_hcd 0001:02:0b.1: irq 63, io mem 0x80101000
usb usb5: new device found, idVendor=0000, idProduct=0000
usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: OHCI Host Controller
usb usb5: Manufacturer: Linux 2.6.16-rc4-3-ppc64 ohci_hcd
usb usb5: SerialNumber: 0001:02:0b.1
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 4-2: new full speed USB device using ohci_hcd and address 2
usb 4-2: new device found, idVendor=05ac, idProduct=1003
usb 4-2: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 4-2: Product: Hub in Apple Extended USB Keyboard
usb 4-2: Manufacturer: Mitsumi Electric
usb 4-2: configuration #1 chosen from 1 choice
hub 4-2:1.0: USB hub found
hub 4-2:1.0: 3 ports detected
usb 5-2: new full speed USB device using ohci_hcd and address 2
usb 5-2: new device found, idVendor=06cd, idProduct=0110
usb 5-2: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 5-2: Product: Keyspan USB Serial Adapter
usb 5-2: Manufacturer: Keyspan, a division of InnoSys Inc.
usb 5-2: configuration #1 chosen from 2 choices
usb 4-2.1: new low speed USB device using ohci_hcd and address 3
usb 4-2.1: new device found, idVendor=05ac, idProduct=0307
usb 4-2.1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 4-2.1: Product: Apple Optical USB Mouse
usb 4-2.1: Manufacturer: Logitech
usb 4-2.1: configuration #1 chosen from 1 choice
usb 4-2.3: new full speed USB device using ohci_hcd and address 4
usb 4-2.3: new device found, idVendor=05ac, idProduct=020c
usb 4-2.3: new device strings: Mfr=1, Product=3, SerialNumber=0
usb 4-2.3: Product: Apple Extended USB Keyboard
usb 4-2.3: Manufacturer: Mitsumi Electric
usb 4-2.3: configuration #1 chosen from 1 choice
usbcore: registered new driver hiddev
input: Logitech Apple Optical USB Mouse as /class/input/input1
input: USB HID v1.10 Mouse [Logitech Apple Optical USB Mouse] on usb-0001:02:0b.0-2.1
input: Mitsumi Electric Apple Extended USB Keyboard as /class/input/input2
input: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:02:0b.0-2.3
input: Mitsumi Electric Apple Extended USB Keyboard as /class/input/input3
input: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:02:0b.0-2.3
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
PowerMac i2c bus pmu 2 registered
PowerMac i2c bus pmu 1 registered
PowerMac i2c bus mac-io 0 registered
found max6690, loc=BACKSIDE reg=98
found max6690, loc=MLB MAX6690 AMB reg=9c
PowerMac i2c bus u3 1 registered
windfarm: failed to attach ds1775 hd-temp to i2c
found max6690, loc=BACKSIDE reg=98
windfarm: failed to attach MAX6690 sensor
found max6690, loc=MLB MAX6690 AMB reg=9c
PowerMac i2c bus u3 0 registered
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
oprofile: using ppc64/970 performance monitoring.
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 3, 32768 bytes)
TCP established hash table entries: 16384 (order: 7, 524288 bytes)
TCP bind hash table entries: 16384 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Freeing unused kernel memory: 256k freed
SCSI subsystem initialized
libata version 1.20 loaded.
sata_svw 0001:05:0c.0: version 1.07
ata1: SATA max UDMA/133 cmd 0xD0000800872F2000 ctl 0xD0000800872F2020 bmdma 0xD0000800872F2030 irq 0
ata2: SATA max UDMA/133 cmd 0xD0000800872F2100 ctl 0xD0000800872F2120 bmdma 0xD0000800872F2130 irq 0
ata3: SATA max UDMA/133 cmd 0xD0000800872F2200 ctl 0xD0000800872F2220 bmdma 0xD0000800872F2230 irq 0
ata4: SATA max UDMA/133 cmd 0xD0000800872F2300 ctl 0xD0000800872F2320 bmdma 0xD0000800872F2330 irq 0
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:007f
ata1: dev 0 ATA-6, max UDMA/133, 156301488 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_svw
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003 88:007f
ata2: dev 0 ATA-7, max UDMA/133, 156312576 sectors: LBA
ata2: dev 0 configured for UDMA/133
scsi1 : sata_svw
ata3: SATA link down (SStatus 4)
scsi2 : sata_svw
ata4: SATA link down (SStatus 4)
scsi3 : sata_svw
  Vendor: ATA       Model: ST380013AS        Rev: 3.05
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: [mac] sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8 sda9 sda10 sda11
sd 0:0:0:0: Attached scsi disk sda
  Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
sd 0:0:0:0: Attached scsi generic sg0 type 0
SCSI device sdb: 156312576 512-byte hdwr sectors (80032 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 156312576 512-byte hdwr sectors (80032 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: [mac] sdb1 sdb2 sdb3 sdb4 sdb5 sdb6 sdb7 sdb8
sd 1:0:0:0: Attached scsi disk sdb
sd 1:0:0:0: Attached scsi generic sg1 type 0
Adding 1048568k swap on /dev/sda3.  Priority:-1 extents:1 across:1048568k
Adding 1023992k swap on /dev/sdb3.  Priority:-2 extents:1 across:1023992k
input: PowerMac Beep as /class/input/input4
hda: ATAPI 32X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected Apple U3 chipset
agpgart: configuring for size idx: 64
agpgart: AGP aperture is 256M @ 0x0
ieee1394: Initialized config rom entry `ip1394'
PCI: Enabling device: (0001:03:0e.0), cmd 2
ohci1394: fw-host0: Unexpected PCI resource length of 1000!
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[40]  MMIO=[80200000-802007ff]  Max Packet=[4096]  IR/IT contexts=[8/8]
tg3.c:v3.49 (Feb 2, 2006)
PCI: Enabling device: (0001:06:03.0), cmd 6
spidernet: module not supported by Novell, setting U taint flag.
eth0: Tigon3 [partno(3C996B-T) rev 0105 PHY(5701)] (PCI:33MHz:64-bit) 10/100/1000BaseT Ethernet 00:04:76:f3:c2:4f
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[0] 
eth0: dma_rwctrl[76ff2d0f]
sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
PHY ID: 2062e0, addr: 1
eth1: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:0a:95:a6:5d:66 
eth1: Found BCM5421-K2 PHY
ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0010b92100519fad]
ieee1394: Host added: ID:BUS[0-01:1023]  GUID[000a95fffea65d66]
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial support registered for generic
usbcore: registered new driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core
drivers/usb/serial/usb-serial.c: USB Serial support registered for Keyspan - (without firmware)
drivers/usb/serial/usb-serial.c: USB Serial support registered for Keyspan 1 port adapter
drivers/usb/serial/usb-serial.c: USB Serial support registered for Keyspan 2 port adapter
drivers/usb/serial/usb-serial.c: USB Serial support registered for Keyspan 4 port adapter
keyspan 5-2:1.0: Keyspan 2 port adapter converter detected
usb 5-2: Keyspan 2 port adapter converter now attached to ttyUSB0
usb 5-2: Keyspan 2 port adapter converter now attached to ttyUSB1
usbcore: registered new driver keyspan
drivers/usb/serial/keyspan.c: v1.1.4:Keyspan USB to Serial Converter Driver
eth0 renamed to ethxx0
eth1 renamed to eth0
eth0: Link is up at 100 Mbps, full-duplex.
ethxx0 renamed to eth1
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
scsi4 : SBP-2 IEEE-1394
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: Node 0-00:1023: Max speed [S400] - Max payload [2048]
  Vendor: Maxtor    Model: OneTouch II       Rev: 023g
  Type:   Direct-Access                      ANSI SCSI revision: 04
SCSI device sdc: 586114704 512-byte hdwr sectors (300091 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 32 00 00
sdc: cache data unavailable
sdc: assuming drive cache: write through
SCSI device sdc: 586114704 512-byte hdwr sectors (300091 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 32 00 00
sdc: cache data unavailable
sdc: assuming drive cache: write through
 sdc: [mac] sdc1 sdc2 sdc3 sdc4 sdc5 sdc6 sdc7 sdc8
sd 4:0:1:0: Attached scsi disk sdc
sd 4:0:1:0: Attached scsi generic sg2 type 0
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
dm-netlink version 0.0.2 loaded
loop: loaded (max 8 devices)
AppArmor: AppArmor (version 2.0-19.43r6152) initialized
audit(1141052147.508:2): AppArmor (version 2.0-19.43r6152) initialized

eth0: Link is up at 100 Mbps, full-duplex.
eth0: Pause is enabled (rxfifo: 10240 off: 7168 on: 5632)
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
st: Version 20050830, fixed bufsize 32768, s/g segs 256
Warning: /proc/ide/hd?/settings interface is obsolete, and will be removed soon!
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_addr (isr: 04)
low_i2c: Keywest got an out of state interrupt, ignoring
low_i2c: Keywest got an out of state interrupt, ignoring
low_i2c: Keywest got an out of state interrupt, ignoring
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
Failure writing address to FCU: -5<7>KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_write (isr: 04)
Error -6 reading backside fan !
Error -6 reading backside fan !
Error -6 reading backside fan !
Error -6 reading backside fan !
Error -6 reading backside fan !
Error -6 reading backside fan !
Error -6 reading backside fan !
Error -6 reading backside fan !
Error -6 reading backside fan !
Error -6 reading backside fan !
Error -6 reading backside fan !
Error -6 reading backside fan !
Error -6 reading backside fan !
Error -6 reading backside fan !
Error -6 reading backside fan !
Error -6 reading backside fan !

----- End forwarded message -----
