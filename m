Return-Path: <John.Linn@xilinx.com>
Received: from outbound1-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id E77C8DE16B
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Apr 2008 01:30:23 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C89404.BEFE4A74"
Subject: RE: xilinx Ml405 NFS mount problem
Date: Tue, 1 Apr 2008 08:29:08 -0600
In-Reply-To: <BAY138-W7044A57F2CF37F5DB50F6B2F50@phx.gbl>
References: <BAY138-W7044A57F2CF37F5DB50F6B2F50@phx.gbl>
From: "John Linn" <John.Linn@xilinx.com>
To: "MingLiu" <eemingliu@hotmail.com>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20080401142910.5BFD038005F@mail141-dub.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C89404.BEFE4A74
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Hi Ming,

=20

It=A1=AFs not obvious to me what the problem is as I don=A1=AFt see any =
driver failures. Have you tried using a ramdisk and then seeing if the =
network is working before using NFS root? =20

=20

And I=A1=AFm assuming you have used the NFS root before so you know that =
it=A1=AFs good for sure.

=20

I test on the ML405 with NFS root and haven=A1=AFt seen this problem, =
but my setup is a little different.  I use DHCP rather than a static IP, =
but other than that it=A1=AFs similar.

=20

I=A1=AFm assuming that you accidentally got 2 different powerup outputs =
in the message below as the 1st stops and a 2nd starts in the middle.

=20

How long has it been since you pulled from the Xilinx Git tree?

=20

Thanks,

John

=20

________________________________

From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org =
[mailto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org] On =
Behalf Of MingLiu
Sent: Tuesday, April 01, 2008 8:12 AM
To: linuxppc-embedded@ozlabs.org
Subject: xilinx Ml405 NFS mount problem

=20

Dear friends,

