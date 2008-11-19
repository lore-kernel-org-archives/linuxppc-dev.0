Return-Path: <jcherukuri_necc@yahoo.com>
Received: from web110306.mail.gq1.yahoo.com (web110306.mail.gq1.yahoo.com
	[67.195.8.206]) by ozlabs.org (Postfix) with SMTP id 9153CDDDEE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Nov 2008 03:04:51 +1100 (EST)
Date: Wed, 19 Nov 2008 08:04:46 -0800 (PST)
From: Jyotshna Cherukuri <jcherukuri_necc@yahoo.com>
Subject: problems loading 2.6.25 kernel into PQ2FADS-VR board
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1491702437-1227110686=:27603"
Message-ID: <458977.27603.qm@web110306.mail.gq1.yahoo.com>
Reply-To: jcherukuri_necc@yahoo.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1491702437-1227110686=:27603
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi ,

I am trying to port 2.6.25 kernel and RFS with NFS onto PQ2FADS-VR board an=
d I run into following error when I boot the image with u-boot 1.3.2

Could anyone please let me know to how I need to debug the following error =
?

Any help is greatly appreciated in this regards.

Thanks
Jyotshna

=3D> bootm 400000 - 800000

## Booting image at 00400000 ...

=A0=A0 Image Name:=A0=A0 Linux-2.6.25

=A0=A0 Image Type:=A0=A0 PowerPC Linux Kernel Image (gzip compressed)

=A0=A0 Data Size:=A0=A0=A0 1339847 Bytes =3D=A0 1.3 MB

=A0=A0 Load Address: 00000000

=A0=A0 Entry Point:=A0 00000000

=A0=A0 Verifying Checksum ... OK

=A0=A0 Uncompressing Kernel Image ... OK

=A0=A0 Booting using the fdt at 0x800000

=A0=A0 Loading Device Tree to 007fc000, end 007fefff ... OK

Xid mach(): done

MMU:enter

MMU:hw init

MMU:mapin

MMU:setio

MMU:exit

Using Freescale PQ2FADS machine description

Linux version 2.6.25 (jcherukuri@localhost.localdomain) (gcc version 4.2.1 =
(Sourcery G++ Lite 4.2-82)) #52 Tue Nov 18 17:15:13 EST 2008

console [udbg0] enabled

Entering add_active_range(0, 0, 8192) 0 entries of 256 used

setup_arch: bootmem

pq2fads_setup_arch()

PCI host bridge /pci@f0010800 (primary) ranges:

=A0MEM 0x0000000080000000..0x000000009fffffff -> 0x0000000080000000 Prefetc=
h

=A0MEM 0x00000000a0000000..0x00000000bfffffff -> 0x00000000a0000000

=A0 IO 0x00000000f6000000..0x00000000f7ffffff -> 0x0000000000000000

pq2fads_setup_arch(), finish

arch: exit

Top of RAM: 0x2000000, Total RAM: 0x2000000

Memory hole size: 0MB

Zone PFN ranges:

=A0 DMA=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 ->=A0=A0=A0=A0 8192

=A0 Normal=A0=A0=A0=A0=A0=A0 8192 ->=A0=A0=A0=A0 8192

Movable zone start PFN for each node

early_node_map[1] active PFN ranges

=A0=A0=A0 0:=A0=A0=A0=A0=A0=A0=A0 0 ->=A0=A0=A0=A0 8192

On node 0 totalpages: 8192

=A0 DMA zone: 64 pages used for memmap

=A0 DMA zone: 0 pages reserved

=A0 DMA zone: 8128 pages, LIFO batch:0

=A0 Normal zone: 0 pages used for memmap

=A0 Movable zone: 0 pages used for memmap

Built 1 zonelists in Zone order, mobility grouping on.=A0 Total pages: 8128

Kernel command line: root=3D/dev/nfs ip=3D192.168.10.112:192.168.10.115::::=
eth0:off console=3DttyCPM0,38400n8 nfsroot=3D/tftpboot/192.168.10.112.LTIB

PID hash table entries: 128 (order: 7, 512 bytes)

time_init: decrementer frequency =3D 16.500000 MHz

