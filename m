Return-Path: <jengelh@inai.de>
Received: from seven.medozas.de (seven.medozas.de [IPv6:2a01:4f8:161:ffa::1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6C8E82C0098
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2012 23:52:01 +1000 (EST)
Date: Fri, 17 Aug 2012 15:51:52 +0200 (CEST)
From: Jan Engelhardt <jengelh@inai.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: therm_pm72 units, interface
In-Reply-To: <1345150317.11751.38.camel@pasglop>
Message-ID: <alpine.LNX.2.01.1208171548230.24880@frira.zrqbmnf.qr>
References: <alpine.LNX.2.01.1208151941010.22695@frira.zrqbmnf.qr>
 <1345066551.11751.1.camel@pasglop>
 <alpine.LNX.2.01.1208161718210.8111@frira.zrqbmnf.qr>
 <1345150317.11751.38.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Thursday 2012-08-16 22:51, Benjamin Herrenschmidt wrote:
>
>You can try netbooting... OF netboot is limited to 4M sized zImages
>which can be a bit tough nowadays, but modern yaboot can netboot larger
>files. Another option is USB sticks.

I can just exploit the fact that the machine will run for about an
hour when it has had a cooldown night.

Except that 3.5, as I already expected by scary mails read on
linux-kernel, looked dangerous to use. Here is a boot-time
hang.

---


Apple RackMac3,1 5.1.7f2 BootROM built on 12/09/04 at 10:58:45
Copyright 1994-2004 Apple Computer, Inc.
All Rights Reserved.

Welcome to Open Firmware, the system time and date is: 14:03:41 08/17/2012

To continue booting, type "mac-boot" and press return.
To shut down, type "shut-down" and press return.

 ok
0 > boot load-size=97d adler32=7e30648e

parsing <CHRP-BOOT>

evaluating <BOOT-SCRIPT>
DART table allocated at: c00000007f000000
Using PowerMac machine description
Found initrd at 0xc000000002400000:0xc000000002783e10
Found U3 memory controller & host bridge @ 0xf8000000 revision: 0x35
Mapped at 0xd000080080000000
Found a K2 mac-io controller, rev: 96, mapped at 0xd000080080050000
PowerMac motherboard: XServe G5
DART IOMMU initialized for U3 type chipset
bootconsole [udbg0] enabled
CPU maps initialized for 1 thread per core
Starting Linux PPC64 #1 SMP Wed Aug 15 21:49:59 UTC 2012 (4904750)
-----------------------------------------------------
ppc64_pft_size                = 0x0
physicalMemorySize            = 0x80000000
htab_address                  = 0xc00000007c000000
htab_hash_mask                = 0x3ffff
-----------------------------------------------------
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Linux version 3.5.2-5-ppc64 (geeko@buildhost) (gcc version 4.7.1 20120723 [gcc-4_7-branch revision 189773] (SUSE Linux) ) #1 SMP Wed Aug 15 21:49:59 UTC 2012 (4904750)
[boot]0012 Setup Arch
Found U3-AGP PCI host bridge.  Firmware bus number: 240->255
PCI host bridge /pci@0,f0000000  ranges:
 MEM 0x00000000f1000000..0x00000000f1ffffff -> 0x00000000f1000000
  IO 0x00000000f0000000..0x00000000f07fffff -> 0x0000000000000000
 MEM 0x00000000b0000000..0x00000000bfffffff -> 0x00000000b0000000
Can't get bus-range for /ht@0,f2000000, assume bus 0
Found U3-HT PCI host bridge.  Firmware bus number: 0->239
PCI host bridge /ht@0,f2000000 (primary) ranges:
via-pmu: Server Mode is disabled
PMU driver v2 initialized for Core99, firmware: 0c
nvram: Checking bank 0...
nvram: gen0=508, gen1=507
nvram: Active bank is: 0
nvram: OF partition at 0x410
nvram: XP partition at 0x1020
nvram: NR partition at 0x1120
Zone ranges:
  DMA      [mem 0x00000000-0x7fffffff]
  Normal   empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x00000000-0x7fffffff]
[boot]0015 Setup Done
PERCPU: Embedded 2 pages/cpu @c000000001700000 s85504 r0 d45568 u524288
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 32740
Policy zone: DMA
Kernel command line: root=/dev/disk/by-label/silvroot sysrq=511 console=ttyPZ0,57600 console=tty0
PID hash table entries: 4096 (order: -1, 32768 bytes)
freeing bootmem node 0
Memory: 2012160k/2097152k available (17152k kernel code, 84992k reserved, 1984k data, 3243k bss, 5952k init)
Hierarchical RCU implementation.
        CONFIG_RCU_FANOUT set to non-default value of 32
        RCU dyntick-idle grace-period acceleration is enabled.
NR_IRQS:512 nr_irqs:512 16
mpic: Setting up MPIC " MPIC 1   " version 1.2 at 80040000, max 2 CPUs
mpic: ISU size: 120, shift: 7, mask: 7f
mpic: Initializing for 120 sources
mpic: Setting up MPIC " MPIC 2   " version 1.2 at f8040000, max 2 CPUs
mpic: ISU size: 124, shift: 7, mask: 7f
mpic: Initializing for 124 sources
/u3@0,f8000000/mpic@f8040000: hooking up to IRQ 56
clocksource: timebase mult[1e000005] shift[24] registered
Console: colour dummy device 80x25
console [tty0] enabled, bootconsole disabled
console [ttyPZ0] enabled
allocated 524288 bytes of page_cgroup
please try 'cgroup_disable=memory' option if you don't want memory cgroups
pid_max: default: 32768 minimum: 301
Security Framework initialized
AppArmor: AppArmor initialized
Dentry cache hash table entries: 262144 (order: 5, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 4, 1048576 bytes)
Mount-cache hash table entries: 4096
Initializing cgroup subsys cpuacct
Initializing cgroup subsys memory
Initializing cgroup subsys devices
Initializing cgroup subsys freezer
Initializing cgroup subsys net_cls
Initializing cgroup subsys blkio
Initializing cgroup subsys perf_event
PowerMac SMP probe found 2 cpus
KeyWest i2c @0xf8001003 irq 16 /u3@0,f8000000/i2c@f8001000
 channel 0 bus <multibus>
 channel 1 bus <multibus>
KeyWest i2c @0x80018000 irq 26 /ht@0,f2000000/pci@3/mac-io@7/i2c@18000
 channel 0 bus <multibus>
PMU i2c /ht@0,f2000000/pci@3/mac-io@7/via-pmu@16000/pmu-i2c
 channel 1 bus <multibus>
 channel 2 bus <multibus>
Processor timebase sync using Pulsar i2c clock
mpic: requesting IPIs...
PPC970/FX/MP performance monitor hardware support registered
Brought up 2 CPUs
devtmpfs: initialized
NET: Registered protocol family 16
IBM eBus Device Driver
CPU Hotplug not supported by firmware - disabling.
PCI: Probing PCI hardware
PCI host bridge to bus 0000:f0
pci_bus 0000:f0: root bus resource [io  0x10000-0x80ffff] (bus address [0x0000-0x7fffff])
pci_bus 0000:f0: root bus resource [mem 0xf1000000-0xf1ffffff]
pci_bus 0000:f0: root bus resource [mem 0xb0000000-0xbfffffff]
IOMMU table initialized, virtual merging enabled
PCI host bridge to bus 0001:00
pci_bus 0001:00: root bus resource [io  0x820000-0xc1ffff] (bus address [0x0000-0x3fffff])
pci_bus 0001:00: root bus resource [mem 0xfa000000-0xffffffff]
pci_bus 0001:00: root bus resource [mem 0x80000000-0xafffffff]
pci_bus 0001:00: root bus resource [mem 0xc0000000-0xefffffff]
pci 0001:00:01.0: PCI bridge to [bus 06-06]
pci 0001:00:02.0: PCI bridge to [bus 07-07]
pci 0001:00:03.0: PCI bridge to [bus 01-01]
pci 0001:00:04.0: PCI bridge to [bus 02-02]
pci 0001:00:05.0: PCI bridge to [bus 03-03]
pci 0001:00:06.0: PCI bridge to [bus 04-04]
pci 0001:00:07.0: PCI bridge to [bus 05-05]
PCI: Cannot allocate resource region 1 of device 0001:06:03.0, will remap
pci 0001:00:01.0: BAR 13: assigned [io  0x821000-0x821fff]
pci 0001:06:03.0: BAR 1: assigned [io  0x821000-0x8210ff]
pci 0001:00:01.0: PCI bridge to [bus 06-06]
pci 0001:00:01.0:   bridge window [io  0x821000-0x821fff]
pci 0001:00:01.0:   bridge window [mem 0x90000000-0x9fffffff]
pci 0001:00:02.0: PCI bridge to [bus 07-07]
pci 0001:00:02.0:   bridge window [mem 0xa0000000-0xa00fffff]
pci 0001:00:03.0: PCI bridge to [bus 01-01]
pci 0001:00:03.0:   bridge window [mem 0x80000000-0x800fffff]
pci 0001:00:04.0: PCI bridge to [bus 02-02]
pci 0001:00:04.0:   bridge window [mem 0x80100000-0x801fffff]
pci 0001:00:05.0: PCI bridge to [bus 03-03]
pci 0001:00:05.0:   bridge window [mem 0x80200000-0x802fffff]
pci 0001:00:06.0: PCI bridge to [bus 04-04]
pci 0001:00:06.0:   bridge window [mem 0x80300000-0x805fffff]
pci 0001:00:07.0: PCI bridge to [bus 05-05]
pci 0001:00:07.0:   bridge window [mem 0x80600000-0x806fffff]
opal: Node not found
bio: create slab <bio-0> at 0
vgaarb: device added: PCI:0001:06:03.0,decodes=io+mem,owns=none,locks=none
vgaarb: loaded
vgaarb: bridge control possible 0001:06:03.0
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
Switching to clocksource timebase
AppArmor: AppArmor Filesystem Enabled
NET: Registered protocol family 2
IP route cache hash table entries: 16384 (order: 1, 131072 bytes)
TCP established hash table entries: 65536 (order: 4, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 4, 1048576 bytes)
TCP: Hash tables configured (established 65536 bind 65536)
TCP: reno registered
UDP hash table entries: 2048 (order: 0, 65536 bytes)
UDP-Lite hash table entries: 2048 (order: 0, 65536 bytes)
NET: Registered protocol family 1
pci 0001:00:01.0: MSI quirk detected; subordinate MSI disabled
pci 0001:00:01.0: AMD8131 rev 12 detected; disabling PCI-X MMRBC
pci 0001:00:02.0: MSI quirk detected; subordinate MSI disabled
pci 0001:00:02.0: AMD8131 rev 12 detected; disabling PCI-X MMRBC
pci 0001:02:0b.0: enabling device (0000 -> 0002)
pci 0001:02:0b.1: enabling device (0000 -> 0002)
pci 0001:02:0b.2: enabling device (0004 -> 0006)
Unpacking initramfs...
Freeing initrd memory: 3648k freed
rtas_flash: no firmware flash support
Registering G5 CPU frequency driver
Frequency method: i2c/pfunc, Voltage method: i2c/pfunc
Low: 1800 Mhz, High: 2300 Mhz, Cur: 1800 MHz
audit: initializing netlink socket (disabled)
type=2000 audit(1345212264.179:1): initialized
HugeTLB registered 16 MB page size, pre-allocated 0 pages
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 8192 (order 0, 65536 bytes)
msgmni has been set to 3936
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
rpaphp: RPA HOT Plug PCI Controller Driver version: 0.1
rpadlpar_io_init: partition not DLPAR capable
Using unsupported 640x480 ATY,Rage128y at 98000000, depth=8, pitch=640
Console: switching to colour frame buffer device 80x30
fb0: Open Firmware frame buffer device on /ht@0,f2000000/pci@1/ATY,Rage128y@3
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
Registering IBM pSeries RNG driver
MacIO PCI driver attached to K2 chipset
0.00013020:ch-a: ttyPZ0 at MMIO 0x80013020 (irq = 22) is a Z85c30 ESCC - Serial port
0.00013000:ch-b: ttyPZ1 at MMIO 0x80013000 (irq = 23) is a Z85c30 ESCC - Serial port
Uniform Multi-Platform E-IDE driver
ide-pmac 0001:03:0d.0: enabling device (0014 -> 0016)
adb: starting probe task...
adb: finished probe task...
ide-pmac: Found Apple K2 ATA-6 controller (PCI), bus ID 3, irq 39
hda: MATSHITACD-RW CW-8124, ATAPI CD/DVD-ROM drive
hda: UDMA/33 mode selected
ide0 at 0xd0000800825e6000-0xd0000800825e6070,0xd0000800825e6160 on irq 39
mousedev: PS/2 mouse device common for all mice
PowerMac i2c bus pmu 2 registered
PowerMac i2c bus pmu 1 registered
PowerMac i2c bus mac-io 0 registered
PowerMac i2c bus u3 1 registered
i2c i2c-3: i2c-powermac: modalias failure on /u3@0,f8000000/i2c@f8001000/cereal@1c0
PowerMac i2c bus u3 0 registered
EDAC MC: Ver: 2.1.0
cpuidle: using governor ladder
cpuidle: using governor menu
TCP: cubic registered
NET: Registered protocol family 10
NET: Registered protocol family 15
lib80211: common routines for IEEE802.11 drivers
Key type dns_resolver registered
PM: Registered nosave memory: 000000007f000000 - 0000000080000000
registered taskstats version 1
input: PMU as /devices/virtual/input/input0
/home/abuild/rpmbuild/BUILD/kernel-ppc64-3.5.2/linux-3.5/drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Freeing unused kernel memory: 5952k freed
SCSI subsystem initialized
scsi0 : sata_svw
scsi1 : sata_svw
scsi2 : sata_svw
scsi3 : sata_svw
ata1: SATA max UDMA/133 mmio m8192@0x80600000 port 0x80600000 irq 17
ata2: SATA max UDMA/133 mmio m8192@0x80600000 port 0x80600100 irq 17
ata3: SATA max UDMA/133 mmio m8192@0x80600000 port 0x80600200 irq 17
ata4: SATA max UDMA/133 mmio m8192@0x80600000 port 0x80600300 irq 17
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7: HITACHI HDS7216SBSUN160G 0825QPY8WM, P22OAB8A, max UDMA/133
ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      HITACHI HDS7216S P22O PQ: 0 ANSI: 5
ata2: SATA link down (SStatus 4 SControl 300)
ata3: SATA link down (SStatus 4 SControl 300)
ata4: SATA link down (SStatus 4 SControl 300)
rdac: device handler registered
alua: device handler registered
hp_sw: device handler registered
emc: device handler registered
udevd[86]: starting version 182
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
BUG: soft lockup - CPU#0 stuck for 22s! [udevd:88]
BUG: soft lockup - CPU#1 stuck for 22s! [udevd:93]
NIP: c00000000000fc84 LR: c00000000000fc84 CTR: c000000000163c20
REGS: c0000000797af830 TRAP: 0901   Not tainted  (3.5.2-5-ppc64)
MSR: 9000000000009032 <SF,HV,EE,ME,IR,DR,RI>  CR: 24222484  XER: 20000000
SOFTE: 1
TASK = c000000079500260[93] 'udevd' THREAD: c0000000797ac000 CPU: 1
GPR00: c00000000000fc48 c0000000797afab0 c00000000121ee98 0000000000000800
GPR04: 0000000000000001 d000000001382a58 00000000aadf3316 0000000000000000
GPR08: 00000000aadf331b 0000000000000000 0000000080000001 0000000000000000
GPR12: 0000000024222482 c00000000fe20780
NIP [c00000000000fc84] .arch_local_irq_restore+0x74/0x90
LR [c00000000000fc84] .arch_local_irq_restore+0x74/0x90
Call Trace:
[c0000000797afab0] [c00000000000fc48] .arch_local_irq_restore+0x38/0x90 (unreliable)
[c0000000797afb20] [c0000000007901b4] ._raw_spin_unlock_irqrestore+0x34/0x80
[c0000000797afb90] [c0000000000d8bdc] .lowest_in_progress+0xbc/0xe0
[c0000000797afc20] [c0000000000d8c58] .async_synchronize_cookie_domain+0x58/0x170
[c0000000797afd00] [c0000000000d8dc8] .async_synchronize_full+0x38/0x70
[c0000000797afd90] [c00000000011d4b0] .SyS_init_module+0xf0/0x240
[c0000000797afe30] [c0000000000098dc] syscall_exit+0x0/0xa0
Instruction dump:
409e002c e92d0020 61298000 7d210164 38210070 e8010010 7c0803a6 4e800020
60000000 60000000 60000000 4bff3985 <60000000> 4bffffdc e92d0020 7d210164
Modules linked in: sd_mod crc_t10dif usbcore usb_common scsi_dh_emc scsi_dh_hp_sw scsi_dh_alua scsi_dh_rdac scsi_dh sata_svw libata scsi_mod
Modules linked in: sd_mod crc_t10dif usbcore usb_common scsi_dh_emc scsi_dh_hp_sw scsi_dh_alua scsi_dh_rdac scsi_dh sata_svw libata scsi_mod
NIP: c00000000079095c LR: c0000000007909a0 CTR: c000000000163c20
REGS: c000000079abb880 TRAP: 0901   Not tainted  (3.5.2-5-ppc64)
MSR: 9000000000009032 <SF,HV,EE,ME,IR,DR,RI>  CR: 24224484  XER: 20000000
SOFTE: 1
TASK = c000000079b45410[88] 'udevd' THREAD: c000000079ab8000 CPU: 0
GPR00: c0000000000d8b4c c000000079abbb00 c00000000121ee98 0000000000000001
GPR04: c0000000010cab88 d00000000169ab38 00000000aad506ec 0000000000000000
GPR08: 00000000aad506f4 0000000080000001 0000000000000000 0000000000000000
GPR12: 0000000024222482 c00000000fe20000
NIP [c00000000079095c] ._raw_spin_lock_irqsave+0x9c/0x110
LR [c0000000007909a0] ._raw_spin_lock_irqsave+0xe0/0x110
Call Trace:
[c000000079abbb00] [c000000079abbb90] 0xc000000079abbb90 (unreliable)
[c000000079abbb90] [c0000000000d8b4c] .lowest_in_progress+0x2c/0xe0
[c000000079abbc20] [c0000000000d8c58] .async_synchronize_cookie_domain+0x58/0x170
[c000000079abbd00] [c0000000000d8dc8] .async_synchronize_full+0x38/0x70
[c000000079abbd90] [c00000000011d4b0] .SyS_init_module+0xf0/0x240
[c000000079abbe30] [c0000000000098dc] syscall_exit+0x0/0xa0
Instruction dump:
81810008 eb81ffe0 eba1ffe8 7c0803a6 ebe1fff8 7d908120 4e800020 8b8d022a
4092004c 38600000 4b87f2bd 60000000 <7c210b78> e92d0000 e9290008 792a7fe1
INFO: rcu_sched self-detected stall on CPU { 1}  (t=6000 jiffies)
Call Trace:
[c000000079abb180] [c000000000014d84] .show_stack+0x74/0x1b0 (unreliable)
[c000000079abb230] [c00000000015da0c] .__rcu_pending+0x1fc/0x570
[c000000079abb2f0] [c00000000015ddc0] .rcu_pending+0x40/0xc0
[c000000079abb380] [c00000000015efe8] .rcu_check_callbacks+0x88/0x200
[c000000079abb420] [c0000000000b67f4] .update_process_times+0x44/0xa0
[c000000079abb4b0] [c00000000010e70c] .tick_sched_timer+0x7c/0x100
[c000000079abb550] [c0000000000d3a04] .__run_hrtimer+0xb4/0x2b0
[c000000079abb600] [c0000000000d4b28] .hrtimer_interrupt+0x138/0x3c0
[c000000079abb710] [c00000000001cbc0] .timer_interrupt+0x120/0x2f0
[c000000079abb7c0] [c000000000003cd8] decrementer_common+0x158/0x180
--- Exception: 901 at .arch_local_irq_restore+0x74/0x90
    LR = .arch_local_irq_restore+0x74/0x90
[c000000079abbab0] [c00000000000fc48] .arch_local_irq_restore+0x38/0x90 (unreliable)
[c000000079abbb20] [c0000000007901b4] ._raw_spin_unlock_irqrestore+0x34/0x80
[c000000079abbb90] [c0000000000d8bdc] .lowest_in_progress+0xbc/0xe0
[c000000079abbc20] [c0000000000d8c58] .async_synchronize_cookie_domain+0x58/0x170
[c000000079abbd00] [c0000000000d8dc8] .async_synchronize_full+0x38/0x70
[c000000079abbd90] [c00000000011d4b0] .SyS_init_module+0xf0/0x240
[c000000079abbe30] [c0000000000098dc] syscall_exit+0x0/0xa0
INFO: rcu_sched self-detected stall on CPU { 0}  (t=6000 jiffies)
Call Trace:
[c0000000797af180] [c000000000014d84] .show_stack+0x74/0x1b0 (unreliable)
[c0000000797af230] [c00000000015da0c] .__rcu_pending+0x1fc/0x570
[c0000000797af2f0] [c00000000015ddc0] .rcu_pending+0x40/0xc0
[c0000000797af380] [c00000000015efe8] .rcu_check_callbacks+0x88/0x200
[c0000000797af420] [c0000000000b67f4] .update_process_times+0x44/0xa0
[c0000000797af4b0] [c00000000010e70c] .tick_sched_timer+0x7c/0x100
[c0000000797af550] [c0000000000d3a04] .__run_hrtimer+0xb4/0x2b0
[c0000000797af600] [c0000000000d4b28] .hrtimer_interrupt+0x138/0x3c0
[c0000000797af710] [c00000000001cbc0] .timer_interrupt+0x120/0x2f0
[c0000000797af7c0] [c000000000003cd8] decrementer_common+0x158/0x180
--- Exception: 901 at .arch_local_irq_restore+0x74/0x90
    LR = .arch_local_irq_restore+0x74/0x90
[c0000000797afab0] [c00000000000fc48] .arch_local_irq_restore+0x38/0x90 (unreliable)
[c0000000797afb20] [c0000000007901b4] ._raw_spin_unlock_irqrestore+0x34/0x80
[c0000000797afb90] [c0000000000d8bdc] .lowest_in_progress+0xbc/0xe0
[c0000000797afc20] [c0000000000d8c58] .async_synchronize_cookie_domain+0x58/0x170
[c0000000797afd00] [c0000000000d8dc8] .async_synchronize_full+0x38/0x70
[c0000000797afd90] [c00000000011d4b0] .SyS_init_module+0xf0/0x240
[c0000000797afe30] [c0000000000098dc] syscall_exit+0x0/0xa0