I am bringing up my kernel from Xilinx git tree. Unfortunately I met =
some
problem when mounting the root file system. Here is the information
listed. I will appreciate a lot if someone can help me out of the =
trouble.=20
Thanks a lot!
=20
=20
loaded at:     00400000 0059F19C
board data at: 0059D120 0059D19C
relocated to:  004050C8 00405144
zimage at:     00405F3F 0059C025
avail ram:     005A0000 08000000
=20
Linux/PPC load: root=3D/dev/nfs
ip=3D192.168.0.4:192.168.0.3:192.168.0.3:255.255.255.0 rw
nfsroot=3D192.168.0.3:/home/mingliu/ml403_rootfs console=3DttyUL0,38400
mem=3D32M
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.6.24-rc8-xlnx-g1db182b8-dirty (mingliu@cca01) (gcc =
version
3.4.1) #7 Tue Apr 1 14:55:25 CEST 2008
Xilinx Generic PowerPC board support package (Xilinx ML405) (Virtex-4 =
FX)
Zone PFN ranges:
  DMA             0 ->     8192
  Normal       8192 ->     8192
  HighMem      8192 ->     8192
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->     8192
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: =
8128
Kernel command line: root=3D/dev/nfs
ip=3D192.168.0.4:192.168.0.3:192.168.0.3:255.255.255.0 rw
nfsroot=3D192.168.0.3:/home/mingliu/ml403_rootfs console=3DttyUL0,38400
mem=3D32M
Xilinx INTC #0 at 0x81800000 mapped to 0xFDFFF000
PID hash table entries: 128 (order: 7, 512 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 28884k available (2552k kernel code, 944k data, 84k init, 0k =
highmem)
SLUB: Genslabs=3D11, HWalign=3D32, Order=3D0-1, MinObjects=3D4, =
CPUs=3D1, Nodes=3D1
Mount-cache hash table entries: 512
net_namespace: 64 bytes
NET: Registered protocol family 16
Registering device uartlite:0
Fixup MAC address for xilinx_lltemac:0
Registering device xilinx_lltemac:0
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 1024 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
TCP reno registered
sysctl table check failed: /kernel/l2cr .1.31 Missing strategy
Call Trace:
[c1c0fe50] [c0008b70] show_stack+0x40/0x194 (unreliable)
[c1c0fe90] [c003aed4] set_fail+0x68/0x80
[c1c0feb0] [c003b4ec] sysctl_check_table+0x600/0x77c
[c1c0fef0] [c003b4d4] sysctl_check_table+0x5e8/0x77c
[c1c0ff30] [c002605c] register_sysctl_table+0x64/0xb4
[c1c0ff50] [c034579c] register_ppc_htab_sysctl+0x18/0x2c
[c1c0ff60] [c034482c] kernel_init+0x94/0x2bc
[c1c0fff0] [c0004d58] kernel_thread+0x44/0x60
Installing knfsd (copyright (C) 1996 okir@monad.swb.de =
<https://webmail.sys.kth.se/src/compose.php?send_to=3Dokir%40monad.swb.de=
> ).
fuse init (API version 7.9)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
uartlite.0: ttyUL0 at MMIO 0x84000003 (irq =3D 3) is a uartlite
console [ttyUL0] enabled
loop: module loaded
nbd: registered device at major 43
xilinx_lltemac xilinx_lltemac.0: MAC address is now  0: a:35: 1: 2: 3
xilinx_lltemac xilinx_lltemac.0: XLlTemac: using DMA mode.
XLlTemac: Dma base address: phy: 0x84600100, virt: 0xc3008100
XLlTemac: buffer descriptor size: 32768 (0x8000)
XLlTemac: Allocating DMA descriptors with kmalloc<6>XLlTemac:
(buffer_descriptor_init) phy: 0x1d18000, virt: 0xc1d18000, size: 0x8000
XTemac: PHY detected at address 7.
xilinx_lltemac xilinx_lltemac.0: eth0: Xilinx TEMAC at 0x81C00000 mapped
to 0xC3004000, irq=3D2
console [netcon0] enabled
Linux version 2.6.24-rc8-xlnx-g1db182b8-dirty (mingliu@cca01) (gcc =
version
3.4.1) #7 Tue Apr 1 14:55:25 CEST 2008
Xilinx Generic PowerPC board support package (Xilinx ML405) (Virtex-4 =
FX)
Zone PFN ranges:
  DMA             0 ->     8192
  Normal       8192 ->     8192
  HighMem      8192 ->     8192
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->     8192
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: =
8128
Kernel command line: root=3D/dev/nfs
ip=3D192.168.0.4:192.168.0.3:192.168.0.3:255.255.255.0 rw
nfsroot=3D192.168.0.3:/home/mingliu/ml403_rootfs console=3DttyUL0,38400
mem=3D32M
Xilinx INTC #0 at 0x81800000 mapped to 0xFDFFF000
PID hash table entries: 128 (order: 7, 512 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 28884k available (2552k kernel code, 944k data, 84k init, 0k =
highmem)
SLUB: Genslabs=3D11, HWalign=3D32, Order=3D0-1, MinObjects=3D4, =
CPUs=3D1, Nodes=3D1
Mount-cache hash table entries: 512
net_namespace: 64 bytes
NET: Registered protocol family 16
Registering device uartlite:0
Fixup MAC address for xilinx_lltemac:0
Registering device xilinx_lltemac:0
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 1024 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
TCP reno registered
sysctl table check failed: /kernel/l2cr .1.31 Missing strategy
Call Trace:
[c1c0fe50] [c0008b70] show_stack+0x40/0x194 (unreliable)
[c1c0fe90] [c003aed4] set_fail+0x68/0x80
[c1c0feb0] [c003b4ec] sysctl_check_table+0x600/0x77c
[c1c0fef0] [c003b4d4] sysctl_check_table+0x5e8/0x77c
[c1c0ff30] [c002605c] register_sysctl_table+0x64/0xb4
[c1c0ff50] [c034579c] register_ppc_htab_sysctl+0x18/0x2c
[c1c0ff60] [c034482c] kernel_init+0x94/0x2bc
[c1c0fff0] [c0004d58] kernel_thread+0x44/0x60
Installing knfsd (copyright (C) 1996 okir@monad.swb.de =
<https://webmail.sys.kth.se/src/compose.php?send_to=3Dokir%40monad.swb.de=
> ).
fuse init (API version 7.9)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
uartlite.0: ttyUL0 at MMIO 0x84000003 (irq =3D 3) is a uartlite
console [ttyUL0] enabled
loop: module loaded
nbd: registered device at major 43
xilinx_lltemac xilinx_lltemac.0: MAC address is now  0: a:35: 1: 2: 3
xilinx_lltemac xilinx_lltemac.0: XLlTemac: using DMA mode.
XLlTemac: Dma base address: phy: 0x84600100, virt: 0xc3008100
XLlTemac: buffer descriptor size: 32768 (0x8000)
XLlTemac: Allocating DMA descriptors with kmalloc<6>XLlTemac:
(buffer_descriptor_init) phy: 0x1d18000, virt: 0xc1d18000, size: 0x8000
XTemac: PHY detected at address 7.
xilinx_lltemac xilinx_lltemac.0: eth0: Xilinx TEMAC at 0x81C00000 mapped
to 0xC3004000, irq=3D2
console [netcon0] enabled
netconsole: network logging started
Generic platform RAM MTD, (c) 2004 Simtec Electronics
mice: PS/2 mouse device common for all mice
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
eth0: XLlTemac: Options: 0x3fa
eth0: XLlTemac: allocating interrupt 0 for dma mode tx.
eth0: XLlTemac: allocating interrupt 1 for dma mode rx.
eth0: XLlTemac: speed set to 1000Mb/s
eth0: XLlTemac: Send Threshold =3D 24, Receive Threshold =3D 4
eth0: XLlTemac: Send Wait bound =3D 254, Receive Wait bound =3D 254
IP-Config: Complete:
      device=3Deth0, addr=3D192.168.0.4, mask=3D255.255.255.0, =
gw=3D192.168.0.3,
     host=3D192.168.0.4, domain=3D, nis-domain=3D(none),
     bootserver=3D192.168.0.3, rootserver=3D192.168.0.3, rootpath=3D
Looking up port of RPC 100003/2 on 192.168.0.3
rpcbind: server 192.168.0.3 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 192.168.0.3
rpcbind: server 192.168.0.3 not responding, timed out
Root-NFS: Unable to get mountd port number from server, using default
mount: server 192.168.0.3 not responding, timed out
Root-NFS: Server returned error -5 while mounting =
/home/mingliu/ml403_rootfs
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "nfs" or unknown-block(2,0)
Please append a correct "root=3D" boot option; here are the available
partitions:
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(2,0)
Rebooting in 180 seconds..
=20
=20
BR
Ming

=20

________________________________

Windows Live =
Writer=A3=AC=D6=A7=B3=D6=C0=EB=CF=DF=D7=AB=D0=B4=B2=A9=BF=CD=C4=DA=C8=DD=A3=
=AC=CB=E6=CA=B1=CB=E6=B5=D8=CF=EB=D0=B4=BE=CD=D0=B4=A1=A3 =
=C1=A2=BC=B4=CA=B9=D3=C3=A3=A1 <http://get.live.cn/product/writer.html>=20


------_=_NextPart_001_01C89404.BEFE4A74
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dgb2312">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><o:SmartTagType
 namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags" =
name=3D"PlaceName"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PlaceType"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"City"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:SimSun;}
h1
	{margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.3in;
	text-indent:-.3in;
	page-break-after:avoid;
	mso-list:l0 level1 lfo3;
	font-size:16.0pt;
	font-family:SimSun;
	font-weight:bold;}
h2
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:12.0pt;
	margin-left:.4in;
	text-indent:-.4in;
	page-break-after:avoid;
	mso-list:l0 level2 lfo3;
	font-size:14.0pt;
	font-family:SimSun;
	font-weight:bold;}
h3
	{margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.5in;
	text-indent:-.5in;
	page-break-after:avoid;
	mso-list:l1 level3 lfo6;
	font-size:13.0pt;
	font-family:SimSun;
	font-weight:bold;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:blue;
	text-decoration:underline;}
p
	{mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:SimSun;}
pre
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:SimSun;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:.5in .5in .5in .5in;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:1143350910;
	mso-list-template-ids:1338282562;}
