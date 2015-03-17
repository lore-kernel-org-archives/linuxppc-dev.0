Return-Path: <bobby.prani@gmail.com>
Received: from mail-vc0-x229.google.com (mail-vc0-x229.google.com
 [IPv6:2607:f8b0:400c:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D7F01A0A05
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2015 07:08:25 +1100 (AEDT)
Received: by mail-vc0-f169.google.com with SMTP id kv7so4782993vcb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 13:08:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5508887B.8080008@hurleysoftware.com>
References: <CAJhHMCC+BJWBo3=XbLf2L_kpOTqR==ee667+TpnFdk3DRT3o+Q@mail.gmail.com>
 <CAJhHMCBcyVbNRQSpsyVfk8HMzZ=NXKkknjDRuch+e+yJGB3T5Q@mail.gmail.com>
 <1426493810.4716.0.camel@ellerman.id.au>
 <CAJhHMCC06H-BRFBBcD_PfumyvHoFAjbi_MOn7gSeq5y093FSEQ@mail.gmail.com>
 <1426548151.31646.4.camel@ellerman.id.au>
 <CAJhHMCDCoo7g5WrXKPEbemoChQn6BGZOXD00z4kZqVE5boEBhA@mail.gmail.com>
 <55079859.1020205@hurleysoftware.com>
 <CAJhHMCBzFfKxubMLkrSwCwqs5q494-kD2=a_n+tGHXAp6qgXDg@mail.gmail.com>
 <55079D05.8020302@hurleysoftware.com>
 <CAJhHMCDNRCUY-H_DzrDf+9LYZOiiEVLW_f7ygp6mRKx-ho7OeA@mail.gmail.com>
 <5508887B.8080008@hurleysoftware.com>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Tue, 17 Mar 2015 16:07:52 -0400
Message-ID: <CAJhHMCDWJZR0rgfMzNKX=btMPCmFfBH-WU0fY3oo0G8TtpdSBA@mail.gmail.com>
Subject: Re: linux panic on 4.0.0-rc4
To: Peter Hurley <peter@hurleysoftware.com>
Content-Type: text/plain; charset=UTF-8
Cc: "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 17, 2015 at 4:03 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>
> Can you send me a complete dmesg capture from a boot with
> this commit reverted?
>

Here it is. Let me know if you want any boot options enabled. I
removed both debug and verbose boot options.

[    0.000000] Using PowerMac machine description
[    0.000000] Total memory = 1024MB; using 2048kB for hash table (at cfe00000)
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.0.0-rc4+ (pranith@macmini) (gcc version
4.9.2 (Debian 4.9.2-10) ) #67 Tue Mar 17 12:40:16 EDT 2015
[    0.000000] Found initrd at 0xc1300000:0xc1692000
[    0.000000] Found UniNorth memory controller & host bridge @
0xf8000000 revision: 0xd2
[    0.000000] Mapped at 0xff7c0000
[    0.000000] Found a Intrepid mac-io controller, rev: 0, mapped at 0xff740000
[    0.000000] Processor NAP mode on idle enabled.
[    0.000000] PowerMac motherboard: Mac mini (Late 2005)
[    0.000000] bootconsole [udbg0] enabled
[    0.000000] Found UniNorth PCI host bridge at 0x00000000f0000000.
Firmware bus number: 0->0
[    0.000000] PCI host bridge /pci@f0000000  ranges:
[    0.000000]  MEM 0x00000000f1000000..0x00000000f1ffffff -> 0x00000000f1000000
[    0.000000]   IO 0x00000000f0000000..0x00000000f07fffff -> 0x0000000000000000
[    0.000000]  MEM 0x0000000090000000..0x000000009fffffff -> 0x0000000090000000
[    0.000000] Found UniNorth PCI host bridge at 0x00000000f2000000.
Firmware bus number: 0->0
[    0.000000] PCI host bridge /pci@f2000000 (primary) ranges:
[    0.000000]  MEM 0x00000000f3000000..0x00000000f3ffffff -> 0x00000000f3000000
[    0.000000]   IO 0x00000000f2000000..0x00000000f27fffff -> 0x0000000000000000
[    0.000000]  MEM 0x0000000080000000..0x000000008fffffff -> 0x0000000080000000
[    0.000000] Found UniNorth PCI host bridge at 0x00000000f4000000.
Firmware bus number: 0->0
[    0.000000] PCI host bridge /pci@f4000000  ranges:
[    0.000000]  MEM 0x00000000f5000000..0x00000000f5ffffff -> 0x00000000f5000000
[    0.000000]   IO 0x00000000f4000000..0x00000000f47fffff -> 0x0000000000000000
[    0.000000] via-pmu: Server Mode is disabled
[    0.000000] PMU driver v2 initialized for Core99, firmware: 55
[    0.000000] Top of RAM: 0x40000000, Total RAM: 0x40000000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x000000002fffffff]
[    0.000000]   Normal   empty
[    0.000000]   HighMem  [mem 0x0000000030000000-0x000000003fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000003fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000003fffffff]
[    0.000000] On node 0 totalpages: 262144
[    0.000000] free_area_init_node: node 0, pgdat c05a4a64,
node_mem_map ef6e3000
[    0.000000]   DMA zone: 1728 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 196608 pages, LIFO batch:31
[    0.000000]   HighMem zone: 65536 pages, LIFO batch:15
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 260416
[    0.000000] Kernel command line:
root=UUID=7252209a-6106-41c2-90a3-45b85ac47837 ro video=radeonfb:off
video=offb:off radeon.modeset=1 radeon.agpmode=-1
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 1026292K/1048576K available (3980K kernel code,
212K rwdata, 1384K rodata, 240K init, 294K bss, 22284K reserved, 0K
cma-reserved, 262144K highmem)
[    0.000000] Kernel virtual memory layout:
[    0.000000]   * 0xfffcf000..0xfffff000  : fixmap
[    0.000000]   * 0xff800000..0xffc00000  : highmem PTEs
[    0.000000]   * 0xfdde4000..0xff800000  : early ioremap
[    0.000000]   * 0xf1000000..0xfdde4000  : vmalloc & ioremap
[    0.000000] NR_IRQS:512 nr_irqs:512 16
[    0.000000] mpic: Resetting
[    0.000000] mpic: Setting up MPIC " MPIC 1   " version 1.2 at
80040000, max 1 CPUs
[    0.000000] mpic: ISU size: 64, shift: 6, mask: 3f
[    0.000000] mpic: Initializing for 64 sources
[    0.000000] time_init: decrementer frequency = 41.600571 MHz
[    0.000000] time_init: processor frequency   = 1333.333328 MHz
[    0.000008] clocksource: timebase mult[1809c2fe] shift[24] registered
[    0.000394] clockevent: decrementer mult[aa655c4] shift[32] cpu[0]
[    0.000647] Console: colour dummy device 80x25
[    0.000998] console [tty0] enabled
[    0.001333] bootconsole [udbg0] disabled
[    0.001859] pid_max: default: 32768 minimum: 301
[    0.001902] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.001913] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.002312] Initializing cgroup subsys blkio
[    0.002330] Initializing cgroup subsys memory
[    0.002357] Initializing cgroup subsys devices
[    0.002367] Initializing cgroup subsys freezer
[    0.002379] Initializing cgroup subsys net_cls
[    0.002391] Initializing cgroup subsys perf_event
[    0.002554] MPC7450 family performance monitor hardware support registered
[    0.003094] devtmpfs: initialized
[    0.004054] device-tree: Duplicate name in PowerPC,G4@0, renamed to
"l2-cache#1"
[    0.008227] NET: Registered protocol family 16
[    0.009172] KeyWest i2c @0xf8001003 irq 42 /uni-n@f8000000/i2c@f8001000
[    0.009186]  channel 0 bus <multibus>
[    0.009193]  channel 1 bus <multibus>
[    0.009296] KeyWest i2c @0x80018000 irq 26 /pci@f2000000/mac-io@17/i2c@18000
[    0.009307]  channel 0 bus <multibus>
[    0.009332] PMU i2c /pci@f2000000/mac-io@17/via-pmu@16000/pmu-i2c
[    0.009341]  channel 1 bus <multibus>
[    0.009348]  channel 2 bus <multibus>
[    0.009779] PCI: Probing PCI hardware
[    0.009931] PCI host bridge to bus 0000:00
[    0.009952] pci_bus 0000:00: root bus resource [io
0x802000-0x1001fff] (bus address [0x0000-0x7fffff])
[    0.009971] pci_bus 0000:00: root bus resource [mem 0xf1000000-0xf1ffffff]
[    0.009985] pci_bus 0000:00: root bus resource [mem 0x90000000-0x9fffffff]
[    0.009999] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.010014] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to ff
[    0.010043] pci 0000:00:0b.0: [106b:0034] type 00 class 0x060000
[    0.010224] pci 0000:00:10.0: [1002:5962] type 00 class 0x030000
[    0.010243] pci 0000:00:10.0: reg 0x10: [mem 0x98000000-0x9fffffff pref]
[    0.010253] pci 0000:00:10.0: reg 0x14: [io  0x802400-0x8024ff]
[    0.010263] pci 0000:00:10.0: reg 0x18: [mem 0x90000000-0x9000ffff]
[    0.010286] pci 0000:00:10.0: reg 0x30: [mem 0x90020000-0x9003ffff pref]
[    0.010319] pci 0000:00:10.0: supports D1 D2
[    0.010544] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
[    0.010669] PCI host bridge to bus 0001:10
[    0.010684] pci_bus 0001:10: root bus resource [io  0x0000-0x7fffff]
[    0.010697] pci_bus 0001:10: root bus resource [mem 0xf3000000-0xf3ffffff]
[    0.010711] pci_bus 0001:10: root bus resource [mem 0x80000000-0x8fffffff]
[    0.010725] pci_bus 0001:10: root bus resource [bus 10-ff]
[    0.010738] pci_bus 0001:10: busn_res: [bus 10-ff] end is updated to ff
[    0.010759] pci 0001:10:0b.0: [106b:0035] type 00 class 0x060000
[    0.010936] pci 0001:10:17.0: [106b:003e] type 00 class 0xff0000
[    0.010951] pci 0001:10:17.0: reg 0x10: [mem 0x80000000-0x8007ffff]
[    0.011121] pci 0001:10:18.0: [106b:003f] type 00 class 0x0c0310
[    0.011135] pci 0001:10:18.0: reg 0x10: [mem 0x00000000-0x00000fff]
[    0.011292] pci 0001:10:19.0: [106b:003f] type 00 class 0x0c0310
[    0.011307] pci 0001:10:19.0: reg 0x10: [mem 0x00000000-0x00000fff]
[    0.011454] pci 0001:10:1a.0: [106b:003f] type 00 class 0x0c0310
[    0.011468] pci 0001:10:1a.0: reg 0x10: [mem 0x80083000-0x80083fff]
[    0.011626] pci 0001:10:1b.0: [1033:0035] type 00 class 0x0c0310
[    0.011643] pci 0001:10:1b.0: reg 0x10: [mem 0x80082000-0x80082fff]
[    0.011696] pci 0001:10:1b.0: supports D1 D2
[    0.011702] pci 0001:10:1b.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.011857] pci 0001:10:1b.1: [1033:0035] type 00 class 0x0c0310
[    0.011873] pci 0001:10:1b.1: reg 0x10: [mem 0x80081000-0x80081fff]
[    0.011926] pci 0001:10:1b.1: supports D1 D2
[    0.011931] pci 0001:10:1b.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.012083] pci 0001:10:1b.2: [1033:00e0] type 00 class 0x0c0320
[    0.012099] pci 0001:10:1b.2: reg 0x10: [mem 0x80080000-0x800800ff]
[    0.012152] pci 0001:10:1b.2: supports D1 D2
[    0.012157] pci 0001:10:1b.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.012390] pci_bus 0001:10: busn_res: [bus 10-ff] end is updated to 10
[    0.012506] PCI host bridge to bus 0002:20
[    0.012524] pci_bus 0002:20: root bus resource [io
0xff7fe000-0xffffdfff] (bus address [0x0000-0x7fffff])
[    0.012542] pci_bus 0002:20: root bus resource [mem 0xf5000000-0xf5ffffff]
[    0.012556] pci_bus 0002:20: root bus resource [bus 20-ff]
[    0.012569] pci_bus 0002:20: busn_res: [bus 20-ff] end is updated to ff
[    0.012591] pci 0002:20:0b.0: [106b:0036] type 00 class 0x060000
[    0.012754] pci 0002:20:0d.0: [106b:003b] type 00 class 0xff0000
[    0.012766] pci 0002:20:0d.0: reg 0x10: [mem 0xf5004000-0xf5007fff]
[    0.012911] pci 0002:20:0e.0: [106b:0031] type 00 class 0x0c0010
[    0.012925] pci 0002:20:0e.0: reg 0x10: [mem 0xf5000000-0xf5000fff]
[    0.012964] pci 0002:20:0e.0: supports D1 D2
[    0.012970] pci 0002:20:0e.0: PME# supported from D0 D1 D2 D3hot
[    0.013117] pci 0002:20:0f.0: [106b:0032] type 00 class 0x020000
[    0.013131] pci 0002:20:0f.0: reg 0x10: [mem 0xf5200000-0xf53fffff]
[    0.013160] pci 0002:20:0f.0: reg 0x30: [mem 0xf5100000-0xf51fffff pref]
[    0.013352] pci_bus 0002:20: busn_res: [bus 20-ff] end is updated to 20
[    0.013414] PCI 0000:00 Cannot reserve Legacy IO [io  0x802000-0x802fff]
[    0.013429] pci_bus 0000:00: resource 4 [io  0x802000-0x1001fff]
[    0.013435] pci_bus 0000:00: resource 5 [mem 0xf1000000-0xf1ffffff]
[    0.013440] pci_bus 0000:00: resource 6 [mem 0x90000000-0x9fffffff]
[    0.013449] pci_bus 0001:10: resource 4 [io  0x0000-0x7fffff]
[    0.013455] pci_bus 0001:10: resource 5 [mem 0xf3000000-0xf3ffffff]
[    0.013461] pci_bus 0001:10: resource 6 [mem 0x80000000-0x8fffffff]
[    0.013468] pci_bus 0002:20: resource 4 [io  0xff7fe000-0xffffdfff]
[    0.013474] pci_bus 0002:20: resource 5 [mem 0xf5000000-0xf5ffffff]
[    0.016908] vgaarb: device added:
PCI:0000:00:10.0,decodes=io+mem,owns=mem,locks=none
[    0.016939] vgaarb: loaded
[    0.016947] vgaarb: bridge control possible 0000:00:10.0
[    0.017285] SCSI subsystem initialized
[    0.017395] libata version 3.00 loaded.
[    0.017468] pps_core: LinuxPPS API ver. 1 registered
[    0.017480] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.017509] PTP clock support registered
[    0.018107] Switched to clocksource timebase
[    0.023597] NET: Registered protocol family 2
[    0.024136] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.024199] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
[    0.024253] TCP: Hash tables configured (established 8192 bind 8192)
[    0.024376] TCP: reno registered
[    0.024391] UDP hash table entries: 512 (order: 1, 8192 bytes)
[    0.024414] UDP-Lite hash table entries: 512 (order: 1, 8192 bytes)
[    0.024658] NET: Registered protocol family 1
[    0.024731] Apple USB OHCI 0001:10:18.0 disabled by firmware
[    0.024748] pci 0001:10:18.0: Can't enable PCI device, BIOS handoff failed.
[    0.024764] Apple USB OHCI 0001:10:19.0 disabled by firmware
[    0.024776] pci 0001:10:19.0: Can't enable PCI device, BIOS handoff failed.
[    0.024799] pci 0001:10:1a.0: enabling device (0000 -> 0002)
[    0.088154] pci 0001:10:1b.0: enabling device (0000 -> 0002)
[    0.148120] pci 0001:10:1b.1: enabling device (0000 -> 0002)
[    0.208119] pci 0001:10:1b.2: enabling device (0004 -> 0006)
[    0.208157] PCI: CLS mismatch (32 != 1020), using 32 bytes
[    0.208306] Unpacking initramfs...
[    0.340122] Freeing initrd memory: 3656K (c1300000 - c1692000)
[    0.340497] Thermal assist unit not available
[    0.341193] futex hash table entries: 256 (order: -1, 3072 bytes)
[    0.341250] audit: initializing netlink subsys (disabled)
[    0.341309] audit: type=2000 audit(1426614345.330:1): initialized
[    0.341757] zpool: loaded
[    0.341886] VFS: Disk quotas dquot_6.5.2
[    0.341920] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.342436] bounce: pool size: 64 pages
[    0.342480] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 251)
[    0.342576] io scheduler noop registered
[    0.342592] io scheduler deadline registered
[    0.342612] io scheduler cfq registered (default)
[    0.343269] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.344448] pmac_zilog: 0.6 (Benjamin Herrenschmidt
<benh@kernel.crashing.org>)
[    0.344575] Serial: MPC52xx PSC UART driver
[    0.344626] Linux agpgart interface v0.103
[    0.344665] agpgart-uninorth 0000:00:0b.0: Apple UniNorth 2 chipset
[    0.345705] agpgart-uninorth 0000:00:0b.0: configuring for size idx: 64
[    0.345814] agpgart-uninorth 0000:00:0b.0: AGP aperture is 256M @ 0x0
[    0.346051] MacIO PCI driver attached to Intrepid chipset
[    0.347005] 0.00013020:ch-a: ttyPZ0 at MMIO 0x80013020 (irq = 22,
base_baud = 230400) is a Z85c30 ESCC - Serial port
[    0.347414] 0.00013000:ch-b: ttyPZ1 at MMIO 0x80013000 (irq = 23,
base_baud = 230400) is a Z85c30 ESCC - Serial port
[    0.348288] pata-pci-macio 0002:20:0d.0: enabling device (0000 -> 0002)
[    0.348419] adb: starting probe task...
[    0.348433] adb: finished probe task...
[    0.368129] pata-pci-macio 0002:20:0d.0: Activating pata-macio
chipset UniNorth ATA-6, Apple bus ID 3
[    0.368811] scsi host0: pata_macio
[    0.369038] ata1: PATA max UDMA/100 irq 39
[    0.568442] ata1.00: ATA-6: ST9402115A, 3.01, max UDMA/100
[    0.568460] ata1.00: 78140160 sectors, multi 16: LBA48
[    0.568480] ata1.01: ATAPI: MATSHITADVD-R   UJ-845, D8PB, max UDMA/66
[    0.608368] ata1.00: configured for UDMA/100
[    0.648403] ata1.01: configured for UDMA/66
[    0.651024] scsi 0:0:0:0: Direct-Access     ATA      ST9402115A
  3.01 PQ: 0 ANSI: 5