time_init: processor frequency=A0=A0 =3D 264.000000 MHz

clocksource: timebase mult[f26c9b2] shift[22] registered

clockevent: decrementer mult[439] shift[16] cpu[0]

Console: colour dumm?Dentry cache hash table entries: 4096 (order: 2, 16384=
 bytes)

Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)

Memory: 29572k/32768k available (2640k kernel code, 3196k reserved, 104k da=
ta, 91k bss, 104k init)

SLUB: Genslabs=3D12, HWalign=3D32, Order=3D0-1, MinObjects=3D4, CPUs=3D1, N=
odes=3D1

Calibrating delay loop... 32.89 BogoMIPS (lpj=3D65792)

Mount-cache hash table entries: 512

net_namespace: 440 bytes

NET: Registered protocol family 16

PCI: Probing PCI hardware

Can't get bus-range for /pci@f0010800, assuming it starts at 0

NET: Registered protocol family 2

IP route cache hash table entries: 1024 (order: 0, 4096 bytes)

TCP established hash table entries: 1024 (order: 1, 8192 bytes)

TCP bind hash table entries: 1024 (order: 0, 4096 bytes)

TCP: Hash tables configured (established 1024 bind 1024)

TCP reno registered

JFFS2 version 2.2. .. 2001-2006 Red Hat, Inc.

io scheduler noop registered

io scheduler anticipatory registered

io scheduler deadline registered

io scheduler cfq registered (default)

pci_hotplug: PCI Hot Plug PCI Core version: 0.5

ttyCPM0 at MMIO 0xf0011a00 (irq =3D 40) is a CPM UART

ttyCPM1 at MMIO 0xf0011a20 (irq =3D 41) is a CPM UART

loop: module loaded

eth0: fs_enet: 00:e0:0a:0b:79:01

eth1: fs_enet: 00:e0:0c:00:79:01

CPM2 Bitbanged MII: probed

physmap platform flash device: 00800000 at ff800000

CFI: Found no physmap-flash.0 device at location zero

physmap-flash physmap-flash.0: map_probe failed

of-flash fe000000.flash: do_map_probe() failed

mice: PS/2 mouse device common for all mice

TCP cubic registered

NET: Registered protocol family 1

NET: Registered protocol family 17

RPC: Registered udp transport module.

RPC: Registered tcp transport module.

IP-Config: Guessing netmask 255.255.255.0

IP-Config: Complete:

=A0=A0=A0=A0 device=3Deth0, addr=3D192.168.10.112, mask=3D255.255.255.0, gw=
=3D255.255.255.255,

=A0=A0=A0=A0 host=3D192.168.10.112, domain=3D, nis-domain=3D(none),

=A0=A0=A0=A0 bootserver=3D192.168.10.115, rootserver=3D192.168.10.115, root=
path=3D

Looking up port of RPC 100003/2 on 192.168.10.115

Looking up port of RPC 100005/1 on 192.168.10.115

VFS: Mounted root (nfs filesystem) readonly.

Freeing unused kernel memory: 104k init

Warning: unable to open an initial console.

Kernel panic - not syncing: No init found.=A0 Try passing init=3D option to=
 kernel.

Rebooting in 180 seconds..





=0A=0A=0A      
--0-1491702437-1227110686=:27603
Content-Type: text/html; charset=us-ascii