@list l0:level1
	{mso-level-style-link:"Heading 1";
	mso-level-text:%1;
	mso-level-tab-stop:.3in;
	mso-level-number-position:left;
	margin-left:.3in;
	text-indent:-.3in;}
@list l0:level2
	{mso-level-style-link:"Heading 2";
	mso-level-text:"%1\.%2";
	mso-level-tab-stop:.4in;
	mso-level-number-position:left;
	margin-left:.4in;
	text-indent:-.4in;}
@list l0:level3
	{mso-level-text:"%1\.%2\.%3";
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	margin-left:.5in;
	text-indent:-.5in;}
@list l0:level4
	{mso-level-text:"%1\.%2\.%3\.%4";
	mso-level-tab-stop:.6in;
	mso-level-number-position:left;
	margin-left:.6in;
	text-indent:-.6in;}
@list l0:level5
	{mso-level-text:"%1\.%2\.%3\.%4\.%5";
	mso-level-tab-stop:.7in;
	mso-level-number-position:left;
	margin-left:.7in;
	text-indent:-.7in;}
@list l0:level6
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6";
	mso-level-tab-stop:.8in;
	mso-level-number-position:left;
	margin-left:.8in;
	text-indent:-.8in;}
@list l0:level7
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7";
	mso-level-tab-stop:.9in;
	mso-level-number-position:left;
	margin-left:.9in;
	text-indent:-.9in;}