[    0.653249] scsi 0:0:1:0: CD-ROM            MATSHITA DVD-R   UJ-845
  D8PB PQ: 0 ANSI: 5
[    1.398123] pata-macio 0.00020000:ata-3: Activating pata-macio
chipset KeyLargo ATA-3, Apple bus ID 0
[    1.398758] scsi host1: pata_macio
[    1.398978] ata2: PATA max MWDMA2 irq 24
[    1.399043] Intel(R) Ethernet Switch Host Interface Driver - version 0.12.2-k
[    1.399055] Copyright (c) 2013 Intel Corporation.
[    1.399587] mousedev: PS/2 mouse device common for all mice
[    1.399845] PowerMac i2c bus pmu 2 registered
[    1.399921] PowerMac i2c bus pmu 1 registered
[    1.400121] PowerMac i2c bus mac-io 0 registered
[    1.400192] PowerMac i2c bus uni-n 1 registered
[    1.400206] i2c i2c-3: i2c-powermac: modalias failure on
/uni-n@f8000000/i2c@f8001000/cereal@1c0
[    1.400345] PowerMac i2c bus uni-n 0 registered
[    1.400610] TCP: cubic registered
[    1.400642] NET: Registered protocol family 10
[    1.401336] mip6: Mobile IPv6
[    1.401357] NET: Registered protocol family 17
[    1.402019] registered taskstats version 1
[    1.402564] input: PMU as /devices/virtual/input/input0
[    1.558522] Freeing unused kernel memory: 240K (c0541000 - c057d000)
[    1.618657] systemd-udevd[60]: starting version 215
[    1.619943] random: systemd-udevd urandom read with 0 bits of
entropy available
[    1.667597] usbcore: registered new interface driver usbfs
[    1.667667] usbcore: registered new interface driver hub
[    1.700832] usbcore: registered new device driver usb
[    1.702392] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.704097] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.705083] ehci-pci: EHCI PCI platform driver
[    1.705198] ehci-pci 0001:10:1b.2: EHCI Host Controller
[    1.705228] ehci-pci 0001:10:1b.2: new USB bus registered, assigned
bus number 1
[    1.705327] ehci-pci 0001:10:1b.2: irq 63, io mem 0x80080000
[    1.712016] sd 0:0:0:0: [sda] 78140160 512-byte logical blocks:
(40.0 GB/37.2 GiB)
[    1.712154] sd 0:0:0:0: [sda] Write Protect is off
[    1.712169] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.712216] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    1.718744] ehci-pci 0001:10:1b.2: USB 2.0 started, EHCI 1.00
[    1.719218] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.719237] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.719253] usb usb1: Product: EHCI Host Controller
[    1.719264] usb usb1: Manufacturer: Linux 4.0.0-rc4+ ehci_hcd
[    1.719276] usb usb1: SerialNumber: 0001:10:1b.2
[    1.726944] sungem.c:v1.0 David S. Miller <davem@redhat.com>
[    1.727824] gem 0002:20:0f.0 eth0: Sun GEM (PCI) 10/100/1000BaseT
Ethernet 00:14:51:15:c1:8c
[    1.738352] hub 1-0:1.0: USB hub found
[    1.738408] hub 1-0:1.0: 5 ports detected
[    1.743409] ohci-pci: OHCI PCI platform driver
[    1.743474] Apple USB OHCI 0001:10:18.0 disabled by firmware
[    1.743507] Apple USB OHCI 0001:10:19.0 disabled by firmware
[    1.743575] ohci-pci 0001:10:1a.0: OHCI PCI host controller
[    1.743605] ohci-pci 0001:10:1a.0: new USB bus registered, assigned
bus number 2
[    1.745446] ohci-pci 0001:10:1a.0: irq 29, io mem 0x80083000
[    1.745983] firewire_ohci 0002:20:0e.0: enabling device (0000 -> 0002)
[    1.749236]  sda: [mac] sda1 sda2 sda3 sda4 sda5
[    1.752085] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.754597] sr 0:0:1:0: [sr0] scsi3-mmc drive: 24x/24x writer cd/rw
xa/form2 cdda tray
[    1.754631] cdrom: Uniform CD-ROM driver Revision: 3.20
[    1.756068] sr 0:0:1:0: Attached scsi CD-ROM sr0
[    1.757531] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.757685] sr 0:0:1:0: Attached scsi generic sg1 type 5
[    1.818204] firewire_ohci 0002:20:0e.0: added OHCI v1.10 device as
card 0, 8 IR + 8 IT contexts, quirks 0x0
[    1.870606] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    1.870639] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.870655] usb usb2: Product: OHCI PCI host controller
[    1.870667] usb usb2: Manufacturer: Linux 4.0.0-rc4+ ohci_hcd
[    1.870679] usb usb2: SerialNumber: 0001:10:1a.0
[    1.871680] hub 2-0:1.0: USB hub found
[    1.871720] hub 2-0:1.0: 2 ports detected
[    1.872763] ohci-pci 0001:10:1b.0: OHCI PCI host controller
[    1.872799] ohci-pci 0001:10:1b.0: new USB bus registered, assigned
bus number 3
[    1.872846] ohci-pci 0001:10:1b.0: irq 63, io mem 0x80082000
[    1.947975] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    1.948008] usb usb3: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.948024] usb usb3: Product: OHCI PCI host controller
[    1.948036] usb usb3: Manufacturer: Linux 4.0.0-rc4+ ohci_hcd
[    1.948047] usb usb3: SerialNumber: 0001:10:1b.0
[    1.949458] hub 3-0:1.0: USB hub found
[    1.949496] hub 3-0:1.0: 3 ports detected
[    1.950427] ohci-pci 0001:10:1b.1: OHCI PCI host controller
[    1.950463] ohci-pci 0001:10:1b.1: new USB bus registered, assigned
bus number 4
[    1.950511] ohci-pci 0001:10:1b.1: irq 63, io mem 0x80081000
[    2.027984] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    2.028016] usb usb4: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.028031] usb usb4: Product: OHCI PCI host controller
[    2.028043] usb usb4: Manufacturer: Linux 4.0.0-rc4+ ohci_hcd
[    2.028055] usb usb4: SerialNumber: 0001:10:1b.1
[    2.029916] hub 4-0:1.0: USB hub found
[    2.029957] hub 4-0:1.0: 2 ports detected
[    2.318358] firewire_core 0002:20:0e.0: created device fw0: GUID
001451fffe15c18c, S400
[    2.509703] PM: Starting manual resume from disk
[    3.038249] EXT4-fs (sda3): mounted filesystem with ordered data
mode. Opts: (null)
[    4.409381] systemd[1]: systemd 215 running in system mode. (+PAM
+AUDIT +SELINUX +IMA +SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ
-SECCOMP -APPARMOR)
[    4.409622] systemd[1]: Detected architecture 'ppc'.
[    4.666761] systemd[1]: Failed to insert module 'autofs4'
[    4.677729] systemd[1]: Set hostname to <macmini>.
[    7.891487] systemd[1]: Starting Forward Password Requests to Wall
Directory Watch.
[    7.892103] systemd[1]: Started Forward Password Requests to Wall
Directory Watch.
[    7.892181] systemd[1]: Starting Remote File Systems (Pre).
[    7.892749] systemd[1]: Reached target Remote File Systems (Pre).
[    7.892836] systemd[1]: Starting Encrypted Volumes.
[    7.892987] systemd[1]: Reached target Encrypted Volumes.
[    7.893060] systemd[1]: Starting Dispatch Password Requests to
Console Directory Watch.
[    7.893197] systemd[1]: Started Dispatch Password Requests to
Console Directory Watch.
[    7.893241] systemd[1]: Starting Paths.
[    7.893366] systemd[1]: Reached target Paths.
[    7.893447] systemd[1]: Set up automount Arbitrary Executable File
Formats File System Automount Point.
[    7.893492] systemd[1]: Expecting device
dev-disk-by\x2duuid-1d89acda\x2d332d\x2d4fc9\x2da52f\x2d62e820d09baf.device...
[    7.893638] systemd[1]: Starting Root Slice.
[    7.912930] systemd[1]: Created slice Root Slice.
[    7.913017] systemd[1]: Starting Delayed Shutdown Socket.
[    7.913297] systemd[1]: Listening on Delayed Shutdown Socket.
[    7.913349] systemd[1]: Starting /dev/initctl Compatibility Named Pipe.
[    7.913543] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[    7.913589] systemd[1]: Starting Journal Socket (/dev/log).
[    7.913779] systemd[1]: Listening on Journal Socket (/dev/log).
[    7.913829] systemd[1]: Starting Syslog Socket.
[    7.913966] systemd[1]: Listening on Syslog Socket.
[    7.914009] systemd[1]: Starting User and Session Slice.
[    7.914858] systemd[1]: Created slice User and Session Slice.
[    7.914938] systemd[1]: Starting udev Control Socket.
[    7.915114] systemd[1]: Listening on udev Control Socket.
[    7.915169] systemd[1]: Starting udev Kernel Socket.
[    7.915327] systemd[1]: Listening on udev Kernel Socket.
[    7.915392] systemd[1]: Starting Journal Socket.
[    7.915666] systemd[1]: Listening on Journal Socket.
[    7.915765] systemd[1]: Starting System Slice.
[    7.916354] systemd[1]: Created slice System Slice.
[    7.916433] systemd[1]: Starting File System Check on Root Device...
[    7.919464] systemd[1]: Mounting POSIX Message Queue File System...
[    7.922804] systemd[1]: Mounted Huge Pages File System.
[    7.923205] systemd[1]: Mounted Debug File System.
[    7.993560] systemd[1]: Starting Load Kernel Modules...
[    7.997050] systemd[1]: Starting udev Coldplug all Devices...
[    8.009743] systemd[1]: Started Set Up Additional Binary Formats.
[    8.010122] systemd[1]: Starting Create list of required static
device nodes for the current kernel...
[    8.013749] systemd[1]: Starting system-getty.slice.
[    8.017656] systemd[1]: Created slice system-getty.slice.
[    8.017791] systemd[1]: Starting Journal Service...
[    8.021297] systemd[1]: Started Journal Service.
[    8.301305] loop: module loaded
[    8.747714] snd-powermac no longer handles any machines with a
layout-id property in the device-tree, use snd-aoa.
[    8.758157] systemd[1]: Unit systemd-modules-load.service entered
failed state.
[    8.906915] random: nonblocking pool is initialized
[   10.253925] systemd-udevd[150]: starting version 215
[   11.462987] EXT4-fs (sda3): re-mounted. Opts: errors=remount-ro
[   12.020462] systemd-journald[133]: Received request to flush
runtime journal from PID 1
[   12.937161] [drm] Initialized drm 1.1.0 20060810
[   13.497021] [drm] radeon kernel modesetting enabled.
[   13.498718] radeon 0000:00:10.0: enabling device (0006 -> 0007)
[   13.499903] [drm] initializing kernel modesetting (RV280
0x1002:0x5962 0x1002:0x5962).
[   13.499935] [drm] Forcing AGP to PCI mode
[   13.499955] [drm] register mmio base: 0x90000000
[   13.499964] [drm] register mmio size: 65536
[   13.500038] radeon 0000:00:10.0: Invalid ROM contents
[   13.500062] radeon 0000:00:10.0: Invalid ROM contents
[   13.500297] [drm:radeon_get_bios [radeon]] *ERROR* Unable to locate
a BIOS ROM
[   13.500326] [drm] Using device-tree clock info
[   13.500338] [drm] Generation 2 PCI interface, using max accessible memory
[   13.500355] radeon 0000:00:10.0: VRAM: 128M 0x0000000098000000 -
0x000000009FFFFFFF (32M used)
[   13.500374] radeon 0000:00:10.0: GTT: 512M 0x0000000078000000 -
0x0000000097FFFFFF
[   13.500392] [drm] Detected VRAM RAM=128M, BAR=128M
[   13.500403] [drm] RAM width 64bits DDR
[   13.500582] [TTM] Zone  kernel: Available graphics memory: 384022 kiB
[   13.500598] [TTM] Zone highmem: Available graphics memory: 515094 kiB
[   13.500609] [TTM] Initializing pool allocator
[   13.501225] [drm] radeon: 32M of VRAM memory ready
[   13.501245] [drm] radeon: 512M of GTT memory ready.
[   13.501264] [drm] GART: num cpu pages 131072, num gpu pages 131072
[   13.505037] [drm] PCI GART of 512M enabled (table at 0x000000002D700000).
[   13.505624] radeon 0000:00:10.0: WB disabled
[   13.505653] radeon 0000:00:10.0: fence driver on ring 0 use gpu
addr 0x0000000078000000 and cpu addr 0xed42c000
[   13.505761] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   13.505772] [drm] Driver supports precise vblank timestamp query.
[   13.506151] [drm] radeon: irq initialized.
[   13.506165] [drm] Loading R200 Microcode
[   13.823512] [drm] radeon: ring at 0x0000000078001000
[   13.823569] [drm] ring test succeeded in 0 usecs
[   13.823859] f 0#1: signaled from fence_wait
[   13.823871] [drm] ib test succeeded in 0 usecs
[   13.825736] [drm] Connector Table: 6 (mini external tmds)
[   13.825774] [drm] No valid Ext TMDS info found in BIOS
[   13.825790] [drm] No TV DAC info found in BIOS
[   13.827398] [drm] Radeon Display Connectors
[   13.827420] [drm] Connector 0:
[   13.827428] [drm]   DVI-I-1
[   13.827436] [drm]   HPD2
[   13.827446] [drm]   DDC: 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c
[   13.827456] [drm]   Encoders:
[   13.827464] [drm]     DFP2: INTERNAL_DVO1
[   13.827473] [drm]     CRT2: INTERNAL_DAC2
[   13.827482] [drm] Connector 1:
[   13.827489] [drm]   SVIDEO-1
[   13.827497] [drm]   Encoders:
[   13.827505] [drm]     TV1: INTERNAL_DAC2
[   13.887813] [drm] fb mappable at 0x98040000
[   13.887843] [drm] vram apper at 0x98000000
[   13.887852] [drm] size 2076672
[   13.887860] [drm] fb depth is 8
[   13.887867] [drm]    pitch is 1920
[   13.942054] Console: switching to colour frame buffer device 240x67
[   13.954601] radeon 0000:00:10.0: fb0: radeondrmfb frame buffer device
[   13.954669] radeon 0000:00:10.0: registered panic notifier
[   13.954737] [drm] Initialized radeon 2.41.0 20080528 for
0000:00:10.0 on minor 0
[   15.438721] Adding 1650120k swap on /dev/sda4.  Priority:-1
extents:1 across:1650120k FS
[   15.778460] sungem_phy: PHY ID: 4061e4, addr: 0
[   15.778814] gem 0002:20:0f.0 eth0: Found BCM5221 PHY
[   15.779140] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   18.178268] gem 0002:20:0f.0 eth0: Link is up at 100 Mbps, full-duplex
[   18.178471] gem 0002:20:0f.0 eth0: Pause is disabled
[   18.181207] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   19.372879] Process accounting resumed
[   24.367106] input: Mouseemu virtual keyboard as /devices/virtual/input/input1
[   24.381877] input: Mouseemu virtual mouse as /devices/virtual/input/input2
[   37.046306] f 0#3: signaled from radeon_fence_signaled
[   38.339580] f 0#8: armed on ring 0!
[   38.372725] f 0#8: signaled from irq context

-- 
Pranith
