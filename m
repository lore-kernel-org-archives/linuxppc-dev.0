Return-Path: <vijay.t.nikam@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.226])
	by ozlabs.org (Postfix) with ESMTP id F1B37DE09A
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 19:14:02 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so272371rvb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 02:14:01 -0700 (PDT)
Message-ID: <f234e2140807300214v60a2ddf3s59c1c9c47af30c9b@mail.gmail.com>
Date: Wed, 30 Jul 2008 14:44:01 +0530
From: "Vijay Nikam" <vijay.t.nikam@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Warning: Uable to open an inital console
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_37077_31124523.1217409241250"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_37077_31124523.1217409241250
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello all,

I have mpc8313erdb board and trying boot the kernel from NAND flash ...
The kernel is booting fine but it hangs at the following message;

Warning: unable to open an initial console.
Kernel panic - not syncing: No init found.  Try passing init= option to
kernel.

Following is the log of the kernel booting ...
########################################## LOG START
########################################

NAND SPL - U-Boot 1.1.6 (Jul 28 2008 - 21:40:02) MPC83XX
Loading from NAND : ........................

U-Boot 1.1.6 (Jul 28 2008 - 21:39:41) MPC83XX

Clock configuration:
  Coherent System Bus:  166 MHz
  Core:                 333 MHz
  Local Bus Controller: 166 MHz
  Local Bus:             41 MHz
  DDR:                  333 MHz
  SEC:                   55 MHz
  I2C1:                 166 MHz
  I2C2:                 166 MHz
  TSEC1:                166 MHz
  TSEC2:                166 MHz
  USB MPH:                0 MHz
  USB DR:                55 MHz
CPU: MPC8313E, Rev: 10 at 333.333 MHz
Board: Freescale MPC8313ERDB
I2C:   ready
DRAM:  Initializing
   DDR RAM: 128 MB
FLASH:  8 MB
NAND:  32 MiB
In:    serial
Out:   serial
Err:   serial
Net:   TSEC0, TSEC1 [PRIME]
Hit any key to stop autoboot:  0

Loading from NAND 32MiB 3,3V 8-bit, offset 0x100000
   Image Name:   Linux-2.6.20
   Created:      2008-07-28  16:15:15 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1716719 Bytes =  1.6 MB
   Load Address: 00000000
   Entry Point:  00000000
## Booting image at 00200000 ...
   Image Name:   Linux-2.6.20
   Created:      2008-07-28  16:15:15 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1716719 Bytes =  1.6 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Booting using flat device tree at 0x400000
setup_arch: bootmem
mpc8313_rdb_setup_arch()
arch: exit

Using MPC8313 RDB machine description
Linux version 2.6.20 (vijay@localhost.localdomain) (gcc version 4.0.2
20060628 (Wasabi)) #8 Mon Jul 28 21:45:12 IST 2008
Found MPC83xx PCI host bridge at 0x00000000e0008500. Firmware bus number:
0->0
Zone PFN ranges:
  DMA             0 ->    32768
  Normal      32768 ->    32768
early_node_map[1] active PFN ranges
    0:        0 ->    32768
