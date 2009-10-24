Return-Path: <wilbur512@gmail.com>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 0B1F0B7BCA
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Oct 2009 18:20:03 +1100 (EST)
Received: by yxe8 with SMTP id 8so9407415yxe.17
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Oct 2009 00:20:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAEDEFF6-55D3-43AA-BA6C-92D14CBA8A79@kernel.crashing.org>
References: <e997b7420910220708i63b85ca1n256f332ddc6819c1@mail.gmail.com>
	<CAEDEFF6-55D3-43AA-BA6C-92D14CBA8A79@kernel.crashing.org>
Date: Sat, 24 Oct 2009 15:20:01 +0800
Message-ID: <e997b7420910240020s32e07cdcr65c007242792ba1e@mail.gmail.com>
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

>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
> Post the full kernel boot log.
>
> - k
>

This is my booting  log using ramdisk, I want to mount sata disk after
booting. However, sata disk module seemed not to be installed
properly, system only found 8M of it,as a matter of fact

p2020ds board has 160 GB disk space.


Detail:

Using P2020 DS machine description
Memory CAM mapping: CAM0=256Mb, CAM1=256Mb, CAM2=256Mb residual: 1280Mb
Linux version 2.6.21.7-EMBSYS-CGEL-3.04.10.P6.F7.B2 (root@localhost.localdomain)
 (gcc version 4.1.2 20070626 (Red Hat 4.1.2-14)) #7 SMP PREEMPT Thu Oct 22 09:10
:31 CST 2009
Found initrd at 0xefbf6000:0xeffff1d6
setup_arch: bootmem
mpc85xx_ds_setup_arch()
Found FSL PCI host bridge at 0x00000000ffe09000.Firmware bus number: 0->2
 ->Hose at 0xc05a8000, cfg_addr=0xfdffd000,cfg_data=0xfdffd004
Found FSL PCI host bridge at 0x00000000ffe08000.Firmware bus number: 0->0
 ->Hose at 0xc05a8100, cfg_addr=0xfdfeb000,cfg_data=0xfdfeb004
Found FSL PCI host bridge at 0x00000000ffe0a000.Firmware bus number: 0->0
 ->Hose at 0xc05a8200, cfg_addr=0xfdfd9000,cfg_data=0xfdfd9004
MPC85xx DS board from Freescale Semiconductor
arch: exit
Zone PFN ranges:
  DMA             0 ->   196608
  Normal     196608 ->   196608
  HighMem    196608 ->   524288
early_node_map[1] active PFN ranges
    0:        0 ->   524288
Built 1 zonelists.  Total pages: 520192
system bbx : start(phy)=0x5c8000 ,start(vir)=0xc05c8000 , size = 0x5ffc
Kernel command line: root=/dev/ram console=ttyS0,115200
mpic: Setting up MPIC " OpenPIC  " version 1.2 at ffe40000, max 2 CPUs
mpic: ISU size: 108, shift: 7, mask: 7f
mpic: Initializing for 108 sources
hwtimer: Added openpic_timer (PowerPC kernel OpenPIC timer) at index=0
i8259 legacy interrupt controller initialized
PID hash table entries: 4096 (order: 12, 16384 bytes)

Using P2020 DS machine description
Memory CAM mapping: CAM0=256Mb, CAM1=256Mb, CAM2=256Mb residual: 1280Mb
Linux version 2.6.21.7-EMBSYS-CGEL-3.04.10.P6.F7.B2 (root@localhost.localdomain)
 (gcc version 4.1.2 20070626 (Red Hat 4.1.2-14)) #7 SMP PREEMPT Thu Oct 22 09:10
:31 CST 2009
Found initrd at 0xefbf6000:0xeffff1d6
Found FSL PCI host bridge at 0x00000000ffe09000.Firmware bus number: 0->2
 ->Hose at 0xc05a8000, cfg_addr=0xfdffd000,cfg_data=0xfdffd004
Found FSL PCI host bridge at 0x00000000ffe08000.Firmware bus number: 0->0
 ->Hose at 0xc05a8100, cfg_addr=0xfdfeb000,cfg_data=0xfdfeb004
Found FSL PCI host bridge at 0x00000000ffe0a000.Firmware bus number: 0->0
 ->Hose at 0xc05a8200, cfg_addr=0xfdfd9000,cfg_data=0xfdfd9004
MPC85xx DS board from Freescale Semiconductor
Zone PFN ranges:
  DMA             0 ->   196608
  Normal     196608 ->   196608
  HighMem    196608 ->   524288
early_node_map[1] active PFN ranges
    0:        0 ->   524288
