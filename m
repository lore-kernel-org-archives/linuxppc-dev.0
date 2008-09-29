Return-Path: <obutler@oze.com.fr>
Received: from smtp1-g19.free.fr (smtp1-g19.free.fr [212.27.42.27])
	by ozlabs.org (Postfix) with ESMTP id A74CDDE17C
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 00:42:24 +1000 (EST)
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 4F7511AB2B8
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Sep 2008 16:42:22 +0200 (CEST)
Received: from [192.168.0.6] (nor75-11-82-66-226-55.fbx.proxad.net
	[82.66.226.55])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 2812D1AB329
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Sep 2008 16:42:20 +0200 (CEST)
Message-Id: <685D492A-6DCC-4F48-8960-5606D6051F1F@oze.com.fr>
From: Olivier Butler <obutler@oze.com.fr>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=Apple-Mail-305--420995699
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: 8349emitx Board : PCI issues
Date: Mon, 29 Sep 2008 16:42:20 +0200
References: <B1B0C6AB-40F1-4FBE-860A-B98BF683DCDB@oze.com.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--Apple-Mail-305--420995699
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

Hi,

I have some issues with the 8349emitx board.

I achieved to run the board with the supplied LTIB cd, witch builds  
linux 2.6.13.
the board is working well.

I downloaded the lasted ltib ( from bitshrine.org ) and the lasted  
kernel 2.6.26.
The last kernel seems supporting this board except with the sata chip.

Attached to this mail, you will find a txt file containing 3 linux  
boot logs.
- the 2.6.26 boot log  witch hangs at sata disks inits
- the 2.6.13 boot log witch works

and
- the 2.6.26 boot log with option libata.dma=0. ( this is the only way  
to have the board booting, I tried all other libata options without  
success ).

the "host bus error" means that the issue is on the PCI bus.

Now I'm out of ideas.

This behaviour has been confirm by FS.

Does someone have any hint ?

Regards
Olivier






--Apple-Mail-305--420995699
Content-Type: multipart/mixed;
	boundary=Apple-Mail-306--420995698


--Apple-Mail-306--420995698
Content-Type: text/html;
	charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; "><div><div style=3D"word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space; "><div><div =
dir=3D"ltr">Hi,</div></div></div><div><br></div>I have some issues with =
the 8349emitx board.<br><div style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space; =
"><div><div dir=3D"ltr"><br></div></div></div>I achieved to run the =
board with the supplied LTIB cd, witch builds linux&nbsp;<a =
href=3D"http://2.6.13." target=3D"_blank">2.6.13.</a><br>the board is =
working well.</div><div><br>I downloaded the lasted ltib ( from&nbsp;<a =
href=3D"http://bitshrine.org" target=3D"_blank">bitshrine.org</a>&nbsp;) =
and the lasted kernel&nbsp;<a href=3D"http://2.6.26." =
target=3D"_blank">2.6.26.</a><br>The last kernel seems supporting this =
board except with the sata chip.</div><div><br><div style=3D"word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space; "><div><div dir=3D"ltr">Attached to this mail, you =
will find a txt file containing 3 linux boot logs.<br>- the 2.6.26 boot =
log&nbsp; witch hangs at sata disks inits<br>- the 2.6.13 boot log witch =
works<br> <br>and<br>- the 2.6.26 boot log with option libata.dma=3D0. ( =
this is the only way to have the board booting,&nbsp;I tried all other =
libata options without success ).</div><div dir=3D"ltr"><br>the "host =
bus error" means that the issue is on the PCI bus.<br> <br>Now I'm out =
of ideas.</div><div dir=3D"ltr"><br></div><div dir=3D"ltr">This =
behaviour has been confirm by FS.</div><div dir=3D"ltr"><br></div><div =
dir=3D"ltr">Does someone have any hint ?</div><div =
dir=3D"ltr"><br></div><div dir=3D"ltr">Regards</div><div =
dir=3D"ltr">Olivier</div><div dir=3D"ltr"><br></div><div =
dir=3D"ltr"><br></div><div =
dir=3D"ltr"></div></div></div></div></body></html>=

