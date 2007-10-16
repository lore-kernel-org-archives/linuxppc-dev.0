Return-Path: <mhamed@future-group.com>
Received: from mail.thesecuremail.net (unknown [217.139.35.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mohamed fekry", Issuer "mohamed fekry" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D63D7DDE3F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Oct 2007 23:55:07 +1000 (EST)
Subject: Re: Antwort: Re: ATA flash disk ok, missing ip config
From: Mohamed Hamed <mhamed@future-group.com>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <0FOJ00CF99QJAJ@pmdf-it.hasler.ascom.ch>
Content-Type: text/plain
Date: Tue, 16 Oct 2007 14:44:53 +0200
Message-Id: <1192538693.9518.11.camel@mhamed>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Sir,

	i'm trying to install qemu in a debian linux system , ubuntu , and when
i finished from installation and trying to run the qemu more error be
found as follow :



 (qemu) Uncompressing
Linux.......................................................................... done, booting the kernel.
Linux version 2.6.17-rc3 (paul@wren) (gcc version 4.1.0 (CodeSourcery
ARM)) #53 Thu May 4 15:05:18 BST 2006
CPU: ARM926EJ-Sid(wb) [41069265] revision 5 (ARMv5TEJ)
Machine: ARM-IntegratorCP
Memory policy: ECC disabled, Data cache writeback
CPU0: D VIVT write-through cache
CPU0: I cache: 4096 bytes, associativity 4, 32 byte lines, 32 sets
CPU0: D cache: 65536 bytes, associativity 4, 32 byte lines, 512 sets
Built 1 zonelists
Kernel command line: console=ttyAMA0 root= /dev/nfs
nfsroot=10.1.6.1:/nfs/share/arm,rsize=8192,wsize=8192,hard,intr,tcp,nolock ip=10.1.6.50::10.1.6.1:255.255.255.0:arm.home:eth0 
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256MB = 256MB total
Memory: 257280KB available (1928K code, 388K data, 104K init)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
NetWinder Floating Point Emulator V0.97 (double precision)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
CLCD: Integrator/CP hardware, VGA display
Clock CLCDCLK: setting VCO reg params: S=1 R=39 V=35
Console: switching to colour frame buffer device 80x30
Serial: AMBA PL011 UART driver
mb:16: ttyAMA0 at MMIO 0x16000000 (irq = 1) is a AMBA/PL011
mb:17: ttyAMA1 at MMIO 0x17000000 (irq = 2) is a AMBA/PL011
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
nbd: registered device at major 43
smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
eth0: SMC91C11xFD (rev 1) at d0816000 IRQ 27 [nowait]
eth0: Ethernet addr: 52:54:00:12:34:56
mice: PS/2 mouse device common for all mice
Green LED off
input: AT Raw Set 2 keyboard as /class/input/input0
input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 8192 bind 4096)
TCP reno registered
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
VFP support v0.3: implementor 41 architecture 1 part 10 variant 9 rev 0
eth0: link up
IP-Config: Complete:
      device=eth0, addr=10.1.6.50, mask=255.255.255.0, gw=10.1.6.1,
     host=arm, domain=, nis-domain=home,
     bootserver=255.255.255.255, rootserver=10.1.6.1, rootpath=
Looking up port of RPC 100003/2 on 10.1.6.1
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 10.1.6.1
Root-NFS: Unable to get mountd port number from server, using default
Root-NFS: Server returned error -5 while mounting /nfs/share/arm
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "<NULL>" or unknown-block(2,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(2,0)
 

and i don't know what is the reason and i don't know what the line root
=boot option 

this is the script which i run

#!/bin/sh

console="ttyAMA0"		# serial console
nfsserver="10.1.6.1"		# address of NFS server
nfsdir="/nfs/share/arm"		# exported share where debian/arm is installed
address="10.1.6.50"		# address for guest server
gateway="10.1.6.1"		# default gateway
netmask="255.255.255.0"		# subnet mask
hostname="arm.home"		# hostname for guest server
device="eth0"			# interface that guest server will use
mem=256				# memory for guest server in Mb
tap="/var/run/vde/tap0.ctl"	# vde tap socket

kernel="/usr/local/etc/images/zimage.arm"	# arm kernel
nfsopts="rsize=8192,wsize=8192,hard,intr,tcp,nolock"	# nfs options

consoleopt="console=$console"
nfsrootopt="nfsroot=$nfsserver:$nfsdir,$nfsopts"
ipopt="ip=$address::$gateway:$netmask:$hostname:$device"

init=""

if [ "x$1" == "xsingle" ]
then
	init="init=/bin/bash"
fi
vdeq qemu-system-arm -sock $tap -m $mem \
	-kernel $kernel -nographic \
	-append "$consoleopt root= /dev/nfs  $nfsrootopt $ipopt $init" 

and i don't know this line root = /dev/nfs , where this directory  is
empty


thanks for helping me 

i hope to reply me at this mail mhamed@future-group.com
or at eng_m_elsaidy@yahoo.com


Hamed 
