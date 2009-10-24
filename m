Return-Path: <wilbur512@gmail.com>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 6F76DB7BCA
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Oct 2009 18:25:24 +1100 (EST)
Received: by yxe8 with SMTP id 8so9409262yxe.17
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Oct 2009 00:25:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAEDEFF6-55D3-43AA-BA6C-92D14CBA8A79@kernel.crashing.org>
References: <e997b7420910220708i63b85ca1n256f332ddc6819c1@mail.gmail.com>
	<CAEDEFF6-55D3-43AA-BA6C-92D14CBA8A79@kernel.crashing.org>
Date: Sat, 24 Oct 2009 15:25:22 +0800
Message-ID: <e997b7420910240025j59361f09oea3b4df67d8dac68@mail.gmail.com>
Subject: Re: How to mount rootfs though harddisk when booting?
From: "wilbur.chan" <wilbur512@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2009/10/22 Kumar Gala <galak@kernel.crashing.org>:
> Post the full kernel boot log.
>
> - k
>

And this is the booting log of freescale linux kernel, which
successfully mount the sata disk (sda3) as the rootfs:


Using P2020 DS machine description
Memory CAM mapping: CAM0=256Mb, CAM1=256Mb, CAM2=256Mb residual: 1280Mb
Linux version 2.6.28.1-00295-g6dbbaa6-dirty (ted@xeon2) (gcc version 4.2.3 (Sour
cery G++ Lite 4.2-171)) #1 SMP Thu Mar 5 14:31:02 CST 2009
CPU maps initialized for 1 thread per core
console [udbg0] enabled
setup_arch: bootmem
mpc85xx_ds_setup_arch()
Found FSL PCI host bridge at 0x00000000ffe09000. Firmware bus number: 0->2
PCI host bridge /pcie@ffe09000 (primary) ranges:
 MEM 0x00000000a0000000..0x00000000bfffffff -> 0x00000000a0000000
  IO 0x00000000ffc10000..0x00000000ffc1ffff -> 0x0000000000000000
Found FSL PCI host bridge at 0x00000000ffe08000. Firmware bus number: 0->0
PCI host bridge /pcie@ffe08000  ranges:
 MEM 0x0000000080000000..0x000000009fffffff -> 0x0000000080000000
  IO 0x00000000ffc00000..0x00000000ffc0ffff -> 0x0000000000000000
Found FSL PCI host bridge at 0x00000000ffe0a000. Firmware bus number: 0->0
PCI host bridge /pcie@ffe0a000  ranges:
 MEM 0x00000000c0000000..0x00000000dfffffff -> 0x00000000c0000000
  IO 0x00000000ffc20000..0x00000000ffc2ffff -> 0x0000000000000000
MPC85xx DS board from Freescale Semiconductor
arch: exit
Zone PFN ranges:
  DMA      0x00000000 -> 0x00030000
  Normal   0x00030000 -> 0x00030000
  HighMem  0x00030000 -> 0x00080000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00080000
MMU: Allocated 1088 bytes of context maps for 255 contexts
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 520192
Kernel command line: root=/dev/sda3 rw console=ttyS0,115200
mpic: Setting up MPIC " OpenPIC  " version 1.2 at ffe40000, max 2 CPUs
mpic: ISU size: 256, shift: 8, mask: ff
mpic: Initializing for 256 sources
i8259 legacy interrupt controller initialized
PID hash table entries: 4096 (order: 12, 16384 bytes)
clocksource: timebase mult[400029f] shift[22] registered
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2073196k/2097152k available (5300k kernel code, 23088k reserved, 168k da
ta, 186k bss, 220k init)
SLUB: Genslabs=12, HWalign=32, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
Calibrating delay loop... 124.67 BogoMIPS (lpj=249344)
Mount-cache hash table entries: 512
mpic: requesting IPIs ...
Processor 1 found.
Brought up 2 CPUs
net_namespace: 496 bytes
NET: Registered protocol family 16

