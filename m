Return-Path: <acrux_it@libero.it>
Received: from outrelay07.libero.it (outrelay07.libero.it [212.52.84.111])
 by ozlabs.org (Postfix) with ESMTP id E2E67104798
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Feb 2012 04:54:00 +1100 (EST)
Received: from acrux-1faad1e87 (151.77.142.172) by outrelay07.libero.it
 (8.6.033) (authenticated as acrux_it@libero.it)
 id 4F29D9C30079EC71 for linuxppc-dev@lists.ozlabs.org;
 Sat, 4 Feb 2012 18:53:57 +0100
Date: Sat, 4 Feb 2012 18:55:04 +0100
From: acrux <acrux_it@libero.it>
To: linuxppc-dev@lists.ozlabs.org
Subject: [ppc] sm501-usb boot hang down with linux-3.1.10 and linux-3.2.4 on
 sam460ex
Message-Id: <20120204185504.f9a64984.acrux_it@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

board: Acube Sam460ex (canyonlands based)

boot process hang down  with linux-3.1.10 and 3.2.4 [1]
instead with linux-3.0.19 still boot but with a weird Oops [2]

[1]
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2073520k/2097152k available (6024k kernel code, 23632k reserved, 168k data, 125k bss, 196k init)
Kernel virtual memory layout:
  * 0xfffcf000..0xfffff000  : fixmap
  * 0xffc00000..0xffe00000  : highmem PTEs
  * 0xffa00000..0xffc00000  : consistent mem
  * 0xffa00000..0xffa00000  : early ioremap
  * 0xf1000000..0xffa00000  : vmalloc & ioremap
SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS:512 nr_irqs:512 16
UIC0 (32 IRQ sources) at DCR 0xc0
UIC1 (32 IRQ sources) at DCR 0xd0
UIC2 (32 IRQ sources) at DCR 0xe0
UIC3 (32 IRQ sources) at DCR 0xf0
clocksource: timebase mult[36db6e] shift[22] registered
Console: colour dummy device 80x25
console [tty0] enabled
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
devtmpfs: initialized
NET: Registered protocol family 16
256k L2-cache enabled
PCIE0: Port disabled via device-tree
PCIE1: Checking link...
PCIE1: No device detected.
PCI host bridge /plb/pciex@d20000000 (primary) ranges:
 MEM 0x0000000e80000000..0x0000000effffffff -> 0x0000000080000000
 MEM 0x0000000f00100000..0x0000000f001fffff -> 0x0000000000000000
  IO 0x0000000f80010000..0x0000000f8001ffff -> 0x0000000000000000
 Removing ISA hole at 0x0000000f00100000
4xx PCI DMA offset set to 0x00000000
/plb/pciex@d20000000: Legacy ISA memory support enabled
PCIE1: successfully set as root-complex
PCI host bridge /plb/pci@c0ec00000 (primary) ranges:
 MEM 0x0000000d80000000..0x0000000dffffffff -> 0x0000000080000000
 MEM 0x0000000c0ee00000..0x0000000c0eefffff -> 0x0000000000000000
  IO 0x0000000c08000000..0x0000000c0800ffff -> 0x0000000000000000
 Removing ISA hole at 0x0000000c0ee00000