--Apple-Mail-306--420995698
Content-Disposition: attachment;
	filename=boot-linux-2.6.26--2.6.13.txt
Content-Type: text/plain;
	x-unix-mode=0666;
	name="boot-linux-2.6.26--2.6.13.txt"
Content-Transfer-Encoding: 7bit


---------------------------------------------------------------
Boot linux 2.6.26
----------------------------------------------------------------

Using MPC834x ITX machine description
Linux version 2.6.26 (olivier@olivier-desktop) (gcc version 4.2.1 (Sourcery G++ Lite 4.2-82)) #35 Tue Jul 29 16:55:34 CEST 2008
Found initrd at 0xcf829000:0xcff74b4a
Found MPC83xx PCI host bridge at 0x00000000e0008500. Firmware bus number: 0->0
PCI host bridge /pci@e0008500 (primary) ranges:
 MEM 0x0000000080000000..0x000000008fffffff -> 0x0000000080000000 Prefetch
 MEM 0x0000000090000000..0x000000009fffffff -> 0x0000000090000000 
  IO 0x00000000e2000000..0x00000000e2ffffff -> 0x0000000000000000
Found MPC83xx PCI host bridge at 0x00000000e0008600. Firmware bus number: 0->0
PCI host bridge /pci@e0008600  ranges:
 MEM 0x00000000a0000000..0x00000000afffffff -> 0x00000000a0000000 Prefetch
 MEM 0x00000000b0000000..0x00000000bfffffff -> 0x00000000b0000000 
  IO 0x00000000e3000000..0x00000000e3ffffff -> 0x0000000000000000
Zone PFN ranges:
  DMA             0 ->    65536
  Normal      65536 ->    65536
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->    65536
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: root=/dev/ram ramdisk_size=80000 rw ip=192.168.0.20:192.168.0.42:192.168.1.254:255.255.255.0:PowerQUICC:eth0:off console=ttyS1,115200 md=0,/dev/sda,/dev/sdb,/dev/sdc,/dev/sdd
md: Will configure md0 (super-block) from /dev/sda,/dev/sdb,/dev/sdc,/dev/sdd, below.
IPIC (128 IRQ sources) at fbffc700
PID hash table entries: 1024 (order: 10, 4096 bytes)
clocksource: timebase mult[3c00001] shift[22] registered
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 248440k/262144k available (3356k kernel code, 13384k reserved, 116k data, 100k bss, 168k init)
SLUB: Genslabs=12, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Mount-cache hash table entries: 512
net_namespace: 192 bytes
xor: measuring software checksum speed
   8regs     :   405.000 MB/sec
   8regs_prefetch:   385.000 MB/sec
   32regs    :   485.000 MB/sec
   32regs_prefetch:   471.000 MB/sec
