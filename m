Return-Path: <Manjunath.AM@Lntemsys.com>
Received: from mail130.messagelabs.com (mail130.messagelabs.com
	[216.82.250.163]) by ozlabs.org (Postfix) with SMTP id 16D98DDEDA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Jan 2007 23:29:22 +1100 (EST)
To: linuxppc-embedded@ozlabs.org
Subject: nfs mounting problem
MIME-Version: 1.0
Message-ID: <OF08754E94.1194DC2D-ON6525726C.0043EADB-6525726C.0044D6F4@lntemsys.com>
From: Manjunath AM <Manjunath.AM@Lntemsys.com>
Date: Tue, 23 Jan 2007 18:03:28 +0530
Content-Type: multipart/alternative;
	boundary="=_alternative 0044D6F26525726C_="
Cc: kernelnewbies@nl.linux.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 0044D6F26525726C_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

We are using MPC8272 based target board, we are trying to mount montavista 
Linux version 2.6.10 kernel image (with NFS enabled) to our target board,
we are setting following bootargs in bootloader 

"setenv bootargs root=/dev/nfs 
nfsroot=192.168.178.110:/opt/montavista/pro/devkit/ppc/82xx/target 
ip=192.168.178.234:192.168.178.110:192.168.178.47:255.255.255.0:cashel:eth1:off"

when we boot the board, it is not able to mount nfs file system to board, 
but the same image and configuration works with MPC8272ADS board.
please suggest me, what could be the problem.

Booting image at 00200000 ...
   Image Name:   Linux-2.6.10_mvl401-8272ads
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    948607 Bytes = 926.4 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.6.10_mvl401-8272ads (root@em178110) (gcc version 3.4.3 
(MontaVista 3.4.3-25.0.70.050
1961 2005-12-18)) #2 Tue Jan 23 16:54:50 IST 2007
Motorola PQ2 ADS PowerPC port
Built 1 zonelists
Kernel command line: root=/dev/nfs 
nfsroot=192.168.178.110:/opt/montavista/pro/devkit/ppc/82xx/targe
t 
ip=192.168.178.234:192.168.178.110:192.168.178.47:255.255.255.0:cashel:eth1:off
PID hash table entries: 128 (order: 7, 2048 bytes)
hr_time_init: arch_to_nsec = 83886080, nsec_to_arch = 107374182
Warning: real time clock seems stuck!
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 13952k available (1684k kernel code, 468k data, 100k init, 0k 
highmem)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
spawn_desched_task(00000000)
desched cpu_callback 3/00000000
ksoftirqd started up.
desched cpu_callback 2/00000000
desched thread 0 started up.
NET: Registered protocol family 16
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
Serial: CPM driver $Revision: 0.01 $
ttyCPM0 at MMIO 0xf0011a00 (irq = 40) is a CPM UART
ttyCPM1 at MMIO 0xf0011a60 (irq = 43) is a CPM UART
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
fs_enet.c:v1.0 (Aug 8, 2005)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 50MHz system bus speed for PIO modes; override with 
idebus=xx
eth0: FCC ENET Version 0.3, 00:99:23:c4:ad:de
eth1: FCC ENET Version 0.3, 00:99:23:44:ad:de
eth2: FCC ENET Version 0.3, 00:99:23:64:ad:de
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 2048)
NET: Registered protocol family 1
NET: Registered protocol family 17
IP-Config: Complete:
      device=eth1, addr=192.168.178.234, mask=255.255.255.0, 
gw=192.168.178.47,
     host=cashel, domain=, nis-domain=(none),
     bootserver=192.168.178.110, rootserver=192.168.178.110, rootpath=
