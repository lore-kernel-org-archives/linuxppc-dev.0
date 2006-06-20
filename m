Return-Path: <Hans.Thielemans@skynet.be>
Received: from outmx016.isp.belgacom.be (outmx016.isp.belgacom.be
	[195.238.4.115])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A81D667B30
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Jun 2006 22:53:43 +1000 (EST)
Received: from outmx016.isp.belgacom.be (localhost [127.0.0.1])
	by outmx016.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k5KCrYeo001116
	for <linuxppc-embedded@ozlabs.org>; Tue, 20 Jun 2006 14:53:34 +0200
	(envelope-from <Hans.Thielemans@skynet.be>)
Date: Tue, 20 Jun 2006 14:52:12 +0200 (CEST)
From: Hans Thielemans <Hans.Thielemans@skynet.be>
To: =?ISO-8859-1?Q?Bj=F6rn_=D6stby?= <Bjorn.Ostby@combitech.se>
Subject: Re: Lite5200 NFS mount issue
In-Reply-To: <BF8F9BE6CD17EB4B8C887AB03E6A9B0303F03C@CORPAPPL020.corp.saab.se>
Message-ID: <Pine.LNX.4.44.0606201451060.24459-100000@gandalf.inthazo.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
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

Hi there,

I remember similar problems. It all had to do with full or half duplex 
ethernet.

Regards

Hans

On Tue, 20 Jun 2006, Björn Östby wrote:

> Hi all,
> I'm using u-boot 1.1.4 (CVS downloaded 2006-05-04) and ELDK 4.0. I've encountered 
> problems when trying to mount a NFS root filesystem when using the Lite MPC5200
> development board. The system mounts ok when the board is connected to office wide 
> network switches but if the board is connected directly through a small 100/10Mbit switch
> to the NFS server, the mount halts as shown in the log below (The 100/10Mbit switch
> do work as other boards can mount their filesystem through these). Does anyone
> recognize this problem and know a suitable work-around/solution?
> 
> =>run flash_nfs
>  ## Booting image at ff0a0000 ...
>    Image Name:   Linux-2.4.25
>    Created:      2006-06-16  13:11:56 UTC
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    945550 Bytes = 923.4 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb
> Linux version 2.4.25 (tord@toshiba) (gcc version 4.0.0 (DENX ELDK 4.0 4.0.0)) #1 fre jun 16 14:46:35 CEST 2006
> On node 0 totalpages: 16384
> zone(0): 16384 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.
> Kernel command line: root=/dev/nfs rw nfsroot=10.3.67.98:/opt/eldk_4_0/ppc_6xx ip=10.3.67.99:10.3.67.98:10.3.67.1:::eth0:off panic=1
> Calibrating delay loop... 263.78 BogoMIPS
> Memory: 62080k available (1608k kernel code, 484k data, 80k init, 0k highmem)
> Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
> Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
> Mount cache hash table entries: 512 (order: 0, 4096 bytes)
> Buffer cache hash table entries: 4096 (order: 2, 16384 bytes)
> Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
> POSIX conformance testing by UNIFIX
> PCI: Probing PCI hardware
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> Starting kswapd
> Journalled Block Device driver loaded
> JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
> i2c-core.o: i2c core module version 2.6.1 (20010830)
> i2c-proc.o version 2.6.1 (20010830)
> pty: 256 Unix98 ptys configured
> ttyS0 on PSC1
> ttyS1 on PSC2
> ttyS2 on PSC3
> RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
> loop: loaded (max 8 devices)
> Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> Port Config is: 0x11050004
> ipb=66MHz, set clock period to 15
> GPIO config: 11050004
> ATA invalid: 00800000
> ATA hostcnf: 03000000
> ATA pio1   : 100a0a00
> ATA pio2   : 02040600
> XLB Arb cnf: 0000a366
> mpc5xxx_ide: Setting up IDE interface ide0...
> ATA DMA task: 5
> Probing IDE interface ide0...
> SCSI subsystem driver Revision: 1.00
> Icecube-0: Found 1 x8 devices at 0x0 in 8-bit bank
> Icecube-0: Found 1 x8 devices at 0x800000 in 8-bit bank
>  Amd/Fujitsu Extended Query Table at 0x0040
> Icecube-0: CFI does not contain boot bank location. Assuming top.
> number of CFI chips: 2
> cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
> Icecube flash bank 0: Using static image partition definition
> Creating 5 MTD partitions on "Icecube-0":
> 0x00000000-0x00800000 : "Spare"
> 0x00800000-0x00900000 : "kernel"
> 0x00900000-0x00c00000 : "initrd"
> 0x00c00000-0x00f00000 : "jffs"
> 0x00f00000-0x01000000 : "Firmware"
> usb.c: registered new driver hub
> host/usb-ohci.c: USB OHCI at membase 0xf0001000, IRQ 44
> host/usb-ohci.c: usb-0, Built-In ohci
> usb.c: new USB bus registered, assigned bus number 1
> hub.c: USB hub found
> hub.c: 1 port detected
> bluetooth.c: USB Bluetooth support registered
> usb.c: registered new driver bluetty
> bluetooth.c: USB Bluetooth tty driver v0.13
> Initializing USB Mass Storage driver...
> usb.c: registered new driver usb-storage
> USB Mass Storage support registered.
> i2c-icecube.o: I2C module #2 installed
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 4096 bind 8192)
> eth0: Phy @ 0x0, type LXT971 (0x001378e2)
> IP-Config: Guessing netmask 255.0.0.0
> IP-Config: Complete:
>       device=eth0, addr=10.3.67.99, mask=255.0.0.0, gw=10.3.67.1,
>      host=10.3.67.99, domain=, nis-domain=(none),
>      bootserver=10.3.67.98, rootserver=10.3.67.98, rootpath=
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> Looking up port of RPC 100003/2 on 10.3.67.98
> Looking up port of RPC 100005/1 on 10.3.67.98
> VFS: Mounted root (nfs filesystem).
> Freeing unused kernel memory: 80k init
> nfs: server 10.3.67.98 not responding, still trying
> nfs: server 10.3.67.98 OK
> nfs: server 10.3.67.98 not responding, still trying
> nfs: server 10.3.67.98 OK
> [time to this about 5 minutes]
> INIT: version 2.85 booting
> nfs: server 10.3.67.98 not responding, still trying
> nfs: server 10.3.67.98 OK
> nfs: server 10.3.67.98 not responding, still trying
> nfs: server 10.3.67.98 OK
> 
> Regards,
> Bjorn Ostby
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
