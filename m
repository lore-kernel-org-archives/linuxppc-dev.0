Return-Path: <chris.pagnotta@viasat.com>
Received: from VCAEXCH02.hq.corp.viasat.com (kestrel.viasat.com
	[199.106.52.139]) by ozlabs.org (Postfix) with ESMTP id 1472CDDDFA
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Nov 2007 05:53:54 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C81CB6.E587E08C"
Subject: bad gunzip
Date: Thu, 1 Nov 2007 11:42:04 -0700
Message-ID: <821B2170E9E7F04FA38DF7EC21DE487105E62511@VCAEXCH01.hq.corp.viasat.com>
From: "Pagnotta, Chris" <chris.pagnotta@viasat.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C81CB6.E587E08C
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I am having difficulty uncompressing the ramdisk. The ramdisk does =
uncompress=20
when I do not have FCC disabled in the kernel and it comes up to the =
prompt.=20
I cannot see how leaving at an option in .config would affect the =
ramdisk
from uncompressing.

I noticed that the code just hangs in huft_build in lib/inflate.c=20
(i.e. just a infinite loop).=20

Has someone else has seen this?

I added some debug info, which is illustrated in the output below.

## Booting image at fc800000 ...
   Image Name:   Kernel 1.0.0-Wed Oct 31 1
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    954708 Bytes =3D 932.3 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at fca00000 ...
   Image Name:   Good Ramdisk
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1663803 Bytes =3D  1.6 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 00e69000, end 00fff33b ... OK
Linux version 2.6.19.2 (gcc version 4.0.0 (DENX ELDK 4.1 4.0.0)) #39 Wed =
Oct 31 14:53:16 PDT 2007
memsize 0x2000000
bus freq 0x3ef1480
cpm freq 0x7de2900
brg freq 0xfbc520
vco 0xfbc5200
baudrate 0x2580
Zone PFN ranges:
  DMA             0 ->     8192
  Normal       8192 ->     8192
early_node_map[1] active PFN ranges
    0:        0 ->     8192
preempt_disable()
build_all_zonelists()
Built 1 zonelists.  Total pages: 8128
page_alloc_init()
Kernel command line: console=3DttyCPM0,9600 root=3D/dev/ram
parse_early_param()
trap_init()
rcu_init()
init_IRQ()
pidhash_init()
PID hash table entries: 128 (order: 7, 512 bytes)
init_timers()
hrtimers_init()
softirq_init()
timekeeping_init()
cpm_uart: console: compat mode
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
cpuset_init_early()
mem_init()
Memory: 28816k available (1540k kernel code, 404k data, 96k init, 0k =
highmem)
kmem_cache_init()
calibrate_delay()
pidmap_init()
pgtable_cache_init()
Mount-cache hash table entries: 512
signals_init()
lock_kernel()
cpuset_init_smp()
populate_rootfs()
inflate complete
checking if image is initramfs...
inflate complete
it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 1624k freed
do_basic_setup()
init_workqueues()
usermodehelper_init()
driver_init()
sysctl_init()
do_initcalls()
NET: Registered protocol family 16
NET: Registered protocol family 2
IP route cache hash table entries: 256 (order: -2, 1024 bytes)
TCP established hash table entries: 1024 (order: 0, 4096 bytes)
TCP bind hash table entries: 512 (order: -1, 2048 bytes)
TCP: Hash tables configured (established 1024 bind 512)
TCP reno registered
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: CPM driver $Revision: 0.02 $
cpm_uart: WARNING: no UART devices found on platform bus!
cpm_uart: the driver will guess configuration, but this mode is no =
longer supported.
ttyCPM0 at MMIO 0xf0011a20 (irq =3D 41) is a CPM UART
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
eth0: FCC ENET Version 0.3, 00:20:7b:80:45:04
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
prepare_namespace()
RAMDISK: Compressed image found at block 0
number blocks 0

