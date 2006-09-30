Return-Path: <shenbagaraj@esds.in>
Received: from server9.one-dom9.com (server9.one-dom9.com [69.20.58.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "one-dom9.com",
	Issuer "Equifax Secure Global eBusiness CA-1" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A028567BC5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Sep 2006 21:45:47 +1000 (EST)
Message-ID: <003701c6e426$43704840$0b01a8c0@shenbagaraj>
From: "shenbagaraj" <shenbagaraj@esds.in>
To: <linuxppc-embedded@ozlabs.org>
Subject: Linux kernel 2.6.11.11 Boot error
Date: Fri, 29 Sep 2006 17:20:37 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Reply-To: shenbagaraj <shenbagaraj@esds.in>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
I am working in 8260 board.I build the kernel for this board using
2.6.11.11.When booting the filesystem through NFS ,
getting following error.Any suggestions would be highly appreciated.

sing IDMA1 for MPC8260 device erratum PCI 9 workaround

Built 1 zonelists

Kernel command line: root=/dev/nfs rw nfsroot=192.168.1.11:/opt/gppleppc82xx
ip=192.168.1.41:192.168.1.11::255.255.255.0:sh

enbagaraj:eth1:off console=ttyCPM0,9600

PID hash table entries: 2048 (order: 11, 32768 bytes)

Console: colour dummy device 80x25

Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)

Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)

Memory: 257024k available (1916k kernel code, 576k data, 104k init, 0k
highmem)

Security Framework v1.0.0 initialized

Capability LSM initialized

Mount-cache hash table entries: 512 (order: 0, 4096 bytes)

NET: Registered protocol family 16

PCI: Probing PCI hardware

PCI: Cannot allocate resource region 0 of device 0000:00:00.0

PCI: Cannot allocate resource region 1 of device 0000:00:00.0

PCI: Cannot allocate resource region 0 of device 0000:00:11.0

PCI: Cannot allocate resource region 0 of device 0000:00:11.1

PCI: Cannot allocate resource region 0 of device 0000:00:12.0

Registering GDB sysrq handler

Initializing Cryptographic API

Setting up CardBus controller

Generic RTC Driver v1.07

Serial: CPM driver $Revision: 0.01 $

ttyCPM0 at MMIO 0xf0011a80 (irq = 4) is a CPM UART

ttyCPM1 at MMIO 0xf0011a90 (irq = 5) is a CPM UART

io scheduler noop registered

io scheduler anticipatory registered

io scheduler deadline registered

io scheduler cfq registered

RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize

netconsole: not configured, aborting

eth0: FCC ENET Version 0.3, 00:a0:1e:a8:7b:c9

eth1: FCC ENET Version 0.3, 00:a0:1e:a8:7b:ca

eth2: FCC ENET Version 0.3, 00:a0:1e:a8:7b:cb

eth3: SCC ENET Version 0.1, 00:a0:1e:a8:7b:c8

NET: Registered protocol family 2

IP: routing cache hash table of 2048 buckets, 16Kbytes

TCP: Hash tables configured (established 16384 bind 32768)

NET: Registered protocol family 1

NET: Registered protocol family 17

kgdb: Defering I/O setup to kernel module.

IP-Config: Complete:

device=eth1, addr=192.168.1.41, mask=255.255.255.0, gw=255.255.255.255,

host=shenbagaraj, domain=, nis-domain=(none),

bootserver=192.168.1.11, rootserver=192.168.1.11, rootpath=

Looking up port of RPC 100003/2 on 192.168.1.11

portmap: server 192.168.1.11 not responding, timed out

Root-NFS: Unable to get nfsd port number from server, using default

Looking up port of RPC 100005/1 on 192.168.1.11

portmap: server 192.168.1.11 not responding, timed out

Root-NFS: Unable to get mountd port number from server, using default

mount: server 192.168.1.11 not responding, timed out

Root-NFS: Server returned error -5 while mounting /opt/gppleppc82xx

VFS: Unable to mount root fs via NFS, trying floppy.

VFS: Cannot open root device "nfs" or unknown-block(2,0)

Please append a correct "root=" boot option

Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(2,0)

<0>Rebooting in 180 seconds..


regards,
Shen