4xx PCI DMA offset set to 0x00000000
/plb/pci@c0ec00000: Legacy ISA memory support enabled
PCI: Probing PCI hardware
PCI: Hiding 4xx host bridge resources 0000:80:00.0
pci 0000:80:00.0: PCI bridge to [bus 81-bf]
pci 0000:80:00.0: PCI bridge to [bus 81-bf]
pci 0001:00:06.0: BAR 0: assigned [mem 0xd80000000-0xd83ffffff]
pci 0001:00:06.0: BAR 0: set to [mem 0xd80000000-0xd83ffffff] (PCI address [0x80000000-0x83ffffff])
pci 0001:00:06.0: BAR 1: assigned [mem 0xd84000000-0xd841fffff]
pci 0001:00:06.0: BAR 1: set to [mem 0xd84000000-0xd841fffff] (PCI address [0x84000000-0x841fffff])
bio: create slab <bio-0> at 0
vgaarb: loaded
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
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
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
Could not remap bcsr
setting trigger mode 3 for irq 43 failed (uic_set_irq_type+0x0/0x164)
setting trigger mode 3 for irq 43 failed (uic_set_irq_type+0x0/0x164)
highmem bounce pool size: 64 pages
JFS: nTxBlock = 8192, nTxLock = 65536
SGI XFS with ACLs, security attributes, large block/inode numbers, no debug enabled
Btrfs loaded
msgmni has been set to 1489
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4ef600300 (irq = 20) is a U6_16550A
console [ttyS0] enabled
serial8250.0: ttyS1 at MMIO 0x4ef600400 (irq = 21) is a U6_16550A
4ef600300.serial: ttyS0 at MMIO 0x4ef600300 (irq = 20) is a 16550
4ef600400.serial: ttyS1 at MMIO 0x4ef600400 (irq = 21) is a 16550
Generic non-volatile memory driver v1.1
brd: module loaded
loop: module loaded
sm501 0001:00:06.0: SM501 At f5480000: Version 050100c0, 64 Mb, IRQ 19
sm501 0001:00:06.0: setting M1XCLK to 144000000
sm501 0001:00:06.0: setting MCLK to 72000000
serial8250.10: ttyS2 at MMIO 0xd84030000 (irq = 19) is a ST16654
serial8250.10: ttyS3 at MMIO 0xd84030020 (irq = 19) is a ST16654
sm501-fb sm501-fb.80: fb sm501fb-crt disabled at start
sm501-fb sm501-fb.80: using mode specified in @mode
Console: switching to colour frame buffer device 100x37
sm501-fb sm501-fb.80: fb0: sm501fb-crt frame buffer
sm501-fb sm501-fb.80: fb sm501fb-panel enabled at start
sm501-fb sm501-fb.80: using mode specified in @mode
sm501-fb sm501-fb.80: fb1: sm501fb-panel frame buffer
sata-dwc 4bffd1000.sata: id 0, controller version 1.82
sata-dwc 4bffd1000.sata: DMA initialized
scsi0 : sata-dwc
ata1: SATA max UDMA/133 irq 34
PPC 4xx OCP EMAC driver, version 3.54
MAL v2 /plb/mcmal, 2 TX channels, 16 RX channels
ZMII /plb/opb/emac-zmii@ef600d00 initialized
RGMII /plb/opb/emac-rgmii@ef601500 initialized with MDIO support
TAH /plb/opb/emac-tah@ef601350 initialized
TAH /plb/opb/emac-tah@ef601450 initialized
/plb/opb/emac-rgmii@ef601500: input 0 in RGMII mode
eth0: EMAC-0 /plb/opb/ethernet@ef600e00, MAC 00:50:c2:80:d4:89
eth0: found Generic MII PHY (0x00)
/plb/opb/emac-rgmii@ef601500: input 1 in RGMII mode
eth1: EMAC-1 /plb/opb/ethernet@ef600f00, MAC 00:00:00:00:00:00
eth1: found Generic MII PHY (0x01)
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ppc-of-ehci 4bffd0400.ehci: OF EHCI
ppc-of-ehci 4bffd0400.ehci: new USB bus registered, assigned bus number 1
ppc-of-ehci 4bffd0400.ehci: irq 27, io mem 0x4bffd0400
ppc-of-ehci 4bffd0400.ehci: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: OF EHCI
usb usb1: Manufacturer: Linux 3.1.10 ehci_hcd
usb usb1: SerialNumber: PPC-OF USB
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
mousedev: PS/2 mouse device common for all mice
i2c /dev entries driver
ibm-iic 4ef600700.i2c: using standard (100 kHz) mode
rtc-m41t80 0-0068: chip found, driver version 0.05
rtc-m41t80 0-0068: rtc core: registered m41t80 as rtc0
ibm-iic 4ef600800.i2c: using standard (100 kHz) mode
booke_wdt: powerpc book-e watchdog driver loaded
device-mapper: ioctl: 4.21.0-ioctl (2011-07-06) initialised: dm-devel@redhat.com
usbcore: registered new interface driver ushc
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
TCP cubic registered
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Registering the dns_resolver key type
rtc-m41t80 0-0068: setting system clock to 2012-02-04 14:15:15 UTC (1328364915)
usb 1-1: new high speed USB device number 2 using ppc-of-ehci
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-8: WDC WD5000AAKX-001CA0, 15.01H15, max UDMA/133
ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 1/32)
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      WDC WD5000AAKX-0 15.0 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:0:0: [sda] Write Protect is off
usb 1-1: New USB device found, idVendor=0424, idProduct=2517
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 7 ports detected
 sda: RDSK (512) sda1 (LNX^@)(res 2 spb 1) sda2 (LNX^@)(res 2 spb 1) sda3 (LNX^@)(res 2 spb 1) sda4 (LNX^@)(res 2 spb 1)