@list l0:level8
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8";
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	margin-left:1.0in;
	text-indent:-1.0in;}
@list l0:level9
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8\.%9";
	mso-level-tab-stop:1.1in;
	mso-level-number-position:left;
	margin-left:1.1in;
	text-indent:-1.1in;}
@list l1
	{mso-list-id:1860200171;
	mso-list-template-ids:1400561736;}
@list l1:level1
	{mso-level-text:%1;
	mso-level-tab-stop:.3in;
	mso-level-number-position:left;
	margin-left:.3in;
	text-indent:-.3in;}
@list l1:level2
	{mso-level-text:"%1\.%2";
	mso-level-tab-stop:.4in;
	mso-level-number-position:left;
	margin-left:.4in;
	text-indent:-.4in;}
@list l1:level3
	{mso-level-reset-level:level2;
	mso-level-style-link:"Heading 3";
	mso-level-text:"%1\.%2\.%3";
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	margin-left:.5in;
	text-indent:-.5in;}
@list l1:level4
	{mso-level-text:"%1\.%2\.%3\.%4";
	mso-level-tab-stop:.6in;
	mso-level-number-position:left;
	margin-left:.6in;
	text-indent:-.6in;}
@list l1:level5
	{mso-level-text:"%1\.%2\.%3\.%4\.%5";
	mso-level-tab-stop:.7in;
	mso-level-number-position:left;
	margin-left:.7in;
	text-indent:-.7in;}
@list l1:level6
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6";
	mso-level-tab-stop:.8in;
	mso-level-number-position:left;
	margin-left:.8in;
	text-indent:-.8in;}
@list l1:level7
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7";
	mso-level-tab-stop:.9in;
	mso-level-number-position:left;
	margin-left:.9in;
	text-indent:-.9in;}
@list l1:level8
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8";
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	margin-left:1.0in;
	text-indent:-1.0in;}
@list l1:level9
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8\.%9";
	mso-level-tab-stop:1.1in;
	mso-level-number-position:left;
	margin-left:1.1in;
	text-indent:-1.1in;}
@list l2
	{mso-list-id:2077240681;
	mso-list-template-ids:-762429638;}
@list l2:level1
	{mso-level-text:%1;
	mso-level-tab-stop:.3in;
	mso-level-number-position:left;
	margin-left:.3in;
	text-indent:-.3in;}
@list l2:level2
	{mso-level-text:"%1\.%2";
	mso-level-tab-stop:.4in;
	mso-level-number-position:left;
	margin-left:.4in;
	text-indent:-.4in;}
@list l2:level3
	{mso-level-text:"%1\.%2\.%3";
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	margin-left:.5in;
	text-indent:-.5in;}
@list l2:level4
	{mso-level-text:"%1\.%2\.%3\.%4";
	mso-level-tab-stop:.6in;
	mso-level-number-position:left;
	margin-left:.6in;
	text-indent:-.6in;}
@list l2:level5
	{mso-level-text:"%1\.%2\.%3\.%4\.%5";
	mso-level-tab-stop:.7in;
	mso-level-number-position:left;
	margin-left:.7in;
	text-indent:-.7in;}
@list l2:level6
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6";
	mso-level-tab-stop:.8in;
	mso-level-number-position:left;
	margin-left:.8in;
	text-indent:-.8in;}
@list l2:level7
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7";
	mso-level-tab-stop:.9in;
	mso-level-number-position:left;
	margin-left:.9in;
	text-indent:-.9in;}
@list l2:level8
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8";
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	margin-left:1.0in;
	text-indent:-1.0in;}
@list l2:level9
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8\.%9";
	mso-level-tab-stop:1.1in;
	mso-level-number-position:left;
	margin-left:1.1in;
	text-indent:-1.1in;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dblue>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Hi =
