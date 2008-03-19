Return-Path: <mail4mz@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.227])
	by ozlabs.org (Postfix) with ESMTP id 56E88DDF50
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Mar 2008 02:50:43 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id 67so486246wri.3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Mar 2008 08:50:41 -0700 (PDT)
Message-ID: <5c9cd53b0803190850w6037aeb5gfbd3ecfebd9c089a@mail.gmail.com>
Date: Wed, 19 Mar 2008 11:50:40 -0400
From: "mike zheng" <mail4mz@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: mpc8568mds bootup problem
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

My mpc8568mds board does not bootup. I am using Freescale's BSP on
kernel2.6.23. The following is the log from serial port. Any idea?
What is the next module to be initialized after the cfq? Where can I
comment it out for debugging purpose?

Thanks for your help,

Mike


=> bootm 1000000 2000000 400000
bootm 1000000 2000000 400000
## Booting image at 01000000 ...
  Image Name:   Linux-2.6.23
  Created:      2008-03-18  20:48:11 UTC
  Image Type:   PowerPC Linux Kernel Image (gzip compressed)
  Data Size:    1283304 Bytes =  1.2 MB
  Load Address: 00000000
  Entry Point:  00000000
  Verifying Checksum ... OK
  Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 02000000 ...
  Image Name:   uboot ext2 ramdisk rootfs
  Created:      2007-06-26   4:25:24 UTC
  Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
  Data Size:    3719970 Bytes =  3.5 MB
  Load Address: 00000000
  Entry Point:  00000000
  Verifying Checksum ... OK
  Booting using flat device tree at 0x400000
  Loading Ramdisk to 1f1c2000, end 1f54e322 ... OK
Using MPC85xx MDS machine description
Memory CAM mapping: CAM0=256Mb, CAM1=256Mb, CAM2=0Mb residual: 0Mb
Linux version 2.6.23 () (gcc version 4.0.2 20060628 (Wasabi)) #9 Tue
Mar 18 16:48:04 EDT 2008
Found initrd at 0xdf1c2000:0xdf54e322
-> find_legacy_serial_port()
stdout is /soc8568@e0000000/serial@4600
legacy_serial_console = 1
default console speed = 115340
<- find_legacy_serial_port()
console [udbg0] enabled
setup_arch: bootmem
mpc85xx_mds_setup_arch()
Found FSL PCI host bridge at 0x00000000e0008000.Firmware bus number: 0->0
pio-handle not available
pio-handle not available
arch: exit
Zone PFN ranges:
 DMA             0 ->   131072
 Normal     131072 ->   131072
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
   0:        0 ->   131072
Built 1 zonelists in Zone order.  Total pages: 130048
Kernel command line: ramdisk_size=42000 root=/dev/ram rw console=ttyS1,115200
mpic: Setting up MPIC " OpenPIC  " version 1.2 at e0040000, max 1 CPUs
mpic: ISU size: 80, shift: 7, mask: 7f
mpic: Initializing for 80 sources
QEIC (64 IRQ sources) at fd6ed080
PID hash table entries: 2048 (order: 11, 8192 bytes)
-> check_legacy_serial_console()
console was specified !
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 512896k/524288k available (2556k kernel code, 10952k reserved,
108k data, 102k bss, 144k init)
Mount-cache hash table entries: 512
NET: Registered protocol family 16

rstcr compatible register does not exist!
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 0 of device 0000:00:02.0
PCI: Cannot allocate resource region 0 of device 0000:00:02.1
PCI: Cannot allocate resource region 0 of device 0000:00:02.2
PCI: Cannot allocate resource region 0 of device 0000:00:03.0
PCI: Cannot allocate resource region 0 of device 0000:00:03.1
PCI: Cannot allocate resource region 0 of device 0000:00:03.2
PCI: Cannot allocate resource region 0 of device 0000:00:04.0
...

PCI: Cannot allocate resource region 0 of device 0000:00:1f.0
PCI: Cannot allocate resource region 0 of device 0000:00:1f.1
PCI: Cannot allocate resource region 0 of device 0000:00:1f.2
Generic PHY: Registered new driver
SCSI subsystem initialized
NET: Registered protocol family 2
IP route cache hash table entries: 16384 (order: 4, 65536 bytes)
TCP established hash table entries: 65536 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 65536 bind 65536)
TCP reno registered
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 3632k freed
Fixing serial ports interrupts and IO ports ...
fixup_port_irq(0)
fixup_port_mmio(0)
fixup_port_irq(1)
fixup_port_mmio(1)
Registering platform serial ports
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