Built 1 zonelists.  Total pages: 32512
Kernel command line: root=/dev/mtdblock3 rootfstype=jffs2 rw
console=ttyS0,115200
mtdparts=nand0:1M(u-boot),3M(kernel),256K(devtb),-(jffs)
IPIC (128 IRQ sources) at fdefa700
PID hash table entries: 512 (order: 9, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 126164k/131072k available (2988k kernel code, 4764k reserved, 464k
data, 96k bss, 144k init)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
PCI: Probing PCI hardware
Generic PHY: Registered new driver
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 4096 bind 2048)
TCP reno registered
JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Generic RTC Driver v1.07
WDT driver for MPC83xx initialized. mode:reset timeout=65535 (25 seconds)
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 16) is a 16550A
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 17) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 7.3.15-k2-NAPI
Copyright (c) 1999-2006 Intel Corporation.
Gianfar MII Bus: probed
eth0: Gianfar Ethernet Controller Version 1.4, 00:04:9f:ef:23:33
eth0: MTU = 1500 (frame size=1540,truesize=2296)
eth0: Running with NAPI enabled
eth0: 64/64 RX/TX BD ring size
eth0: Socket buffer recycling mode enabled
eth1: Gianfar Ethernet Controller Version 1.4, 00:e0:0c:00:7e:21
eth1: MTU = 1500 (frame size=1540,truesize=2296)
eth1: Running with NAPI enabled
eth1: 64/64 RX/TX BD ring size
eth1: Socket buffer recycling mode enabled
SKB Handler initialized(max=64)
Marvell 88E1101: Registered new driver
Marvell 88E1111: Registered new driver
Marvell 88E1145: Registered new driver
MPC8313ERDB Ethernet Switch: Registered new driver
MPC8313RDB flash device: 800000 at fe000000 Partition number 4
MPC8313RDB Flash Map Info: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
MPC8313RDB Flash Map Info: Swapping erase regions for broken CFI table.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
Creating 4 MTD partitions on "MPC8313RDB Flash Map Info":
0x00000000-0x00100000 : "U-Boot"
0x00100000-0x00300000 : "Kernel"
0x00300000-0x00700000 : "JFFS2"
0x00700000-0x00800000 : "dtb"
MPC8313RDB flash device (MPC8313RDB Flash Map Info) initialized
Freescale eLBC NAND Driver (C) 2006 Freescale
NAND device: Manufacturer ID: 0xec, Chip ID: 0x75 (Samsung NAND 32MiB 3,3V
8-bit)
Scanning device for bad blocks
4 cmdlinepart partitions found on MTD device nand0
Creating 4 MTD partitions on "nand0":
0x00000000-0x00100000 : "u-boot"
0x00100000-0x00400000 : "kernel"
0x00400000-0x00440000 : "devtb"
0x00440000-0x02000000 : "jffs"
usbmon: debugfs is not available
fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 1
fsl-ehci fsl-ehci.0: irq 38, io base 0xe0023000
fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
Freescale High-Speed USB SOC Device Controller driver (Feb 5, 2007)
i2c /dev entries driver
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
VFS: Mounted root (jffs2 filesystem).
Freeing unused kernel memory: 144k init
Warning: unable to open an initial console.
Kernel panic - not syncing: No init found.  Try passing init= option to
kernel.
 <0>Rebooting in 180 seconds..
########################################################## LOG END
#########################################################

Can anyone suggest someway to proceed ... thanks ...

Kindly please acknowledge ... thank you ...

Kind Regards,

Vijay Nikam

------=_Part_37077_31124523.1217409241250
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hello all,</div>
<div>&nbsp;</div>
<div>I have mpc8313erdb board and trying boot the kernel from NAND flash ...</div>
<div>The kernel is booting fine but it hangs at the following message;</div>
<div>&nbsp;</div>
<div>Warning: unable to open an initial console.<br>Kernel panic - not syncing: No init found.&nbsp; Try passing init= option to kernel.</div>
<div>&nbsp;</div>
<div>Following is the log of the kernel booting ...</div>
<div>########################################## LOG START ########################################</div>
<div>
<p>NAND SPL - U-Boot 1.1.6 (Jul 28 2008 - 21:40:02) MPC83XX<br>Loading from NAND : ........................</p>
<p>U-Boot 1.1.6 (Jul 28 2008 - 21:39:41) MPC83XX</p>
<p>Clock configuration:<br>&nbsp; Coherent System Bus:&nbsp; 166 MHz<br>&nbsp; Core:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 333 MHz<br>&nbsp; Local Bus Controller: 166 MHz<br>&nbsp; Local Bus:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 41 MHz<br>&nbsp; DDR:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 333 MHz<br>&nbsp; SEC:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 55 MHz<br>
&nbsp; I2C1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 166 MHz<br>&nbsp; I2C2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 166 MHz<br>&nbsp; TSEC1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 166 MHz<br>&nbsp; TSEC2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 166 MHz<br>&nbsp; USB MPH:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 MHz<br>&nbsp; USB DR:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 55 MHz<br>CPU: MPC8313E, Rev: 10 at 333.333 MHz<br>
Board: Freescale MPC8313ERDB<br>I2C:&nbsp;&nbsp; ready<br>DRAM:&nbsp; Initializing<br>&nbsp;&nbsp; DDR RAM: 128 MB<br>FLASH:&nbsp; 8 MB<br>NAND:&nbsp; 32 MiB<br>In:&nbsp;&nbsp;&nbsp; serial<br>Out:&nbsp;&nbsp; serial<br>Err:&nbsp;&nbsp; serial<br>Net:&nbsp;&nbsp; TSEC0, TSEC1 [PRIME]<br>Hit any key to stop autoboot:&nbsp; 0</p>