Ming,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>It=A1=AFs not obvious to me what =
the problem is
as I don=A1=AFt see any driver failures. Have you tried using a ramdisk =
and then
seeing if the network is working before using NFS root?&nbsp; =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>And I=A1=AFm assuming you have used =
the NFS
root before so you know that it=A1=AFs good for =
sure.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>I test on the ML405 with NFS root =
and
haven=A1=AFt seen this problem, but my setup is a little different. =
&nbsp;I use DHCP
rather than a static IP, but other than that it=A1=AFs =
similar.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>I=A1=AFm assuming that you =
accidentally got 2
different powerup outputs in the message below as the 1<sup>st</sup> =
stops and
a 2<sup>nd</sup> starts in the middle.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>How long has it been since you =
pulled from
the Xilinx Git tree?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Thanks,<o:p></o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>John<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D3
face=3DSimSun><span style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
font-family:Tahoma;font-weight:bold'>From:</span></font></b><font =
size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'>
linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org] =
<b><span
style=3D'font-weight:bold'>On Behalf Of </span></b>MingLiu<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Tuesday, April 01, =
2008 8:12
AM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> =
linuxppc-embedded@ozlabs.org<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> xilinx Ml405 NFS =
mount
problem</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DTahoma><span =
style=3D'font-size:9.0pt;
font-family:Tahoma'>Dear friends,<o:p></o:p></span></font></p>

<pre><font size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>I am =
bringing up my kernel from Xilinx git tree. Unfortunately I met =
some<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>problem when =
mounting the root file system. Here is the =
information<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>listed. I will =
appreciate a lot if someone can help me out of the trouble. =
<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Thanks a =
lot!<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>loaded =
at:&nbsp;&nbsp;&nbsp;&nbsp; 00400000 =
0059F19C<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>board data at: =
0059D120 0059D19C<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>relocated =
to:&nbsp; 004050C8 00405144<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>zimage =
at:&nbsp;&nbsp;&nbsp;&nbsp; 00405F3F =
0059C025<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>avail =
ram:&nbsp;&nbsp;&nbsp;&nbsp; 005A0000 =
08000000<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Linux/PPC load: =
root=3D/dev/nfs<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'>ip=3D192.168.0.4:192.168.0.3:192.168.0.3:255.2=
55.255.0 rw<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'>nfsroot=3D192.168.0.3:/home/mingliu/ml403_root=
fs console=3DttyUL0,38400<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'>mem=3D32M<o:p></o:p></span></font></pre><pre><=
font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Uncompressing =
Linux...done.<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Now booting the =
kernel<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Linux version =
2.6.24-rc8-xlnx-g1db182b8-dirty (mingliu@cca01) (gcc =
version<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>3.4.1) #7 Tue =
Apr 1 14:55:25 CEST 2008<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Xilinx Generic =
PowerPC board support package (Xilinx ML405) (Virtex-4 =
FX)<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Zone PFN =
ranges:<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>&nbsp; =
DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0 -&gt;&nbsp;&nbsp;&nbsp;&nbsp; =
8192<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>&nbsp; =
Normal&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8192 =
-&gt;&nbsp;&nbsp;&nbsp;&nbsp; =
8192<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>&nbsp; =
HighMem&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8192 -&gt;&nbsp;&nbsp;&nbsp;&nbsp; =
8192<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Movable zone =
start PFN for each node<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'>early_node_map[1] active PFN =
ranges<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'>&nbsp;&nbsp;&nbsp; =
0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 =
-&gt;&nbsp;&nbsp;&nbsp;&nbsp; =
8192<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Built 1 =
zonelists in Zone order, mobility grouping on.&nbsp; Total pages: =
8128<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Kernel command =
line: root=3D/dev/nfs<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'>ip=3D192.168.0.4:192.168.0.3:192.168.0.3:255.2=
55.255.0 rw<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'>nfsroot=3D192.168.0.3:/home/mingliu/ml403_root=
fs console=3DttyUL0,38400<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'>mem=3D32M<o:p></o:p></span></font></pre><pre><=
font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Xilinx INTC #0 =
at 0x81800000 mapped to =
0xFDFFF000<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>PID hash table =
entries: 128 (order: 7, 512 =
bytes)<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Console: colour =
dummy device 80x25<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Dentry cache =
hash table entries: 4096 (order: 2, 16384 =
bytes)<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Inode-cache hash =
table entries: 2048 (order: 1, 8192 =
bytes)<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Memory: 28884k =
available (2552k kernel code, 944k data, 84k init, 0k =
highmem)<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>SLUB: =
Genslabs=3D11, HWalign=3D32, Order=3D0-1, MinObjects=3D4, CPUs=3D1, =
Nodes=3D1<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Mount-cache hash =
table entries: 512<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>net_namespace: =
64 bytes<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>NET: Registered =
protocol family 16<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Registering =
device uartlite:0<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Fixup MAC =
address for xilinx_lltemac:0<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Registering =
device xilinx_lltemac:0<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>NET: Registered =
protocol family 2<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>IP route cache =
hash table entries: 1024 (order: 0, 4096 =
bytes)<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>TCP established =
hash table entries: 1024 (order: 1, 8192 =
bytes)<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>TCP bind hash =
table entries: 1024 (order: 0, 4096 =
bytes)<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>TCP: Hash tables =
configured (established 1024 bind =
1024)<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>TCP <st1:City =
w:st=3D"on"><st1:place
 w:st=3D"on">reno</st1:place></st1:City> =
