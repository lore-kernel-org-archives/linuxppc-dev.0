Return-Path: <muditg@lucent.com>
Received: from hoemail2.lucent.com (hoemail2.lucent.com [192.11.226.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hoemail2.lucent.com",
	Issuer "Lucent Technologies Certificate Services 1" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 193A667C68
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Nov 2006 21:20:14 +1100 (EST)
Received: from ii0015exch002u.wins.lucent.com (h135-254-246-205.lucent.com
	[135.254.246.205])
	by hoemail2.lucent.com (8.13.8/IER-o) with ESMTP id kA6ABH6w007834
	for <linuxppc-embedded@ozlabs.org>; Mon, 6 Nov 2006 04:11:19 -0600 (CST)
Message-ID: <3BE48DD0EC7D3948BC183931D9150C210BBB0BAB@ii0015exch001u.iprc.lucent.com>
From: "Goel, Mudit (Mudit)" <muditg@lucent.com>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: Linux Kernel 2.6 on Artesyn Katana Board (3750) with IBM 750FX PP
	C
Date: Mon, 6 Nov 2006 15:41:15 +0530 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

All , 
  We have Artesyn Katana Boards with ppc boot version 1.2.0 (with different
release dates ).We have MV Linux  to be 
  used on these cards. 
  
  We are trying to upgrade the kernel to 2.6. The kernel upgrade is success
on one card with ppc boot version 1.2 
  with release date of July 2004. 
  
  But all other cards which have different dates but same boot version the
kernel upgrade is not successful.
  Here is the boot output
 ---------------------------- 
P1(2.01)=>go 0x08010000
## Starting application at 0x08010000 ...
loaded at:     08010000 081EA320
relocated to:  00800000 009DA320
zimage at:     00805909 009D78BD
avail ram:     00700000 00B00000
max kernel:    00600000

Linux/PPC load: root=/dev/nfs rw nfsroot=172.31.4.10:/app2/cpsbeplg
nfsaddrs=172
.31.4.50:172.31.4.10:172.31.4.254:255.255.255.0:cpsbcicc-50:eth0:off
Uncompressing Linux...done.
Now booting the kernel
Total memory = 256MB; using 512kB for hash table (at c0480000)
Linux version 2.6.10_mvlcge401-katana (root@hdrlin03) (gcc version 3.4.3
(MontaV
ista 3.4.3-25.0.41.0501420 2005-09-07)) #29 Mon Nov 6 14:58:36 IST 2006
RMON: rmon_first_init
Artesyn Communication Products, LLC - Katana(TM)
Real-Time Preemption Support (c) Ingo Molnar
Built 1 zonelists
Kernel command line: root=/dev/nfs rw nfsroot=172.31.4.10:/app2/cpsbeplg
nfsaddr
s=172.31.4.50:172.31.4.10:172.31.4.254:255.255.255.0:cpsbcicc-50:eth0:off
PID hash table entries: 2048 (order: 11, 32768 bytes)
time_init: decrementer frequency = 33.333333 MHz
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 254576k available (2856k kernel code, 1468k data, 152k init, 0k
highmem)

RMON - kernel resource monitoring
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
spawn_desched_task(00000000)
desched cpu_callback 3/00000000
ksoftirqd started up.
softirq RT prio: 24.
desched cpu_callback 2/00000000
desched thread 0 started up.
NET: Registered protocol family 16
PCI: Probing PCI hardware
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
SGI XFS with ACLs, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
Fast Real Time Domain (c) 2005 Montavista Software, Inc.
FRD major device number is 254
Generic RTC Driver v1.07
Serial: MPSC driver $Revision: 1.00 $
ttyMM0 at MMIO 0xd10bc000 (irq = 36) is a MPSC
ttyMM1 at MMIO 0xd10c2000 (irq = 38) is a MPSC
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
MV-643xx 10/100/1000 Ethernet Driver
eth0: port 2 with MAC address 00:80:f9:64:a8:c0
eth0: RX NAPI Enabled
i2c /dev entries driver
IPMB I2C Client 0.07 05 Nov 2004 - Loaded on address 0x08 (0x10)
mv64xxx: i2c slave interface enabled
Local Slave Address: 80
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
elevator: using anticipatory as default io scheduler
physmap flash device: 4000000 at e0000000
phys_mapped_flash: Found 2 x16 devices at 0x0 in 32-bit bank
 Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
cmdlinepart partition parsing not available
RedBoot partition parsing not available
Using physmap partition definition
Creating 6 MTD partitions on "phys_mapped_flash":
0x00000000-0x00100000 : "Monitor"
0x00100000-0x00300000 : "Primary Kernel"
0x00300000-0x02080000 : "Primary Filesystem"
0x02080000-0x02280000 : "Secondary Kernel"
0x02280000-0x04000000 : "Secondary Filesystem"
0x00100000-0x04000000 : "User FLASH"
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP: routing cache hash table of 256 buckets, 14Kbytes
TCP: Hash tables configured (established 2048 bind 2340)
NET: Registered protocol family 1
NET: Registered protocol family 17
IP-Config: Complete:
      device=eth0, addr=172.31.4.50, mask=255.255.255.0, gw=172.31.4.254,
     host=cpsbcicc-50, domain=, nis-domain=(none),
     bootserver=172.31.4.10, rootserver=172.31.4.10, rootpath=
Looking up port of RPC 100003/2 on 172.31.4.10
portmap: server 172.31.4.10 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 172.31.4.10
portmap: server 172.31.4.10 not responding, timed out
Root-NFS: Unable to get mountd port number from server, using default
mount: server 172.31.4.10 not responding, timed out
Root-NFS: Server returned error -5 while mounting /app2/cpsbeplg
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "nfs" or unknown-block(2,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(2,0)
 <0>Rebooting in 180 seconds..


---------------------------

Thanx
Mudit Goel