<p>Loading from NAND 32MiB 3,3V 8-bit, offset 0x100000<br>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.20<br>&nbsp;&nbsp; Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2008-07-28&nbsp; 16:15:15 UTC<br>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip compressed)<br>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1716719 Bytes =&nbsp; 1.6 MB<br>
&nbsp;&nbsp; Load Address: 00000000<br>&nbsp;&nbsp; Entry Point:&nbsp; 00000000<br>## Booting image at 00200000 ...<br>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.20<br>&nbsp;&nbsp; Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2008-07-28&nbsp; 16:15:15 UTC<br>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip compressed)<br>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1716719 Bytes =&nbsp; 1.6 MB<br>&nbsp;&nbsp; Load Address: 00000000<br>&nbsp;&nbsp; Entry Point:&nbsp; 00000000<br>&nbsp;&nbsp; Verifying Checksum ... OK<br>&nbsp;&nbsp; Uncompressing Kernel Image ... OK<br>&nbsp;&nbsp; Booting using flat device tree at 0x400000<br>
setup_arch: bootmem<br>mpc8313_rdb_setup_arch()<br>arch: exit</p>
<p>Using MPC8313 RDB machine description<br>Linux version 2.6.20 (<a href="mailto:vijay@localhost.localdomain">vijay@localhost.localdomain</a>) (gcc version 4.0.2 20060628 (Wasabi)) #8 Mon Jul 28 21:45:12 IST 2008<br>Found MPC83xx PCI host bridge at 0x00000000e0008500. Firmware bus number: 0-&gt;0<br>
Zone PFN ranges:<br>&nbsp; DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp;&nbsp; 32768<br>&nbsp; Normal&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 32768 -&gt;&nbsp;&nbsp;&nbsp; 32768<br>early_node_map[1] active PFN ranges<br>&nbsp;&nbsp;&nbsp; 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp;&nbsp; 32768<br>Built 1 zonelists.&nbsp; Total pages: 32512<br>Kernel command line: root=/dev/mtdblock3 rootfstype=jffs2 rw console=ttyS0,115200 mtdparts=nand0:1M(u-boot),3M(kernel),256K(devtb),-(jffs)<br>
IPIC (128 IRQ sources) at fdefa700<br>PID hash table entries: 512 (order: 9, 2048 bytes)<br>Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)<br>Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)<br>
Memory: 126164k/131072k available (2988k kernel code, 4764k reserved, 464k data, 96k bss, 144k init)<br>Mount-cache hash table entries: 512<br>NET: Registered protocol family 16<br>PCI: Probing PCI hardware<br>Generic PHY: Registered new driver<br>
SCSI subsystem initialized<br>usbcore: registered new interface driver usbfs<br>usbcore: registered new interface driver hub<br>usbcore: registered new device driver usb<br>NET: Registered protocol family 2<br>IP route cache hash table entries: 1024 (order: 0, 4096 bytes)<br>
TCP established hash table entries: 4096 (order: 2, 16384 bytes)<br>TCP bind hash table entries: 2048 (order: 1, 8192 bytes)<br>TCP: Hash tables configured (established 4096 bind 2048)<br>TCP reno registered<br>JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.<br>
io scheduler noop registered<br>io scheduler anticipatory registered (default)<br>io scheduler deadline registered<br>io scheduler cfq registered<br>Generic RTC Driver v1.07<br>WDT driver for MPC83xx initialized. mode:reset timeout=65535 (25 seconds)<br>
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled<br>serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 16) is a 16550A<br>serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 17) is a 16550A<br>RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize<br>
loop: loaded (max 8 devices)<br>Intel(R) PRO/1000 Network Driver - version 7.3.15-k2-NAPI<br>Copyright (c) 1999-2006 Intel Corporation.<br>Gianfar MII Bus: probed<br>eth0: Gianfar Ethernet Controller Version 1.4, 00:04:9f:ef:23:33<br>
eth0: MTU = 1500 (frame size=1540,truesize=2296)<br>eth0: Running with NAPI enabled<br>eth0: 64/64 RX/TX BD ring size<br>eth0: Socket buffer recycling mode enabled<br>eth1: Gianfar Ethernet Controller Version 1.4, 00:e0:0c:00:7e:21<br>
eth1: MTU = 1500 (frame size=1540,truesize=2296)<br>eth1: Running with NAPI enabled<br>eth1: 64/64 RX/TX BD ring size<br>eth1: Socket buffer recycling mode enabled<br>SKB Handler initialized(max=64)<br>Marvell 88E1101: Registered new driver<br>
Marvell 88E1111: Registered new driver<br>Marvell 88E1145: Registered new driver<br>MPC8313ERDB Ethernet Switch: Registered new driver<br>MPC8313RDB flash device: 800000 at fe000000 Partition number 4<br>MPC8313RDB Flash Map Info: Found 1 x16 devices at 0x0 in 16-bit bank<br>
&nbsp;Amd/Fujitsu Extended Query Table at 0x0040<br>MPC8313RDB Flash Map Info: Swapping erase regions for broken CFI table.<br>number of CFI chips: 1<br>cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.<br>
Creating 4 MTD partitions on &quot;MPC8313RDB Flash Map Info&quot;:<br>0x00000000-0x00100000 : &quot;U-Boot&quot;<br>0x00100000-0x00300000 : &quot;Kernel&quot;<br>0x00300000-0x00700000 : &quot;JFFS2&quot;<br>0x00700000-0x00800000 : &quot;dtb&quot;<br>
MPC8313RDB flash device (MPC8313RDB Flash Map Info) initialized<br>Freescale eLBC NAND Driver (C) 2006 Freescale<br>NAND device: Manufacturer ID: 0xec, Chip ID: 0x75 (Samsung NAND 32MiB 3,3V 8-bit)<br>Scanning device for bad blocks<br>
4 cmdlinepart partitions found on MTD device nand0<br>Creating 4 MTD partitions on &quot;nand0&quot;:<br>0x00000000-0x00100000 : &quot;u-boot&quot;<br>0x00100000-0x00400000 : &quot;kernel&quot;<br>0x00400000-0x00440000 : &quot;devtb&quot;<br>
0x00440000-0x02000000 : &quot;jffs&quot;<br>usbmon: debugfs is not available<br>fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller<br>fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 1<br>fsl-ehci fsl-ehci.0: irq 38, io base 0xe0023000<br>
fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004<br>usb usb1: configuration #1 chosen from 1 choice<br>hub 1-0:1.0: USB hub found<br>hub 1-0:1.0: 1 port detected<br>Initializing USB Mass Storage driver...<br>
usbcore: registered new interface driver usb-storage<br>USB Mass Storage support registered.<br>Freescale High-Speed USB SOC Device Controller driver (Feb 5, 2007)<br>i2c /dev entries driver<br>TCP cubic registered<br>NET: Registered protocol family 1<br>
NET: Registered protocol family 17<br>VFS: Mounted root (jffs2 filesystem).<br>Freeing unused kernel memory: 144k init<br>Warning: unable to open an initial console.<br>Kernel panic - not syncing: No init found.&nbsp; Try passing init= option to kernel.<br>
&nbsp;&lt;0&gt;Rebooting in 180 seconds..<br>########################################################## LOG END #########################################################</p>
<p>Can anyone suggest someway to proceed ... thanks ...</p>
<p>Kindly please acknowledge ... thank you ...</p>
<p>Kind Regards,</p>
<p>Vijay Nikam </p>
<p>&nbsp;<br></p></div>

------=_Part_37077_31124523.1217409241250--