sd 0:0:0:0: [sda] Attached SCSI disk
REISERFS (device sda3): found reiserfs format "3.6" with standard journal
REISERFS (device sda3): using ordered data mode
reiserfs: using flush barriers
REISERFS (device sda3): journal params: device sda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
REISERFS (device sda3): checking transaction log (sda3)
REISERFS (device sda3): Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly on device 8:3.
devtmpfs: mounted
Freeing unused kernel memory: 196k freed
usb 1-1.1: new low speed USB device number 3 using ppc-of-ehci
usb 1-1.1: New USB device found, idVendor=062a, idProduct=0102
usb 1-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-1.1: Product: Wireless Keyboard & Mouse
usb 1-1.1: Manufacturer: MOSART Semi.
input: MOSART Semi. Wireless Keyboard & Mouse as /devices/plb.0/4bffd0400.ehci/usb1/1-1/1-1.1/1-1.1:1.0/input/input0
generic-usb 0003:062A:0102.0001: input,hidraw0: USB HID v1.10 Keyboard [MOSART Semi. Wireless Keyboard & Mouse] on usb-PPC-OF USB-1.1/input0
input: MOSART Semi. Wireless Keyboard & Mouse as /devices/plb.0/4bffd0400.ehci/usb1/1-1/1-1.1/1-1.1:1.1/input/input1
INIT: generic-usb 0003:062A:0102.0002: input,hiddev0,hidraw1: USB HID v1.10 Mouse [MOSART Semi. Wireless Keyboard & Mouse] on usb-PPC-OF USB-1.1/input1
version 2.88 booting
usb 1-1.7: new high speed USB device number 4 using ppc-of-ehci
The system is coming up.  Please wait.
usb 1-1.7: New USB device found, idVendor=0424, idProduct=2240
usb 1-1.7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1.7: Product: Ultra Fast Media
usb 1-1.7: Manufacturer: Generic
usb 1-1.7: SerialNumber: 000000225001
scsi1 : usb-storage 1-1.7:1.0
udevd[55]: error: runtime directory '/run/udev' not writable, for now falling back to '/dev/.udev'
udevd[56]: starting version 175
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ppc-of-ohci 4bffd0000.usb: OF OHCI
ppc-of-ohci 4bffd0000.usb: new USB bus registered, assigned bus number 2
ppc-of-ohci 4bffd0000.usb: irq 28, io mem 0x4bffd0000
usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OF OHCI
usb usb2: Manufacturer: Linux 3.1.10 ohci_hcd
usb usb2: SerialNumber: PPC-OF USB
scsi 1:0:0:0: Direct-Access     Generic  Ultra HS-COMBO   1.68 PQ: 0 ANSI: 0
sd 1:0:0:0: [sdb] Attached SCSI removable disk
sd 1:0:0:0: Attached scsi generic sg1 type 0
ad7414 0-0048: chip found
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
sm501-usb sm501-usb.80: cannot declare coherent memory


[2]
pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
pcpu-alloc: [0] 0
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 520192
Kernel command line: root=/dev/sda3 ro video=800x600 udbg-immortal console=tty0 console=ttyS0,115200
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
High memory: 1310720k
Memory: 2073496k/2097152k available (6048k kernel code, 23656k reserved, 168k data, 125k bss, 196k init)
Kernel virtual memory layout:
  * 0xfffcf000..0xfffff000  : fixmap
  * 0xffc00000..0xffe00000  : highmem PTEs
  * 0xffa00000..0xffc00000  : consistent mem
  * 0xffa00000..0xffa00000  : early ioremap
  * 0xf1000000..0xffa00000  : vmalloc & ioremap
SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS:512 nr_irqs:512 16
UIC0 (32 IRQ sources) at DCR 0xc0
UIC1 (32 IRQ sources) at DCR 0xd0
irq: irq 30 on host /interrupt-controller0 mapped to virtual irq 30
UIC2 (32 IRQ sources) at DCR 0xe0
irq: irq 10 on host /interrupt-controller0 mapped to virtual irq 16
UIC3 (32 IRQ sources) at DCR 0xf0
irq: irq 16 on host /interrupt-controller0 mapped to virtual irq 17
time_init: decrementer frequency = 1166.666663 MHz
time_init: processor frequency   = 1166.666663 MHz
clocksource: timebase mult[36db6e] shift[22] registered
clockevent: decrementer mult[9555554d] shift[31] cpu[0]
Console: colour dummy device 80x25
console [tty0] enabled
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
devtmpfs: initialized
NET: Registered protocol family 16
irq: irq 11 on host /interrupt-controller1 mapped to virtual irq 18
256k L2-cache enabled
PCIE0: Port disabled via device-tree
PCIE1: Checking link...
PCIE1: No device detected.
PCI host bridge /plb/pciex@d20000000 (primary) ranges:
 MEM 0x0000000e80000000..0x0000000effffffff -> 0x0000000080000000
 MEM 0x0000000f00100000..0x0000000f001fffff -> 0x0000000000000000
  IO 0x0000000f80010000..0x0000000f8001ffff -> 0x0000000000000000
 Removing ISA hole at 0x0000000f00100000
4xx PCI DMA offset set to 0x00000000
/plb/pciex@d20000000: Legacy ISA memory support enabled
PCIE1: successfully set as root-complex
PCI host bridge /plb/pci@c0ec00000 (primary) ranges:
 MEM 0x0000000d80000000..0x0000000dffffffff -> 0x0000000080000000
 MEM 0x0000000c0ee00000..0x0000000c0eefffff -> 0x0000000000000000
  IO 0x0000000c08000000..0x0000000c0800ffff -> 0x0000000000000000
 Removing ISA hole at 0x0000000c0ee00000
