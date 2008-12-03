Return-Path: <spamreceptor@yahoo.com>
Received: from web30107.mail.mud.yahoo.com (web30107.mail.mud.yahoo.com
	[209.191.69.39]) by ozlabs.org (Postfix) with SMTP id AA2C0DDDE6
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Dec 2008 07:17:13 +1100 (EST)
Date: Wed, 3 Dec 2008 12:17:12 -0800 (PST)
From: Joe Shmo <spamreceptor@yahoo.com>
Subject: Re: Help with DTS file on MPC8313e-rdb board
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <4936C547.6060409@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <56436.75877.qm@web30107.mail.mud.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Forgot the screen dump:

U-Boot 1.3.0 (Oct 31 2008 - 10:01:02) MPC83XX

Reset Status: Software Hard, External/Internal Soft,
External/Internal Hard

CPU:   e300c3, Rev: Unknown revision number:80b10020
Warning: Unsupported cpu revision!
Board: Freescale MPC8313ERDB
I2C:   ready
DRAM:  64 MB
FLASH:  2 MB
In:    serial
Out:   serial
Err:   serial
Net:   TSEC0, TSEC1 [PRIME]
=> run nfsboot
 phy reg contents is 13
Speed: 10, half duplex
Using TSEC1 device
TFTP from server 192.168.1.21; our IP address is
192.168.1.35
Filename 'uImage'.
Load address: 0x200000
Loading:
#################################################################
        
######################################################
done
Bytes transferred = 1735095 (1a79b7 hex)
 phy reg contents is 13
Speed: 10, half duplex
Using TSEC1 device
TFTP from server 192.168.1.21; our IP address is
192.168.1.35
Filename 'dtb'.
Load address: 0x400000
Loading: #
done
Bytes transferred = 12288 (3000 hex)
## Booting image at 00200000 ...
   Image Name:   Linux-2.6.21.7-hrt1-WR2.0bl_stan
   Created:      2008-12-03  19:36:47 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip
compressed)
   Data Size:    1735031 Bytes =  1.7 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Booting using the fdt at 0x400000
Using MPC8313 RDB machine description
Linux version 2.6.21.7-hrt1-WR2.0bl_standard
(root@vbox-kuhlp) (gcc version 4.1.2 (Wind River Linux
Sourcery G++ 4.1-91)) #47 PREEMPT Wed Dec 3 13:36:33
CST 2008
setup_arch: bootmem
mpc8313_rdb_setup_arch()
Found MPC83xx PCI host bridge at 0x00000000e0008500.
Firmware bus number: 0->0
phy_mode =3
arch: exit
Zone PFN ranges:
  DMA             0 ->    16384
  Normal      16384 ->    16384
early_node_map[1] active PFN ranges
    0:        0 ->    16384
Built 1 zonelists.  Total pages: 16256
Kernel command line:
nfsroot=192.168.1.21:/home/developer/export
ip=192.168.1.35:192.168.1.21:192.168.1.1:255.255.255.0:mpc8313erdb-0:eth1:off
root=/dev/nfs rw console=ttyS0,115200
IPIC (128 IRQ sources) at fdefa700
PID hash table entries: 256 (order: 8, 1024 bytes)

object ttyzb: registering. parent: tty, set: devices
WDT driver for MPC83xx initialized. mode:reset
timeout=65535 (32 seconds)
i8042.c: No controller found.
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports,
IRQ sharing disabled
serial8250.0: ttyS0 at MMIO map 0xe0004500 mem
0xc5000500 (irq = 16) is a 16550A
serial8250.0: ttyS1 at MMIO map 0xe0004600 mem
0xc5002600 (irq = 17) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size
1024 blocksize
^^^ Weird phy_device.c stuff but I turned it off
^^^ This should never happen phy_device.c but I turned
it off.
Gianfar MII Bus: probed
eth0: Gianfar Ethernet Controller Version 1.2,
00:e0:0c:00:95:01
eth0: Running with NAPI disabled
eth0: 64/64 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.2,
00:e0:0c:00:95:02
eth1: Running with NAPI disabled
eth1: 64/64 RX/TX BD ring size
netconsole: not configured, aborting
i2c /dev entries driver
MPC8313RDB flash device: 200000 at fe000000 Partition
number 2
MPC8313RDB Flash Map Info: Found 1 x16 devices at 0x0
in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
MPC8313RDB Flash Map Info: JEDEC Device ID is 0x22C4.
Assuming broken CFI table.
MPC8313RDB Flash Map Info: Swapping erase regions for
broken CFI table.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due
to code brokenness.
Creating 2 MTD partitions on "MPC8313RDB Flash Map
Info":
0x00000000-0x00100000 : "U-Boot"
mtd: Giving out device 0 to U-Boot
0x00100000-0x00180000 : "dtb"
mtd: Giving out device 1 to dtb
MPC8313RDB flash device (MPC8313RDB Flash Map Info)
initialized
Freescale eLBC NAND Driver (C) 2006 Freescale
NAND device: Manufacturer ID: 0x2c, Chip ID: 0xb1
(Micron NAND 128MiB 1,8V 8-bit)
Scanning device for bad blocks
Bad eraseblock 122 at 0x00f40000
Bad eraseblock 452 at 0x03880000
Bad eraseblock 481 at 0x03c20000
Bad eraseblock 703 at 0x057e0000
mtd: Giving out device 2 to nand0
mice: PS/2 mouse device common for all mice
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12)
initialised: dm-devel@redhat.com
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
drivers/rtc/hctosys.c: unable to open rtc device
(rtc0)
^^^ Returning correct MII value !
^^^ Interface = 0
IP-Config: Complete:
      device=eth1, addr=192.168.1.35,
mask=255.255.255.0, gw=192.168.1.1,
     host=mpc8313erdb-0, domain=, nis-domain=(none),
     bootserver=192.168.1.21, rootserver=192.168.1.21,
rootpath=
Looking up port of RPC 100003/2 on 192.168.1.21
PHY: e0024520:03 - Link is Up - 10/Half
portmap: server 192.168.1.21 not responding, timed out
Root-NFS: Unable to get nfsd port number from server,
using default
Looking up port of RPC 100005/1 on 192.168.1.21
portmap: server 192.168.1.21 not responding, timed out
Root-NFS: Unable to get mountd port number from
server, using default
mount: server 192.168.1.21 not responding, timed out
Root-NFS: Server returned error -5 while mounting
/home/developer/export
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "nfs" or
unknown-block(2,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root
fs on unknown-block(2,0)
Rebooting in 180 seconds..



--- Scott Wood <scottwood@freescale.com> wrote:

> Joe Shmo wrote:
> > What I don't know is what reg = <4> means.  Is
> that
> > the phy address or the interrupt? 
> 
> It's the PHY address.
> 
> > My phy is the National semi dp83848.  It does not
> use
> > an IRQ.  Should I replace this with zero?  Should
> I
> > take that line out of the DTS file?
> 
> You should remove the interrupts and
> interrupt-parent properties.
> 
> -Scott
> 



      
