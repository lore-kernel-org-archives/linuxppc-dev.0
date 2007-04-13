Return-Path: <cthomas@Soneticom.com>
Received: from Soneticom.com (soneticom.com [209.114.210.150])
	by ozlabs.org (Postfix) with ESMTP id 84AF4DDE47
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Apr 2007 06:24:17 +1000 (EST)
MIME-Version: 1.0
Subject: RE: Linux 2.6 and uboot
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 13 Apr 2007 16:24:52 -0400
Message-ID: <3C02138692C13C4BB675FE7EA24095293284E0@bluefin.Soneticom.local>
In-Reply-To: <56EADD43-F9B3-427E-9322-AAC708EF2CCC@kernel.crashing.org>
From: "Clint Thomas" <cthomas@Soneticom.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sorry, not quite the latest kernel. 2.6.19 as distributed in ELDK 4.1,
built for the MPC8555CDS, although the actual board is slightly
different.

Here is the boot time output. U-boot succesfully enables the ethernet to
get its kernel image from the TFTP server.

## Booting image at 01000000 ...
   Image Name:   Linux-2.6.19.2
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1475429 Bytes =3D  1.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Memory CAM mapping: CAM0=3D256Mb, CAM1=3D0Mb, CAM2=3D0Mb residual: 0Mb
Linux version 2.6.19.2 (cthomas@devbox) (gcc version 4.0.0 (DENX ELDK
4.1 4.0.0)) #3 Mon Apr
 13:44:24 EDT 2007
mpc85xx_cds_setup_arch
CDS Version =3D 80 in PCI slot 1
Zone PFN ranges:
  DMA             0 ->    65536
  Normal      65536 ->    65536
early_node_map[1] active PFN ranges
    0:        0 ->    65536
Built 1 zonelists.  Total pages: 65024
Kernel command line: root=3D/dev/nfs
nfsaddrs=3D204.215.226.247:204.215.226.49:204.215.226.50:255.255.2
5.0 rw nfsroot=3D/opt/RFS_CAT console=3DttyS0,9600 doPci=3D1
OpenPIC Version 1.2 (1 CPUs and 60 IRQ sources) at fcf78000
PID hash table entries: 1024 (order: 10, 4096 bytes)
Warning: real time clock seems stuck!
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256640k available (2276k kernel code, 704k data, 136k init, 0k
highmem)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
PCI: Probing PCI hardware
Generic PHY: Registered new driver
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 8192 bind 4096)
TCP reno registered
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing
disabled
serial8250.0: ttyS0 at MMIO 0xfdf04500 (irq =3D 106) is a 16550A
serial8250.0: ttyS1 at MMIO 0xfdf04600 (irq =3D 106) is a 16550A
RAMDISK driver initialized: 8 RAM disks of 32768K size 1024 blocksize
loop: loaded (max 8 devices)
nbd: registered device at major 43
Gianfar MII Bus: probed
eth0: Gianfar Ethernet Controller Version 1.2, 00:01:af:07:9b:8b
eth0: Running with NAPI enabled
eth0: 256/256 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.2, df:f7:bf:7d:72:6f
eth1: Running with NAPI enabled
eth1: 256/256 RX/TX BD ring size
Marvell 88E1101: Registered new driver
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=3Dxx
st: Version 20050830, fixed bufsize 32768, s/g segs 256
ehci_hcd 0000:01:06.2: EHCI Host Controller
ehci_hcd 0000:01:06.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:01:06.2: irq 130, io mem 0x9efbdf00
ehci_hcd 0000:01:06.2: USB 2.0 started, EHCI 0.95, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
ohci_hcd 0000:01:06.0: OHCI Host Controller
ohci_hcd 0000:01:06.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:01:06.0: irq 130, io mem 0x9efbf000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ohci_hcd 0000:01:06.1: OHCI Host Controller
ohci_hcd 0000:01:06.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:01:06.1: irq 130, io mem 0x9efbe000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17

This is the point where it stops booting.


Clint Thomas

-----Original Message-----
From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
Sent: Friday, April 13, 2007 4:18 PM
To: Clint Thomas
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux 2.6 and uboot


On Apr 13, 2007, at 2:55 PM, Clint Thomas wrote:

> Is there any correlation between the version of U-boot to use on a=20
> board and the version of the Linux kernel you plan to use? Current I'm

> running U-boot 1.1.2 with kernel 2.4.26 on my MPC85xx board, but i'm=20
> trying to migrate to the latest 2.6 kernel. I am getting a kernel hang

> at boot when it registers socket family 17, so I was wondering if it=20
> might have to do with u-boot before exploring the debug route.

That's an odd place to hang. Which 2.6 kernel are you using?  Also are
you using arch/ppc or arch/powerpc?

- k
