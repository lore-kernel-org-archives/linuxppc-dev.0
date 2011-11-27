Return-Path: <acrux_it@libero.it>
Received: from outrelay06.libero.it (outrelay06.libero.it [212.52.84.110])
 by ozlabs.org (Postfix) with ESMTP id C8F57B6FA1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2011 00:42:27 +1100 (EST)
Received: from acrux-1faad1e87 (151.77.169.2) by outrelay06.libero.it
 (8.5.133) (authenticated as acrux_it@libero.it)
 id 4DF73B8D11D1DE78 for linuxppc-dev@lists.ozlabs.org;
 Sun, 27 Nov 2011 14:37:16 +0100
Date: Sun, 27 Nov 2011 14:37:52 +0100
From: acrux <acrux_it@libero.it>
To: linuxppc-dev@lists.ozlabs.org
Subject: scsi/ipr failed to initialize >=linux-3.0.9, >=linux-3.1.1
Message-Id: <20111127143752.269cc898.acrux_it@libero.it>
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


scsi subsystem with ipr driver fails to initialize with every kernel >=3.0.9 and >=3.1.1
Checked on YDL_Powerstation, IBM 9114-275, IBM 9123-710,

[...]
OF stdout device is: /ht/isa@8/serial@3f8
Preparing to boot Linux version 3.0.10 (root@radio) (gcc version 4.5.3 (CRUX PP1
command line: root=/dev/sda5 ro
memory layout at init:
  memory_limit : 0000000000000000 (16 MB aligned)
  alloc_bottom : 0000000000b28000
  alloc_top    : 0000000030000000
  alloc_top_hi : 0000000400000000
  rmo_top      : 0000000030000000
  ram_top      : 0000000400000000
instantiating rtas at 0x000000002fff6000... done
boot cpu hw idx 0
starting cpu hw idx 1... done
starting cpu hw idx 2... done
starting cpu hw idx 3... done
copying OF device tree...
Building dt strings...
Building dt structure...
Device tree strings 0x0000000000c29000 -> 0x0000000000c29636
Device tree struct  0x0000000000c2a000 -> 0x0000000000c2d000
Calling quiesce...
returning from prom_init
DART table allocated at: c00000007f000000
Using Maple machine description
DART IOMMU initialized for U4 type chipset
bootconsole [udbg0] enabled
CPU maps initialized for 1 thread per core
Starting Linux PPC64 #1 SMP PREEMPT Sat Nov 26 19:26:54 CET 2011
-----------------------------------------------------
ppc64_pft_size                = 0x0
physicalMemorySize            = 0x380000000
htab_address                  = 0xc0000003f0000000
htab_hash_mask                = 0x1fffff
-----------------------------------------------------
Initializing cgroup subsys cpu
Linux version 3.0.10 (root@radio) (gcc version 4.5.3 (CRUX PPC) ) #1 SMP PREEMP1
*** 0000 : CF000012

*** 0000 : Setup Arch
[boot]0012 Setup Arch
Found U4-PCIE PCI host bridge. Firmware bus number: 240->255
PCI host bridge /pciex  ranges:
  IO 0x00000000f0000000..0x00000000f03fffff -> 0x0000000000000000
 MEM 0x00000000c0000000..0x00000000efffffff -> 0x00000000c0000000
Found U3-HT PCI host bridge. Firmware bus number: 0->239
PCI host bridge /ht (primary) ranges:
  IO 0x00000000f4000000..0x00000000f43fffff -> 0x0000000000000000
 MEM 0x0000000080000000..0x00000000bfffffff -> 0x0000000080000000
mmio NVRAM, 1024k at 0xff800000 mapped to d00008008220b000
Zone PFN ranges:
  DMA      0x00000000 -> 0x00400000
  Normal   empty
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0: 0x00000000 -> 0x00080000
    0: 0x00100000 -> 0x00400000
*** 0000 : CF000015

*** 0000 : Setup Done
[boot]0015 Setup Done
PERCPU: Embedded 11 pages/cpu @c000000000d00000 s14848 r0 d30208 u262144
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 3612672
Policy zone: DMA
Kernel command line: root=/dev/sda5 ro
PID hash table entries: 4096 (order: 3, 32768 bytes)
freeing bootmem node 0
Memory: 14176588k/14680064k available (8176k kernel code, 503476k reserved, 120)
SLUB: Genslabs=15, HWalign=128, Order=0-3, MinObjects=0, CPUs=4, Nodes=256
Preemptible hierarchical RCU implementation.
NR_IRQS:512 nr_irqs:512 16
mpic: Setting up MPIC " MPIC     " version 1.2 at f8040000, max 4 CPUs
mpic: ISU size: 124, shift: 7, mask: 7f
mpic: Initializing for 124 sources
mpic: Setting up HT PICs workarounds for U3/U4
mpic:   - HT:07.0 [0xf0] vendor 1022 device 7460 has 24 irqs
Maple: Found RTC at IO 0x1070
clocksource: timebase mult[1175bfb2] shift[22] registered
Console: colour dummy device 80x25
pid_max: default: 32768 minimum: 301
Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Mount-cache hash table entries: 256
mpic: requesting IPIs...
PPC970/FX/MP performance monitor hardware support registered
Brought up 4 CPUs
devtmpfs: initialized
NET: Registered protocol family 16
PCI: Probing PCI hardware
IOMMU table initialized, virtual merging enabled
pci 0000:f0:0b.0: PCI bridge to [bus f1-f1]
pci 0001:00:01.0: PCI bridge to [bus 01-01]
pci 0001:00:02.0: PCI bridge to [bus 02-02]
pci 0001:00:03.0: PCI bridge to [bus 03-03]
pci 0001:00:04.0: PCI bridge to [bus 04-04]
pci 0001:00:05.0: PCI bridge to [bus 05-05]
pci 0001:00:06.0: PCI bridge to [bus 06-06]
pci 0001:00:07.0: PCI bridge to [bus 07-07]
bio: create slab <bio-0> at 0
vgaarb: device added: PCI:0000:f1:00.0,decodes=io+mem,owns=none,locks=none
vgaarb: loaded
vgaarb: bridge control possible 0000:f1:00.0
SCSI subsystem initialized
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
cfg80211: Calling CRDA to update world regulatory domain
Switching to clocksource timebase
Switched to NOHz mode on CPU #3
NET: Registered protocol family 2
Switched to NOHz mode on CPU #2
Switched to NOHz mode on CPU #1
IP route cache hash table entries: 524288 (order: 10, 4194304 bytes)
Switched to NOHz mode on CPU #0
TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
UDP hash table entries: 8192 (order: 7, 524288 bytes)
UDP-Lite hash table entries: 8192 (order: 7, 524288 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
pci 0001:00:03.0: Found enabled HT MSI Mapping
pci 0001:00:04.0: Found enabled HT MSI Mapping
pci 0001:00:05.0: Found enabled HT MSI Mapping
pci 0001:00:06.0: Found enabled HT MSI Mapping
pci 0001:01:01.0: Quirk disabled MSI
HugeTLB registered 16 MB page size, pre-allocated 0 pages
squashfs: version 4.0 (2009/01/31) Phillip Lougher
JFS: nTxBlock = 8192, nTxLock = 65536
SGI XFS with ACLs, security attributes, large block/inode numbers, no debug enad
Btrfs loaded
msgmni has been set to 27688
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at I/O 0x4113f8 (irq = 68) is a 16550A
console [ttyS0] enabled, bootconsole disabled
console [ttyS0] enabled, bootconsole disabled
serial8250.0: ttyS1 at I/O 0x4112f8 (irq = 67) is a 16550A
serial 0001:07:02.0: enabling device (0140 -> 0142)
0001:07:02.0: ttyS2 at MMIO 0xb8202000 (irq = 17) is a U6_16550A
0001:07:02.0: ttyS3 at MMIO 0xb8202200 (irq = 17) is a U6_16550A
ipmi message handler version 39.2
ipmi device interface
IPMI System Interface driver.
ipmi_si: Unable to find any System Interface(s)
IPMI Watchdog: driver initialized
Copyright (C) 2004 MontaVista Software - IPMI Powerdown via sys_reboot.
brd: module loaded
loop: module loaded
nbd: registered device at major 43
ipr: IBM Power RAID SCSI Device Driver version: 2.5.2 (April 27, 2011)
ipr 0001:01:01.0: Found IOA with IRQ: 18
ipr 0001:01:01.0: Using 32-bit DMA via iommu
ipr 0001:01:01.0: Starting IOA initialization sequence.
ipr 0001:01:01.0: Adapter firmware version: 01200018
ipr 0001:01:01.0: IOA initialized.
scsi0 : IBM 572C Storage Adapter
scsi 0:0:0:0: Direct-Access     IBM-ESXS ST373455SS       BA23 PQ: 0 ANSI: 5
------------[ cut here ]------------
WARNING: at drivers/scsi/scsi_lib.c:1702
Modules linked in:
NIP: c000000000441db4 LR: c000000000441d9c CTR: c00000000044504c
REGS: c0000003ec8b2ee0 TRAP: 0700   Not tainted  (3.0.10)
MSR: 9000000000029032 <EE,ME,CE,IR,DR>  CR: 48000024  XER: 200fffff
TASK = c0000003ec8a8000[1] 'swapper' THREAD: c0000003ec8b0000 CPU: 1
GPR00: 0000000000000001 c0000003ec8b3160 c00000000091c8c8 c0000003ea12f940
GPR04: c0000000008d4668 0000000000000000 c0000003ea143740 c0000000007fba80
GPR08: 0000000000000bd1 c0000000007fba88 0000000000548000 0000000000548000
GPR12: 0000000048000028 c00000000ffff280 0000000000000000 0000000000180000
GPR16: c0000003ec8b37a0 0000000000000090 c0000003ea198d88 0000000000000074
GPR20: 0000000000000000 c0000003ea198000 0000000000000000 0000000000000004
GPR24: c0000003ec8b3460 c0000003ea194400 0000000000000000 c0000003ea194428
GPR28: c0000003ea161940 fffffffffffffffa c00000000087e5c0 c0000003ea12f940
NIP [c000000000441db4] .scsi_free_queue+0x20/0x7c
LR [c000000000441d9c] .scsi_free_queue+0x8/0x7c
Call Trace:
[c0000003ec8b3160] [c00000000087e5c0] 0xc00000000087e5c0 (unreliable)
[c0000003ec8b31f0] [c0000000004427e8] .scsi_alloc_sdev+0x240/0x27c
[c0000003ec8b3290] [c000000000442ba0] .scsi_probe_and_add_lun+0xf8/0x960
[c0000003ec8b33e0] [c000000000443678] .__scsi_scan_target+0xd8/0x59c
[c0000003ec8b3520] [c000000000443ba0] .scsi_scan_channel+0x64/0xac
[c0000003ec8b35d0] [c000000000443f08] .scsi_scan_host_selected+0xd4/0x124
[c0000003ec8b3680] [c0000000004443a4] .scsi_scan_host+0x1d0/0x21c
[c0000003ec8b3720] [c000000000647058] .ipr_probe+0x13a8/0x1464
[c0000003ec8b3850] [c0000000003b3ca4] .local_pci_probe+0x70/0xd4
[c0000003ec8b38e0] [c0000000003b418c] .pci_device_probe+0xc8/0xf8
[c0000003ec8b3990] [c0000000004290c8] .driver_probe_device+0xf0/0x1ac
[c0000003ec8b3a30] [c00000000042920c] .__driver_attach+0x88/0xb8
[c0000003ec8b3ac0] [c000000000428020] .bus_for_each_dev+0x70/0xa8
[c0000003ec8b3b70] [c000000000428cd8] .driver_attach+0x24/0x30
[c0000003ec8b3bf0] [c000000000428828] .bus_add_driver+0xc0/0x264
[c0000003ec8b3c90] [c000000000429680] .driver_register+0xb8/0x150
[c0000003ec8b3d30] [c0000000003b4428] .__pci_register_driver+0x4c/0xdc
[c0000003ec8b3dd0] [c0000000007cef68] .ipr_init+0x44/0x50
[c0000003ec8b3e50] [c00000000000a7e4] .do_one_initcall+0xc0/0x190
[c0000003ec8b3f00] [c0000000007ac910] .kernel_init+0xb0/0x14c
[c0000003ec8b3f90] [c00000000001859c] .kernel_thread+0x54/0x70
Instruction dump:
60000000 38210080 7fe3fb78 4bbee468 7c0802a6 4bbee3f9 f821ff71 7c7f1b78
e80302c8 7c000074 7800d182 68000001 <0b000000> e86302e8 481f92a5 60000000
---[ end trace 6a6e1c0c73955051 ]---
------------[ cut here ]------------
WARNING: at drivers/scsi/scsi_lib.c:1702
Modules linked in:
NIP: c000000000441db4 LR: c000000000441d9c CTR: c00000000044504c
REGS: c0000003ec8b2ee0 TRAP: 0700   Tainted: G        W    (3.0.10)
MSR: 9000000000029032 <EE,ME,CE,IR,DR>  CR: 48000024  XER: 200fffff
TASK = c0000003ec8a8000[1] 'swapper' THREAD: c0000003ec8b0000 CPU: 1
GPR00: 0000000000000001 c0000003ec8b3160 c00000000091c8c8 c0000003ea12f940
GPR04: c0000000008d4668 0000000000000000 c0000003ea143740 c0000000007fba80
GPR08: 0000000000000be1 c0000000007fba88 0000000000548000 0000000000548000
GPR12: 0000000048000028 c00000000ffff280 0000000000000000 0000000000180000
GPR16: c0000003ec8b37a0 0000000000000090 c0000003ea198d88 0000000000000074
GPR20: 0000000000000000 c0000003ea198000 0000000000000000 0000000000000004
GPR24: c0000003ec8b3460 c0000003ea194400 0000000000000000 c0000003ea194428
GPR28: c0000003ea161940 fffffffffffffffa c00000000087e5c0 c0000003ea12f940
NIP [c000000000441db4] .scsi_free_queue+0x20/0x7c
LR [c000000000441d9c] .scsi_free_queue+0x8/0x7c
Call Trace:
[c0000003ec8b3160] [c00000000087e5c0] 0xc00000000087e5c0 (unreliable)
[c0000003ec8b31f0] [c0000000004427e8] .scsi_alloc_sdev+0x240/0x27c
[c0000003ec8b3290] [c000000000442ba0] .scsi_probe_and_add_lun+0xf8/0x960
[c0000003ec8b33e0] [c000000000443678] .__scsi_scan_target+0xd8/0x59c
[c0000003ec8b3520] [c000000000443ba0] .scsi_scan_channel+0x64/0xac
[c0000003ec8b35d0] [c000000000443f08] .scsi_scan_host_selected+0xd4/0x124
[c0000003ec8b3680] [c0000000004443a4] .scsi_scan_host+0x1d0/0x21c
[c0000003ec8b3720] [c000000000647058] .ipr_probe+0x13a8/0x1464
[c0000003ec8b3850] [c0000000003b3ca4] .local_pci_probe+0x70/0xd4
[c0000003ec8b38e0] [c0000000003b418c] .pci_device_probe+0xc8/0xf8
[c0000003ec8b3990] [c0000000004290c8] .driver_probe_device+0xf0/0x1ac
[c0000003ec8b3a30] [c00000000042920c] .__driver_attach+0x88/0xb8
[c0000003ec8b3ac0] [c000000000428020] .bus_for_each_dev+0x70/0xa8
[c0000003ec8b3b70] [c000000000428cd8] .driver_attach+0x24/0x30
[c0000003ec8b3bf0] [c000000000428828] .bus_add_driver+0xc0/0x264
[c0000003ec8b3c90] [c000000000429680] .driver_register+0xb8/0x150
[c0000003ec8b3d30] [c0000000003b4428] .__pci_register_driver+0x4c/0xdc
[c0000003ec8b3dd0] [c0000000007cef68] .ipr_init+0x44/0x50
[c0000003ec8b3e50] [c00000000000a7e4] .do_one_initcall+0xc0/0x190
[c0000003ec8b3f00] [c0000000007ac910] .kernel_init+0xb0/0x14c
[c0000003ec8b3f90] [c00000000001859c] .kernel_thread+0x54/0x70
Instruction dump:
60000000 38210080 7fe3fb78 4bbee468 7c0802a6 4bbee3f9 f821ff71 7c7f1b78
e80302c8 7c000074 7800d182 68000001 <0b000000> e86302e8 481f92a5 60000000
---[ end trace 6a6e1c0c73955052 ]---
------------[ cut here ]------------
WARNING: at drivers/scsi/scsi_lib.c:1702
Modules linked in:
NIP: c000000000441db4 LR: c000000000441d9c CTR: c00000000044504c
REGS: c0000003ec8b2ee0 TRAP: 0700   Tainted: G        W    (3.0.10)
MSR: 9000000000029032 <EE,ME,CE,IR,DR>  CR: 48000024  XER: 200fffff
TASK = c0000003ec8a8000[1] 'swapper' THREAD: c0000003ec8b0000 CPU: 1
GPR00: 0000000000000001 c0000003ec8b3160 c00000000091c8c8 c0000003ea12f940
GPR04: c0000000008d4668 0000000000000000 c0000003ea143740 c0000000007fba80
GPR08: 0000000000000bf1 c0000000007fba88 0000000000548000 0000000000548000
GPR12: 0000000048000028 c00000000ffff280 0000000000000000 0000000000180000
GPR16: c0000003ec8b37a0 0000000000000090 c0000003ea198d88 0000000000000074
GPR20: 0000000000000000 c0000003ea198000 0000000000000000 0000000000000004
GPR24: c0000003ec8b3460 c0000003ea194400 0000000000000000 c0000003ea194428
GPR28: c0000003ea161940 fffffffffffffffa c00000000087e5c0 c0000003ea12f940
NIP [c000000000441db4] .scsi_free_queue+0x20/0x7c
LR [c000000000441d9c] .scsi_free_queue+0x8/0x7c
Call Trace:
[c0000003ec8b3160] [c00000000087e5c0] 0xc00000000087e5c0 (unreliable)
[c0000003ec8b31f0] [c0000000004427e8] .scsi_alloc_sdev+0x240/0x27c
[c0000003ec8b3290] [c000000000442ba0] .scsi_probe_and_add_lun+0xf8/0x960
[c0000003ec8b33e0] [c000000000443678] .__scsi_scan_target+0xd8/0x59c
[c0000003ec8b3520] [c000000000443ba0] .scsi_scan_channel+0x64/0xac
[c0000003ec8b35d0] [c000000000443f08] .scsi_scan_host_selected+0xd4/0x124
[c0000003ec8b3680] [c0000000004443a4] .scsi_scan_host+0x1d0/0x21c
[c0000003ec8b3720] [c000000000647058] .ipr_probe+0x13a8/0x1464
[c0000003ec8b3850] [c0000000003b3ca4] .local_pci_probe+0x70/0xd4
[c0000003ec8b38e0] [c0000000003b418c] .pci_device_probe+0xc8/0xf8
[c0000003ec8b3990] [c0000000004290c8] .driver_probe_device+0xf0/0x1ac
[c0000003ec8b3a30] [c00000000042920c] .__driver_attach+0x88/0xb8
[c0000003ec8b3ac0] [c000000000428020] .bus_for_each_dev+0x70/0xa8
[c0000003ec8b3b70] [c000000000428cd8] .driver_attach+0x24/0x30
[c0000003ec8b3bf0] [c000000000428828] .bus_add_driver+0xc0/0x264
[c0000003ec8b3c90] [c000000000429680] .driver_register+0xb8/0x150
[c0000003ec8b3d30] [c0000000003b4428] .__pci_register_driver+0x4c/0xdc
[c0000003ec8b3dd0] [c0000000007cef68] .ipr_init+0x44/0x50
[c0000003ec8b3e50] [c00000000000a7e4] .do_one_initcall+0xc0/0x190
[c0000003ec8b3f00] [c0000000007ac910] .kernel_init+0xb0/0x14c
[c0000003ec8b3f90] [c00000000001859c] .kernel_thread+0x54/0x70
Instruction dump:
60000000 38210080 7fe3fb78 4bbee468 7c0802a6 4bbee3f9 f821ff71 7c7f1b78
e80302c8 7c000074 7800d182 68000001 <0b000000> e86302e8 481f92a5 60000000
---[ end trace 6a6e1c0c73955053 ]---
------------[ cut here ]------------
[...]


regards,
--nico
-- 
acrux <acrux_it@libero.it>