------_=_NextPart_001_01C81CB6.E587E08C
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7651.59">
<TITLE>bad gunzip</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>I am having difficulty uncompressing the ramdisk. The =
ramdisk does uncompress<BR>
when I do not have FCC disabled in the kernel and it comes up to the =
prompt.<BR>
I cannot see how leaving at an option in .config would affect the =
ramdisk<BR>
from uncompressing.<BR>
<BR>
I noticed that the code just hangs in huft_build in lib/inflate.c<BR>
(i.e. just a infinite loop).<BR>
<BR>
Has someone else has seen this?<BR>
<BR>
I added some debug info, which is illustrated in the output below.<BR>
<BR>
## Booting image at fc800000 ...<BR>
&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Kernel 1.0.0-Wed Oct 31 1<BR>
&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip =
compressed)<BR>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 954708 Bytes =3D 932.3 kB<BR>
&nbsp;&nbsp; Load Address: 00000000<BR>
&nbsp;&nbsp; Entry Point:&nbsp; 00000000<BR>
&nbsp;&nbsp; Verifying Checksum ... OK<BR>
&nbsp;&nbsp; Uncompressing Kernel Image ... OK<BR>
## Loading RAMDisk Image at fca00000 ...<BR>
&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Good Ramdisk<BR>
&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux RAMDisk Image (gzip =
compressed)<BR>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1663803 Bytes =3D&nbsp; 1.6 =
MB<BR>
&nbsp;&nbsp; Load Address: 00000000<BR>
&nbsp;&nbsp; Entry Point:&nbsp; 00000000<BR>
&nbsp;&nbsp; Verifying Checksum ... OK<BR>
&nbsp;&nbsp; Loading Ramdisk to 00e69000, end 00fff33b ... OK<BR>
Linux version 2.6.19.2 (gcc version 4.0.0 (DENX ELDK 4.1 4.0.0)) #39 Wed =
Oct 31 14:53:16 PDT 2007<BR>
memsize 0x2000000<BR>
bus freq 0x3ef1480<BR>
cpm freq 0x7de2900<BR>
brg freq 0xfbc520<BR>
vco 0xfbc5200<BR>
baudrate 0x2580<BR>
Zone PFN ranges:<BR>
&nbsp; =
DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0 -&gt;&nbsp;&nbsp;&nbsp;&nbsp; 8192<BR>
&nbsp; Normal&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8192 =
-&gt;&nbsp;&nbsp;&nbsp;&nbsp; 8192<BR>
early_node_map[1] active PFN ranges<BR>
&nbsp;&nbsp;&nbsp; 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 =
-&gt;&nbsp;&nbsp;&nbsp;&nbsp; 8192<BR>
preempt_disable()<BR>
build_all_zonelists()<BR>
Built 1 zonelists.&nbsp; Total pages: 8128<BR>
page_alloc_init()<BR>
Kernel command line: console=3DttyCPM0,9600 root=3D/dev/ram<BR>
parse_early_param()<BR>
trap_init()<BR>
rcu_init()<BR>
init_IRQ()<BR>
pidhash_init()<BR>
PID hash table entries: 128 (order: 7, 512 bytes)<BR>
init_timers()<BR>
hrtimers_init()<BR>
softirq_init()<BR>
timekeeping_init()<BR>
cpm_uart: console: compat mode<BR>
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)<BR>
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)<BR>
cpuset_init_early()<BR>
mem_init()<BR>
Memory: 28816k available (1540k kernel code, 404k data, 96k init, 0k =
highmem)<BR>
kmem_cache_init()<BR>
calibrate_delay()<BR>
pidmap_init()<BR>
pgtable_cache_init()<BR>
Mount-cache hash table entries: 512<BR>
signals_init()<BR>
lock_kernel()<BR>
cpuset_init_smp()<BR>
populate_rootfs()<BR>
inflate complete<BR>
checking if image is initramfs...<BR>
inflate complete<BR>
it isn't (no cpio magic); looks like an initrd<BR>
Freeing initrd memory: 1624k freed<BR>
do_basic_setup()<BR>
init_workqueues()<BR>
usermodehelper_init()<BR>
driver_init()<BR>
sysctl_init()<BR>
do_initcalls()<BR>
NET: Registered protocol family 16<BR>
NET: Registered protocol family 2<BR>
IP route cache hash table entries: 256 (order: -2, 1024 bytes)<BR>
TCP established hash table entries: 1024 (order: 0, 4096 bytes)<BR>
TCP bind hash table entries: 512 (order: -1, 2048 bytes)<BR>
TCP: Hash tables configured (established 1024 bind 512)<BR>
TCP reno registered<BR>
io scheduler noop registered<BR>
io scheduler anticipatory registered<BR>
io scheduler deadline registered<BR>
io scheduler cfq registered (default)<BR>
Serial: CPM driver $Revision: 0.02 $<BR>
cpm_uart: WARNING: no UART devices found on platform bus!<BR>
cpm_uart: the driver will guess configuration, but this mode is no =
longer supported.<BR>
ttyCPM0 at MMIO 0xf0011a20 (irq =3D 41) is a CPM UART<BR>
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 =
blocksize<BR>
loop: loaded (max 8 devices)<BR>
eth0: FCC ENET Version 0.3, 00:20:7b:80:45:04<BR>
TCP cubic registered<BR>
NET: Registered protocol family 1<BR>
NET: Registered protocol family 17<BR>
prepare_namespace()<BR>
RAMDISK: Compressed image found at block 0<BR>
number blocks 0<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C81CB6.E587E08C--