Looking up port of RPC 100003/2 on 192.168.178.110
portmap: server 192.168.178.110 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 192.168.178.110
portmap: server 192.168.178.110 not responding, timed out
Root-NFS: Unable to get mountd port number from server, using default
mount: server 192.168.178.110 not responding, timed out
Root-NFS: Server returned error -5 while mounting 
/opt/montavista/pro/devkit/ppc/82xx/target
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "nfs" or unknown-block(2,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-block(2,0)
 <0>Rebooting in 180 seconds..

Thanks and awaiting for your valuable feedback



Thanks & Regards
 MANJUNATH AM
 
--=_alternative 0044D6F26525726C_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">We are using MPC8272 based target board,
we are trying to mount montavista Linux version 2.6.10 kernel image (with
NFS enabled) to our target board,</font>
<br><font size=2 face="sans-serif">we are setting following bootargs in
bootloader </font>
<br>
<br><font size=2 face="sans-serif">&quot;setenv bootargs root=/dev/nfs
nfsroot=192.168.178.110:/opt/montavista/pro/devkit/ppc/82xx/target ip=192.168.178.234:192.168.178.110:192.168.178.47:255.255.255.0:cashel:eth1:off&quot;</font>
<br>
<br><font size=2 face="sans-serif">when we boot the board, it is not able
to mount nfs file system to board, &nbsp;but the same image and configuration
works with MPC8272ADS board.</font>
<br><font size=2 face="sans-serif">please suggest me, what could be the
problem.</font>
<br>
<br><font size=2 face="sans-serif">Booting image at 00200000 ...</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp;Image Name: &nbsp; Linux-2.6.10_mvl401-8272ads</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp;Image Type: &nbsp; PowerPC
Linux Kernel Image (gzip compressed)</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp;Data Size: &nbsp; &nbsp;948607
Bytes = 926.4 kB</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp;Load Address: 00000000</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp;Entry Point: &nbsp;00000000</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp;Verifying Checksum ...
OK</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp;Uncompressing Kernel Image
... OK</font>
<br><font size=2 face="sans-serif">Linux version 2.6.10_mvl401-8272ads
(root@em178110) (gcc version 3.4.3 (MontaVista 3.4.3-25.0.70.050</font>
<br><font size=2 face="sans-serif">1961 2005-12-18)) #2 Tue Jan 23 16:54:50
IST 2007</font>
<br><font size=2 face="sans-serif">Motorola PQ2 ADS PowerPC port</font>
<br><font size=2 face="sans-serif">Built 1 zonelists</font>
<br><font size=2 face="sans-serif">Kernel command line: root=/dev/nfs nfsroot=192.168.178.110:/opt/montavista/pro/devkit/ppc/82xx/targe</font>
<br><font size=2 face="sans-serif">t ip=192.168.178.234:192.168.178.110:192.168.178.47:255.255.255.0:cashel:eth1:off</font>
<br><font size=2 face="sans-serif">PID hash table entries: 128 (order:
7, 2048 bytes)</font>
<br><font size=2 face="sans-serif">hr_time_init: arch_to_nsec = 83886080,
nsec_to_arch = 107374182</font>
<br><font size=2 face="sans-serif">Warning: real time clock seems stuck!</font>
<br><font size=2 face="sans-serif">Dentry cache hash table entries: 4096
(order: 2, 16384 bytes)</font>
<br><font size=2 face="sans-serif">Inode-cache hash table entries: 2048
(order: 1, 8192 bytes)</font>
<br><font size=2 face="sans-serif">Memory: 13952k available (1684k kernel
code, 468k data, 100k init, 0k highmem)</font>
<br><font size=2 face="sans-serif">Mount-cache hash table entries: 512
(order: 0, 4096 bytes)</font>
<br><font size=2 face="sans-serif">spawn_desched_task(00000000)</font>
<br><font size=2 face="sans-serif">desched cpu_callback 3/00000000</font>
<br><font size=2 face="sans-serif">ksoftirqd started up.</font>
<br><font size=2 face="sans-serif">desched cpu_callback 2/00000000</font>
<br><font size=2 face="sans-serif">desched thread 0 started up.</font>
<br><font size=2 face="sans-serif">NET: Registered protocol family 16</font>
<br><font size=2 face="sans-serif">Installing knfsd (copyright (C) 1996
okir@monad.swb.de).</font>
<br><font size=2 face="sans-serif">Initializing Cryptographic API</font>
<br><font size=2 face="sans-serif">Serial: CPM driver $Revision: 0.01 $</font>
<br><font size=2 face="sans-serif">ttyCPM0 at MMIO 0xf0011a00 (irq = 40)
is a CPM UART</font>
<br><font size=2 face="sans-serif">ttyCPM1 at MMIO 0xf0011a60 (irq = 43)
is a CPM UART</font>
<br><font size=2 face="sans-serif">io scheduler noop registered</font>
<br><font size=2 face="sans-serif">io scheduler anticipatory registered</font>
<br><font size=2 face="sans-serif">io scheduler deadline registered</font>
<br><font size=2 face="sans-serif">io scheduler cfq registered</font>
<br><font size=2 face="sans-serif">RAMDISK driver initialized: 16 RAM disks
of 8192K size 1024 blocksize</font>
<br><font size=2 face="sans-serif">loop: loaded (max 8 devices)</font>
<br><font size=2 face="sans-serif">fs_enet.c:v1.0 (Aug 8, 2005)</font>
<br><font size=2 face="sans-serif">Uniform Multi-Platform E-IDE driver
Revision: 7.00alpha2</font>
<br><font size=2 face="sans-serif">ide: Assuming 50MHz system bus speed
for PIO modes; override with idebus=xx</font>
<br><font size=2 face="sans-serif">eth0: FCC ENET Version 0.3, 00:99:23:c4:ad:de</font>
<br><font size=2 face="sans-serif">eth1: FCC ENET Version 0.3, 00:99:23:44:ad:de</font>
<br><font size=2 face="sans-serif">eth2: FCC ENET Version 0.3, 00:99:23:64:ad:de</font>
<br><font size=2 face="sans-serif">NET: Registered protocol family 2</font>
<br><font size=2 face="sans-serif">IP: routing cache hash table of 512
buckets, 4Kbytes</font>
<br><font size=2 face="sans-serif">TCP: Hash tables configured (established
1024 bind 2048)</font>
<br><font size=2 face="sans-serif">NET: Registered protocol family 1</font>
<br><font size=2 face="sans-serif">NET: Registered protocol family 17</font>
<br><font size=2 face="sans-serif">IP-Config: Complete:</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; device=eth1, addr=192.168.178.234,
mask=255.255.255.0, gw=192.168.178.47,</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp;host=cashel, domain=,
nis-domain=(none),</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp;bootserver=192.168.178.110,
rootserver=192.168.178.110, rootpath=</font>
<br><font size=2 face="sans-serif">Looking up port of RPC 100003/2 on 192.168.178.110</font>
<br><font size=2 face="sans-serif">portmap: server 192.168.178.110 not
responding, timed out</font>
<br><font size=2 face="sans-serif">Root-NFS: Unable to get nfsd port number
from server, using default</font>
<br><font size=2 face="sans-serif">Looking up port of RPC 100005/1 on 192.168.178.110</font>
<br><font size=2 face="sans-serif">portmap: server 192.168.178.110 not
responding, timed out</font>
<br><font size=2 face="sans-serif">Root-NFS: Unable to get mountd port
number from server, using default</font>
<br><font size=2 face="sans-serif">mount: server 192.168.178.110 not responding,
timed out</font>
<br><font size=2 face="sans-serif">Root-NFS: Server returned error -5 while
mounting /opt/montavista/pro/devkit/ppc/82xx/target</font>
<br><font size=2 face="sans-serif">VFS: Unable to mount root fs via NFS,
trying floppy.</font>
<br><font size=2 face="sans-serif">VFS: Cannot open root device &quot;nfs&quot;
or unknown-block(2,0)</font>
<br><font size=2 face="sans-serif">Please append a correct &quot;root=&quot;
boot option</font>
<br><font size=2 face="sans-serif">Kernel panic - not syncing: VFS: Unable
to mount root fs on unknown-block(2,0)</font>
<br><font size=2 face="sans-serif">&nbsp;&lt;0&gt;Rebooting in 180 seconds..</font>
<br>
<br><font size=2 face="sans-serif">Thanks and awaiting for your valuable
feedback</font>
<br>
<br>
<br>
<br><font size=2 face="sans-serif">Thanks &amp; Regards<br>
 MANJUNATH AM<br>
 </font>
--=_alternative 0044D6F26525726C_=--
