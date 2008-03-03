Return-Path: <antbrunet@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.191])
	by ozlabs.org (Postfix) with ESMTP id E0A6CDDE42
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Mar 2008 20:17:02 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so4329036rvf.9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 03 Mar 2008 01:17:01 -0800 (PST)
Message-ID: <3f5ae9300803030117wb75983v80629287bcf13121@mail.gmail.com>
Date: Mon, 3 Mar 2008 10:17:01 +0100
From: "Antoine BRUNET" <antbrunet@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: ml403 linux port with hard_temac
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_23784_24807907.1204535821504"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_23784_24807907.1204535821504
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
I try to build 2.6.24rc3 kernel of secretlab git for ml403.
I can build the kernel for a BSP (xilinx) without hard_temac and plb_temac.
And the kernel boot on ml403 :

loaded at:     00400000 007C01A0
board data at: 007BE124 007BE1A0
relocated to:  004040B8 00404134
zimage at:     00404EA9 0053D590
initrd at:     0053E000 007BE000
avail ram:     007C1000 04000000

Linux/PPC load: console=3DttyS0,9600 root=3D/dev/ram0 rw initrd=3D/linuxrc
Uncompressing Linux...done.
Now booting the kernel
=81Linux version 2.6.24-rc3-gd7ed933b-dirty (root@debian) (gcc version 4.0.=
2)
#28 Thu Feb 28 11:16:30 CET 2008
[    0.000000] Xilinx ML403 Reference System (Virtex-4 FX)
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->    16384
[    0.000000]   Normal      16384 ->    16384
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->    16384
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l
pages: 16256
[    0.000000] Kernel command line: console=3DttyS0,9600 root=3D/dev/ram0 r=
w
initrd=3D/linuxrc
[    0.000000] Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFE000
[    0.000000] PID hash table entries: 256 (order: 8, 1024 bytes)
[    0.000427] Console: colour dummy device 80x25
[    0.001585] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes=
)
[    0.003394] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.037491] Memory: 59464k available (2100k kernel code, 672k data, 108k
init, 0k highmem)
[    0.129388] Mount-cache hash table entries: 512
[    0.138776] net_namespace: 64 bytes
[    0.150035] NET: Registered protocol family 16
[    0.222660] NET: Registered protocol family 2
[    0.257836] IP route cache hash table entries: 1024 (order: 0, 4096
bytes)
[    0.264505] TCP established hash table entries: 2048 (order: 2, 16384
bytes)
[    0.265237] TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
[    0.265673] TCP: Hash tables configured (established 2048 bind 2048)
[    0.265756] TCP reno registered
[    0.279119] checking if image is initramfs...it isn't (bad gzip magic
numbers); looks like an initrd
[    0.393762] Freeing initrd memory: 2560k freed
[    0.397985] sysctl table check failed: /kernel/l2cr .1.31 Missing
strategy
[    0.398155] Call Trace:
[    0.398209] [c3c17e80] [c000835c] show_stack+0x4c/0x174 (unreliable)
[    0.398428] [c3c17eb0] [c003644c] set_fail+0x50/0x68
[    0.398609] [c3c17ed0] [c0036ad4] sysctl_check_table+0x670/0x6bc
[    0.398744] [c3c17f10] [c0036ae8] sysctl_check_table+0x684/0x6bc
[    0.398873] [c3c17f50] [c002416c] register_sysctl_table+0x5c/0xac
[    0.399053] [c3c17f70] [c0292a58] register_ppc_htab_sysctl+0x18/0x2c
[    0.399257] [c3c17f80] [c028c824] kernel_init+0xb4/0x270
[    0.399377] [c3c17ff0] [c0004b18] kernel_thread+0x44/0x60
[    0.413198] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    0.418934] io scheduler noop registered (default)
[    0.552627] Generic RTC Driver v1.07
[    0.554582] Serial: 8250/16550 driver $Revision: 1.90 $ 1 ports, IRQ
sharing disabled
[    0.562210] serial8250.0: ttyS0 at MMIO 0x40401003 (irq =3D 0) is a 1655=
0A
[    0.562392] console [ttyS0] enabled
[    3.488329] RAMDISK driver initialized: 4 RAM disks of 8192K size 1024
blocksize
[    3.592001] loop: module loaded
[    3.632702] $Id: ftl.c,v 1.59 2005/11/29 14:48:31 gleixner Exp $
[    3.705897] NFTL driver: nftlcore.c $Revision: 1.98 $, nftlmount.c$Revis=
ion:
1.41 $
[    3.800355] INFTL: inftlcore.c $Revision: 1.19 $, inftlmount.c $Revision=
:
1.18 $
[    3.891145] SSFDC read-only Flash Translation layer
[    3.955590] TCP cubic registered
[    3.994870] NET: Registered protocol family 1
[    4.047673] NET: Registered protocol family 17
[    4.103431] RPC: Registered udp transport module.
[    4.160199] RPC: Registered tcp transport module.
[    4.221066] RAMDISK: ext2 filesystem found at block 0
[    4.282120] RAMDISK: Loading 2560KiB [1 disk] into ram disk... done.
[    5.139783] EXT2-fs warning: mounting unchecked fs, running e2fsck is
recommended
[    5.230262] VFS: Mounted root (ext2 filesystem).
[    5.286631] Freeing unused kernel memory: 108k init
init started: BusyBox v1.8.2 (2008-02-11 16:09:57 CET)
starting pid 160, tty '': '/etc/init.d/rcS'
Cannot run '/etc/init.d/rcS': Permission denied