registered<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>sysctl table =
check failed: /kernel/l2cr .1.31 Missing =
strategy<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Call =
Trace:<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>[c1c0fe50] =
[c0008b70] show_stack+0x40/0x194 =
(unreliable)<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>[c1c0fe90] =
[c003aed4] set_fail+0x68/0x80<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>[c1c0feb0] =
[c003b4ec] =
sysctl_check_table+0x600/0x77c<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>[c1c0fef0] =
[c003b4d4] =
sysctl_check_table+0x5e8/0x77c<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>[c1c0ff30] =
[c002605c] =
register_sysctl_table+0x64/0xb4<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>[c1c0ff50] =
[c034579c] =
register_ppc_htab_sysctl+0x18/0x2c<o:p></o:p></span></font></pre><pre><fo=
nt
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>[c1c0ff60] =
[c034482c] =
kernel_init+0x94/0x2bc<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>[c1c0fff0] =
[c0004d58] =
kernel_thread+0x44/0x60<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Installing knfsd =
(copyright (C) 1996 <a
href=3D"https://webmail.sys.kth.se/src/compose.php?send_to=3Dokir%40monad=
.swb.de">okir@monad.swb.de</a>).<o:p></o:p></span></font></pre><pre><font=

size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>fuse init (API =
version 7.9)<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>io scheduler =
noop registered<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>io scheduler =
anticipatory registered<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>io scheduler =
deadline registered<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>io scheduler cfq =
registered (default)<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>uartlite.0: =
ttyUL0 at MMIO 0x84000003 (irq =3D 3) is a =
uartlite<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>console [ttyUL0] =
enabled<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>loop: module =
loaded<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>nbd: registered =
device at major 43<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>xilinx_lltemac =
xilinx_lltemac.0: MAC address is now&nbsp; 0: a:35: 1: 2: =
3<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>xilinx_lltemac =
xilinx_lltemac.0: XLlTemac: using DMA =
mode.<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>XLlTemac: Dma =
base address: phy: 0x84600100, virt: =
0xc3008100<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>XLlTemac: buffer =
descriptor size: 32768 (0x8000)<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>XLlTemac: =
Allocating DMA descriptors with =
kmalloc&lt;6&gt;XLlTemac:<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'>(buffer_descriptor_init) phy: 0x1d18000, =
virt: 0xc1d18000, size: 0x8000<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>XTemac: PHY =
detected at address 7.<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>xilinx_lltemac =
xilinx_lltemac.0: eth0: Xilinx TEMAC at 0x81C00000 =
mapped<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>to 0xC3004000, =
irq=3D2<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>console =
[netcon0] enabled<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Linux version =
2.6.24-rc8-xlnx-g1db182b8-dirty (mingliu@cca01) (gcc =
version<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>3.4.1) #7 Tue =
Apr 1 14:55:25 CEST 2008<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Xilinx Generic =
PowerPC board support package (Xilinx ML405) (Virtex-4 =
FX)<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Zone PFN =
ranges:<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>&nbsp; =
DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0 -&gt;&nbsp;&nbsp;&nbsp;&nbsp; =
8192<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>&nbsp; =
Normal&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8192 =
-&gt;&nbsp;&nbsp;&nbsp;&nbsp; =
8192<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>&nbsp; =
HighMem&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8192 -&gt;&nbsp;&nbsp;&nbsp;&nbsp; =
8192<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Movable zone =
start PFN for each node<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'>early_node_map[1] active PFN =
ranges<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'>&nbsp;&nbsp;&nbsp; =
0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 =
-&gt;&nbsp;&nbsp;&nbsp;&nbsp; =
8192<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Built 1 =
zonelists in Zone order, mobility grouping on.&nbsp; Total pages: =
8128<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Kernel command =
line: root=3D/dev/nfs<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'>ip=3D192.168.0.4:192.168.0.3:192.168.0.3:255.2=
55.255.0 rw<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'>nfsroot=3D192.168.0.3:/home/mingliu/ml403_root=
fs console=3DttyUL0,38400<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'>mem=3D32M<o:p></o:p></span></font></pre><pre><=
font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Xilinx INTC #0 =
at 0x81800000 mapped to =
0xFDFFF000<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>PID hash table =
entries: 128 (order: 7, 512 =
bytes)<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Console: colour =
dummy device 80x25<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Dentry cache =
hash table entries: 4096 (order: 2, 16384 =
bytes)<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Inode-cache hash =
table entries: 2048 (order: 1, 8192 =
bytes)<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Memory: 28884k =
available (2552k kernel code, 944k data, 84k init, 0k =
highmem)<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>SLUB: =
Genslabs=3D11, HWalign=3D32, Order=3D0-1, MinObjects=3D4, CPUs=3D1, =
Nodes=3D1<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Mount-cache hash =
table entries: 512<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>net_namespace: =
64 bytes<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>NET: Registered =
protocol family 16<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Registering =
device uartlite:0<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Fixup MAC =
address for xilinx_lltemac:0<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Registering =
device xilinx_lltemac:0<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>NET: Registered =
protocol family 2<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>IP route cache =
hash table entries: 1024 (order: 0, 4096 =
bytes)<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>TCP established =
hash table entries: 1024 (order: 1, 8192 =
bytes)<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>TCP bind hash =
table entries: 1024 (order: 0, 4096 =
bytes)<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>TCP: Hash tables =
configured (established 1024 bind =
1024)<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>TCP <st1:City =
w:st=3D"on"><st1:place
 w:st=3D"on">reno</st1:place></st1:City> =
registered<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>sysctl table =
check failed: /kernel/l2cr .1.31 Missing =
strategy<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Call =
Trace:<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>[c1c0fe50] =
[c0008b70] show_stack+0x40/0x194 =
(unreliable)<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>[c1c0fe90] =
[c003aed4] set_fail+0x68/0x80<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>[c1c0feb0] =
[c003b4ec] =
sysctl_check_table+0x600/0x77c<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>[c1c0fef0] =
[c003b4d4] =
sysctl_check_table+0x5e8/0x77c<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>[c1c0ff30] =
[c002605c] =
register_sysctl_table+0x64/0xb4<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>[c1c0ff50] =
[c034579c] =
register_ppc_htab_sysctl+0x18/0x2c<o:p></o:p></span></font></pre><pre><fo=
nt
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>[c1c0ff60] =
[c034482c] =
kernel_init+0x94/0x2bc<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>[c1c0fff0] =
[c0004d58] =
kernel_thread+0x44/0x60<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Installing knfsd =
(copyright (C) 1996 <a
href=3D"https://webmail.sys.kth.se/src/compose.php?send_to=3Dokir%40monad=
.swb.de">okir@monad.swb.de</a>).<o:p></o:p></span></font></pre><pre><font=

size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>fuse init (API =
version 7.9)<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>io scheduler =
noop registered<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>io scheduler =
anticipatory registered<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>io scheduler =
deadline registered<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>io scheduler cfq =
registered (default)<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>uartlite.0: =
ttyUL0 at MMIO 0x84000003 (irq =3D 3) is a =
uartlite<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>console [ttyUL0] =
enabled<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>loop: module =
loaded<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>nbd: registered =
device at major 43<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>xilinx_lltemac =
xilinx_lltemac.0: MAC address is now&nbsp; 0: a:35: 1: 2: =
3<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>xilinx_lltemac =
xilinx_lltemac.0: XLlTemac: using DMA =
mode.<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>XLlTemac: Dma =
base address: phy: 0x84600100, virt: =
0xc3008100<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>XLlTemac: buffer =
descriptor size: 32768 (0x8000)<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>XLlTemac: =
Allocating DMA descriptors with =
kmalloc&lt;6&gt;XLlTemac:<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'>(buffer_descriptor_init) phy: 0x1d18000, =
virt: 0xc1d18000, size: 0x8000<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>XTemac: PHY =
detected at address 7.<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>xilinx_lltemac =
xilinx_lltemac.0: eth0: Xilinx TEMAC at 0x81C00000 =
mapped<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>to 0xC3004000, =
irq=3D2<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>console =
[netcon0] enabled<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>netconsole: =
network logging started<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Generic platform =
RAM MTD, (c) 2004 Simtec =
Electronics<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>mice: PS/2 mouse =
device common for all mice<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>TCP cubic =
registered<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>NET: Registered =
protocol family 1<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>NET: Registered =
protocol family 17<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>RPC: Registered =
udp transport module.<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>RPC: Registered =
tcp transport module.<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>eth0: XLlTemac: =
Options: 0x3fa<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>eth0: XLlTemac: =
allocating interrupt 0 for dma mode =
tx.<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>eth0: XLlTemac: =
allocating interrupt 1 for dma mode =
rx.<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>eth0: XLlTemac: =
speed set to 1000Mb/s<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>eth0: XLlTemac: =
Send Threshold =3D 24, Receive Threshold =3D =
4<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>eth0: XLlTemac: =
Send Wait bound =3D 254, Receive Wait bound =3D =
254<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>IP-Config: =
Complete:<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device=3Deth0, =
addr=3D192.168.0.4, mask=3D255.255.255.0, =
gw=3D192.168.0.3,<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'>&nbsp;&nbsp;&nbsp;&nbsp; host=3D192.168.0.4, =
domain=3D, nis-domain=3D(none),<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'>&nbsp;&nbsp;&nbsp;&nbsp; =
bootserver=3D192.168.0.3, rootserver=3D192.168.0.3, =
rootpath=3D<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Looking up =
<st1:place w:st=3D"on"><st1:PlaceType
 w:st=3D"on">port</st1:PlaceType> of <st1:PlaceName =
w:st=3D"on">RPC</st1:PlaceName></st1:place> 100003/2 on =
192.168.0.3<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>rpcbind: server =
192.168.0.3 not responding, timed =
out<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Root-NFS: Unable =
to get nfsd port number from server, using =
default<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Looking up =
<st1:place w:st=3D"on"><st1:PlaceType
 w:st=3D"on">port</st1:PlaceType> of <st1:PlaceName =
w:st=3D"on">RPC</st1:PlaceName></st1:place> 100005/1 on =
192.168.0.3<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>rpcbind: server =
192.168.0.3 not responding, timed =
out<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Root-NFS: Unable =
to get mountd port number from server, using =
default<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>mount: server =
192.168.0.3 not responding, timed =
out<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Root-NFS: Server =
returned error -5 while mounting =
/home/mingliu/ml403_rootfs<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>VFS: Unable to =
mount root fs via NFS, trying =
floppy.<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>VFS: Cannot open =
root device &quot;nfs&quot; or =
unknown-block(2,0)<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Please append a =
correct &quot;root=3D&quot; boot option; here are the =
available<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'>partitions:<o:p></o:p></span></font></pre><pre=
><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Kernel panic - =
not syncing: VFS: Unable to mount root fs =
on<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'>unknown-block(2,0)<o:p></o:p></span></font></p=
re><pre><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>Rebooting in 180 =
seconds..<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'>BR<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'>Ming<o:p></o:p></span></font></pre>

<p class=3DMsoNormal><font size=3D1 face=3DTahoma><span =
style=3D'font-size:9.0pt;
font-family:Tahoma'><o:p>&nbsp;</o:p></span></font></p>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D1
face=3DTahoma><span style=3D'font-size:9.0pt;font-family:Tahoma'>

<hr size=3D2 width=3D"100%" align=3Dcenter>

</span></font></div>

<p class=3DMsoNormal><font size=3D1 face=3DTahoma><span =
style=3D'font-size:9.0pt;
font-family:Tahoma'>Windows Live Writer</span></font><font =
size=3D1><span
lang=3DZH-CN =
style=3D'font-size:9.0pt'>=A3=AC=D6=A7=B3=D6=C0=EB=CF=DF=D7=AB=D0=B4=B2=A9=
=BF=CD=C4=DA=C8=DD=A3=AC=CB=E6=CA=B1=CB=E6=B5=D8=CF=EB=D0=B4=BE=CD=D0=B4=A1=
=A3</span></font><font
size=3D1 face=3DTahoma><span lang=3DZH-CN =
style=3D'font-size:9.0pt;font-family:Tahoma'>
</span></font><font size=3D1 face=3DTahoma><span =
style=3D'font-size:9.0pt;font-family:
Tahoma'><a href=3D"http://get.live.cn/product/writer.html" =
target=3D"_new"><font
face=3DSimSun><span lang=3DZH-CN =
style=3D'font-family:SimSun'>=C1=A2=BC=B4=CA=B9=D3=C3=A3=A1</span></font>=
</a><o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C89404.BEFE4A74--