4xx PCI DMA offset set to 0x00000000
/plb/pci@c0ec00000: Legacy ISA memory support enabled
PCI: Probing PCI hardware
pci 0000:80:00.0: [aaa1:bed1] type 1 class 0x000604
pci 0000:80:00.0: reg 10: [mem 0x00000000-0x7fffffff pref]
PCI: Hiding 4xx host bridge resources 0000:80:00.0
pci 0000:80:00.0: PCI bridge to [bus 81-bf]
pci 0000:80:00.0:   bridge window [io  0x0000-0x0000] (disabled)
pci 0000:80:00.0:   bridge window [mem 0x00000000-0x000fffff] (disabled)
pci 0000:80:00.0:   bridge window [mem 0x00000000-0x000fffff pref] (disabled)
pci 0001:00:06.0: [126f:0501] type 0 class 0x000380
pci 0001:00:06.0: reg 10: [mem 0x80000000-0x83ffffff]
pci 0001:00:06.0: reg 14: [mem 0x84000000-0x841fffff]
pci 0001:00:06.0: supports D1 D2
irq: irq 0 on host /interrupt-controller1 mapped to virtual irq 19
PCI: max bus depth: 1 pci_try_num: 2
pci 0000:80:00.0: PCI bridge to [bus 81-bf]
pci 0000:80:00.0:   bridge window [io  disabled]
pci 0000:80:00.0:   bridge window [mem disabled]
pci 0000:80:00.0:   bridge window [mem pref disabled]
pci 0001:00:06.0: BAR 0: assigned [mem 0xd80000000-0xd83ffffff]
pci 0001:00:06.0: BAR 0: set to [mem 0xd80000000-0xd83ffffff] (PCI address [0x80000000-0x83ffffff])
pci 0001:00:06.0: BAR 1: assigned [mem 0xd84000000-0xd841fffff]
pci 0001:00:06.0: BAR 1: set to [mem 0xd84000000-0xd841fffff] (PCI address [0x84000000-0x841fffff])
pci_bus 0000:80: resource 0 [io  0xfffe0000-0xfffeffff]
pci_bus 0000:80: resource 1 [mem 0xe80000000-0xeffffffff]
pci_bus 0001:00: resource 0 [io  0x0000-0xffff]
pci_bus 0001:00: resource 1 [mem 0xd80000000-0xdffffffff]
bio: create slab <bio-0> at 0
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
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
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
PCI: CLS 0 bytes, default 32
irq: irq 1 on host /interrupt-controller1 mapped to virtual irq 20
irq: irq 1 on host /interrupt-controller0 mapped to virtual irq 21
Could not remap bcsr
irq: irq 29 on host /interrupt-controller0 mapped to virtual irq 29
irq: irq 6 on host /interrupt-controller2 mapped to virtual irq 22
irq: irq 7 on host /interrupt-controller2 mapped to virtual irq 23
irq: irq 3 on host /interrupt-controller2 mapped to virtual irq 24
irq: irq 4 on host /interrupt-controller2 mapped to virtual irq 25
irq: irq 5 on host /interrupt-controller2 mapped to virtual irq 26
irq: irq 29 on host /interrupt-controller2 mapped to virtual irq 27
irq: irq 30 on host /interrupt-controller2 mapped to virtual irq 28
irq: irq 28 on host /interrupt-controller2 mapped to virtual irq 31
irq: irq 26 on host /interrupt-controller1 mapped to virtual irq 32
irq: irq 12 on host /interrupt-controller0 mapped to virtual irq 33
irq: irq 0 on host /interrupt-controller3 mapped to virtual irq 34
irq: irq 5 on host /interrupt-controller3 mapped to virtual irq 35
irq: irq 6 on host /interrupt-controller1 mapped to virtual irq 36
irq: irq 2 on host /interrupt-controller0 mapped to virtual irq 37
irq: irq 3 on host /interrupt-controller0 mapped to virtual irq 38
irq: irq 16 on host /interrupt-controller2 mapped to virtual irq 39
irq: irq 20 on host /interrupt-controller2 mapped to virtual irq 40
irq: irq 17 on host /interrupt-controller2 mapped to virtual irq 41
irq: irq 21 on host /interrupt-controller2 mapped to virtual irq 42
irq: irq 2 on host /interrupt-controller3 mapped to virtual irq 43
setting trigger mode 3 for irq 43 failed (uic_set_irq_type+0x0/0x164)
setting trigger mode 3 for irq 43 failed (uic_set_irq_type+0x0/0x164)
highmem bounce pool size: 64 pages
JFS: nTxBlock = 8192, nTxLock = 65536
SGI XFS with ACLs, security attributes, large block/inode numbers, no debug enabled
Btrfs loaded
msgmni has been set to 1489
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4ef600300 (irq = 20) is a U6_16550A
console [ttyS0] enabled
serial8250.0: ttyS1 at MMIO 0x4ef600400 (irq = 21) is a U6_16550A
4ef600300.serial: ttyS0 at MMIO 0x4ef600300 (irq = 20) is a 16550
4ef600400.serial: ttyS1 at MMIO 0x4ef600400 (irq = 21) is a 16550
Generic non-volatile memory driver v1.1
brd: module loaded
loop: module loaded
sm501 0001:00:06.0: SM501 At f5480000: Version 050100c0, 64 Mb, IRQ 19
sm501 0001:00:06.0: setting M1XCLK to 144000000
sm501 0001:00:06.0: setting MCLK to 72000000
sm501-usb[0] [mem 0xd84040000-0xd8405ffff]
sm501-usb[1] [mem 0xd83fc0000-0xd83ffffff]
sm501-usb[2] [irq 19]
serial8250.10: ttyS2 at MMIO 0xd84030000 (irq = 19) is a ST16654
serial8250.10: ttyS3 at MMIO 0xd84030020 (irq = 19) is a ST16654
sm501-fb[0] [mem 0xd84080000-0xd8408ffff]
sm501-fb[1] [mem 0xd84100000-0xd8414ffff]
sm501-fb[2] [mem 0xd80000000-0xd83fbffff]
sm501-fb[3] [irq 19]
sm501-fb sm501-fb.80: fb sm501fb-crt disabled at start
sm501-fb sm501-fb.80: using mode specified in @mode
Console: switching to colour frame buffer device 100x37
sm501-fb sm501-fb.80: fb0: sm501fb-crt frame buffer
sm501-fb sm501-fb.80: fb sm501fb-panel enabled at start
sm501-fb sm501-fb.80: using mode specified in @mode
sm501-fb sm501-fb.80: fb1: sm501fb-panel frame buffer
sata-dwc 4bffd1000.sata: id 0, controller version 1.82
sata-dwc 4bffd1000.sata: DMA initialized
scsi0 : sata-dwc
ata1: SATA max UDMA/133 irq 34
PPC 4xx OCP EMAC driver, version 3.54
MAL v2 /plb/mcmal, 2 TX channels, 16 RX channels
ZMII /plb/opb/emac-zmii@ef600d00 initialized
RGMII /plb/opb/emac-rgmii@ef601500 initialized with MDIO support
TAH /plb/opb/emac-tah@ef601350 initialized
TAH /plb/opb/emac-tah@ef601450 initialized
/plb/opb/emac-rgmii@ef601500: input 0 in RGMII mode
eth0: EMAC-0 /plb/opb/ethernet@ef600e00, MAC 00:50:c2:80:d4:89
eth0: found Generic MII PHY (0x00)
/plb/opb/emac-rgmii@ef601500: input 1 in RGMII mode
eth1: EMAC-1 /plb/opb/ethernet@ef600f00, MAC 00:00:00:00:00:00
eth1: found Generic MII PHY (0x01)
usbmon: debugfs is not available
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ppc-of-ehci 4bffd0400.ehci: OF EHCI
ppc-of-ehci 4bffd0400.ehci: new USB bus registered, assigned bus number 1
ppc-of-ehci 4bffd0400.ehci: irq 27, io mem 0x4bffd0400
ppc-of-ehci 4bffd0400.ehci: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: OF EHCI
usb usb1: Manufacturer: Linux 3.0.19 ehci_hcd
usb usb1: SerialNumber: PPC-OF USB
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
mousedev: PS/2 mouse device common for all mice
i2c /dev entries driver
ibm-iic 4ef600700.i2c: using standard (100 kHz) mode
irq: irq 25 on host /interrupt-controller2 mapped to virtual irq 44
rtc-m41t80 0-0068: chip found, driver version 0.05
rtc-m41t80 0-0068: rtc core: registered m41t80 as rtc0
irq: irq 20 on host /interrupt-controller1 mapped to virtual irq 45
ibm-iic 4ef600800.i2c: using standard (100 kHz) mode
booke_wdt: powerpc book-e watchdog driver loaded
device-mapper: ioctl: 4.20.0-ioctl (2011-02-02) initialised: dm-devel@redhat.com
usbcore: registered new interface driver ushc
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
TCP cubic registered
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Registering the dns_resolver key type
rtc-m41t80 0-0068: setting system clock to 2012-02-04 16:53:29 UTC (1328374409)
usb 1-1: new high speed USB device number 2 using ppc-of-ehci
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-8: WDC WD5000AAKX-001CA0, 15.01H15, max UDMA/133
ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 1/32)
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      WDC WD5000AAKX-0 15.0 PQ: 0 ANSI: 5
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
usb 1-1: New USB device found, idVendor=0424, idProduct=2517
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
hub 1-1:1.0: USB hub found
 sda: RDSK (512) sda1 (LNX^@)(res 2 spb 1) sda2 (LNX^@)(res 2 spb 1) sda3 (LNX^@)(res 2 spb 1) sda4 (LNX^@)(res 2 spb 1)