Please press Enter to activate this console.
starting pid 161, tty '': '/bin/sh'
#


If I add hard_temac and plb_temac in the same BSP and add in the .config of
the kernel:
CONFIG_NETDEV_1000=3Dy
CONFIG_XILINX_TEMAC=3Dy
#CONFIG_XILINX_TEMAC_PHY_GENERIC_PHY is not set
CONFIG_XILINX_TEMAC_PHY_MARVELL_88E1111=3Dy

The kernel can't boot :

loaded at:     00400000 007BE1A0
board data at: 007BC124 007BC1A0
relocated to:  004040B8 00404134
zimage at:     00404EA9 0053B2E6
initrd at:     0053C000 007BC000
avail ram:     007BF000 04000000

Linux/PPC load: console=3DttyS0,9600 root=3D/dev/ram0 rw initrd=3D/linuxrc
Uncompressing Linux...done.
Now booting the kernel
And the kernel displays nothing else...

I use a hard_temac 3.00a.

I have difficulties to locate the problem. Someone can help me? Thanks

--=20
-------------------------------------------------
Antoine BRUNET

------=_Part_23784_24807907.1204535821504
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>I try to build 2.6.24rc3 kernel of secretlab git for ml403.<br>I can=
 build the kernel for a BSP (xilinx) without hard_temac and plb_temac. And =
the kernel boot on ml403 :<br><br>loaded at:&nbsp;&nbsp;&nbsp;&nbsp; 004000=
00 007C01A0<br>board data at: 007BE124 007BE1A0<br>
relocated to:&nbsp; 004040B8 00404134<br>zimage at:&nbsp;&nbsp;&nbsp;&nbsp;=
 00404EA9 0053D590<br>initrd at:&nbsp;&nbsp;&nbsp;&nbsp; 0053E000 007BE000<=
