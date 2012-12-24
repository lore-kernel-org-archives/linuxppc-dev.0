Return-Path: <devurandom@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by ozlabs.org (Postfix) with ESMTP id 253D52C0089
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Dec 2012 00:52:21 +1100 (EST)
Received: from mailout-de.gmx.net ([10.1.76.71]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0MaXIN-1TTWw4129R-00K6qX for
 <linuxppc-dev@ozlabs.org>; Mon, 24 Dec 2012 14:39:29 +0100
From: Dennis Schridde <devurandom@gmx.net>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: PROBLEM: Linux 3.6.2 fails to boot on IBM Cell
Date: Mon, 24 Dec 2012 14:39:21 +0100
Message-ID: <9109967.tMrIZKlHsK@ernie>
In-Reply-To: <20121115175835.652C43E197F@localhost>
References: <5521875.6lkx8Qvfk5@ernie> <1573571.I7ElC3JheV@ernie>
 <20121115175835.652C43E197F@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1567729.12I4HcqslV";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Cc: Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--nextPart1567729.12I4HcqslV
Content-Type: multipart/mixed; boundary="nextPart3972859.NtQBm7c9En"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart3972859.NtQBm7c9En
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 15. November 2012, 17:58:35 schrieb Grant Likely:
> Anyway, here is a real patch.
Thanks a lot, Grant!

Your patch improves the situation significantly. However, it is still not 
entirely fixed:
irq: irq-93==>hwirq-0x5d mapping failed: -22

There are a lot less error messages than before, though. Please see attached 
log.

Best regards,
Dennis Schridde
--nextPart3972859.NtQBm7c9En
Content-Disposition: attachment; filename="boot.log"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-log; charset="UTF-8"; name="boot.log"

Please wait, loading kernel...

 Bootloader 2.0
  Reading MAC address from device: 00:1a:64:b8:07:fa
  Requesting IP address via DHCP: 192.168.100.53
  Requesting file "/images/gentoo-ppc64-3.6/vmlinux-3.6.11-aufs" via TFTP from 192.168.100.1
  Receiving data:  8738 KBytes
  TFTP: Received /images/gentoo-ppc64-3.6/vmlinux-3.6.11-aufs (8738 KBytes)
   Elf64 kernel loaded...
Loading ramdisk...

 Bootloader 2.0
  Reading MAC address from device: 00:1a:64:b8:07:fa
  Requesting IP address via DHCP: 192.168.100.53
  Requesting file "/images/gentoo-ppc64-3.6/initramfs-3.6.11-aufs.img" via TFTP from 192.168.100.1
  Receiving data:  7018 KBytes
  TFTP: Received /images/gentoo-ppc64-3.6/initramfs-3.6.11-aufs.img (7018 KBytes)
ramdisk loaded at 03000000, size: 7018 Kbytes
OF stdout device is: /axon@10000000000/plb5/plb4/opb/serial@40000200
Preparing to boot Linux version 3.6.11-aufs (root@blade00) (gcc version 4.7.2 (Gentoo 4.7.2 p1.3, pie-0.5.5) ) #2 SMP Mon Dec 24 12:34:21 CET 2012
Detected machine type: 0000000000000500
command line:  ksdevice=bootif lang=  loglevel=8 text
memory layout at init:
  memory_limit : 0000000000000000 (16 MB aligned)
  alloc_bottom : 00000000036db000
  alloc_top    : 0000000030000000
  alloc_top_hi : 0000000200000000
  rmo_top      : 0000000030000000
  ram_top      : 0000000200000000
instantiating rtas at 0x000000002fff3000... done
boot cpu hw idx 0
starting cpu hw idx 2... done
copying OF device tree...
Building dt strings...
Building dt structure...
Device tree strings 0x00000000037dc000 -> 0x00000000037dc8e3
Device tree struct  0x00000000037dd000 -> 0x00000000037e6000
[    0.000000] Allocated 20480 bytes for 32 pacas at c00000000fffb000
[    0.000000] Using Cell machine description
[    0.000000] Page orders: linear mapping = 24, virtual = 12, io = 12, vmemmap = 24
[    0.000000] Found initrd at 0xc000000003000000:0xc0000000036da850
[    0.000000] Found legacy serial port 0 for /axon@10000000000/plb5/plb4/opb/serial@40000200
[    0.000000]   mem=14540000200, taddr=14540000200, irq=0, clk=14745600, speed=19200
[    0.000000] Found legacy serial port 1 for /axon@10000000000/plb5/plb4/opb/serial@40000300
[    0.000000]   mem=14540000300, taddr=14540000300, irq=0, clk=14745600, speed=115200
[    0.000000] Found legacy serial port 2 for /axon@30000000000/plb5/plb4/opb/serial@40000200
[    0.000000]   mem=34540000200, taddr=34540000200, irq=0, clk=14745600, speed=-1
[    0.000000] Found legacy serial port 3 for /axon@30000000000/plb5/plb4/opb/serial@40000300
[    0.000000]   mem=34540000300, taddr=34540000300, irq=0, clk=14745600, speed=-1
[    0.000000] bootconsole [udbg0] enabled
[    0.000000] CPU maps initialized for 2 threads per core
[    0.000000]  (thread shift is 1)
[    0.000000] Freed 16384 bytes for unused pacas
[    0.000000] Starting Linux PPC64 #2 SMP Mon Dec 24 12:34:21 CET 2012
[    0.000000] -----------------------------------------------------
[    0.000000] ppc64_pft_size                = 0x0
[    0.000000] physicalMemorySize            = 0x200000000
[    0.000000] htab_address                  = 0xc000000078000000
[    0.000000] htab_hash_mask                = 0xfffff
[    0.000000] -----------------------------------------------------
[    0.000000] Linux version 3.6.11-aufs (root@blade00) (gcc version 4.7.2 (Gentoo 4.7.2 p1.3, pie-0.5.5) ) #2 SMP Mon Dec 24 12:34:21 CET 2012
[    0.000000] *** 0000 : CF000012
[    0.000000]
[    0.000000] *** 0000 : Setup Arch
[    0.000000] [boot]0012 Setup Arch
[    0.000000] Node 0 Memory: 0x0-0x100000000
[    0.000000] Node 1 Memory: 0x100000000-0x200000000
[    0.000000] mmio NVRAM, 1020k at 0x14502000000 mapped to d000080080008000
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00000000-0x1ffffffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00000000-0xffffffff]
[    0.000000]   node   1: [mem 0x100000000-0x1ffffffff]
[    0.000000] On node 0 totalpages: 1048576
[    0.000000]   DMA zone: 14336 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 1034240 pages, LIFO batch:31
[    0.000000] On node 1 totalpages: 1048576
[    0.000000]   DMA zone: 14336 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 1034240 pages, LIFO batch:31
[    0.000000] *** 0000 : CF000015
[    0.000000]
[    0.000000] *** 0000 : Setup Done
[    0.000000] [boot]0015 Setup Done
[    0.000000] PERCPU: Embedded 11 pages/cpu @c000000000700000 s14720 r0 d30336 u262144
[    0.000000] pcpu-alloc: s14720 r0 d30336 u262144 alloc=1*1048576
[    0.000000] pcpu-alloc: [0] 0 1 2 3
[    0.000000] Built 2 zonelists in Node order, mobility grouping on.  Total pages: 2068480
[    0.000000] Policy zone: DMA
[    0.000000] Kernel command line:  ksdevice=bootif lang=  loglevel=8 text
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] freeing bootmem node 0
[    0.000000] freeing bootmem node 1
[    0.000000] Memory: 8127828k/8388608k available (5980k kernel code, 260780k reserved, 644k data, 424k bss, 2016k init)
[    0.000000] SLUB: Genslabs=15, HWalign=128, Order=0-3, MinObjects=0, CPUs=4, Nodes=256
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=32 to nr_cpu_ids=4.
[    0.000000] NR_IRQS:512 nr_irqs:512 16
[    0.000000] IIC for CPU 0 target id 0xe : /be@20000000000/interrupt-controller@508400
[    0.000000] IIC for CPU 1 target id 0xf : /be@20000000000/interrupt-controller@508400
[    0.000000] IIC for CPU 2 target id 0x1e : /be@20100000000/interrupt-controller@508400
[    0.000000] IIC for CPU 3 target id 0x1f : /be@20100000000/interrupt-controller@508400
[    0.000000] mpic: Setting up MPIC " MPIC     " version 1.2 at 0, max 4 CPUs
[    0.000000] mpic: ISU size: 128, shift: 7, mask: 7f
[    0.000000] mpic: Initializing for 128 sources
[    0.000000] /axon@10000000000/interrupt-controller: hooking up to IRQ 43
[    0.000000] mpic: Setting up MPIC " MPIC     " version 1.2 at 0, max 4 CPUs
[    0.000000] mpic: ISU size: 128, shift: 7, mask: 7f
[    0.000000] mpic: Initializing for 128 sources
[    0.000000] /axon@30000000000/interrupt-controller: hooking up to IRQ 299
[    0.000000] time_init: decrementer frequency = 26.664580 MHz
[    0.000000] time_init: processor frequency   = 3200.000000 MHz
[    0.000000] clocksource: timebase mult[2580c052] shift[24] registered
[    0.000000] clockevent: decrementer mult[6d37d6b] shift[32] cpu[0]
[    0.000000] Console: colour dummy device 80x25
[    0.102201] pid_max: default: 32768 minimum: 301
[    0.132364] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.187768] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.235629] Mount-cache hash table entries: 256
[    0.265044] Brought up 4 CPUs
[    0.282347] Node 0 CPUs: 0-1
[    0.299528] Node 1 CPUs: 2-3
[    0.317296] devtmpfs: initialized
[    0.363359] NET: Registered protocol family 16
[    0.389798] iommu: node 0, dynamic window 0x0-0x80000000 fixed window 0x80000000-0x280000000
[    0.441355] IOMMU: Using strong ordering for fixed mapping
[    0.475729] IOMMU table initialized, virtual merging enabled
[    0.509230] iommu: node 1, dynamic window 0x0-0x80000000 fixed window 0x80000000-0x280000000
[    0.561925] IOMMU: Using strong ordering for fixed mapping
[    0.602829] PCI: Probing PCI hardware
[    0.624284] PCI: Probing PCI hardware done
[    0.649080] irq: irq-93==>hwirq-0x5d mapping failed: -22
[    0.680551] ------------[ cut here ]------------
[    0.708129] WARNING: at /usr/src/linux-3.6.11-aufs/kernel/irq/irqdomain.c:444
[    0.750838] Modules linked in:
[    0.769070] NIP: c0000000000ba93c LR: c0000000000ba938 CTR: c0000000000254b0
[    0.811259] REGS: c0000000fe65b370 TRAP: 0700   Not tainted  (3.6.11-aufs)
[    0.852403] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 44000024  XER: 00000000
[    0.899279] SOFTE: 1
[    0.912302] TASK = c0000000fe650000[1] 'swapper/0' THREAD: c0000000fe658000 CPU: 0
GPR00: c0000000000ba938 c0000000fe65b5f0 c000000000668808 000000000000002c
GPR04: 0000000000000000 000000007c05ba71 0000000000000008 0000000000000000
GPR08: 000000007c123f36 0000000000000000 0000000000000000 0000000000000000
GPR12: d000070000000000 c00000000fffb000 ffffffffffffffff 0000000002c0f498
GPR16: 0000000000000060 000000000ead9738 0000000002c0f498 00000000037db028
GPR20: 00000000037dc012 0000000000000000 c0000000fe006078 000000000000005e
GPR24: 0000000000000174 000000000000005d 000000000000005d c0000000fe64ba00
GPR28: c0000000fe006060 000000000000005d c000000000614b20 000000000000005d
[    1.278470] NIP [c0000000000ba93c] .irq_domain_associate_many+0x264/0x290
[    1.319087] LR [c0000000000ba938] .irq_domain_associate_many+0x260/0x290
[    1.359188] Call Trace:
[    1.373776] [c0000000fe65b5f0] [c0000000000ba938] .irq_domain_associate_many+0x260/0x290 (unreliable)
[    1.428987] [c0000000fe65b6c0] [c0000000000bb3b8] .irq_create_mapping+0xc8/0x1d0
[    1.473258] [c0000000fe65b760] [c0000000000bb568] .irq_create_of_mapping+0xa8/0x170
[    1.519096] [c0000000fe65b810] [c0000000002777b0] .irq_of_parse_and_map+0x40/0x58
[    1.563886] [c0000000fe65b8a0] [c0000000002778e0] .of_irq_count+0x30/0x58
[    1.604511] [c0000000fe65b930] [c000000000278204] .of_device_alloc+0x94/0x238
[    1.647222] [c0000000fe65ba30] [c0000000002783fc] .of_platform_device_create_pdata+0x54/0xf8
[    1.697744] [c0000000fe65bad0] [c0000000002785e4] .of_platform_bus_create+0x144/0x1e0
[    1.744620] [c0000000fe65bbc0] [c000000000278640] .of_platform_bus_create+0x1a0/0x1e0
[    1.791496] [c0000000fe65bcb0] [c000000000278830] .of_platform_bus_probe+0xd0/0x140
[    1.837334] [c0000000fe65bd50] [c0000000003f0444] .__machine_initcall_cell_cell_publish_devices+0x54/0x1ac
[    1.895149] [c0000000fe65be20] [c000000000009a70] .do_one_initcall+0x168/0x1d0
[    1.938379] [c0000000fe65bee0] [c0000000003dfb74] .kernel_init+0x14c/0x1f4
[    1.979527] [c0000000fe65bf90] [c00000000001b478] .kernel_thread+0x54/0x70
[    2.020666] Instruction dump:
[    2.038375] 7fa4eb78 7ca507b4 482709ed 60000000 0fe00000 3860ffea 4bffff80 e87e8020
[    2.084730] 7fa4eb78 7fe5fb78 482709cd 60000000 <0fe00000> 39200000 7f83e378 7f44d378
[    2.132140] ---[ end trace a23e1daeebb82ff6 ]---
[    2.160223] irq: irq-59==>hwirq-0x3b mapping failed: -22
[    2.191570] ------------[ cut here ]------------
[    2.219163] WARNING: at /usr/src/linux-3.6.11-aufs/kernel/irq/irqdomain.c:444
[    2.261870] Modules linked in:
[    2.280102] NIP: c0000000000ba93c LR: c0000000000ba938 CTR: c0000000000254b0
[    2.322292] REGS: c0000000fe65b190 TRAP: 0700   Tainted: G        W     (3.6.11-aufs)
[    2.369166] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 44000024  XER: 00000000
[    2.416042] SOFTE: 1
[    2.429064] TASK = c0000000fe650000[1] 'swapper/0' THREAD: c0000000fe658000 CPU: 0
GPR00: c0000000000ba938 c0000000fe65b410 c000000000668808 000000000000002c
GPR04: 0000000000000000 000000007e6c8024 0000000000000008 0000000000000000
GPR08: 000000007e790a3c 0000000000000000 0000000000000000 0000000000000000
GPR12: d000070000000000 c00000000fffb000 ffffffffffffffff 0000000002c0f498
GPR16: 0000000000000060 000000000ead9738 0000000002c0f498 00000000037db028
GPR20: 00000000037dc012 0000000000000000 c0000000fe006078 000000000000003c
GPR24: 00000000000000ec 000000000000003b 000000000000003b c0000000fe64bf00
GPR28: c0000000fe006060 000000000000003b c000000000614b20 000000000000003b
[    2.795224] NIP [c0000000000ba93c] .irq_domain_associate_many+0x264/0x290
[    2.835850] LR [c0000000000ba938] .irq_domain_associate_many+0x260/0x290
[    2.875951] Call Trace:
[    2.890539] [c0000000fe65b410] [c0000000000ba938] .irq_domain_associate_many+0x260/0x290 (unreliable)
[    2.945748] [c0000000fe65b4e0] [c0000000000bb3b8] .irq_create_mapping+0xc8/0x1d0
[    2.990020] [c0000000fe65b580] [c0000000000bb568] .irq_create_of_mapping+0xa8/0x170
[    3.035856] [c0000000fe65b630] [c0000000002777b0] .irq_of_parse_and_map+0x40/0x58
[    3.080648] [c0000000fe65b6c0] [c0000000002778e0] .of_irq_count+0x30/0x58
[    3.121275] [c0000000fe65b750] [c000000000278204] .of_device_alloc+0x94/0x238
[    3.163985] [c0000000fe65b850] [c0000000002783fc] .of_platform_device_create_pdata+0x54/0xf8
[    3.214507] [c0000000fe65b8f0] [c0000000002785e4] .of_platform_bus_create+0x144/0x1e0
[    3.261382] [c0000000fe65b9e0] [c000000000278640] .of_platform_bus_create+0x1a0/0x1e0
[    3.308259] [c0000000fe65bad0] [c000000000278640] .of_platform_bus_create+0x1a0/0x1e0
[    3.355136] [c0000000fe65bbc0] [c000000000278640] .of_platform_bus_create+0x1a0/0x1e0
[    3.402011] [c0000000fe65bcb0] [c000000000278830] .of_platform_bus_probe+0xd0/0x140
[    3.447847] [c0000000fe65bd50] [c0000000003f0444] .__machine_initcall_cell_cell_publish_devices+0x54/0x1ac
[    3.505661] [c0000000fe65be20] [c000000000009a70] .do_one_initcall+0x168/0x1d0
[    3.548892] [c0000000fe65bee0] [c0000000003dfb74] .kernel_init+0x14c/0x1f4
[    3.590039] [c0000000fe65bf90] [c00000000001b478] .kernel_thread+0x54/0x70
[    3.631181] Instruction dump:
[    3.648890] 7fa4eb78 7ca507b4 482709ed 60000000 0fe00000 3860ffea 4bffff80 e87e8020
[    3.695246] 7fa4eb78 7fe5fb78 482709cd 60000000 <0fe00000> 39200000 7f83e378 7f44d378
[    3.742644] ---[ end trace a23e1daeebb82ff7 ]---
[    3.771196] irq: irq-18==>hwirq-0x2 mapping failed: -22
[    3.802033] ------------[ cut here ]------------
[    3.829627] WARNING: at /usr/src/linux-3.6.11-aufs/kernel/irq/irqdomain.c:444
[    3.872334] Modules linked in:
[    3.890566] NIP: c0000000000ba93c LR: c0000000000ba938 CTR: c0000000000254b0
[    3.932755] REGS: c0000000fe65b0a0 TRAP: 0700   Tainted: G        W     (3.6.11-aufs)
[    3.979630] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 84000024  XER: 00000000
[    4.026506] SOFTE: 1
[    4.039528] TASK = c0000000fe650000[1] 'swapper/0' THREAD: c0000000fe658000 CPU: 0
GPR00: c0000000000ba938 c0000000fe65b320 c000000000668808 000000000000002b
GPR04: 0000000000000000 0000000080fbc4fa 0000000000000008 0000000000000000
GPR08: 00000000810849bd 0000000000000000 0000000000000000 0000000000000000
GPR12: d000070000000000 c00000000fffb000 ffffffffffffffff 0000000002c0f498
GPR16: 0000000000000060 000000000ead9738 0000000002c0f498 00000000037db028
GPR20: 00000000037dc012 0000000000000000 c0000000fe006078 0000000000000013
GPR24: 0000000000000008 0000000000000002 0000000000000012 c0000000fe7d1300
GPR28: c0000000fe006060 0000000000000012 c000000000614b20 0000000000000002
[    4.405688] NIP [c0000000000ba93c] .irq_domain_associate_many+0x264/0x290
[    4.446313] LR [c0000000000ba938] .irq_domain_associate_many+0x260/0x290
[    4.486415] Call Trace:
[    4.501003] [c0000000fe65b320] [c0000000000ba938] .irq_domain_associate_many+0x260/0x290 (unreliable)
[    4.556212] [c0000000fe65b3f0] [c0000000000bb3b8] .irq_create_mapping+0xc8/0x1d0
[    4.600484] [c0000000fe65b490] [c0000000000bb568] .irq_create_of_mapping+0xa8/0x170
[    4.646320] [c0000000fe65b540] [c0000000002777b0] .irq_of_parse_and_map+0x40/0x58
[    4.691111] [c0000000fe65b5d0] [c0000000002778e0] .of_irq_count+0x30/0x58
[    4.731738] [c0000000fe65b660] [c000000000278204] .of_device_alloc+0x94/0x238
[    4.774448] [c0000000fe65b760] [c0000000002783fc] .of_platform_device_create_pdata+0x54/0xf8
[    4.824970] [c0000000fe65b800] [c0000000002785e4] .of_platform_bus_create+0x144/0x1e0
[    4.871846] [c0000000fe65b8f0] [c000000000278640] .of_platform_bus_create+0x1a0/0x1e0
[    4.918723] [c0000000fe65b9e0] [c000000000278640] .of_platform_bus_create+0x1a0/0x1e0
[    4.965599] [c0000000fe65bad0] [c000000000278640] .of_platform_bus_create+0x1a0/0x1e0
[    5.012475] [c0000000fe65bbc0] [c000000000278640] .of_platform_bus_create+0x1a0/0x1e0
[    5.059351] [c0000000fe65bcb0] [c000000000278830] .of_platform_bus_probe+0xd0/0x140
[    5.105187] [c0000000fe65bd50] [c0000000003f0444] .__machine_initcall_cell_cell_publish_devices+0x54/0x1ac
[    5.163001] [c0000000fe65be20] [c000000000009a70] .do_one_initcall+0x168/0x1d0
[    5.206231] [c0000000fe65bee0] [c0000000003dfb74] .kernel_init+0x14c/0x1f4
[    5.247378] [c0000000fe65bf90] [c00000000001b478] .kernel_thread+0x54/0x70
[    5.288521] Instruction dump:
[    5.306230] 7fa4eb78 7ca507b4 482709ed 60000000 0fe00000 3860ffea 4bffff80 e87e8020
[    5.352586] 7fa4eb78 7fe5fb78 482709cd 60000000 <0fe00000> 39200000 7f83e378 7f44d378
[    5.399984] ---[ end trace a23e1daeebb82ff8 ]---
[    5.429311] irq: irq-102==>hwirq-0x66 mapping failed: -22
[    5.461194] ------------[ cut here ]------------
[    5.488789] WARNING: at /usr/src/linux-3.6.11-aufs/kernel/irq/irqdomain.c:444
[    5.531497] Modules linked in:
[    5.549729] NIP: c0000000000ba93c LR: c0000000000ba938 CTR: c0000000000254b0
[    5.591918] REGS: c0000000fe65b280 TRAP: 0700   Tainted: G        W     (3.6.11-aufs)
[    5.638793] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 84000024  XER: 00000000
[    5.685669] SOFTE: 1
[    5.698691] TASK = c0000000fe650000[1] 'swapper/0' THREAD: c0000000fe658000 CPU: 0
GPR00: c0000000000ba938 c0000000fe65b500 c000000000668808 000000000000002d
GPR04: 0000000000000000 00000000839e7fc2 0000000000000008 0000000000000000
GPR08: 0000000083ab59b2 0000000000000000 0000000000000000 0000000000000000
GPR12: d000070000000000 c00000000fffb000 ffffffffffffffff 0000000002c0f498
GPR16: 0000000000000060 000000000ead9738 0000000002c0f498 00000000037db028
GPR20: 00000000037dc012 0000000000000000 c0000000fe006078 0000000000000067
GPR24: 0000000000000198 0000000000000066 0000000000000066 c0000000fe7d7d00
GPR28: c0000000fe006060 0000000000000066 c000000000614b20 0000000000000066
[    6.064852] NIP [c0000000000ba93c] .irq_domain_associate_many+0x264/0x290
[    6.105476] LR [c0000000000ba938] .irq_domain_associate_many+0x260/0x290
[    6.145578] Call Trace:
[    6.160165] [c0000000fe65b500] [c0000000000ba938] .irq_domain_associate_many+0x260/0x290 (unreliable)
[    6.215375] [c0000000fe65b5d0] [c0000000000bb3b8] .irq_create_mapping+0xc8/0x1d0
[    6.259648] [c0000000fe65b670] [c0000000000bb568] .irq_create_of_mapping+0xa8/0x170
[    6.305482] [c0000000fe65b720] [c0000000002777b0] .irq_of_parse_and_map+0x40/0x58
[    6.350274] [c0000000fe65b7b0] [c0000000002778e0] .of_irq_count+0x30/0x58
[    6.390901] [c0000000fe65b840] [c000000000278204] .of_device_alloc+0x94/0x238
[    6.433611] [c0000000fe65b940] [c0000000002783fc] .of_platform_device_create_pdata+0x54/0xf8
[    6.484133] [c0000000fe65b9e0] [c0000000002785e4] .of_platform_bus_create+0x144/0x1e0
[    6.531009] [c0000000fe65bad0] [c000000000278640] .of_platform_bus_create+0x1a0/0x1e0
[    6.577885] [c0000000fe65bbc0] [c000000000278640] .of_platform_bus_create+0x1a0/0x1e0
[    6.624761] [c0000000fe65bcb0] [c000000000278830] .of_platform_bus_probe+0xd0/0x140
[    6.670598] [c0000000fe65bd50] [c0000000003f0444] .__machine_initcall_cell_cell_publish_devices+0x54/0x1ac
[    6.728411] [c0000000fe65be20] [c000000000009a70] .do_one_initcall+0x168/0x1d0
[    6.771642] [c0000000fe65bee0] [c0000000003dfb74] .kernel_init+0x14c/0x1f4
[    6.812789] [c0000000fe65bf90] [c00000000001b478] .kernel_thread+0x54/0x70
[    6.853932] Instruction dump:
[    6.871641] 7fa4eb78 7ca507b4 482709ed 60000000 0fe00000 3860ffea 4bffff80 e87e8020
[    6.917996] 7fa4eb78 7fe5fb78 482709cd 60000000 <0fe00000> 39200000 7f83e378 7f44d378
[    6.965394] ---[ end trace a23e1daeebb82ff9 ]---
[    6.993163] irq: irq-110==>hwirq-0x6e mapping failed: -22
[    7.025301] ------------[ cut here ]------------
[    7.052898] WARNING: at /usr/src/linux-3.6.11-aufs/kernel/irq/irqdomain.c:444
[    7.095605] Modules linked in:
[    7.113837] NIP: c0000000000ba93c LR: c0000000000ba938 CTR: c0000000000254b0
[    7.156026] REGS: c0000000fe65b280 TRAP: 0700   Tainted: G        W     (3.6.11-aufs)
[    7.202901] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 84000024  XER: 00000000
[    7.249777] SOFTE: 1
[    7.262799] TASK = c0000000fe650000[1] 'swapper/0' THREAD: c0000000fe658000 CPU: 0
GPR00: c0000000000ba938 c0000000fe65b500 c000000000668808 000000000000002d
GPR04: 0000000000000000 00000000861b01e7 0000000000000008 0000000000000000
GPR08: 000000008627bcd9 0000000000000000 0000000000000000 0000000000000000
GPR12: d000070000000000 c00000000fffb000 ffffffffffffffff 0000000002c0f498
GPR16: 0000000000000060 000000000ead9738 0000000002c0f498 00000000037db028
GPR20: 00000000037dc012 0000000000000000 c0000000fe006078 000000000000006f
GPR24: 00000000000001b8 000000000000006e 000000000000006e c0000000fe7d7d00
GPR28: c0000000fe006060 000000000000006e c000000000614b20 000000000000006e
[    7.628959] NIP [c0000000000ba93c] .irq_domain_associate_many+0x264/0x290
[    7.669584] LR [c0000000000ba938] .irq_domain_associate_many+0x260/0x290
[    7.709686] Call Trace:
[    7.724273] [c0000000fe65b500] [c0000000000ba938] .irq_domain_associate_many+0x260/0x290 (unreliable)
[    7.779483] [c0000000fe65b5d0] [c0000000000bb3b8] .irq_create_mapping+0xc8/0x1d0
[    7.823756] [c0000000fe65b670] [c0000000000bb568] .irq_create_of_mapping+0xa8/0x170
[    7.869590] [c0000000fe65b720] [c0000000002777b0] .irq_of_parse_and_map+0x40/0x58
[    7.914382] [c0000000fe65b7b0] [c0000000002778e0] .of_irq_count+0x30/0x58
[    7.955009] [c0000000fe65b840] [c000000000278204] .of_device_alloc+0x94/0x238
[    7.997719] [c0000000fe65b940] [c0000000002783fc] .of_platform_device_create_pdata+0x54/0xf8
[    8.048241] [c0000000fe65b9e0] [c0000000002785e4] .of_platform_bus_create+0x144/0x1e0
[    8.095118] [c0000000fe65bad0] [c000000000278640] .of_platform_bus_create+0x1a0/0x1e0
[    8.141994] [c0000000fe65bbc0] [c000000000278640] .of_platform_bus_create+0x1a0/0x1e0
[    8.188870] [c0000000fe65bcb0] [c000000000278830] .of_platform_bus_probe+0xd0/0x140
[    8.234705] [c0000000fe65bd50] [c0000000003f0444] .__machine_initcall_cell_cell_publish_devices+0x54/0x1ac
[    8.292519] [c0000000fe65be20] [c000000000009a70] .do_one_initcall+0x168/0x1d0
[    8.335749] [c0000000fe65bee0] [c0000000003dfb74] .kernel_init+0x14c/0x1f4
[    8.376896] [c0000000fe65bf90] [c00000000001b478] .kernel_thread+0x54/0x70
[    8.418040] Instruction dump:
[    8.435749] 7fa4eb78 7ca507b4 482709ed 60000000 0fe00000 3860ffea 4bffff80 e87e8020
[    8.482104] 7fa4eb78 7fe5fb78 482709cd 60000000 <0fe00000> 39200000 7f83e378 7f44d378
[    8.529503] ---[ end trace a23e1daeebb82ffa ]---
[    8.557296] irq: irq-39==>hwirq-0x27 mapping failed: -22
[    8.588889] ------------[ cut here ]------------
[    8.616484] WARNING: at /usr/src/linux-3.6.11-aufs/kernel/irq/irqdomain.c:444
[    8.659193] Modules linked in:
[    8.677424] NIP: c0000000000ba93c LR: c0000000000ba938 CTR: c0000000000254b0
[    8.719613] REGS: c0000000fe65b280 TRAP: 0700   Tainted: G        W     (3.6.11-aufs)
[    8.766488] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 84000024  XER: 00000000
[    8.813364] SOFTE: 1
[    8.826387] TASK = c0000000fe650000[1] 'swapper/0' THREAD: c0000000fe658000 CPU: 0
GPR00: c0000000000ba938 c0000000fe65b500 c000000000668808 000000000000002c
GPR04: 0000000000000000 0000000088976500 0000000000000008 0000000000000000
GPR08: 0000000088a3e9d1 0000000000000000 0000000000000000 0000000000000000
GPR12: d000070000000000 c00000000fffb000 ffffffffffffffff 0000000002c0f498
GPR16: 0000000000000060 000000000ead9738 0000000002c0f498 00000000037db028
GPR20: 00000000037dc012 0000000000000000 c0000000fe006078 0000000000000028
GPR24: 000000000000009c 0000000000000027 0000000000000027 c0000000fe7d7e00
GPR28: c0000000fe006060 0000000000000027 c000000000614b20 0000000000000027
[    9.192547] NIP [c0000000000ba93c] .irq_domain_associate_many+0x264/0x290
[    9.233171] LR [c0000000000ba938] .irq_domain_associate_many+0x260/0x290
[    9.273273] Call Trace:
[    9.287860] [c0000000fe65b500] [c0000000000ba938] .irq_domain_associate_many+0x260/0x290 (unreliable)
[    9.343070] [c0000000fe65b5d0] [c0000000000bb3b8] .irq_create_mapping+0xc8/0x1d0
[    9.387343] [c0000000fe65b670] [c0000000000bb568] .irq_create_of_mapping+0xa8/0x170
[    9.433177] [c0000000fe65b720] [c0000000002777b0] .irq_of_parse_and_map+0x40/0x58
[    9.477969] [c0000000fe65b7b0] [c0000000002778e0] .of_irq_count+0x30/0x58
[    9.518597] [c0000000fe65b840] [c000000000278204] .of_device_alloc+0x94/0x238
[    9.561305] [c0000000fe65b940] [c0000000002783fc] .of_platform_device_create_pdata+0x54/0xf8
[    9.611828] [c0000000fe65b9e0] [c0000000002785e4] .of_platform_bus_create+0x144/0x1e0
[    9.658704] [c0000000fe65bad0] [c000000000278640] .of_platform_bus_create+0x1a0/0x1e0
[    9.705580] [c0000000fe65bbc0] [c000000000278640] .of_platform_bus_create+0x1a0/0x1e0
[    9.752458] [c0000000fe65bcb0] [c000000000278830] .of_platform_bus_probe+0xd0/0x140
[    9.798293] [c0000000fe65bd50] [c0000000003f0444] .__machine_initcall_cell_cell_publish_devices+0x54/0x1ac
[    9.856106] [c0000000fe65be20] [c000000000009a70] .do_one_initcall+0x168/0x1d0
[    9.899337] [c0000000fe65bee0] [c0000000003dfb74] .kernel_init+0x14c/0x1f4
[    9.940483] [c0000000fe65bf90] [c00000000001b478] .kernel_thread+0x54/0x70
[    9.981627] Instruction dump:
[    9.999336] 7fa4eb78 7ca507b4 482709ed 60000000 0fe00000 3860ffea 4bffff80 e87e8020
[   10.045691] 7fa4eb78 7fe5fb78 482709cd 60000000 <0fe00000> 39200000 7f83e378 7f44d378
[   10.093090] ---[ end trace a23e1daeebb82ffb ]---
[   10.121125] irq: irq-93==>hwirq-0x5d mapping failed: -22
[   10.152477] ------------[ cut here ]------------
[   10.180072] WARNING: at /usr/src/linux-3.6.11-aufs/kernel/irq/irqdomain.c:444
[   10.222780] Modules linked in:
[   10.241012] NIP: c0000000000ba93c LR: c0000000000ba938 CTR: c0000000000254b0
[   10.283201] REGS: c0000000fe65b370 TRAP: 0700   Tainted: G        W     (3.6.11-aufs)
[   10.330075] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 84000024  XER: 00000000
[   10.376951] SOFTE: 1
[   10.389974] TASK = c0000000fe650000[1] 'swapper/0' THREAD: c0000000fe658000 CPU: 0
GPR00: c0000000000ba938 c0000000fe65b5f0 c000000000668808 000000000000002c
GPR04: 0000000000000000 000000008b1391f6 0000000000000008 0000000000000000
GPR08: 000000008b2016b5 0000000000000000 0000000000000000 0000000000000000
GPR12: d000070000000000 c00000000fffb000 ffffffffffffffff 0000000002c0f498
GPR16: 0000000000000060 000000000ead9738 0000000002c0f498 00000000037db028
GPR20: 00000000037dc012 0000000000000000 c0000001fe001018 000000000000005e
GPR24: 0000000000000174 000000000000005d 000000000000005d c0000001fe7a2100
GPR28: c0000001fe001000 000000000000005d c000000000614b20 000000000000005d
[   10.756134] NIP [c0000000000ba93c] .irq_domain_associate_many+0x264/0x290
[   10.796759] LR [c0000000000ba938] .irq_domain_associate_many+0x260/0x290
[   10.836860] Call Trace:
[   10.851448] [c0000000fe65b5f0] [c0000000000ba938] .irq_domain_associate_many+0x260/0x290 (unreliable)
[   10.906658] [c0000000fe65b6c0] [c0000000000bb3b8] .irq_create_mapping+0xc8/0x1d0
[   10.950930] [c0000000fe65b760] [c0000000000bb568] .irq_create_of_mapping+0xa8/0x170
[   10.996764] [c0000000fe65b810] [c0000000002777b0] .irq_of_parse_and_map+0x40/0x58
[   11.041557] [c0000000fe65b8a0] [c0000000002778e0] .of_irq_count+0x30/0x58
[   11.082184] [c0000000fe65b930] [c000000000278204] .of_device_alloc+0x94/0x238
[   11.124894] [c0000000fe65ba30] [c0000000002783fc] .of_platform_device_create_pdata+0x54/0xf8
[   11.175415] [c0000000fe65bad0] [c0000000002785e4] .of_platform_bus_create+0x144/0x1e0
[   11.222292] [c0000000fe65bbc0] [c000000000278640] .of_platform_bus_create+0x1a0/0x1e0
[   11.269168] [c0000000fe65bcb0] [c000000000278830] .of_platform_bus_probe+0xd0/0x140
[   11.315003] [c0000000fe65bd50] [c0000000003f0444] .__machine_initcall_cell_cell_publish_devices+0x54/0x1ac
[   11.372818] [c0000000fe65be20] [c000000000009a70] .do_one_initcall+0x168/0x1d0
[   11.416049] [c0000000fe65bee0] [c0000000003dfb74] .kernel_init+0x14c/0x1f4
[   11.457196] [c0000000fe65bf90] [c00000000001b478] .kernel_thread+0x54/0x70
[   11.498338] Instruction dump:
[   11.516047] 7fa4eb78 7ca507b4 482709ed 60000000 0fe00000 3860ffea 4bffff80 e87e8020
[   11.562403] 7fa4eb78 7fe5fb78 482709cd 60000000 <0fe00000> 39200000 7f83e378 7f44d378
[   11.609801] ---[ end trace a23e1daeebb82ffc ]---
[   11.637919] irq: irq-59==>hwirq-0x3b mapping failed: -22
[   11.669293] ------------[ cut here ]------------
[   11.696887] WARNING: at /usr/src/linux-3.6.11-aufs/kernel/irq/irqdomain.c:444
[   11.739595] Modules linked in:
[   11.757826] NIP: c0000000000ba93c LR: c0000000000ba938 CTR: c0000000000254b0
[   11.800016] REGS: c0000000fe65b190 TRAP: 0700   Tainted: G        W     (3.6.11-aufs)
[   11.846890] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 84000024  XER: 00000000
[   11.893767] SOFTE: 1
[   11.906789] TASK = c0000000fe650000[1] 'swapper/0' THREAD: c0000000fe658000 CPU: 0
GPR00: c0000000000ba938 c0000000fe65b410 c000000000668808 000000000000002c
GPR04: 0000000000000000 000000008d7cac57 0000000000000008 0000000000000000
GPR08: 000000008d893bed 0000000000000000 0000000000000000 0000000000000000
GPR12: d000070000000000 c00000000fffb000 ffffffffffffffff 0000000002c0f498
GPR16: 0000000000000060 000000000ead9738 0000000002c0f498 00000000037db028
GPR20: 00000000037dc012 0000000000000000 c0000001fe001018 000000000000003c
GPR24: 00000000000000ec 000000000000003b 000000000000003b c0000001fe7a2600
GPR28: c0000001fe001000 000000000000003b c000000000614b20 000000000000003b
[   12.272949] NIP [c0000000000ba93c] .irq_domain_associate_many+0x264/0x290
[   12.313574] LR [c0000000000ba938] .irq_domain_associate_many+0x260/0x290
[   12.353675] Call Trace:
[   12.368263] [c0000000fe65b410] [c0000000000ba938] .irq_domain_associate_many+0x260/0x290 (unreliable)
[   12.423473] [c0000000fe65b4e0] [c0000000000bb3b8] .irq_create_mapping+0xc8/0x1d0
[   12.467745] [c0000000fe65b580] [c0000000000bb568] .irq_create_of_mapping+0xa8/0x170
[   12.513579] [c0000000fe65b630] [c0000000002777b0] .irq_of_parse_and_map+0x40/0x58
[   12.558372] [c0000000fe65b6c0] [c0000000002778e0] .of_irq_count+0x30/0x58
[   12.599002] [c0000000fe65b750] [c000000000278204] .of_device_alloc+0x94/0x238
[   12.641708] [c0000000fe65b850] [c0000000002783fc] .of_platform_device_create_pdata+0x54/0xf8
[   12.692231] [c0000000fe65b8f0] [c0000000002785e4] .of_platform_bus_create+0x144/0x1e0
[   12.739107] [c0000000fe65b9e0] [c000000000278640] .of_platform_bus_create+0x1a0/0x1e0
[   12.785983] [c0000000fe65bad0] [c000000000278640] .of_platform_bus_create+0x1a0/0x1e0
[   12.832860] [c0000000fe65bbc0] [c000000000278640] .of_platform_bus_create+0x1a0/0x1e0
[   12.879736] [c0000000fe65bcb0] [c000000000278830] .of_platform_bus_probe+0xd0/0x140
[   12.925572] [c0000000fe65bd50] [c0000000003f0444] .__machine_initcall_cell_cell_publish_devices+0x54/0x1ac
[   12.983385] [c0000000fe65be20] [c000000000009a70] .do_one_initcall+0x168/0x1d0
[   13.026616] [c0000000fe65bee0] [c0000000003dfb74] .kernel_init+0x14c/0x1f4
[   13.067764] [c0000000fe65bf90] [c00000000001b478] .kernel_thread+0x54/0x70
[   13.108905] Instruction dump:
[   13.126614] 7fa4eb78 7ca507b4 482709ed 60000000 0fe00000 3860ffea 4bffff80 e87e8020
[   13.172970] 7fa4eb78 7fe5fb78 482709cd 60000000 <0fe00000> 39200000 7f83e378 7f44d378
[   13.220369] ---[ end trace a23e1daeebb82ffd ]---
[   13.248514] irq: irq-20==>hwirq-0x2 mapping failed: -22
[   13.279339] ------------[ cut here ]------------
[   13.306933] WARNING: at /usr/src/linux-3.6.11-aufs/kernel/irq/irqdomain.c:444
[   13.349642] Modules linked in:
[   13.367873] NIP: c0000000000ba93c LR: c0000000000ba938 CTR: c0000000000254b0
[   13.410062] REGS: c0000000fe65b0a0 TRAP: 0700   Tainted: G        W     (3.6.11-aufs)
[   13.456937] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 84000024  XER: 00000000
[   13.503813] SOFTE: 1
[   13.516836] TASK = c0000000fe650000[1] 'swapper/0' THREAD: c0000000fe658000 CPU: 0
GPR00: c0000000000ba938 c0000000fe65b320 c000000000668808 000000000000002b
GPR04: 0000000000000000 00000000900bf6b2 0000000000000008 0000000000000000
GPR08: 0000000090185006 0000000000000000 0000000000000000 0000000000000000
GPR12: d000070000000000 c00000000fffb000 ffffffffffffffff 0000000002c0f498
GPR16: 0000000000000060 000000000ead9738 0000000002c0f498 00000000037db028
GPR20: 00000000037dc012 0000000000000000 c0000001fe001018 0000000000000015
GPR24: 0000000000000008 0000000000000002 0000000000000014 c0000001fe7a2900
GPR28: c0000001fe001000 0000000000000014 c000000000614b20 0000000000000002
[   13.882996] NIP [c0000000000ba93c] .irq_domain_associate_many+0x264/0x290
[   13.923620] LR [c0000000000ba938] .irq_domain_associate_many+0x260/0x290
[   13.963723] Call Trace:
[   13.978310] [c0000000fe65b320] [c0000000000ba938] .irq_domain_associate_many+0x260/0x290 (unreliable)
[   14.033520] [c0000000fe65b3f0] [c0000000000bb3b8] .irq_create_mapping+0xc8/0x1d0
[   14.077792] [c0000000fe65b490] [c0000000000bb568] .irq_create_of_mapping+0xa8/0x170
[   14.123627] [c0000000fe65b540] [c0000000002777b0] .irq_of_parse_and_map+0x40/0x58
[   14.168419] [c0000000fe65b5d0] [c0000000002778e0] .of_irq_count+0x30/0x58
[   14.209046] [c0000000fe65b660] [c000000000278204] .of_device_alloc+0x94/0x238
[   14.251756] [c0000000fe65b760] [c0000000002783fc] .of_platform_device_create_pdata+0x54/0xf8
[   14.302277] [c0000000fe65b800] [c0000000002785e4] .of_platform_bus_create+0x144/0x1e0
[   14.349154] [c0000000fe65b8f0] [c000000000278640] .of_platform_bus_create+0x1a0/0x1e0
[   14.396031] [c0000000fe65b9e0] [c000000000278640] .of_platform_bus_create+0x1a0/0x1e0
[   14.442906] [c0000000fe65bad0] [c000000000278640] .of_platform_bus_create+0x1a0/0x1e0
[   14.489783] [c0000000fe65bbc0] [c [c00000000001b478] .kernel_thread+0x54/0x70
[   14.765829] Instruction dump:
[   14.783538] 7fa4eb78 7ca507b4 482709ed 60000000 0fe00000 3860ffea 4bffff80 e87e8020
[   14.829893] 7fa4eb78 7fe5fb78 482709cd 60000000 <0fe00000> 39200000 7f83e378 7f44d378
[   14.877292] ---[ end trace a23e1daeebb82ffe ]---
[   14.906827] irq: irq-108==>hwirq-0x66 mapping failed: -22
[   14.938714] ------------[ cut here ]------------
[   14.966305] WARNING: at /usr/src/linux-3.6.11-aufs/kernel/irq/irqdomain.c:444
[   15.009014] Modules linked in:
[   15.027245] NIP: c0000000000ba93c LR: c0000000000ba938 CTR: c0000000000254b0
[   15.069434] REGS: c0000000fe65b280 TRAP: 0700   Tainted: G        W     (3.6.11-aufs)
[   15.116308] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 84000024  XER: 00000000
[   15.163184] SOFTE: 1
[   15.176207] TASK = c0000000fe650000[1] 'swapper/0' THREAD: c0000000fe658000 CPU: 0
GPR00: c0000000000ba938 c0000000fe65b500 c000000000668808 000000000000002d
GPR04: 0000000000000000 0000000092ae860b 0000000000000008 0000000000000000
GPR08: 0000000092bb75bd 0000000000000000 0000000000000000 0000000000000000
GPR12: d000070000000000 c00000000fffb000 ffffffffffffffff 0000000002c0f498
GPR16: 0000000000000060 000000000ead9738 0000000002c0f498 00000000037db028
GPR20: 00000000037dc012 0000000000000000 c0000001fe001018 000000000000006d
GPR24: 0000000000000198 0000000000000066 000000000000006c c0000001fe7a6400
GPR28: c0000001fe001000 000000000000006c c000000000614b20 0000000000000066
[   15.542368] NIP [c0000000000ba93c] .irq_domain_associate_many+0x264/0x290
[   15.582992] LR [c0000000000ba938] .irq_domain_associate_many+0x260/0x290
[   15.623094] Call Trace:
[   15.637681] [c0000000fe65b500] [c0000000000ba938] .irq_domain_associate_many+0x260/0x290 (unreliable)
[   15.692891] [c0000000fe65b5d0] [c0000000000bb3b8] .irq_create_mapping+0xc8/0x1d0
[   15.737164] [c0000000fe65b670] [c0000000000bb568] .irq_create_of_mapping+0xa8/0x170
[   15.782998] [c0000000fe65b720] [c0000000002777b0] .irq_of_parse_and_map+0x40/0x58
[   15.827791] [c0000000fe65b7b0] [c0000000002778e0] .of_irq_count+0x30/0x58
[   15.868417] [c0000000fe65b840] [c000000000278204] .of_device_alloc+0x94/0x238
[   15.911126] [c0000000fe65b940] [c0000000002783fc] .of_platform_device_create_pdata+0x54/0xf8
[   15.961649] [c0000000fe65b9e0] [c0000000002785e4] .of_platform_bus_create+0x144/0x1e0
[   16.008525] [c0000000fe65bad0] [c000000000278640] .of_platform_bus_create+0x1a0/0x1e0
[   16.055402] [c0000000fe65bbc0] [c000000000278640] .of_platform_bus_create+0x1a0/0x1e0
[   16.102278] [c0000000fe65bcb0] [c000000000278830] .of_platform_bus_probe+0xd0/0x140
[   16.148114] [c0000000fe65bd50] [c0000000003f0444] .__machine_initcall_cell_cell_publish_devices+0x54/0x1ac
[   16.205928] [c0000000fe65be20] [c000000000009a70] .do_one_initcall+0x168/0x1d0
[   16.249158] [c0000000fe65bee0] [c0000000003dfb74] .kernel_init+0x14c/0x1f4
[   16.290306] [c0000000fe65bf90] [c00000000001b478] .kernel_thread+0x54/0x70
[   16.331448] Instrucn6475] NIP [c0000000000ba93c] .irq_domain_associate_many+0x264/0x290
[   17.147100] LR [c0000000000ba938] .irq_domain_associate_many+0x260/0x290
[   17.187202] Call Trace:
[   17.201789] [c0000000fe65b500] [c0000000000ba938] .irq_domain_associate_many+0x260/0x290 (unreliable)
[   17.256999] [c0000000fe65b5d0] [c0000000000bb3b8] .irq_create_mapping+0xc8/0x1d0
[   17.301272] [c0000000fe65b670] [c0000000000bb568] .irq_create_of_mapping+0xa8/0x170
[   17.347106] [c0000000fe65b720] [c0000000002777b0] .irq_of_parse_and_map+0x40/0x58
[   17.391898] [c0000000fe65b7b0] [c0000000002778e0] .of_irq_count+0x30/0x58
[   17.432525] [c0000000fe65b840] [c000000000278204] .of_device_alloc+0x94/0x238
[   17.475235] [c0000000fe65b940] [c0000000002783fc] .of_platform_device_create_pdata+0x54/0xf8
[   17.525757] [c0000000fe65b9e0] [c0000000002785e4] .of_platform_bus_create+0x144/0x1e0
[   17.572634] [c0000000fe65bad0] [c000000000278640] .of_platform_bus_create+0x1a0/0x1e0
[   17.619510] [c0000000fe65bbc0] [c000000000278640] .of_platform_bus_create+0x1a0/0x1e0
[   17.666387] [c0000000fe65bcb0] [c000000000278830] .of_platform_bus_probe+0xd0/0x140
[   17.712221] [c0000000fe65bd50] [c0000000003f0444] .__machine_initcall_cell_cell_publish_devices+0x54/0x1ac
[   17.770036] [c0000000fe65be20] [c000000000009a70] .do_one_initcall+0x168/0x1d0
[   17.813266] [c0000000fe65bee0] [c0000000003dfb74] .kernel_init+0x14c/0x1f4
[   17.854415] [c0000000fe65bf90] [c00000000001b478] .kernel_thread+0x54/0x70
[   17.895556] Instruction dump:
[   17.913265] 7fa4eb78 7ca507b4 482709ed 60000000 0fe00000 3860ffea 4bffff80 e87e8020
[   17.959621] 7fa4eb78 7fe5fb78 482709cd 60000000 <0fe00000> 39200000 7f83e378 7f44d378
[   18.007019] ---[ end trace a23e1daeebb83000 ]---
[   18.034834] irq: irq-42==>hwirq-0x27 mapping failed: -22
[   18.066406] ------------[ cut here ]------------
[   18.094000] WARNING: at /usr/src/linux-3.6.11-aufs/kernel/irq/irqdomain.c:444
[   18.136709] Modules linked in:
[   18.154940] NIP: c0000000000ba93c LR: c0000000000ba938 CTR: c0000000000254b0
[   18.197130] REGS: c0000000fe65b280 TRAP: 0700   Tainted: G        W     (3.6.11-aufs)
[   18.244004] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 84000024  XER: 00000000
[   18.290880] SOFTE: 1
[   18.303903] TASK = c0000000fe650000[1] 'swapper/0' THREAD: c0000000fe658000 CPU: 0
GPR00: c0000000000ba938 c0000000fe65b500 c000000000668808 000000000000002c
GPR04: 0000000000000000 0000000097a78110 0000000000000008 0000000000000000
GPR08: 0000000097b405d5 0000000000000000 0000000000000000 0000000000000000
GPR12: d000070000000000 c00000000fffb000 ffffffffffffffff 0000000002c0f498
GPR16: 0000000000000060 000000000ead9738 0000000002c0f498 00000000037db028
GPR20: 00000000037dc012 0000000000000000 c0000001fe001018 000000000000002b
GPR24: 000000000000009c 0000000000000027 000000000000002a c0000001fe7a6500
GPR28: c0000001fe001000 000000000000002a c000000000614b20 0000000000000027
[   18.670062] NIP [c0000000000ba93c] .irq_domain_associate_many+0x264/0x290
[9.376854] [c0000000fe65bee0] [c0000000003dfb74] .kernel_init+0x14c/0x1f4
[   19.418000] [c0000000fe65bf90] [c00000000001b478] .kernel_thread+0x54/0x70
[   19.459143] Instruction dump:
[   19.476852] 7fa4eb78 7ca507b4 482709ed 60000000 0fe00000 3860ffea 4bffff80 e87e8020
[   19.523208] 7fa4eb78 7fe5fb78 482709cd 60000000 <0fe00000> 39200000 7f83e378 7f44d378
[   19.570606] ---[ end trace a23e1daeebb83001 ]---
[   19.598449] iommu: missing iommu for <no-node> (node -1)
[   19.630031] iommu: missing iommu for <no-node> (node -1)
[   19.661896] axon_msi: setup MSIC on /axon@10000000000/plb5/msic@4000004400003000
[   19.706220] axon_msi: setup MSIC on /axon@30000000000/plb5/msic@4000004400003000
[   19.751382] bio: create slab <bio-0> at 0
[   19.775232] vgaarb: loaded
[   19.791382] Switching to clocksource timebase
[   19.823496] NET: Registered protocol family 2
[   19.851983] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
[   19.904057] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[   19.946030] TCP: Hash tables configured (established 524288 bind 65536)
[   19.985278] TCP: reno registered
[   20.004540] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[   20.041124] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[   20.080321] PCI: CLS 0 bytes, default 128
[   20.104111] Unpacking initramfs...
[   22.854958] Freeing initrd memory: 7020k freed
[   22.882363] iommu: missing iommu for <no-node> (node -1)
[   22.913895] Setting up PCI bus /axon@10000000000/plb5/plb4/pcix@4000004600000000
[   22.958055] PCI host bridge /axon@10000000000/plb5/plb4/pcix@4000004600000000  ranges:
[   23.005414]   IO 0x0000014608000000..0x000001460800ffff -> 0x0000000000000000
[   23.048120]  MEM 0x0000014780000000..0x00000147bfffffff -> 0x0000000080000000
[   23.091360]  MEM 0x00000147c0000000..0x00000147ffffffff -> 0x00000000c0000000 Prefetch
[   23.138865] of-pci 14600000000.pcix: PCI host bridge to bus 0000:00
[   23.176252] pci_bus 0000:00: root bus resource [io  0x10000-0x1ffff] (bus address [0x0000-0xffff])
[   23.229893] pci_bus 0000:00: root bus resource [mem 0x14780000000-0x147bfffffff] (bus address [0x80000000-0xbfffffff])
[   23.293958] pci_bus 0000:00: root bus resource [mem 0x147c0000000-0x147ffffffff pref] (bus address [0xc0000000-0xffffffff])
[   23.360632] pci_bus 0000:00: busn_res: [bus 00-ff] is inserted under domain [bus 00-ff]
[   23.408542] pci_bus 0000:00: root bus resource [bus 00-ff]
[   23.441357] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to ff
[   23.481038] pci 0000:00:01.0: [14e4:16a8] type 00 class 0x020000
[   23.516978] pci 0000:00:01.0: reg 10: [mem 0x14780000000-0x1478000ffff 64bit]
[   23.560015] pci 0000:00:01.0: PME# supported from D3hot D3cold
[   23.594619] pci 0000:00:01.1: [14e4:16a8] type 00 class 0x020000
[   23.630519] pci 0000:00:01.1: reg 10: [mem 0x14780010000-0x1478001ffff 64bit]
[   23.673553] pci 0000:00:01.1: PME# supported from D3hot D3cold
[   23.708197] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
[   23.747817] Setting up PCI bus /axon@10000000000/plb5/pciex@a00000a000000000
[   23.789821] PCI host bridge /axon@10000000000/plb5/pciex@a00000a000000000  ranges:
[   23.835121]   IO 0x000001a100000000..0x000001a10000ffff -> 0x0000000000000000
[   23.877831]  MEM 0x000001c080000000..0x000001c0bfffffff -> 0x0000000080000000
[   23.921065]  MEM 0x000001c0c0000000..0x000001c0ffffffff -> 0x00000000c0000000 Prefetch
[   23.968536] of-pci D18000002400.pciex: PCI host bridge to bus 0001:00
[   24.007001] pci_bus 0001:00: root bus resource [io  0x21000-0x30fff] (bus address [0x0000-0xffff])
[   24.060648] pci_bus 0001:00: root bus resource [mem 0x1c080000000-0x1c0bfffffff] (bus address [0x80000000-0xbfffffff])
[   24.124712] pci_bus 0001:00: root bus resource [mem 0x1c0c0000000-0x1c0ffffffff pref] (bus address [0xc0000000-0xffffffff])
[   24.191383] pci_bus 0001:00: busn_res: [bus 00-ff] is inserted under domain [bus 00-ff]
[   24.239295] pci_bus 0001:00: root bus resource [bus 00-ff]
[   24.272109] pci_bus 0001:00: busn_res: [bus 00-ff] end is updated to ff
[   24.311780] pci 0001:00:00.0: [1014:032c] type 01 class 0x060400
[   24.347720] pci 0001:00:00.0: reg 10: [mem 0x00000000-0x7fffffff 64bit pref]
[   24.389867] pci 0001:00:00.0: reg 38: [mem 0x1c0ffff8000-0x1c0ffffffff pref]
[   24.432068] PCI: Hiding resources on Axon PCIE RC 0001:00:00.0
[   24.467137] pci 0001:00:00.0: supports D1 D2
[   24.492427] pci 0001:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   24.532148] irq: no irq domain found for /axon@10000000000/plb5/pciex-utl@a00000a000004000 !
[   24.582772] pci_bus 0001:01: busn_res: [bus 01] is inserted under [bus 00-ff]
[   24.625247] pci 0001:00:00.0: PCI bridge to [bus 01]
[   24.655032] pci_bus 0001:00: busn_res: [bus 00-ff] end is updated to 01
[   24.694651] Setting up PCI bus /axon@10000000000/plb5/pciex@a00000a200000000
[   24.736724] PCI host bridge /axon@10000000000/plb5/pciex@a00000a200000000  ranges:
[   24.782024]   IO 0x000001a300000000..0x000001a30000ffff -> 0x0000000000000000
[   24.824734]  MEM 0x000001d080000000..0x000001d0bfffffff -> 0x0000000080000000
[   24.867963]  MEM 0x000001d0c0000000..0x000001d0ffffffff -> 0x00000000c0000000 Prefetch
[   24.915433] of-pci D18000002800.pciex: PCI host bridge to bus 0002:00
[   24.953903] pci_bus 0002:00: root bus resource [io  0x32000-0x41fff] (bus address [0x0000-0xffff])
[   25.007553] pci_bus 0002:00: root bus resource [mem 0x1d080000000-0x1d0bfffffff] (bus address [0x80000000-0xbfffffff])
[   25.071614] pci_bus 0002:00: root bus resource [mem 0x1d0c0000000-0x1d0ffffffff pref] (bus address [0xc0000000-0xffffffff])
[   25.138283] pci_bus 0002:00: busn_res: [bus 00-ff] is inserted under domain [bus 00-ff]
[   25.186198] pci_bus 0002:00: root bus resource [bus 00-ff]
[   25.219012] pci_bus 0002:00: busn_res: [bus 00-ff] end is updated to ff
[   25.258682] pci 0002:00:00.0: [1014:032c] type 01 class 0x060400
[   25.294623] pci 0002:00:00.0: reg 10: [mem 0x00000000-0x7fffffff 64bit pref]
[   25.336770] pci 0002:00:00.0: reg 38: [mem 0x1d0ffff8000-0x1d0ffffffff pref]
[   25.378971] PCI: Hiding resources on Axon PCIE RC 0002:00:00.0
[   25.414030] pci 0002:00:00.0: supports D1 D2
[   25.439331] pci 0002:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   25.479038] irq: no irq domain found for /axon@10000000000/plb5/pciex-utl@a00000a200004000 !
[   25.529676] pci_bus 0002:01: busn_res: [bus 01] is inserted under [bus 00-ff]
[   25.572151] pci 0002:00:00.0: PCI bridge to [bus 01]
[   25.601933] pci_bus 0002:00: busn_res: [bus 00-ff] end is updated to 01
[   25.641567] Setting up PCI bus /axon@30000000000/plb5/plb4/pcix@4000004600000000
[   25.685712] PCI host bridge /axon@30000000000/plb5/plb4/pcix@4000004600000000  ranges:
[   25.733096]   IO 0x0000034608000000..0x000003460800ffff -> 0x0000000000000000
[   25.775804]  MEM 0x0000034780000000..0x00000347bfffffff -> 0x0000000080000000
[   25.819034]  MEM 0x00000347c0000000..0x00000347ffffffff -> 0x00000000c0000000 Prefetch
[   25.866515] of-pci 34600000000.pcix: PCI host bridge to bus 0003:00
[   25.903931] pci_bus 0003:00: root bus resource [io  0x43000-0x52fff] (bus address [0x0000-0xffff])
[   25.957577] pci_bus 0003:00: root bus resource [mem 0x34780000000-0x347bfffffff] (bus address [0x80000000-0xbfffffff])
[   26.021642] pci_bus 0003:00: root bus resource [mem 0x347c0000000-0x347ffffffff pref] (bus address [0xc0000000-0xffffffff])
[   26.088311] pci_bus 0003:00: busn_res: [bus 00-ff] is inserted under domain [bus 00-ff]
[   26.136228] pci_bus 0003:00: root bus resource [bus 00-ff]
[   26.169040] pci_bus 0003:00: busn_res: [bus 00-ff] end is updated to ff
[   26.208674] pci 0003:00:01.0: [1033:0035] type 00 class 0x0c0310
[   26.244638] pci 0003:00:01.0: reg 10: [mem 0x34780000000-0x34780000fff]
[   26.284501] pci 0003:00:01.0: supports D1 D2
[   26.309668] pci 0003:00:01.0: PME# supported from D0 D1 D2 D3hot
[   26.345691] pci 0003:00:01.1: [1033:0035] type 00 class 0x0c0310
[   26.381620] pci 0003:00:01.1: reg 10: [mem 0x34780001000-0x34780001fff]
[   26.421491] pci 0003:00:01.1: supports D1 D2
[   26.446651] pci 0003:00:01.1: PME# supported from D0 D1 D2 D3hot
[   26.482675] pci 0003:00:01.2: [1033:00e0] type 00 class 0x0c0320
[   26.518603] pci 0003:00:01.2: reg 10: [mem 0x34780002000-0x347800020ff]
[   26.558472] pci 0003:00:01.2: supports D1 D2
[   26.583635] pci 0003:00:01.2: PME# supported from D0 D1 D2 D3hot
[   26.619724] pci_bus 0003:00: busn_res: [bus 00-ff] end is updated to 00
[   26.761253] pci 0003:00:01.2: enabling device (0140 -> 0142)
[   26.794828] Setting up PCI bus /axon@30000000000/plb5/pciex@a00000a000000000
[   26.836889] PCI host bridge /axon@30000000000/plb5/pciex@a00000a000000000  ranges:
[   26.882190]   IO 0x000003a100000000..0x000003a10000ffff -> 0x0000000000000000
[   26.924899]  MEM 0x000003c080000000..0x000003c0bfffffff -> 0x0000000080000000
[   26.968134]  MEM 0x000003c0c0000000..0x000003c0ffffffff -> 0x00000000c0000000 Prefetch
[   27.015609] of-pci D38000002400.pciex: PCI host bridge to bus 0004:00
[   27.054072] pci_bus 0004:00: root bus resource [io  0x54000-0x63fff] (bus address [0x0000-0xffff])
[   27.107717] pci_bus 0004:00: root bus resource [mem 0x3c080000000-0x3c0bfffffff] (bus address [0x80000000-0xbfffffff])
[   27.171780] pci_bus 0004:00: root bus resource [mem 0x3c0c0000000-0x3c0ffffffff pref] (bus address [0xc0000000-0xffffffff])
[   27.238449] pci_bus 0004:00: busn_res: [bus 00-ff] is inserted under domain [bus 00-ff]
[   27.286363] pci_bus 0004:00: root bus resource [bus 00-ff]
[   27.319179] pci_bus 0004:00: busn_res: [bus 00-ff] end is updated to ff
[   27.358854] pci 0004:00:00.0: [1014:032c] type 01 class 0x060400
[   27.394794] pci 0004:00:00.0: reg 10: [mem 0x00000000-0x7fffffff 64bit pref]
[   27.436939] pci 0004:00:00.0: reg 38: [mem 0x3c0ffff8000-0x3c0ffffffff pref]
[   27.479145] PCI: Hiding resources on Axon PCIE RC 0004:00:00.0
[   27.514218] pci 0004:00:00.0: supports D1 D2
[   27.539495] pci 0004:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   27.579230] irq: no irq domain found for /axon@30000000000/plb5/pciex-utl@a00000a000004000 !
[   27.629860] pci_bus 0004:01: busn_res: [bus 01] is inserted under [bus 00-ff]
[   27.672314] pci 0004:00:00.0: PCI bridge to [bus 01]
[   27.702107] pci_bus 0004:00: busn_res: [bus 00-ff] end is updated to 01
[   27.741724] Setting up PCI bus /axon@30000000000/plb5/pciex@a00000a200000000
[   27.783790] PCI host bridge /axon@30000000000/plb5/pciex@a00000a200000000  ranges:
[   27.829092]   IO 0x000003a300000000..0x000003a30000ffff -> 0x0000000000000000
[   27.871803]  MEM 0x000003d080000000..0x000003d0bfffffff -> 0x0000000080000000
[   27.915031]  MEM 0x000003d0c0000000..0x000003d0ffffffff -> 0x00000000c0000000 Prefetch
[   27.962516] of-pci D38000002800.pciex: PCI host bridge to bus 0005:00
[   28.000971] pci_bus 0005:00: root bus resource [io  0x65000-0x74fff] (bus address [0x0000-0xffff])
[   28.054618] pci_bus 0005:00: root bus resource [mem 0x3d080000000-0x3d0bfffffff] (bus address [0x80000000-0xbfffffff])
[   28.118682] pci_bus 0005:00: root bus resource [mem 0x3d0c0000000-0x3d0ffffffff pref] (bus address [0xc0000000-0xffffffff])
[   28.185353] pci_bus 0005:00: busn_res: [bus 00-ff] is inserted under domain [bus 00-ff]
[   28.233267] pci_bus 0005:00: root bus resource [bus 00-ff]
[   28.266080] pci_bus 0005:00: busn_res: [bus 00-ff] end is updated to ff
[   28.305755] pci 0005:00:00.0: [1014:032c] type 01 class 0x060400
[   28.341695] pci 0005:00:00.0: reg 10: [mem 0x00000000-0x7fffffff 64bit pref]
[   28.383842] pci 0005:00:00.0: reg 38: [mem 0x3d0ffff8000-0x3d0ffffffff pref]
[   28.426043] PCI: Hiding resources on Axon PCIE RC 0005:00:00.0
[   28.461115] pci 0005:00:00.0: supports D1 D2
[   28.486398] pci 0005:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   28.526116] irq: no irq domain found for /axon@30000000000/plb5/pciex-utl@a00000a200004000 !
[   28.576762] pci_bus 0005:01: busn_res: [bus 01] is inserted under [bus 00-ff]
[   28.619382] pci 0005:01:00.0: [15b3:634a] type 00 class 0x0c0600
[   28.655326] pci 0005:01:00.0: reg 10: [mem 0x3d080000000-0x3d0800fffff 64bit]
[   28.698001] pci 0005:01:00.0: reg 18: [mem 0x3d0c0000000-0x3d0c1ffffff 64bit pref]
[   28.744181] pci 0005:00:00.0: PCI bridge to [bus 01]
[   28.773481] pci 0005:00:00.0:   bridge window [mem 0x3d080000000-0x3d0800fffff]
[   28.817219] pci 0005:00:00.0:   bridge window [mem 0x3d0c0000000-0x3d0c1ffffff 64bit pref]
[   28.866752] pci_bus 0005:00: busn_res: [bus 00-ff] end is updated to 01
[   28.906596] iommu: missing iommu for <no-node> (node -1)
[   28.942003] iommu: missing iommu for <no-node> (node -1)
[   28.979542] msgmni has been set to 15888
[   29.002740] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[   29.046837] io scheduler noop registered
[   29.070268] io scheduler deadline registered
[   29.095984] io scheduler cfq registered (default)
[   29.168736] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[   29.206481] iommu: missing iommu for <no-node> (node -1)
[   29.259915] serial8250.0: ttyS0 at MMIO 0x14540000200 (irq = 16) is a U6_16550A
[   29.303338] console [ttyS0] enabled, bootconsole disabled
[   29.303338] console [ttyS0] enabled, bootconsole disabled
[   29.389162] serial8250.0: ttyS1 at MMIO 0x14540000300 (irq = 17) is a U6_16550A
[   29.454303] serial8250.0: ttyS2 at MMIO 0x34540000200 (irq = 18) is a U6_16550A
[   29.519453] serial8250.0: ttyS3 at MMIO 0x34540000300 (irq = 19) is a U6_16550A
[   29.563961] mousedev: PS/2 mouse device common for all mice
[   29.597418] cpuidle: using governor ladder
[   29.621974] cpuidle: using governor menu
[   29.645908] TCP: cubic registered
[   29.665828] Key type dns_resolver registered
[   29.693738] /usr/src/linux-3.6.11-aufs/drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[   29.749311] Freeing unused kernel memory: 2016k freed
[   30.040855] dracut: dracut-dracut-024-3246731
[   30.272613] dracut: FATAL: No or empty root= argument
[   30.302997] dracut: Refusing to continue

--nextPart3972859.NtQBm7c9En--

--nextPart1567729.12I4HcqslV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEABECAAYFAlDYWw4ACgkQjqfyF1DtJW6mmwCeKmToBxFO2YgzQVnQ9JWBD5g8
fkEAoIxzUPZSmeBkQ9c2MOBvSNplwik8
=VdWG
-----END PGP SIGNATURE-----

--nextPart1567729.12I4HcqslV--
