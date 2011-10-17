Return-Path: <ppc.addon@gmail.com>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
 [209.85.161.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 59270B70B1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2011 08:41:02 +1100 (EST)
Received: by ggnk1 with SMTP id k1so447179ggn.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Oct 2011 14:40:55 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 17 Oct 2011 23:40:54 +0200
Message-ID: <CABMX=WzPuhBywZTJShnM5W1Y2cqMOr=2BuJTKecsyfCp73Ko7g@mail.gmail.com>
Subject: linux-3.0.4, mv643xx_eth troubles on Pegasos2 G4
From: nello martuscielli <ppc.addon@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/mixed; boundary=bcaec520f4d928981604af857606
Cc: acrux@linuxmail.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--bcaec520f4d928981604af857606
Content-Type: text/plain; charset=ISO-8859-1

i'm trying to enable marvel gigabit ethernet support but it doesn't work.
Here my dmesg instead my config is attached.

root@peg2:~# dmesg
:08.0: supports D1 D2
pci 0001:01:08.1: [1002:5940] type 0 class 0x000380
pci 0001:01:08.1: reg 10: [mem 0xd0000000-0xd7ffffff pref]
pci 0001:01:08.1: reg 14: [mem 0xc8010000-0xc801ffff]
pci 0001:01:08.1: supports D1 D2
PCI 0000:00 Cannot reserve Legacy IO [io  0x0000-0x0fff]
PCI: max bus depth: 0 pci_try_num: 1
pci_bus 0000:00: resource 0 [io  0x0000-0xffff]
pci_bus 0000:00: resource 1 [mem 0x80000000-0xbfffffff]
pci_bus 0001:01: resource 0 [io  0xffff0000-0xffffffff]
pci_bus 0001:01: resource 1 [mem 0xc0000000-0xdfffffff]
bio: create slab <bio-0> at 0
vgaarb: device added: PCI:0001:01:08.0,decodes=io+mem,owns=io+mem,locks=none
vgaarb: loaded
vgaarb: bridge control possible 0001:01:08.0
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Advanced Linux Sound Architecture Driver Version 1.0.24.
Bluetooth: Core ver 2.16
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO socket layer initialized
Switching to clocksource timebase
Switched to NOHz mode on CPU #0
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
UDP hash table entries: 512 (order: 1, 8192 bytes)
UDP-Lite hash table entries: 512 (order: 1, 8192 bytes)
NET: Registered protocol family 1
pci 0000:00:0c.1: Fixing VIA IDE, force legacy mode on
PCI: CLS 128 bytes, default 32
rtasd: scan rate is 0, not scanning
Thermal assist unit not available
highmem bounce pool size: 64 pages
NTFS driver 2.1.30 [Flags: R/W].
JFS: nTxBlock = 8044, nTxLock = 64358
SGI XFS with ACLs, security attributes, large block/inode numbers, no
debug enabled
Btrfs loaded
msgmni has been set to 1499
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler cfq registered (default)
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: No ATY,RefCLK property !
radeonfb: Retrieved PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=240.00 Mhz, System=166.00 MHz
radeonfb: PLL min 20000 max 40000
i2c i2c-1: unable to read EDID block.
i2c i2c-1: unable to read EDID block.
i2c i2c-1: unable to read EDID block.
i2c i2c-3: unable to read EDID block.
i2c i2c-3: unable to read EDID block.
i2c i2c-3: unable to read EDID block.
radeonfb: Monitor 1 type CRT found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
Console: switching to colour frame buffer device 100x37
radeonfb (0001:01:08.0): ATI Radeon 5960 "Y`"
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at I/O 0x2f8 (irq = 0) is a 16550A
Generic non-volatile memory driver v1.1
parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
parport_pc: Current parallel port base: 0x3BC
parport0: PC-style at 0x3bc, irq 7 [PCSPP]
parport0: Device ID was 64 bytes while device told it would be 63 bytes
parport0 (addr 0): SCSI adapter, IMG VP1
parport_pc: VIA parallel port: io=0x3BC, irq=7
brd: module loaded
loop: module loaded
pata_via 0000:00:0c.1: version 0.3.4
scsi0 : pata_via
scsi1 : pata_via
ata1: PATA max UDMA/100 cmd 0x1000 ctl 0x100c bmdma 0x1020 irq 14
ata2: PATA max UDMA/100 cmd 0x1010 ctl 0x101c bmdma 0x1028 irq 15
Fixed MDIO Bus: probed
firewire_ohci 0000:00:01.0: enabling device (0000 -> 0003)
firewire_ohci: Added fw-ohci device 0000:00:01.0, OHCI v1.0, 8 IR + 8
IT contexts, quirks 0x11
usbmon: debugfs is not available
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci_hcd 0000:00:05.1: enabling device (0000 -> 0002)
ehci_hcd 0000:00:05.1: EHCI Host Controller
ehci_hcd 0000:00:05.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:05.1: irq 9, io mem 0x80001800
ehci_hcd 0000:00:05.1: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 3.0.4 ehci_hcd
usb usb1: SerialNumber: 0000:00:05.1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mousedev: PS/2 mouse device common for all mice
rtc-generic rtc-generic: rtc core: registered rtc-generic as rtc0
i2c /dev entries driver
ata1.00: ATA-6: ST340810A, 3.39, max UDMA/100
ata1.00: 78165360 sectors, multi 0: LBA
lirc_dev: IR Remote Control driver registered, major 251
atkbd serio0: keyboard reset failed on isa0060/serio0
IR NEC protocol handler initialized
IR RC5(x) protocol handler initialized
IR RC6 protocol handler initialized
IR JVC protocol handler initialized
IR Sony protocol handler initialized
ata1.00: configured for UDMA/100
IR RC5 (streamzap) protocol handler initialized
IR LIRC bridge handler initialized
Linux video capture interface: v2.00
device-mapper: ioctl: 4.20.0-ioctl (2011-02-02) initialised: dm-devel@redhat.com
scsi 0:0:0:0: Direct-Access     ATA      ST340810A        3.39 PQ: 0 ANSI: 5
usbcore: registered new interface driver usbhid
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:0:0: [sda] 78165360 512-byte logical blocks: (40.0 GB/37.2 GiB)
sd 0:0:0:0: [sda] Write Protect is off
atkbd serio1: keyboard reset failed on isa0060/serio1
usbhid: USB HID core driver
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
ALSA device list:
 No soundcards found.
TCP cubic registered
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
sd 0:0:0:0: [sda] Attached SCSI disk
ata2.00: ATAPI: SAMSUNG CDRW/DVD SM-352B, T807, max UDMA/33
ata2.00: configured for UDMA/33
scsi 1:0:0:0: CD-ROM            SAMSUNG  CDRW/DVD SM-352B T807 PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 1x/52x writer cd/rw xa/form2 cdda tray
cdrom: Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
sr 1:0:0:0: Attached scsi generic sg1 type 5
REISERFS (device sda5): found reiserfs format "3.6" with standard journal
REISERFS (device sda5): using ordered data mode
REISERFS (device sda5): journal params: device sda5, size 8192,
journal first block 18, max trans len 1024, max batch 900, max commit
age 30, max trans age 30
REISERFS (device sda5): checking transaction log (sda5)
REISERFS (device sda5): Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly on device 8:5.
devtmpfs: mounted
Freeing unused kernel memory: 220k init
firewire_core: created device fw0: GUID 0011060000004b2f, S400
udevd[57]: starting version 173
uhci_hcd: USB Universal Host Controller Interface driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
uhci_hcd 0000:00:0c.2: enabling device (0000 -> 0001)
uhci_hcd 0000:00:0c.2: UHCI Host Controller
uhci_hcd 0000:00:0c.2: new USB bus registered, assigned bus number 2
via_rhine: v1.10-LK1.5.0 2010-10-09 Written by Donald Becker
mv643xx_eth: MV-643xx 10/100/1000 ethernet driver version 1.4
uhci_hcd 0000:00:0c.2: irq 9, io base 0x00001040
sysfs: cannot create duplicate filename '/class/mdio_bus/0'
usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
------------[ cut here ]------------
WARNING: at fs/sysfs/dir.c:455
Modules linked in: snd_via82xx(+) snd_ac97_codec mv643xx_eth(+)
via_rhine(+) i2c_viapro(+) ac97_bus ohci_hcd(+) snd_mpu401_uart
uhci_hcd(+) snd_rawmidi
NIP: c00fa718 LR: c00fa718 CTR: 00000000
REGS: ef271c00 TRAP: 0700   Not tainted  (3.0.4)
MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 22004428  XER: 00000000
TASK = ef294c60[94] 'modprobe' THREAD: ef270000
GPR00: c00fa718 ef271cb0 ef294c60 00000042 c0008904 00000001 00000000 00000000
GPR08: c06b6bd8 00000000 22004482 ef271c70 22004422 10024440 1000ba68 00000000
GPR16: 1000ba44 bf83e324 00000000 1000ba58 00000000 104410ec 00000a30 00000000
GPR24: c0059210 00000124 00000000 00000001 ef271cd8 ef2ba480 ffffffef ef344000
NIP [c00fa718] sysfs_add_one+0x88/0xa0
LR [c00fa718] sysfs_add_one+0x88/0xa0
Call Trace:
[ef271cb0] [c00fa718] sysfs_add_one+0x88/0xa0 (unreliable)
[ef271cd0] [c00faff4] sysfs_do_create_link+0x134/0x1e0
[ef271d00] [c0392cf8] device_add+0x204/0x544
[ef271d40] [c03d67e4] mdiobus_register+0xa4/0x198
[ef271d60] [f26785a4] mv643xx_eth_shared_probe+0x144/0x428 [mv643xx_eth]
[ef271d80] [c039685c] platform_drv_probe+0x20/0x30
[ef271d90] [c0395578] driver_probe_device+0xe4/0x198
[ef271db0] [c039569c] __driver_attach+0x70/0x98
[ef271dd0] [c0394614] bus_for_each_dev+0x60/0x90
[ef271e00] [c03951d0] driver_attach+0x24/0x34
[ef271e10] [c0394d9c] bus_add_driver+0xbc/0x23c
[ef271e30] [c0395ac8] driver_register+0xb8/0x144
[ef271e50] [c0396bb4] platform_driver_register+0x68/0x78
[ef271e60] [f2680024] mv643xx_eth_init_module+0x24/0x80 [mv643xx_eth]
[ef271e80] [c000402c] do_one_initcall+0xe0/0x1c0
[ef271eb0] [c005b438] sys_init_module+0x1600/0x17f4
[ef271f40] [c0012df8] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xff62ac0
   LR = 0x10003f2c
Instruction dump:
807c0000 7fe4fb78 4bfff469 3c80c060 3884f131 4bf2051d 809d0010 4bf20515
7c641b78 3c60c060 3863f0fe 484650f9 <0fe00000> 7fe3fb78 4bfa8009 39610020
---[ end trace cebed1f190337b77 ]---
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 3.0.4 uhci_hcd
usb usb2: SerialNumber: 0000:00:0c.2
hub 2-0:1.0: USB hub found
mii_bus 0 failed to register
mv643xx_eth: probe of mv643xx_eth.0 failed with error -12
hub 2-0:1.0: 2 ports detected
ohci_hcd 0000:00:05.0: OHCI Host Controller
ohci_hcd 0000:00:05.0: new USB bus registered, assigned bus number 3
Unable to handle kernel paging request for data at address 0x00000000
ohci_hcd 0000:00:05.0: irq 9, io mem 0x80000000
Faulting instruction address: 0xf267b3a8
Oops: Kernel access of bad area, sig: 11 [#1]
PREEMPT CHRP
Modules linked in: snd_via82xx(+) snd_ac97_codec mv643xx_eth(+)
via_rhine(+) i2c_viapro(+) ac97_bus ohci_hcd(+) snd_mpu401_uart
uhci_hcd(+) snd_rawmidi
NIP: f267b3a8 LR: f267b3a0 CTR: c0394ff4
REGS: ef271c90 TRAP: 0300   Tainted: G        W    (3.0.4)
MSR: 00009032 <EE,ME,IR,DR>  CR: 84004448  XER: 00000000
DAR: 00000000, DSISR: 40000000
TASK = ef294c60[94] 'modprobe' THREAD: ef270000
GPR00: 00000000 ef271d40 ef294c60 00000000 eec003c0 eec00005 ef24bb3c 00000000
GPR08: ef24bb28 ef8a7600 ffffffff 00000001 44004442 10024440 1000ba68 00000000
GPR16: 1000ba44 bf83e324 00000000 1000ba58 00000000 104410ec 00000a30 00000000
GPR24: c0059210 c06b68c0 00000020 c06b68b8 fffffff4 eec00000 c06b6740 eec003c0
NIP [f267b3a8] mv643xx_eth_probe+0x98/0x604 [mv643xx_eth]
LR [f267b3a0] mv643xx_eth_probe+0x90/0x604 [mv643xx_eth]
Call Trace:
[ef271d40] [f267b394] mv643xx_eth_probe+0x84/0x604 [mv643xx_eth] (unreliable)
[ef271d80] [c039685c] platform_drv_probe+0x20/0x30
[ef271d90] [c0395578] driver_probe_device+0xe4/0x198
[ef271db0] [c039569c] __driver_attach+0x70/0x98
[ef271dd0] [c0394614] bus_for_each_dev+0x60/0x90
[ef271e00] [c03951d0] driver_attach+0x24/0x34
[ef271e10] [c0394d9c] bus_add_driver+0xbc/0x23c
[ef271e30] [c0395ac8] driver_register+0xb8/0x144
[ef271e50] [c0396bb4] platform_driver_register+0x68/0x78
[ef271e60] [f2680034] mv643xx_eth_init_module+0x34/0x80 [mv643xx_eth]
[ef271e80] [c000402c] do_one_initcall+0xe0/0x1c0
[ef271eb0] [c005b438] sys_init_module+0x1600/0x17f4
[ef271f40] [c0012df8] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xff62ac0
   LR = 0x10003f2c
Instruction dump:
7c7d1b79 41820530 3bfd03c0 3b3b0008 7fe4fb78 7f23cb78 48001101 807e0000
38630008 48001505 907d03c0 817e0004
556b502a 396b0400 7d605a14
usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: OHCI Host Controller
usb usb3: Manufacturer: Linux 3.0.4 ohci_hcd
usb usb3: SerialNumber: 0000:00:05.0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
vt596_smbus 0000:00:0c.4: SMBUS: Error: Host SMBus controller not
enabled! - upgrade BIOS or use force=1
VIA 82xx Audio 0000:00:0c.5: enabling device (0000 -> 0001)
---[ end trace cebed1f190337b78 ]---
via-rhine 0000:00:0d.0: enabling device (0000 -> 0003)
via-rhine 0000:00:0d.0: eth0: VIA Rhine II at 0x80001900,
00:0b:2f:4f:65:7b, IRQ 9
via-rhine 0000:00:0d.0: eth0: MII PHY found at address 16, status
0x786d advertising 01e1 Link 45e1
uhci_hcd 0000:00:0c.3: enabling device (0000 -> 0001)
uhci_hcd 0000:00:0c.3: UHCI Host Controller
uhci_hcd 0000:00:0c.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:0c.3: irq 9, io base 0x00001060
usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 3.0.4 uhci_hcd
usb usb4: SerialNumber: 0000:00:0c.3
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 4-1: new low speed USB device number 2 using uhci_hcd
usb 4-1: New USB device found, idVendor=062a, idProduct=0102
usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 4-1: Product: Wireless Keyboard & Mouse
usb 4-1: Manufacturer: MOSART Semi.
input: MOSART Semi. Wireless Keyboard & Mouse as
/devices/pci0000:00/0000:00:0c.3/usb4/4-1/4-1:1.0/input/input0
generic-usb 0003:062A:0102.0001: input,hidraw0: USB HID v1.10 Keyboard
[MOSART Semi. Wireless Keyboard & Mouse] on usb-0000:00:0c.3-1/input0
input: MOSART Semi. Wireless Keyboard & Mouse as
/devices/pci0000:00/0000:00:0c.3/usb4/4-1/4-1:1.1/input/input1
generic-usb 0003:062A:0102.0002: input,hiddev0,hidraw1: USB HID v1.10
Mouse [MOSART Semi. Wireless Keyboard & Mouse] on
usb-0000:00:0c.3-1/input1
REISERFS (device sda6): found reiserfs format "3.6" with standard journal
REISERFS (device sda6): using ordered data mode
REISERFS (device sda6): journal params: device sda6, size 8192,
journal first block 18, max trans len 1024, max batch 900, max commit
age 30, max trans age 30
REISERFS (device sda6): checking transaction log (sda6)
REISERFS (device sda6): Using r5 hash to sort names
REISERFS (device sda7): found reiserfs format "3.6" with standard journal
REISERFS (device sda7): using ordered data mode
REISERFS (device sda7): journal params: device sda7, size 8192,
journal first block 18, max trans len 1024, max batch 900, max commit
age 30, max trans age 30
REISERFS (device sda7): checking transaction log (sda7)
REISERFS (device sda7): Using r5 hash to sort names
Adding 499996k swap on /dev/sda1.  Priority:-1 extents:1 across:499996k
imm: Version 2.05 (for Linux 2.4.0)
imm: Found device at ID 6, Attempting to use SPP
imm: Communication established at 0x3bc with ID 6 using SPP
scsi2 : Iomega VPI2 (imm) interface
scsi 2:0:6:0: Direct-Access     IOMEGA   ZIP 100 PLUS     J.66 PQ: 0 ANSI: 2
sd 2:0:6:0: Attached scsi generic sg2 type 0
sd 2:0:6:0: [sdb] Attached SCSI removable disk
via-rhine 0000:00:0d.0: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
ata1.00: configured for UDMA/100
ata1: EH complete
eth0: no IPv6 routers present



--
Power Mac G4 AGP 450MHz - CRUX PPC (32bit)

--bcaec520f4d928981604af857606
Content-Type: application/x-gzip; name="config.gz"
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gtvzlqlq0

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
M+aW81AdWZU89cJg/D+Ye3Wt+v4AAA==
--bcaec520f4d928981604af857606--