xor: using function: 32regs (485.000 MB/sec)
NET: Registered protocol family 16
PCI: Probing PCI hardware
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
NET: Registered protocol family 1
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 7470k freed
msgmni has been set to 500
async_tx: api initialized (async)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 18) is a 16550A
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 19) is a 16550A
console [ttyS1] enabled
brd: module loaded
loop: module loaded
eth0: Gianfar Ethernet Controller Version 1.2, 08:00:3e:03:01:11
eth0: Running with NAPI enabled
eth0: 256/256 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.2, 08:00:3e:03:01:12
eth1: Running with NAPI enabled
eth1: 256/256 RX/TX BD ring size
Fixed MDIO Bus: probed
Driver 'sd' needs updating - please use bus_type methods
sata_sil 0000:00:10.0: enabling device (0000 -> 0003)
sata_sil 0000:00:10.0: cache line size not set.  Driver may not function
sata_sil 0000:00:10.0: Applying R_ERR on DMA activate FIS errata fix
scsi0 : sata_sil
scsi1 : sata_sil
scsi2 : sata_sil
scsi3 : sata_sil
ata1: SATA max UDMA/100 mmio m1024@0x90000000 tf 0x90000080 irq 22
ata2: SATA max UDMA/100 mmio m1024@0x90000000 tf 0x900000c0 irq 22
ata3: SATA max UDMA/100 mmio m1024@0x90000000 tf 0x90000280 irq 22
ata4: SATA max UDMA/100 mmio m1024@0x90000000 tf 0x900002c0 irq 22
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-7: Maxtor 6V250F0, VA111900, max UDMA/133
ata1.00: 490234752 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/100
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata2.00: ATA-7: Maxtor 6V250F0, VA111900, max UDMA/133
ata2.00: 490234752 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata2.00: configured for UDMA/100
ata3: SATA link down (SStatus 0 SControl 310)
ata4: SATA link down (SStatus 0 SControl 310)
scsi 0:0:0:0: Direct-Access     ATA      Maxtor 6V250F0   VA11 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 490234752 512-byte hardware sectors (251000 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 490234752 512-byte hardware sectors (251000 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda:<3>ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x20 (host bus error)
ata1.00: status: { DRDY }
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1.00: revalidation failed (errno=-5)
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting link
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/100
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x20 (host bus error)
ata1.00: status: { DRDY }
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1.00: revalidation failed (errno=-5)
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting link
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/100
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x20 (host bus error)
ata1.00: status: { DRDY }



!!!!!
The boot process hangs here

!!!!



---------------------------------------------------------------
Boot linux 2.6.13
----------------------------------------------------------------

Linux version 2.6.13.4 (root@LINUX-MICETEK) (gcc version 3.4.3) #1 Mon Mar 10 13:39:07 CST 2008
PCI2 confirm: isa_io_base = 0xfc000000
Configure PCI2 controller isa_io_base = 0xfc000000
hose2->io_base_virt = 0xfd000000
Built 1 zonelists
Kernel command line: root=/dev/ram ramdisk_size=80000 rw ip=192.168.0.20:192.168.0.42:192.168.1.254:255.255.255.0:PowerQUICC:eth0:off console=ttyS1,115200 md=0,/dev/sda,/dev/sdb,/dev/sdc,/dev/sdd
md: Will configure md0 (super-block) from /dev/sda,/dev/sdb,/dev/sdc,/dev/sdd, below.
IPIC (128 IRQ sources, 8 External IRQs) at fe000700
PID hash table entries: 2048 (order: 11, 32768 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 254208k available (2400k kernel code, 876k data, 112k init, 0k highmem)
Mount-cache hash table entries: 512
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 1864k freed
NET: Registered protocol family 16
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 0 of device 0000:00:00.0
PCI: Cannot allocate resource region 2 of device 0000:00:00.0
PCI: Cannot allocate resource region 0 of device 0001:01:00.0
PCI: Cannot allocate resource region 2 of device 0001:01:00.0
PCI: Failed to allocate mem resource #2:80000000@0 for 0000:00:00.0
PCI: Failed to allocate mem resource #2:80000000@0 for 0001:01:00.0
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
NTFS driver 2.1.23 [Flags: R/W DEBUG].
Generic RTC Driver v1.07
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at MMIO 0xe0004500 (irq = 9) is a 16550A
ttyS1 at MMIO 0xe0004600 (irq = 10) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 80000K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 6.0.60-k2-NAPI
Copyright (c) 1999-2005 Intel Corporation.
eth0: Gianfar Ethernet Controller Version 1.4, 08:00:3e:03:01:11 
eth0: MTU = 1500 (frame size=1514,truesize=1780)
eth0: Running with NAPI enabled
eth0: 64/64 RX/TX BD ring size
eth0: Socket buffer recycling mode enabled
eth1: Gianfar Ethernet Controller Version 1.4, 08:00:3e:03:01:12 
eth1: MTU = 1500 (frame size=1514,truesize=1780)
eth1: Running with NAPI enabled
eth1: 64/64 RX/TX BD ring size
eth1: Socket buffer recycling mode enabled
SKB Handler initialized(max=64)
sata_sil(0000:00:10.0): cache line size not set.  Driver may not function
ata1: SATA max UDMA/100 cmd 0xD1000C80 ctl 0xD1000C8A bmdma 0xD1000C00 irq 22
ata2: SATA max UDMA/100 cmd 0xD1000CC0 ctl 0xD1000CCA bmdma 0xD1000C08 irq 22
ata3: SATA max UDMA/100 cmd 0xD1000E80 ctl 0xD1000E8A bmdma 0xD1000E00 irq 22
ata4: SATA max UDMA/100 cmd 0xD1000EC0 ctl 0xD1000ECA bmdma 0xD1000E08 irq 22
ata1: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
ata3: no device found (phy stat 00000000)
scsi2 : sata_sil
ata4: no device found (phy stat 00000000)
scsi3 : sata_sil
  Vendor: ATA       Model: Maxtor 6V250F0    Rev: VA11
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6V250F0    Rev: VA11
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sda: drive cache: write back
 sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sdb: drive cache: write back
 sdb:
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
usbmon: debugfs is not available
driver fsl-usb2-mph, $Revision: 1.11 $
fsl-usb2-mph fsl-usb2-mph.1: new USB bus registered, assigned bus number 1
fsl-usb2-mph fsl-usb2-mph.1: park 0
fsl-usb2-mph fsl-usb2-mph.1: USB 0.0 initialized, EHCI 1.00, driver $Revision: 1.11 $
usb usb1: Product: fsl usb20
usb usb1: Manufacturer: Linux 2.6.13.4 fsl-usb2-mph
usb usb1: SerialNumber: fsl-usb2-mph.1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/net/rtl8150.c: rtl8150 based usb-ethernet driver v0.6.2 (2004/08/27)
usb 1-1: new high speed USB device using fsl-usb2-mph and address 2
usb 1-1: Product: USB2.0 Hub
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
usbcore: registered new driver rtl8150
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
i2c /dev entries driver
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :   448.000 MB/sec
   8regs_prefetch:   396.000 MB/sec
   32regs    :   484.000 MB/sec
   32regs_prefetch:   528.000 MB/sec
raid5: using function: 32regs_prefetch (528.000 MB/sec)
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.38
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
eth0: PHY is Intellon 6xMX Module (2834)
IP-Config: Gateway not on directly connected network.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
md: Unknown device name: sdc
md: Loading md0: /dev/sda
md: bind<sda>
md: sdb has different UUID to sda
md: sdb has different UUID to sda
md: export_rdev(sdb)
raid1: raid set md0 active with 1 out of 2 mirrors
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 112k init
Setting the hostname to mpc8349itx-min-fs
Mounting filesystems
rootfs / rootfs rw 0 0
/dev/root / ext2 rw 0 0
proc /proc proc rw,nodiratime 0 0
rwfs /mnt/rwfs tmpfs rw 0 0
Starting syslogd and klogd
Running depmod
Setting up networking on loopback device: 
Setting up networking on eth0: 
udhcpc (v0.9.9-pre) started
Sending discover...
Sending select for 192.168.0.8...
Lease of 192.168.0.8 obtained, lease time 864000
deleting routers
SIOCDELRT: No such process
adding dns 212.27.40.240
adding dns 212.27.40.241
Starting inetd: 


        Welcome to Freescale Semiconductor Embedded Linux Environment

!!!!! WARNING !!!!!!!

The default password for the root account is: root
please change this password using the 'passwd' command
and then edit this message (/etc/issue) to remove this message

mpc8349itx-min-fs login: 





---------------------------------------------------------------
Boot linux 2.6.26 with libata.dma=0
----------------------------------------------------------------
Using MPC834x ITX machine description
Linux version 2.6.26 (olivier@olivier-desktop) (gcc version 4.2.1 (Sourcery G++ Lite 4.2-82)) #35 Tue Jul 29 16:55:34 CEST 2008
Found initrd at 0xcf829000:0xcff74b4a
Found MPC83xx PCI host bridge at 0x00000000e0008500. Firmware bus number: 0->0
PCI host bridge /pci@e0008500 (primary) ranges:
 MEM 0x0000000080000000..0x000000008fffffff -> 0x0000000080000000 Prefetch
 MEM 0x0000000090000000..0x000000009fffffff -> 0x0000000090000000 
  IO 0x00000000e2000000..0x00000000e2ffffff -> 0x0000000000000000
Found MPC83xx PCI host bridge at 0x00000000e0008600. Firmware bus number: 0->0
PCI host bridge /pci@e0008600  ranges:
 MEM 0x00000000a0000000..0x00000000afffffff -> 0x00000000a0000000 Prefetch
 MEM 0x00000000b0000000..0x00000000bfffffff -> 0x00000000b0000000 
  IO 0x00000000e3000000..0x00000000e3ffffff -> 0x0000000000000000
Zone PFN ranges:
  DMA             0 ->    65536
  Normal      65536 ->    65536
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->    65536
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: root=/dev/ram ramdisk_size=80000 rw ip=192.168.0.20:192.168.0.42:192.168.1.254:255.255.255.0:PowerQUICC:eth0:off console=ttyS1,115200 libata.dma=0 libata.force=pio7
IPIC (128 IRQ sources) at fbffc700
PID hash table entries: 1024 (order: 10, 4096 bytes)
clocksource: timebase mult[3c00001] shift[22] registered
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 248440k/262144k available (3356k kernel code, 13384k reserved, 116k data, 100k bss, 168k init)
SLUB: Genslabs=12, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Mount-cache hash table entries: 512
net_namespace: 192 bytes
xor: measuring software checksum speed
   8regs     :   405.000 MB/sec
   8regs_prefetch:   385.000 MB/sec
   32regs    :   485.000 MB/sec
   32regs_prefetch:   471.000 MB/sec
xor: using function: 32regs (485.000 MB/sec)
NET: Registered protocol family 16
PCI: Probing PCI hardware
SCSI subsystem initialized
ata: failed to parse force parameter "pio7" (unknown value)
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
NET: Registered protocol family 1
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 7470k freed
msgmni has been set to 500
async_tx: api initialized (async)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 18) is a 16550A
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 19) is a 16550A
console [ttyS1] enabled
brd: module loaded
loop: module loaded
eth0: Gianfar Ethernet Controller Version 1.2, 08:00:3e:03:01:11
eth0: Running with NAPI enabled
eth0: 256/256 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.2, 08:00:3e:03:01:12
eth1: Running with NAPI enabled
eth1: 256/256 RX/TX BD ring size
Fixed MDIO Bus: probed
Driver 'sd' needs updating - please use bus_type methods
sata_sil 0000:00:10.0: enabling device (0000 -> 0003)
sata_sil 0000:00:10.0: cache line size not set.  Driver may not function
sata_sil 0000:00:10.0: Applying R_ERR on DMA activate FIS errata fix
scsi0 : sata_sil
scsi1 : sata_sil
scsi2 : sata_sil
scsi3 : sata_sil
ata1: SATA max UDMA/100 mmio m1024@0x90000000 tf 0x90000080 irq 22
ata2: SATA max UDMA/100 mmio m1024@0x90000000 tf 0x900000c0 irq 22
ata3: SATA max UDMA/100 mmio m1024@0x90000000 tf 0x90000280 irq 22
ata4: SATA max UDMA/100 mmio m1024@0x90000000 tf 0x900002c0 irq 22
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-7: Maxtor 6V250F0, VA111900, max UDMA/133
ata1.00: 490234752 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata1.00: configured for PIO4
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata2.00: ATA-7: Maxtor 6V250F0, VA111900, max UDMA/133
ata2.00: 490234752 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata2.00: configured for PIO4
ata3: SATA link down (SStatus 0 SControl 310)
ata4: SATA link down (SStatus 0 SControl 310)
scsi 0:0:0:0: Direct-Access     ATA      Maxtor 6V250F0   VA11 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 490234752 512-byte hardware sectors (251000 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 490234752 512-byte hardware sectors (251000 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1
sd 0:0:0:0: [sda] Attached SCSI disk
scsi 1:0:0:0: Direct-Access     ATA      Maxtor 6V250F0   VA11 PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 490234752 512-byte hardware sectors (251000 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] 490234752 512-byte hardware sectors (251000 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb:
sd 1:0:0:0: [sdb] Attached SCSI disk
fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 1
fsl-ehci fsl-ehci.0: irq 39, io base 0xe0022000
fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usb 1-1: new high speed USB device using fsl-ehci and address 2
usb 1-1: configuration #1 chosen from 1 choice
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
i2c /dev entries driver
S08QG8:Version 0.3 - 09 Jan 2008
md: raid1 personality registered for level 1
raid6: int32x1     35 MB/s
raid6: int32x2     54 MB/s
raid6: int32x4     84 MB/s
raid6: int32x8     99 MB/s
raid6: using algorithm int32x8 (99 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
md: multipath personality registered for level -4
md: faulty personality registered for level -5
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
IP-Config: Gateway not on directly connected network.
md: Autodetecting RAID arrays.
md: Scanned 0 and added 0 devices.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 168k init
PHY: 0:01 - Link is Up - 100/Full
Setting the hostname to oze-systems
Mounting filesystems
rootfs / rootfs rw 0 0
/dev/root / ext2 rw 0 0
proc /proc proc rw 0 0
rwfs /mnt/rwfs tmpfs rw,size=512k 0 0
VFS: Can't find an ext2 filesystem on dev sda1.
mount: wrong fs EXT2-fs: unable to read superblock
type, bad option, bad superblock on /dev/sda1,
       missing codepage or helper program, or other error
       In some cases useful info is found in syslog - try
       dmesg | tail  or so

mount: wrong fs type, bad option, bad superblock on /dev/md0,
       missing codepage or helper program, or other error
       (could this be the IDE device where you in fact use
       ide-scsi so that sr0 or sda or so is needed?)
       In some cases useful info is found in syslog - try
       dmesg | tail  or so

Running sysctl
Setting up networking on loopback device: 
Setting up networking on eth0: 
udhcpc (v0.9.9-pre) started
udhcpc[815]: udhcpc (v0.9.9-pre) started
Sending discover...
udhcpc[815]: Sending discover...
Sending select for 192.168.0.8...
udhcpc[815]: Sending select for 192.168.0.8...
Lease of 192.168.0.8 obtained, lease time 864000
udhcpc[815]: Lease of 192.168.0.8 obtained, lease time 864000
deleting routers
SIOCDELRT: No such process
adding dns 212.27.40.240
adding dns 212.27.40.241
Setting up networking on eth1: 
eth1: 0:01 already attached
eth1: Could not attach to PHY
SIOCSIFFLAGS: Device or resource busy
Starting inetd: 
Starting the dropbear ssh server: 
Setting time from ntp server: ntp.cs.strath.ac.uk


        Welcome to OZE


oze-systems login: 







--Apple-Mail-306--420995698
Content-Type: text/html;
	charset=US-ASCII
Content-Transfer-Encoding: 7bit

<html><body style="word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space; "><div><div style="word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space; "><div><div dir="ltr"></div></div></div><div style="word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space; "><div></div><br></div></div><br></body></html>
--Apple-Mail-306--420995698--

--Apple-Mail-305--420995699--
