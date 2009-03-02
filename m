Return-Path: <sachinp@in.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [59.145.155.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp09.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D0BF6DDF19
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Mar 2009 17:55:09 +1100 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp09.in.ibm.com (8.13.1/8.13.1) with ESMTP id n226UexW004099
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Mar 2009 12:00:40 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n226rbiR143556
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Mar 2009 12:23:37 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.13.1/8.13.3) with ESMTP id n226rTWd023906
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Mar 2009 17:53:30 +1100
Message-ID: <49AB8269.9080600@in.ibm.com>
Date: Mon, 02 Mar 2009 12:23:29 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.29-rc6-git4 boot failure
References: <49A7DA4B.7060404@in.ibm.com> <1235768752.7388.94.camel@pasglop>
	<1235951557.7248.1.camel@pasglop>
In-Reply-To: <1235951557.7248.1.camel@pasglop>
Content-Type: multipart/mixed; boundary="------------030806050907010407050501"
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@ozlabs.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030806050907010407050501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:
> Ok, so I tried here on a dual G5 and couldn't reproduce with -rc6
> g64e7130.
>
> Now, it would be nice if you guys stopped sending stripped down dmesg...
> the whole thing is potentially relevant. Also, which compiler version
> did you use to generate this kernel ?
>   
Hi Ben, Sorry about not attaching the complete log. Here it is. This is
with git5 kernel.

The machines has an older version of compiler. Here are the details :

# gcc -v
Using built-in specs.
Target: powerpc-linux-gnu
Configured with: ../src/configure -v --enable-languages=c,c++,java,f95,
objc,ada,treelang --prefix=/usr --with-gxx-include-dir=/usr/include/c++/4.0.2
--enable-shared --with-system-zlib --libexecdir=/usr/lib --enable-nls
--without-included-gettext --enable-threads=posix --program-suffix=-4.0
--enable-__cxa_atexit --enable-libstdcxx-allocator=mt --enable-clocale=gnu
--enable-libstdcxx-debug --enable-java-gc=boehm --enable-java-awt=gtk-default
--enable-gtk-cairo --with-java-home=/usr/lib/jvm/java-1.4.2-gcj-4.0-1.4.2.0/jre
--enable-mpfr --disable-softfloat --enable-targets=powerpc-linux,powerpc64-linux
--with-cpu=default32 --disable-werror --enable-checking=release powerpc-linux-gnu
Thread model: posix
gcc version 4.0.2 20050808 (prerelease) (Ubuntu 4.0.1-4ubuntu9)

# ld -v
GNU ld version 2.16.1 Debian GNU/Linux
# 

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------


--------------030806050907010407050501
Content-Type: text/plain;
 name="dmesg_log"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="dmesg_log"