<table cellspacing="0" cellpadding="0" border="0" ><tr><td valign="top" style="font: inherit;">Hi ,<br><br>I am trying to port 2.6.25 kernel and RFS with NFS onto PQ2FADS-VR board and I run into following error when I boot the image with u-boot 1.3.2<br><br>Could anyone please let me know to how I need to debug the following error ?<br><br>Any help is greatly appreciated in this regards.<br><br>Thanks<br>Jyotshna<br><br><tt>=&gt; bootm 400000 - 800000</tt><br>
<tt>## Booting image at 00400000 ...</tt><br>
<tt>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.25</tt><br>
<tt>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip compressed)</tt><br>
<tt>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1339847 Bytes =&nbsp; 1.3 MB</tt><br>
<tt>&nbsp;&nbsp; Load Address: 00000000</tt><br>
<tt>&nbsp;&nbsp; Entry Point:&nbsp; 00000000</tt><br>
<tt>&nbsp;&nbsp; Verifying Checksum ... OK</tt><br>
<tt>&nbsp;&nbsp; Uncompressing Kernel Image ... OK</tt><br>
<tt>&nbsp;&nbsp; Booting using the fdt at 0x800000</tt><br>
<tt>&nbsp;&nbsp; Loading Device Tree to 007fc000, end 007fefff ... OK</tt><br>
<tt>Xid mach(): done</tt><br>
<tt>MMU:enter</tt><br>
<tt>MMU:hw init</tt><br>
<tt>MMU:mapin</tt><br>
<tt>MMU:setio</tt><br>
<tt>MMU:exit</tt><br>
<tt>Using Freescale PQ2FADS machine description</tt><br>
<tt>Linux version 2.6.25 (<a href="mailto:jcherukuri@localhost.localdomain">jcherukuri@localhost.localdomain</a>) (gcc version 4.2.1 (Sourcery G++ Lite 4.2-82)) #52 Tue Nov 18 17:15:13 EST 2008</tt><br>
<tt>console [udbg0] enabled</tt><br>
<tt>Entering add_active_range(0, 0, 8192) 0 entries of 256 used</tt><br>
<tt>setup_arch: bootmem</tt><br>
<tt>pq2fads_setup_arch()</tt><br>
<tt>PCI host bridge /pci@f0010800 (primary) ranges:</tt><br>
<tt>&nbsp;MEM 0x0000000080000000..0x000000009fffffff -&gt; 0x0000000080000000 Prefetch</tt><br>
<tt>&nbsp;MEM 0x00000000a0000000..0x00000000bfffffff -&gt; 0x00000000a0000000</tt><br>
<tt>&nbsp; IO 0x00000000f6000000..0x00000000f7ffffff -&gt; 0x0000000000000000</tt><br>
<tt>pq2fads_setup_arch(), finish</tt><br>
<tt>arch: exit</tt><br>
<tt>Top of RAM: 0x2000000, Total RAM: 0x2000000</tt><br>
<tt>Memory hole size: 0MB</tt><br>
<tt>Zone PFN ranges:</tt><br>
<tt>&nbsp; DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp;&nbsp;&nbsp; 8192</tt><br>
<tt>&nbsp; Normal&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8192 -&gt;&nbsp;&nbsp;&nbsp;&nbsp; 8192</tt><br>
<tt>Movable zone start PFN for each node</tt><br>
<tt>early_node_map[1] active PFN ranges</tt><br>
<tt>&nbsp;&nbsp;&nbsp; 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp;&nbsp;&nbsp; 8192</tt><br>
<tt>On node 0 totalpages: 8192</tt><br>
<tt>&nbsp; DMA zone: 64 pages used for memmap</tt><br>
<tt>&nbsp; DMA zone: 0 pages reserved</tt><br>
<tt>&nbsp; DMA zone: 8128 pages, LIFO batch:0</tt><br>
<tt>&nbsp; Normal zone: 0 pages used for memmap</tt><br>
<tt>&nbsp; Movable zone: 0 pages used for memmap</tt><br>
<tt>Built 1 zonelists in Zone order, mobility grouping on.&nbsp; Total pages: 8128</tt><br>
<tt>Kernel command line: root=/dev/nfs ip=192.168.10.112:192.168.10.115::::eth0:off console=ttyCPM0,38400n8 nfsroot=/tftpboot/192.168.10.112.LTIB</tt><br>
<tt>PID hash table entries: 128 (order: 7, 512 bytes)</tt><br>
<tt>time_init: decrementer frequency = 16.500000 MHz</tt><br>
<tt>time_init: processor frequency&nbsp;&nbsp; = 264.000000 MHz</tt><br>
<tt>clocksource: timebase mult[f26c9b2] shift[22] registered</tt><br>
<tt>clockevent: decrementer mult[439] shift[16] cpu[0]</tt><br>
<tt>Console: colour dumm?Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)</tt><br>
<tt>Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)</tt><br>
<tt>Memory: 29572k/32768k available (2640k kernel code, 3196k reserved, 104k data, 91k bss, 104k init)</tt><br>
<tt>SLUB: Genslabs=12, HWalign=32, Order=0-1, MinObjects=4, CPUs=1, Nodes=1</tt><br>
<tt>Calibrating delay loop... 32.89 BogoMIPS (lpj=65792)</tt><br>
<tt>Mount-cache hash table entries: 512</tt><br>
<tt>net_namespace: 440 bytes</tt><br>
<tt>NET: Registered protocol family 16</tt><br>
<tt>PCI: Probing PCI hardware</tt><br>
<tt>Can't get bus-range for /pci@f0010800, assuming it starts at 0</tt><br>
<tt>NET: Registered protocol family 2</tt><br>
<tt>IP route cache hash table entries: 1024 (order: 0, 4096 bytes)</tt><br>
<tt>TCP established hash table entries: 1024 (order: 1, 8192 bytes)</tt><br>
<tt>TCP bind hash table entries: 1024 (order: 0, 4096 bytes)</tt><br>
<tt>TCP: Hash tables configured (established 1024 bind 1024)</tt><br>
<tt>TCP reno registered</tt><br>
<tt>JFFS2 version 2.2. .. 2001-2006 Red Hat, Inc.</tt><br>
<tt>io scheduler noop registered</tt><br>
<tt>io scheduler anticipatory registered</tt><br>
<tt>io scheduler deadline registered</tt><br>
<tt>io scheduler cfq registered (default)</tt><br>
<tt>pci_hotplug: PCI Hot Plug PCI Core version: 0.5</tt><br>
<tt>ttyCPM0 at MMIO 0xf0011a00 (irq = 40) is a CPM UART</tt><br>
<tt>ttyCPM1 at MMIO 0xf0011a20 (irq = 41) is a CPM UART</tt><br>
<tt>loop: module loaded</tt><br>
<tt>eth0: fs_enet: 00:e0:0a:0b:79:01</tt><br>
<tt>eth1: fs_enet: 00:e0:0c:00:79:01</tt><br>
<tt>CPM2 Bitbanged MII: probed</tt><br>
<tt>physmap platform flash device: 00800000 at ff800000</tt><br>
<tt>CFI: Found no physmap-flash.0 device at location zero</tt><br>
<tt>physmap-flash physmap-flash.0: map_probe failed</tt><br>
<tt>of-flash fe000000.flash: do_map_probe() failed</tt><br>
<tt>mice: PS/2 mouse device common for all mice</tt><br>
<tt>TCP cubic registered</tt><br>
<tt>NET: Registered protocol family 1</tt><br>
<tt>NET: Registered protocol family 17</tt><br>
<tt>RPC: Registered udp transport module.</tt><br>
<tt>RPC: Registered tcp transport module.</tt><br>
<tt>IP-Config: Guessing netmask 255.255.255.0</tt><br>
<tt>IP-Config: Complete:</tt><br>
<tt>&nbsp;&nbsp;&nbsp;&nbsp; device=eth0, addr=192.168.10.112, mask=255.255.255.0, gw=255.255.255.255,</tt><br>
<tt>&nbsp;&nbsp;&nbsp;&nbsp; host=192.168.10.112, domain=, nis-domain=(none),</tt><br>
<tt>&nbsp;&nbsp;&nbsp;&nbsp; bootserver=192.168.10.115, rootserver=192.168.10.115, rootpath=</tt><br>
<tt>Looking up port of RPC 100003/2 on 192.168.10.115</tt><br>
<tt>Looking up port of RPC 100005/1 on 192.168.10.115</tt><br>
<tt>VFS: Mounted root (nfs filesystem) readonly.</tt><br>
<tt>Freeing unused kernel memory: 104k init</tt><br>
<tt>Warning: unable to open an initial console.</tt><br>
<tt>Kernel panic - not syncing: No init found.&nbsp; Try passing init= option to kernel.</tt><br>
<tt>Rebooting in 180 seconds..</tt><br>
<br>
<br><br></td></tr></table><br>

      
--0-1491702437-1227110686=:27603--