PCI: Probing PCI hardware
pci 0000:00:00.0: ignoring class b20 (doesn't match header type 01)
pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:00.0: PME# disabled
pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
pci 0000:01:00.0: PME# disabled
pci 0000:02:1c.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:02:1c.0: PME# disabled
pci 0000:02:1c.1: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:02:1c.1: PME# disabled
pci 0000:02:1c.2: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:02:1c.2: PME# disabled
pci 0000:02:1c.3: PME# supported from D0 D3hot D3cold
pci 0000:02:1c.3: PME# disabled
pci 0000:02:1f.1: PME# supported from D3hot
pci 0000:02:1f.1: PME# disabled
pci 0000:01:00.0: transparent bridge
pci 0001:03:00.0: ignoring class b20 (doesn't match header type 01)
pci 0001:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0001:03:00.0: PME# disabled
pci 0002:05:00.0: ignoring class b20 (doesn't match header type 01)
pci 0002:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0002:05:00.0: PME# disabled
pci 0000:01:00.0: PCI bridge, secondary bus 0000:02
pci 0000:01:00.0:   IO window: 0x1000-0x1fff
pci 0000:01:00.0:   MEM window: 0xa0000000-0xa00fffff
pci 0000:01:00.0:   PREFETCH window: disabled
pci 0000:00:00.0: PCI bridge, secondary bus 0000:01
pci 0000:00:00.0:   IO window: 0x00-0xffff
pci 0000:00:00.0:   MEM window: 0xa0000000-0xbfffffff
pci 0000:00:00.0:   PREFETCH window: disabled
pci 0000:00:00.0: enabling device (0106 -> 0107)
pci 0001:03:00.0: PCI bridge, secondary bus 0001:04
pci 0001:03:00.0:   IO window: 0x00-0xffff
pci 0001:03:00.0:   MEM window: 0x80000000-0x9fffffff
pci 0001:03:00.0:   PREFETCH window: disabled
pci 0001:03:00.0: enabling device (0106 -> 0107)
pci 0002:05:00.0: PCI bridge, secondary bus 0002:06
pci 0002:05:00.0:   IO window: 0x00-0xffff
pci 0002:05:00.0:   MEM window: 0xc0000000-0xdfffffff
pci 0002:05:00.0:   PREFETCH window: disabled
pci 0002:05:00.0: enabling device (0106 -> 0107)
bus: 00 index 0 io port: [0x00-0xffff]
bus: 00 index 1 mmio: [0xa0000000-0xbfffffff]
bus: 01 index 0 io port: [0x00-0xffff]
bus: 01 index 1 mmio: [0xa0000000-0xbfffffff]
bus: 01 index 2 mmio: [0x0-0x0]
bus: 01 index 3 mmio: [0x0-0x0]
bus: 02 index 0 io port: [0x1000-0x1fff]
bus: 02 index 1 mmio: [0xa0000000-0xa00fffff]
bus: 02 index 2 mmio: [0x0-0x0]
bus: 02 index 3 io port: [0x00-0xffff]
bus: 02 index 4 mmio: [0xa0000000-0xbfffffff]
bus: 02 index 5 mmio: [0x0-0x0]
bus: 02 index 6 mmio: [0x0-0x0]
bus: 03 index 0 io port: [0xfffee000-0xffffdfff]
bus: 03 index 1 mmio: [0x80000000-0x9fffffff]
bus: 04 index 0 io port: [0xfffee000-0xffffdfff]
bus: 04 index 1 mmio: [0x80000000-0x9fffffff]
bus: 04 index 2 mmio: [0x0-0x0]
bus: 04 index 3 mmio: [0x0-0x0]
bus: 05 index 0 io port: [0xfffdc000-0xfffebfff]
bus: 05 index 1 mmio: [0xc0000000-0xdfffffff]
bus: 06 index 0 io port: [0xfffdc000-0xfffebfff]
bus: 06 index 1 mmio: [0xc0000000-0xdfffffff]
bus: 06 index 2 mmio: [0x0-0x0]
bus: 06 index 3 mmio: [0x0-0x0]
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
NET: Registered protocol family 1
mpc85xx_spi_init >>
audit: initializing netlink socket (disabled)
type=2000 audit(0.720:1): initialized
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.29 [Flags: R/O].
msgmni has been set to 1490
alg: No test for cipher_null (cipher_null-generic)
alg: No test for digest_null (digest_null-generic)
alg: No test for compress_null (compress_null-generic)
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Generic non-volatile memory driver v1.1
Serial: 8250/16550 driver2 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0xffe04500 (irq = 42) is a 16550A
                                                             console handover: b
oot [udbg0] -> real [ttyS0]
serial8250.0: ttyS1 at MMIO 0xffe04600 (irq = 42) is a 16550A
brd: module loaded
loop: module loaded
nbd: registered device at major 43
e1000e: Intel(R) PRO/1000 Network Driver - 0.3.3.3-k6
e1000e: Copyright (c) 1999-2008 Intel Corporation.
Gianfar MII Bus: probed
Gianfar MII Bus: probed
Gianfar MII Bus: probed
eth0: Gianfar Ethernet Controller Version 1.2, 00:e0:0c:02:00:fd
eth0: Running with NAPI enabled
eth0: 256/256 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.2, 00:e0:0c:02:01:fd
eth1: Running with NAPI enabled
eth1: 256/256 RX/TX BD ring size
eth2: Gianfar Ethernet Controller Version 1.2, 00:e0:0c:02:02:fd
eth2: Running with NAPI enabled
eth2: 256/256 RX/TX BD ring size
sky2 driver version 1.22
st: Version 20080504, fixed bufsize 32768, s/g segs 256
Driver 'st' needs updating - please use bus_type methods
Driver 'sd' needs updating - please use bus_type methods
Driver 'sr' needs updating - please use bus_type methods
ahci 0000:02:1f.1: AHCI 0001.0000 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:02:1f.1: flags: ncq sntf ilck pm led clo pmp pio slum part
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
ata1: SATA max UDMA/133 abar m1024@0xa0003400 port 0xa0003500 irq 18
ata2: SATA max UDMA/133 abar m1024@0xa0003400 port 0xa0003580 irq 18
ata3: SATA max UDMA/133 abar m1024@0xa0003400 port 0xa0003600 irq 18
ata4: SATA max UDMA/133 abar m1024@0xa0003400 port 0xa0003680 irq 18
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-8: Hitachi HDP725016GLA380, GMBOA52A, max UDMA/133
ata1.00: 312581808 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/133
ata2: SATA link down (SStatus 0 SControl 300)
ata3: SATA link down (SStatus 0 SControl 300)
ata4: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      Hitachi HDP72501 GMBO PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors: (160 GB/149 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO
 or FUA
sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors: (160 GB/149 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO
 or FUA
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi4 : pata_ali
scsi5 : pata_ali
ata5: PATA max UDMA/133 cmd 0x1000 ctl 0x1008 bmdma 0x1020 irq 14
ata6: PATA max UDMA/133 cmd 0x1010 ctl 0x1018 bmdma 0x1028 irq 14
fsl_m25p80 spi28672.0: s25sl128b (16384 Kbytes)
fsl_espi.0: Freescale eSPI Controller driver at 0xf1094000 (irq = 59)
usbmon: debugfs is not available
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 1
fsl-ehci fsl-ehci.0: irq 28, io base 0xffe22000
fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
ehci_hcd 0000:02:1c.3: Found HC with no IRQ.  Check BIOS/PCI 0000:02:1c.3 setup!
ehci_hcd 0000:02:1c.3: init 0000:02:1c.3 fail, -19
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci_hcd 0000:02:1c.0: Found HC with no IRQ.  Check BIOS/PCI 0000:02:1c.0 setup!
ohci_hcd 0000:02:1c.0: init 0000:02:1c.0 fail, -19
ohci_hcd 0000:02:1c.1: Found HC with no IRQ.  Check BIOS/PCI 0000:02:1c.1 setup!
ohci_hcd 0000:02:1c.1: init 0000:02:1c.1 fail, -19
ohci_hcd 0000:02:1c.2: Found HC with no IRQ.  Check BIOS/PCI 0000:02:1c.2 setup!
ohci_hcd 0000:02:1c.2: init 0000:02:1c.2 fail, -19
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
i8042.c: No controller found.
rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one day, 114 bytes nvram
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
Advanced Linux Sound Architecture Driver Version 1.0.18rc3.
ALSA device list:
  No soundcards found.
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
rtc_cmos rtc_cmos: setting system clock to 1970-06-23 12:08:10 UTC (14990890)
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: mounting unchecked fs, running e2fsck is recommended
EXT3 FS on sda3, internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem).
Freeing unused kernel memory: 220k init
Mounting /proc and /sys
Starting the hotplug events dispatcher udevd
Synthesizing initial hotplug events
Setting the hostname to p2020ds
Running depmod
WARNING: Couldn't open directory /lib/modules/2.6.28.1-00295-g6dbbaa6-dirty: No
such file or directory
FATAL: Could not open /lib/modules/2.6.28.1-00295-g6dbbaa6-dirty/modules.dep.tem
p for writing: No such file or directory
Mounting filesystems
Starting syslogd and klogd
Running sysctl
Setting up networking on loopback device:
Setting up networking on eth0:
ADDRCONF(NETDEV_UP): eth0: link is not ready
Adding static route for default gateway to 192.168.1.1:
Setting nameserver to 192.168.1.1 in /etc/resolvADDRCONF(NETDEV_UP): eth1: link
is not ready
.conf:
Setting up networking on eth1:
Adding static route for default gateway to 192.168.1.1:
Setting nameserver to 192.168.1.1 in /etc/resolv.conf:
Starting inetd:
Starting the port mapper:
Setting time from ntp server:
/bin/ntpclient: option requires an argument -- h
Usage: /bin/ntpclient [-c count] [-d] [-g goodness] -h hostname [-i interval]
        [-l] [-p port] [-r] [-s]


        Welcome to Freescale Semiconductor Embedded Linux Environment

!!!!! WARNING !!!!!!!

The default password for the root account is: root
please change this password using the 'passwd' command
and then edit this message (/etc/issue) to remove this message

p2020ds login: PHY: mdio@24520:00 - Link is Up - 100/Full
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