[1;37m[2;40mConfig file read, 2093 bytes
Welcome to yaboot version 1.3.13
Enter "help" to get some basic usage information
boot: autobench
Please wait, loading kernel...
   Elf64 kernel loaded...
Loading ramdisk...
ramdisk loaded at 01b00000, size: 5428 Kbytes
OF stdout device is: /ht@0,f2000000/pci@3/mac-io@7/escc@13000/ch-a@13020
command line: root=/dev/sda4 ro console=tty0 console=ttyS0,57600 autobench_args: root=/dev/sda7 ABAT:1235973754 
memory layout at init:
  alloc_bottom : 000000000204d000
  alloc_top    : 0000000030000000
  alloc_top_hi : 0000000280000000
  rmo_top      : 0000000030000000
  ram_top      : 0000000280000000
Looking for displays
found display   : /pci@0,f0000000/ATY,SimoneParent@10/ATY,Simone_A@0, opening ... done
found display   : /pci@0,f0000000/ATY,SimoneParent@10/ATY,Simone_B@1, opening ... done
copying OF device tree ...
Building dt strings...
Building dt structure...
Device tree strings 0x000000000234e000 -> 0x000000000234f64c
Device tree struct  0x0000000002350000 -> 0x0000000002389000
Calling quiesce ...
returning from prom_init
Hello World !
[    0.000000] DART table allocated at: c00000007f000000
[    0.000000] Using PowerMac machine description
[    0.000000] Found initrd at 0xc000000001b00000:0xc00000000204d000
[    0.000000] Found U3 memory controller & host bridge @ 0xf8000000 revision: 0xb3
[    0.000000] Mapped at 0xd000080080000000
[    0.000000] Found a K2 mac-io controller, rev: 32, mapped at 0xd000080080041000
[    0.000000] PowerMac motherboard: PowerMac G5
[    0.000000] boot stdout isn't a display !
[    0.000000] DART IOMMU initialized for U3 type chipset
[    0.000000] console [udbg0] enabled
[    0.000000] CPU maps initialized for 1 thread per core
[    0.000000] Starting Linux PPC64 #1 SMP Mon Mar 2 05:26:24 UTC 2009
[    0.000000] -----------------------------------------------------
[    0.000000] ppc64_pft_size                = 0x0
[    0.000000] physicalMemorySize            = 0x200000000
[    0.000000] htab_address                  = 0xc000000278000000
[    0.000000] htab_hash_mask                = 0xfffff
[    0.000000] -----------------------------------------------------
[    0.000000] Linux version 2.6.29-rc6-git5-autokern1 (root@elm3b19) (gcc version 4.0.2 20050808 (prerelease) (Ubuntu 4.0.1-4ubuntu9)) #1 SMP Mon Mar 2 05:26:24 UTC 2009
CF000012

Setup Arch
[    0.000000] [boot]0012 Setup Arch
[    0.000000] Found U3-AGP PCI host bridge.  Firmware bus number: 240->255
[    0.000000] PCI host bridge /pci@0,f0000000  ranges:
[    0.000000]  MEM 0x00000000f1000000..0x00000000f1ffffff -> 0x00000000f1000000 
[    0.000000]   IO 0x00000000f0000000..0x00000000f07fffff -> 0x0000000000000000
[    0.000000]  MEM 0x0000000090000000..0x00000000afffffff -> 0x0000000090000000 
[    0.000000] Can't get bus-range for /ht@0,f2000000, assume bus 0
[    0.000000] Found U3-HT PCI host bridge.  Firmware bus number: 0->239
[    0.000000] PCI host bridge /ht@0,f2000000 (primary) ranges:
[    0.000000] via-pmu: Server Mode is enabled
[    0.000000] PMU driver v2 initialized for Core99, firmware: 0c
[    0.000000] nvram: Checking bank 0...
[    0.000000] nvram: gen0=776, gen1=777
[    0.000000] nvram: Active bank is: 1
[    0.000000] nvram: OF partition at 0x410
[    0.000000] nvram: XP partition at 0x1020
[    0.000000] nvram: NR partition at 0x1120
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00280000
[    0.000000]   Normal   0x00280000 -> 0x00280000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00080000
[    0.000000]     0: 0x00100000 -> 0x00280000
CF000015

Setup Done
[    0.000000] [boot]0015 Setup Done
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 2061312
[    0.000000] Policy zone: DMA
[    0.000000] Kernel command line: root=/dev/sda4 ro console=tty0 console=ttyS0,57600 autobench_args: root=/dev/sda7 ABAT:1235973754 
[    0.000000] mpic: Setting up MPIC " MPIC 1   " version 1.2 at 80040000, max 4 CPUs
[    0.000000] mpic: ISU size: 120, shift: 7, mask: 7f
[    0.000000] mpic: Initializing for 120 sources
[    0.000000] mpic: Setting up MPIC " MPIC 2   " version 1.2 at f8040000, max 4 CPUs
[    0.000000] mpic: ISU size: 120, shift: 7, mask: 7f
[    0.000000] mpic: Initializing for 120 sources
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] clocksource: timebase mult[7800001] shift[22] registered
[    0.012359] Console: colour dummy device 80x25
[    0.021190] console [tty0] enabled
[    0.000000] DART table allocated at: c00000007f000000
[    0.000000] Using PowerMac machine description
[    0.000000] Found initrd at 0xc000000001b00000:0xc00000000204d000
[    0.000000] Found U3 memory controller & host bridge @ 0xf8000000 revision: 0xb3
[    0.000000] Mapped at 0xd000080080000000
[    0.000000] Found a K2 mac-io controller, rev: 32, mapped at 0xd000080080041000
[    0.000000] PowerMac motherboard: PowerMac G5
[    0.000000] boot stdout isn't a display !
[    0.000000] DART IOMMU initialized for U3 type chipset
[    0.000000] console [udbg0] enabled
[    0.000000] CPU maps initialized for 1 thread per core
[    0.000000] Starting Linux PPC64 #1 SMP Mon Mar 2 05:26:24 UTC 2009
[    0.000000] -----------------------------------------------------
[    0.000000] ppc64_pft_size                = 0x0
[    0.000000] physicalMemorySize            = 0x200000000
[    0.000000] htab_address                  = 0xc000000278000000
[    0.000000] htab_hash_mask                = 0xfffff
[    0.000000] -----------------------------------------------------
[    0.000000] Linux version 2.6.29-rc6-git5-autokern1 (root@elm3b19) (gcc version 4.0.2 20050808 (prerelease) (Ubuntu 4.0.1-4ubuntu9)) #1 SMP Mon Mar 2 05:26:24 UTC 2009
[    0.000000] [boot]0012 Setup Arch
[    0.000000] Found U3-AGP PCI host bridge.  Firmware bus number: 240->255
[    0.000000] PCI host bridge /pci@0,f0000000  ranges:
[    0.000000]  MEM 0x00000000f1000000..0x00000000f1ffffff -> 0x00000000f1000000 
[    0.000000]   IO 0x00000000f0000000..0x00000000f07fffff -> 0x0000000000000000
[    0.000000]  MEM 0x0000000090000000..0x00000000afffffff -> 0x0000000090000000 
[    0.000000] Can't get bus-range for /ht@0,f2000000, assume bus 0
[    0.000000] Found U3-HT PCI host bridge.  Firmware bus number: 0->239
[    0.000000] PCI host bridge /ht@0,f2000000 (primary) ranges:
[    0.000000] via-pmu: Server Mode is enabled
[    0.000000] PMU driver v2 initialized for Core99, firmware: 0c
[    0.000000] nvram: Checking bank 0...
[    0.000000] nvram: gen0=776, gen1=777
[    0.000000] nvram: Active bank is: 1
[    0.000000] nvram: OF partition at 0x410
[    0.000000] nvram: XP partition at 0x1020
[    0.000000] nvram: NR partition at 0x1120
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00280000
[    0.000000]   Normal   0x00280000 -> 0x00280000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00080000
[    0.000000]     0: 0x00100000 -> 0x00280000
[    0.000000] [boot]0015 Setup Done
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 2061312
[    0.000000] Policy zone: DMA
[    0.000000] Kernel command line: root=/dev/sda4 ro console=tty0 console=ttyS0,57600 autobench_args: root=/dev/sda7 ABAT:1235973754 
[    0.000000] mpic: Setting up MPIC " MPIC 1   " version 1.2 at 80040000, max 4 CPUs
[    0.000000] mpic: ISU size: 120, shift: 7, mask: 7f
[    0.000000] mpic: Initializing for 120 sources
[    0.000000] mpic: Setting up MPIC " MPIC 2   " version 1.2 at f8040000, max 4 CPUs
[    0.000000] mpic: ISU size: 120, shift: 7, mask: 7f
[    0.000000] mpic: Initializing for 120 sources
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] clocksource: timebase mult[7800001] shift[22] registered
[    0.012359] Console: colour dummy device 80x25
[    0.021190] console [tty0] enabledú[    0.641012] console handover: boot [udbg0] -> real [ttyS0]
[    0.657617] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.680829] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.697623] freeing bootmem node 0
[    0.941314] Memory: 8085276k/8388608k available (4348k kernel code, 303332k reserved, 760k data, 436k bss, 272k init)
[    0.962416] Calibrating delay loop... 66.56 BogoMIPS (lpj=133120)
[    1.062043] Security Framework initialized
[    1.070127] SELinux:  Disabled at boot.
[    1.077792] Mount-cache hash table entries: 256
smp_core99_probe
[    1.092683] PowerMac SMP probe found 2 cpus
[    1.101139] KeyWest i2c @0xf8001003 irq 42 /u3@0,f8000000/i2c@f8001000
[    1.114021]  channel 0 bus <multibus>
[    1.121311]  channel 1 bus <multibus>
[    1.128626] KeyWest i2c @0x80018000 irq 26 /ht@0,f2000000/pci@3/mac-io@7/i2c@18000
[    1.143710]  channel 0 bus <multibus>
[    1.151006] PMU i2c /ht@0,f2000000/pci@3/mac-io@7/via-pmu@16000/pmu-i2c
[    1.164199]  channel 1 bus <multibus>
[    1.171490]  channel 2 bus <multibus>
[    1.178854] Processor timebase sync using Cypress i2c clock
[    1.189891] mpic: requesting IPIs ... 
smp_core99_kick_cpu
smp_core99_kick_cpu done
[    1.206762] Processor 1 found.
[    1.250881] Brought up 2 CPUs
[    1.250910] Unable to handle kernel paging request for data at address 0x00000009
[    1.250913] Faulting instruction address: 0xc00000000005b5d8
[    1.250917] Oops: Kernel access of bad area, sig: 11 [#1]
[    1.250920] SMP NR_CPUS=32 NUMA PowerMac
[    1.250923] Modules linked in:
[    1.250927] NIP: c00000000005b5d8 LR: c00000000006f950 CTR: c00000000005b5a0
[    1.250931] REGS: c0000002763c3c80 TRAP: 0300   Not tainted  (2.6.29-rc6-git5-autokern1)
[    1.250933] MSR: 9000000000009032 <EE,ME,IR,DR>  CR: 24000084  XER: 000fffff
[    1.250941] DAR: 0000000000000009, DSISR: 0000000040000000
[    1.250944] TASK = c0000002760e20c0[5] 'ksoftirqd/1' THREAD: c0000002763c0000 CPU: 1
[    1.250946] GPR00: 0000000000000000 c0000002763c3f00 c0000000005008f8 0000000000000001 
[    1.250951] GPR04: c0000002760e28d0 0000000000000000 0000000024000082 c0000000000101bc 
[    1.250956] GPR08: 0000000000000000 000000000ec1c518 c00000000051ca40 0000000000000010 
[    1.250960] GPR12: c000000000524700 c000000000524500 0000000000000000 0000000000000000 
[    1.250965] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
[    1.250969] GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000001400000 
[    1.250973] GPR24: 00000000018314c0 c000000000431260 c000000000529680 0000000000000000 
[    1.250978] GPR28: c0000002760bfc48 0000000000000001 c00000000049f770 c0000000004b7300 
[    1.250989] NIP [c00000000005b5d8] .tasklet_kill_immediate+0x38/0xb8
[    1.250996] LR [c00000000006f950] .kthread+0x78/0xc4
[    1.250997] Call Trace:
[    1.251001] [c0000002763c3f00] [c00000000006f918] .kthread+0x40/0xc4 (unreliable)
[    1.251008] [c0000002763c3f90] [c000000000022fe8] .kernel_thread+0x54/0x70
[    1.251010] Instruction dump:
[    1.251012] 7c8b07b4 7d693670 7d290194 556b06be e95e8038 7d2907b4 79291f24 e94a0000 
[    1.251018] 7c0a482a 7c005c36 780007e0 0b000000 <e8030008> 7800ffe2 0b000000 e8030008 
[    1.251033] ---[ end trace 31fd0ba7d8756001 ]---
[    1.251059] Unable to handle kernel paging request for data at address 0x00000000
[    1.251062] Faulting instruction address: 0xc0000000000db8ac
[    1.251065] Oops: Kernel access of bad area, sig: 11 [#2]
[    1.251067] SMP NR_CPUS=32 NUMA PowerMac
[    1.251070] Modules linked in:
[    1.251073] NIP: c0000000000db8ac LR: c000000000051d30 CTR: 0000000000000003
[    1.251076] REGS: c0000002763c35d0 TRAP: 0300   Tainted: G      D     (2.6.29-rc6-git5-autokern1)
[    1.251079] MSR: 9000000000009032 <EE,ME,IR,DR>  CR: 28004082  XER: 200fffff
[    1.251085] DAR: 0000000000000000, DSISR: 0000000040000000
[    1.251088] TASK = c0000002760e20c0[5] 'ksoftirqd/1' THREAD: c0000002763c0000 CPU: 1
[    1.251091] GPR00: 0000000000000004 c0000002763c3850 c0000000005008f8 c000000276027d00 
[    1.251095] GPR04: c0000002763b6980 0000000000000000 000000000000001f c00000000045e0d0 
[    1.251100] GPR08: c0000002760e2288 0000000000000000 c000000000524500 c0000002763b6080 
[    1.251104] GPR12: 0000000048000084 c000000000524500 0000000000000000 0000000000000000 
[    1.251109] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
[    1.251113] GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000001 
[    1.251118] GPR24: c0000002760e20b0 c0000002760e2220 0000000000000000 c000000276027d00 
[    1.251122] GPR28: 0000000000000000 c0000002763b6980 c0000000004a37c8 0000000000000000 
[    1.251131] NIP [c0000000000db8ac] .kmem_cache_free+0x1b8/0x244
[    1.251135] LR [c000000000051d30] .__cleanup_sighand+0x44/0x5c
[    1.251137] Call Trace:
[    1.251140] [c0000002763c3850] [c0000000004a19a0] 0xc0000000004a19a0 (unreliable)
[    1.251145] [c0000002763c3900] [c000000000051d30] .__cleanup_sighand+0x44/0x5c
[    1.251150] [c0000002763c3980] [c000000000057e74] .release_task+0x320/0x44c
[    1.251154] [c0000002763c3a20] [c000000000058714] .do_exit+0x774/0x820
[    1.251158] [c0000002763c3af0] [c000000000020c54] .die+0x1c8/0x1cc
[    1.251163] [c0000002763c3b90] [c00000000002883c] .bad_page_fault+0xb8/0xd4
[    1.251168] [c0000002763c3c10] [c000000000005318] handle_page_fault+0x3c/0x5c
[    1.251175] --- Exception: 300 at .tasklet_kill_immediate+0x38/0xb8
[    1.251176]     LR = .kthread+0x78/0xc4
[    1.251180] [c0000002763c3f00] [c00000000006f918] .kthread+0x40/0xc4 (unreliable)
[    1.251185] [c0000002763c3f90] [c000000000022fe8] .kernel_thread+0x54/0x70
[    1.251188] Instruction dump:
[    1.251190] 4800016d e97d0168 880d01dc 2fa00000 41be0010 7c0004ac 38000000 980d01dc 
[    1.251196] 7c2004ac 38000000 900b0040 48000050 <817f0000> 801f0004 7f8b0040 409c001c 
[    1.251202] ---[ end trace 31fd0ba7d8756002 ]---
[    1.251205] Fixing recursive fault but reboot is needed!
core99_setup_cpu 0 done


--------------030806050907010407050501--