hub 1-1:1.0: 7 ports detected
sd 0:0:0:0: [sda] Attached SCSI disk
REISERFS (device sda3): found reiserfs format "3.6" with standard journal
REISERFS (device sda3): using ordered data mode
REISERFS (device sda3): journal params: device sda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
REISERFS (device sda3): checking transaction log (sda3)
REISERFS (device sda3): Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly on device 8:3.
devtmpfs: mounted
Freeing unused kernel memory: 196k init
usb 1-1.1: new low speed USB device number 3 using ppc-of-ehci
usb 1-1.1: New USB device found, idVendor=062a, idProduct=0102
usb 1-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-1.1: Product: Wireless Keyboard & Mouse
usb 1-1.1: Manufacturer: MOSART Semi.
input: MOSART Semi. Wireless Keyboard & Mouse as /devices/plb.0/4bffd0400.ehci/usb1/1-1/1-1.1/1-1.1:1.0/input/input0
generic-usb 0003:062A:0102.0001: input,hidraw0: USB HID v1.10 Keyboard [MOSART Semi. Wireless Keyboard & Mouse] on usb-PPC-OF USB-1.1/input0
input: MOSART Semi. Wireless Keyboard & Mouse as /devices/plb.0/4bffd0400.ehci/usb1/1-1/1-1.1/1-1.1:1.1/input/input1
generic-usb 0003:062A:0102.0002: input,hiddev0,hidraw1: USB HID v1.10 Mouse [MOSART Semi. Wireless Keyboard & Mouse] on usb-PPC-OF USB-1.1/input1
usb 1-1.7: new high speed USB device number 4 using ppc-of-ehci
usb 1-1.7: New USB device found, idVendor=0424, idProduct=2240
usb 1-1.7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1.7: Product: Ultra Fast Media
usb 1-1.7: Manufacturer: Generic
usb 1-1.7: SerialNumber: 000000225001
scsi1 : usb-storage 1-1.7:1.0
udevd[55]: starting version 175
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
sm501-usb sm501-usb.80: cannot declare coherent memory
Unable to handle kernel paging request for data at address 0xf543bfb4
Faulting instruction address: 0xc00003f0
Oops: Kernel access of bad area, sig: 11 [#1]
Canyonlands
Modules linked in: ohci_hcd(+)
NIP: c00003f0 LR: c000bd58 CTR: f54710cc
REGS: f543bf1c TRAP: 0300   Not tainted  (3.0.19)
MSR: 00021000 <ME,CE>  CR: 24004422  XER: 00000001
DEAR: f543bfb4, ESR: 00800000
TASK = ef102d60[77] 'modprobe' THREAD: ef172000
GPR00: c000bd58 ef102f30 ef102d60 f547101c 838bfff0 00000000 c02d276c ef221000
GPR08: 00002284 c000bf58 24004422 f543bf0c ef102f30 10024440 1000ba68 00000000
GPR16: 1000ba44 bfcbe4a4 00000000 1000ba58 00000000 1061f354 00000a60 00000000
GPR24: c004ca18 00000124 00000022 82cbffd8 82ebffdc 830bffe0 832bffe4 834bffe8
NIP [c00003f0] DataStorage+0x30/0xc0
LR [c000bd58] handle_page_fault+0xc/0x80
Call Trace:
Instruction dump:
7d5043a6 7d7143a6 7c3443a6 7d400026 7d7b02a6 716b4000 41820010 7c3342a6
8021fe34 38212000 3821ff40 7c2b0b78 <914b00a8> 918b0040 912b0034 7d5042a6
---[ end trace 8b79cce2f3ca8696 ]---
scsi 1:0:0:0: Direct-Access     Generic  Ultra HS-COMBO   1.68 PQ: 0 ANSI: 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
sd 1:0:0:0: [sdb] Attached SCSI removable disk
ad7414 0-0048: chip found
ad7414 0-0048: ad7414_probe unable to read config register.
REISERFS (device sda4): found reiserfs format "3.6" with standard journal
REISERFS (device sda4): using ordered data mode
REISERFS (device sda4): journal params: device sda4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
REISERFS (device sda4): checking transaction log (sda4)
REISERFS (device sda4): Using r5 hash to sort names
Adding 626528k swap on /dev/sda2.  Priority:-1 extents:1 across:626528k
eth0: link is up, 100 FDX, pause enabled
ata1.00: configured for UDMA/133
ata1: EH complete
eth0: no IPv6 routers present

-- 
acrux <acrux@cruxppc.org>