br>avail ram:&nbsp;&nbsp;&nbsp;&nbsp; 007C1000 04000000<br><br>Linux/PPC lo=
ad: console=3DttyS0,9600 root=3D/dev/ram0 rw initrd=3D/linuxrc<br>Uncompres=
sing Linux...done.<br>
Now booting the kernel<br>=81Linux version 2.6.24-rc3-gd7ed933b-dirty (root=
@debian) (gcc version 4.0.2) #28 Thu Feb 28 11:16:30 CET 2008<br>[&nbsp;&nb=
sp;&nbsp; 0.000000] Xilinx ML403 Reference System (Virtex-4 FX)<br>[&nbsp;&=
nbsp;&nbsp; 0.000000] Zone PFN ranges:<br>
[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp;&nbsp; 16384<=
br>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; Normal&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; 16384 -&gt;&nbsp;&nbsp;&nbsp; 16384<br>[&nbsp;&nbsp;&nbsp; 0.000000]=
 Movable zone start PFN for each node<br>[&nbsp;&nbsp;&nbsp; 0.000000] earl=
y_node_map[1] active PFN ranges<br>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp=
;&nbsp;&nbsp; 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nb=
sp;&nbsp; 16384<br>
[&nbsp;&nbsp;&nbsp; 0.000000] Built 1 zonelists in Zone order, mobility gro=
uping on.&nbsp; Total pages: 16256<br>[&nbsp;&nbsp;&nbsp; 0.000000] Kernel =
command line: console=3DttyS0,9600 root=3D/dev/ram0 rw initrd=3D/linuxrc<br=
>[&nbsp;&nbsp;&nbsp; 0.000000] Xilinx INTC #0 at 0x41200000 mapped to 0xFDF=
FE000<br>
[&nbsp;&nbsp;&nbsp; 0.000000] PID hash table entries: 256 (order: 8, 1024 b=
ytes)<br>[&nbsp;&nbsp;&nbsp; 0.000427] Console: colour dummy device 80x25<b=
r>[&nbsp;&nbsp;&nbsp; 0.001585] Dentry cache hash table entries: 8192 (orde=
r: 3, 32768 bytes)<br>[&nbsp;&nbsp;&nbsp; 0.003394] Inode-cache hash table =
entries: 4096 (order: 2, 16384 bytes)<br>
[&nbsp;&nbsp;&nbsp; 0.037491] Memory: 59464k available (2100k kernel code, =
672k data, 108k init, 0k highmem)<br>[&nbsp;&nbsp;&nbsp; 0.129388] Mount-ca=
che hash table entries: 512<br>[&nbsp;&nbsp;&nbsp; 0.138776] net_namespace:=
 64 bytes<br>[&nbsp;&nbsp;&nbsp; 0.150035] NET: Registered protocol family =
16<br>
[&nbsp;&nbsp;&nbsp; 0.222660] NET: Registered protocol family 2<br>[&nbsp;&=
nbsp;&nbsp; 0.257836] IP route cache hash table entries: 1024 (order: 0, 40=
96 bytes)<br>[&nbsp;&nbsp;&nbsp; 0.264505] TCP established hash table entri=
es: 2048 (order: 2, 16384 bytes)<br>[&nbsp;&nbsp;&nbsp; 0.265237] TCP bind =
hash table entries: 2048 (order: 1, 8192 bytes)<br>
[&nbsp;&nbsp;&nbsp; 0.265673] TCP: Hash tables configured (established 2048=
 bind 2048)<br>[&nbsp;&nbsp;&nbsp; 0.265756] TCP reno registered<br>[&nbsp;=
&nbsp;&nbsp; 0.279119] checking if image is initramfs...it isn&#39;t (bad g=
zip magic numbers); looks like an initrd<br>
[&nbsp;&nbsp;&nbsp; 0.393762] Freeing initrd memory: 2560k freed<br>[&nbsp;=
&nbsp;&nbsp; 0.397985] sysctl table check failed: /kernel/l2cr .1.31 Missin=
g strategy<br>[&nbsp;&nbsp;&nbsp; 0.398155] Call Trace:<br>[&nbsp;&nbsp;&nb=
sp; 0.398209] [c3c17e80] [c000835c] show_stack+0x4c/0x174 (unreliable)<br>
[&nbsp;&nbsp;&nbsp; 0.398428] [c3c17eb0] [c003644c] set_fail+0x50/0x68<br>[=
&nbsp;&nbsp;&nbsp; 0.398609] [c3c17ed0] [c0036ad4] sysctl_check_table+0x670=
/0x6bc<br>[&nbsp;&nbsp;&nbsp; 0.398744] [c3c17f10] [c0036ae8] sysctl_check_=
table+0x684/0x6bc<br>[&nbsp;&nbsp;&nbsp; 0.398873] [c3c17f50] [c002416c] re=
gister_sysctl_table+0x5c/0xac<br>
[&nbsp;&nbsp;&nbsp; 0.399053] [c3c17f70] [c0292a58] register_ppc_htab_sysct=
l+0x18/0x2c<br>[&nbsp;&nbsp;&nbsp; 0.399257] [c3c17f80] [c028c824] kernel_i=
nit+0xb4/0x270<br>[&nbsp;&nbsp;&nbsp; 0.399377] [c3c17ff0] [c0004b18] kerne=
l_thread+0x44/0x60<br>[&nbsp;&nbsp;&nbsp; 0.413198] Installing knfsd (copyr=
ight (C) 1996 <a href=3D"mailto:okir@monad.swb.de">okir@monad.swb.de</a>).<=
br>
[&nbsp;&nbsp;&nbsp; 0.418934] io scheduler noop registered (default)<br>[&n=
bsp;&nbsp;&nbsp; 0.552627] Generic RTC Driver v1.07<br>[&nbsp;&nbsp;&nbsp; =
0.554582] Serial: 8250/16550 driver $Revision: 1.90 $ 1 ports, IRQ sharing =
disabled<br>[&nbsp;&nbsp;&nbsp; 0.562210] serial8250.0: ttyS0 at MMIO 0x404=
01003 (irq =3D 0) is a 16550A<br>
[&nbsp;&nbsp;&nbsp; 0.562392] console [ttyS0] enabled<br>[&nbsp;&nbsp;&nbsp=
; 3.488329] RAMDISK driver initialized: 4 RAM disks of 8192K size 1024 bloc=
ksize<br>[&nbsp;&nbsp;&nbsp; 3.592001] loop: module loaded<br>[&nbsp;&nbsp;=
&nbsp; 3.632702] $Id: ftl.c,v 1.59 2005/11/29 14:48:31 gleixner Exp $<br>
[&nbsp;&nbsp;&nbsp; 3.705897] NFTL driver: nftlcore.c $Revision: 1.98 $, nf=
tlmount.c $Revision: 1.41 $<br>[&nbsp;&nbsp;&nbsp; 3.800355] INFTL: inftlco=
re.c $Revision: 1.19 $, inftlmount.c $Revision: 1.18 $<br>[&nbsp;&nbsp;&nbs=
p; 3.891145] SSFDC read-only Flash Translation layer<br>
[&nbsp;&nbsp;&nbsp; 3.955590] TCP cubic registered<br>[&nbsp;&nbsp;&nbsp; 3=
.994870] NET: Registered protocol family 1<br>[&nbsp;&nbsp;&nbsp; 4.047673]=
 NET: Registered protocol family 17<br>[&nbsp;&nbsp;&nbsp; 4.103431] RPC: R=