Built 1 zonelists.  Total pages: 520192
system bbx : start(phy)=0x5c8000 ,start(vir)=0xc05c8000 , size = 0x5ffc
Kernel command line: root=/dev/ram console=ttyS0,115200
mpic: Setting up MPIC " OpenPIC  " version 1.2 at ffe40000, max 2 CPUs
mpic: ISU size: 108, shift: 7, mask: 7f
mpic: Initializing for 108 sources
hwtimer: Added openpic_timer (PowerPC kernel OpenPIC timer) at index=0
i8259 legacy interrupt controller initialized
PID hash table entries: 4096 (order: 12, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2068844k/2097152k available (5232k kernel code, 1338008k reserved, 292k
data, 194k bss, 192k init)
Mount-cache hash table entries: 512
mpic: requesting IPIs ...
Processor 1 found.
Synchronizing timebase
Got ack
Min 6 (score -99), Max 7 (score 299)
Final offset: 6 (101/300)
Brought up 2 CPUs
NET: Registered protocol family 16
PCI: Probing PCI hardware
PCI: 0000:00:00.0: class b20 doesn't match header type 01. Ignoring class.
PCI: Transparent bridge - 0000:01:00.0
PCI: 0001:03:00.0: class b20 doesn't match header type 01. Ignoring class.
PCI: 0002:05:00.0: class b20 doesn't match header type 01. Ignoring class.
Generic PHY: Registered new driver
SCSI subsystem initialized
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Unpacking initramfs... done
Freeing initrd memory: 4132k freed
mpc85xx_spi_init >>
No valid ESPI Node found
audit: initializing netlink socket (disabled)
audit(1.756:1): initialized
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Time: timebase clocksource has been installed.
Generic RTC Driver v1.07
Macintosh non-volatile memory driver v1.1
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO map 0xffe04500 mem 0xf1000500 (irq = 42) is a 16550A
serial8250.0: ttyS1 at MMIO map 0xffe04600 mem 0xf1002600 (irq = 42) is a 16550A
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
Vitesse VSC8244: Registered new driver
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Loading iSCSI transport class v2.0-724.
iscsi: registered transport (tcp)
Loading Adaptec I2O RAID: Version 2.4 Build 5go
Detecting Adaptec I2O RAID controllers...
Adaptec aacraid driver (1.1-5[2423]-mh3)
aic94xx: Adaptec aic94xx SAS/SATA driver version 1.0.3 loaded
__ioremap(): phys addr 000c8000 is RAM lr c027318c
__ioremap(): phys addr 000ca000 is RAM lr c027318c
__ioremap(): phys addr 000ce000 is RAM lr c027318c
__ioremap(): phys addr 000de000 is RAM lr c027318c
__ioremap(): phys addr 000cc000 is RAM lr c027318c
__ioremap(): phys addr 000d0000 is RAM lr c027318c
__ioremap(): phys addr 000e0000 is RAM lr c027318c
scsi: <fdomain> Detection failed (no card)
QLogic Fibre Channel HBA Driver
iscsi: registered transport (qla4xxx)
QLogic iSCSI HBA Driver
Emulex LightPulse Fibre Channel SCSI driver 8.1.11
Copyright(c) 2004-2006 Emulex.  All rights reserved.
DC390: clustering now enabled by default. If you get problems load
        with "disable_clustering=1" and report to maintainers
megasas: 00.00.03.10-rc1 Wed Feb 14 10:14:25 PST 2007
3ware Storage Controller device driver for Linux v1.26.02.002.
3ware 9000 Storage Controller device driver for Linux v2.26.02.008.
nsp32: loading...
RocketRAID 3xxx SATA Controller driver v1.0 (060426)
stex: Promise SuperTrak EX Driver version: 3.1.0.1
scsi0 : scsi_debug, version 1.81 [20070104], dev_size_mb=8, opts=0x0
scsi 0:0:0:0: Direct-Access     Linux    scsi_debug       0004 PQ: 0 ANSI: 5
SCSI device sda: 16384 512-byte hdwr sectors (8 MB)
sda: Write Protect is off
SCSI device sda: write cache: enabled, read cache: enabled, supports DPO and FUA
SCSI device sda: 16384 512-byte hdwr sectors (8 MB)
sda: Write Protect is off
SCSI device sda: write cache: enabled, read cache: enabled, supports DPO and FUA
 sda: unknown partition table
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
ahci 0000:02:1f.1: AHCI 0001.0000 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:02:1f.1: flags: ncq ilck pm led clo pmp pio slum part
ata1: SATA max UDMA/133 cmd 0xf1812500 ctl 0x00000000 bmdma 0x00000000 irq 18
ata2: SATA max UDMA/133 cmd 0xf1812580 ctl 0x00000000 bmdma 0x00000000 irq 18
ata3: SATA max UDMA/133 cmd 0xf1812600 ctl 0x00000000 bmdma 0x00000000 irq 18
ata4: SATA max UDMA/133 cmd 0xf1812680 ctl 0x00000000 bmdma 0x00000000 irq 18
scsi1 : ahci
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x104)
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x104)
ata1.00: limiting speed to UDMA7:PIO5
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x104)
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
scsi2 : ahci
ata2: SATA link down (SStatus 0 SControl 300)
scsi3 : ahci
ata3: SATA link down (SStatus 0 SControl 300)
scsi4 : ahci
ata4: SATA link down (SStatus 0 SControl 300)
ata5: PATA max UDMA/133 cmd 0xfdfee000 ctl 0xfdfee00a bmdma 0xfdfee020 irq 18
ata6: PATA max UDMA/133 cmd 0xfdfee010 ctl 0xfdfee01a bmdma 0xfdfee028 irq 18
scsi5 : pata_ali
scsi6 : pata_ali
Fusion MPT base driver 3.04.04
Copyright (c) 1999-2007 LSI Logic Corporation
Fusion MPT SPI Host driver 3.04.04
Fusion MPT FC Host driver 3.04.04
Fusion MPT SAS Host driver 3.04.04
Fusion MPT misc device (ioctl) driver 3.04.04
mptctl: Registered with Fusion MPT base driver
mptctl: /dev/mptctl @ (major,minor=10,220)
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
/home/xuezhh/kernel/cgel-svn-new/target-cgl/kernel-version/cgel3.0/linux/drivers
/rtc/hctosys.c: unable to open rtc device (rtc0)
Freeing unused kernel memory: 192k init

Processing /etc/profile... Done

#