egistered udp transport module.<br>[&nbsp;&nbsp;&nbsp; 4.160199] RPC: Regis=
tered tcp transport module.<br>
[&nbsp;&nbsp;&nbsp; 4.221066] RAMDISK: ext2 filesystem found at block 0<br>=
[&nbsp;&nbsp;&nbsp; 4.282120] RAMDISK: Loading 2560KiB [1 disk] into ram di=
sk... done.<br>[&nbsp;&nbsp;&nbsp; 5.139783] EXT2-fs warning: mounting unch=
ecked fs, running e2fsck is recommended<br>
[&nbsp;&nbsp;&nbsp; 5.230262] VFS: Mounted root (ext2 filesystem).<br>[&nbs=
p;&nbsp;&nbsp; 5.286631] Freeing unused kernel memory: 108k init<br>init st=
arted: BusyBox v1.8.2 (2008-02-11 16:09:57 CET)<br>starting pid 160, tty &#=
39;&#39;: &#39;/etc/init.d/rcS&#39;<br>
Cannot run &#39;/etc/init.d/rcS&#39;: Permission denied<br><br>Please press=
 Enter to activate this console.<br>starting pid 161, tty &#39;&#39;: &#39;=
/bin/sh&#39;<br>#<br><br><br>If I add hard_temac and plb_temac in the same =
BSP and add in the .config of the kernel:<br>
CONFIG_NETDEV_1000=3Dy<br>CONFIG_XILINX_TEMAC=3Dy<br>#CONFIG_XILINX_TEMAC_P=
HY_GENERIC_PHY is not set<br>CONFIG_XILINX_TEMAC_PHY_MARVELL_88E1111=3Dy<br=
><br>The kernel can&#39;t boot :<br><br>loaded at:&nbsp;&nbsp;&nbsp;&nbsp; =
00400000 007BE1A0<br>board data at: 007BC124 007BC1A0<br>
relocated to:&nbsp; 004040B8 00404134<br>zimage at:&nbsp;&nbsp;&nbsp;&nbsp;=
 00404EA9 0053B2E6<br>initrd at:&nbsp;&nbsp;&nbsp;&nbsp; 0053C000 007BC000<=
br>avail ram:&nbsp;&nbsp;&nbsp;&nbsp; 007BF000 04000000<br><br>Linux/PPC lo=
ad: console=3DttyS0,9600 root=3D/dev/ram0 rw initrd=3D/linuxrc<br>Uncompres=
sing Linux...done.<br>
Now booting the kernel<br>And the kernel displays nothing else...<br><br>I =
use a hard_temac 3.00a.<br><br>I have difficulties to locate the problem. S=
omeone can help me? Thanks<br clear=3D"all"><br>-- <br>--------------------=
-----------------------------<br>
Antoine BRUNET

------=_Part_23784_24807907.1204535821504--
