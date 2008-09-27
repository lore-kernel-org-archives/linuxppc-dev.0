Return-Path: <tmarri@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 589ECDDDE6
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Sep 2008 07:47:39 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C920E9.34D9CF1F"
Subject: rootfs mount problem
Date: Sat, 27 Sep 2008 14:37:22 -0700
Message-ID: <AC5E1C3367E37D44970B81A6ADD1DA2C06052F2A@SDCEXCHANGE01.ad.amcc.com>
From: "Tirumala Reddy Marri" <tmarri@amcc.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C920E9.34D9CF1F
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi ,
  I am trying to bring up a new SOC. I am seeing the following error.
Has any one seen this error before. I am pretty sure RAMDISK is not
corrupted.
Thanks,
Marri
------------------- LOG ---------------
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
prepare_namespace line 361=20
prepare_namespace line 385=20
RAMDISK: Compressed image found at block 0
invalid compressed format (err=3D1)
EXT3-fs error (device ram0): ext3_check_descriptors: Block bitmap for
group 0 not in group (block 14728687)!
EXT3-fs: group descriptors corrupted!
EXT2-fs error (device ram0): ext2_check_descriptors: Block bitmap for
group 0 not in group (block 14728687)!
EXT2-fs: group descriptors corrupted!
List of all partitions:
No filesystem could mount root, tried:  ext3 ext2 cramfs
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(1,0)
Rebooting in 180 seconds..?
=20
U-Boot 1.3.2 (Sep 24 2008 - 14:25:32)

----------------------------------------------- back trace -----------
(gdb) bt
#0  __delay (loops=3D800000) at include/asm/time.h:97
#1  0xc001f07c in panic (fmt=3DVariable "fmt" is not available.
) at kernel/panic.c:115
#2  0xc0248dc4 in mount_block_root (name=3D0xc020f9f4 "/dev/root",
flags=3D32768) at init/do_mounts.c:277
#3  0xc02491b0 in prepare_namespace () at init/do_mounts.c:403
#4  0xc02489a8 in kernel_init (unused=3DVariable "unused" is not
available.
) at init/main.c:878
#5  0xc000cf08 in kernel_thread ()
Previous frame inner to this frame (corrupt stack?)
(gdb)=20
---------------

------_=_NextPart_001_01C920E9.34D9CF1F
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3354" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2>
<DIV><SPAN class=3D155142821-27092008><FONT face=3DArial size=3D2>Hi=20
,</FONT></SPAN></DIV>
<DIV><SPAN class=3D155142821-27092008><FONT face=3DArial size=3D2>&nbsp; =
I am trying=20
to bring up a new SOC. I am seeing the following error. Has any one seen =
this=20
error before. I am pretty sure RAMDISK is not =
corrupted.</FONT></SPAN></DIV>
<DIV><SPAN class=3D155142821-27092008><FONT face=3DArial=20
size=3D2>Thanks,</FONT></SPAN></DIV>
<DIV><SPAN class=3D155142821-27092008><FONT face=3DArial=20
size=3D2>Marri</FONT></SPAN></DIV>
<DIV><SPAN class=3D155142821-27092008><FONT face=3DArial =
size=3D2>-------------------=20
LOG ---------------</FONT></SPAN></DIV>
<DIV><SPAN class=3D155142821-27092008><FONT face=3DArial size=3D2>NET: =
Registered=20
protocol family 17<BR>RPC: Registered udp transport module.<BR>RPC: =
Registered=20
tcp transport module.<BR>prepare_namespace line 361 =
<BR>prepare_namespace line=20
385 <BR>RAMDISK: Compressed image found at block 0<BR>invalid compressed =
format=20
(err=3D1)<BR>EXT3-fs error (device ram0): ext3_check_descriptors: Block =
bitmap for=20
group 0 not in group (block 14728687)!<BR>EXT3-fs: group descriptors=20
corrupted!<BR>EXT2-fs error (device ram0): ext2_check_descriptors: Block =
bitmap=20
for group 0 not in group (block 14728687)!<BR>EXT2-fs: group descriptors =

corrupted!<BR>List of all partitions:<BR>No filesystem could mount root, =

tried:&nbsp; ext3 ext2 cramfs<BR>Kernel panic - not syncing: VFS: Unable =
to=20
mount root fs on unknown-block(1,0)<BR>Rebooting in 180=20
seconds..?</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D155142821-27092008><FONT face=3DArial size=3D2>U-Boot =
1.3.2 (Sep 24=20
2008 - 14:25:32)<BR></FONT></SPAN></DIV>
<DIV><SPAN class=3D155142821-27092008><FONT face=3DArial=20
size=3D2>----------------------------------------------- back trace=20
-----------</FONT></SPAN></DIV>
<DIV><SPAN class=3D155142821-27092008><FONT face=3DArial size=3D2>(gdb) =
bt<BR>#0&nbsp;=20
__delay (loops=3D800000) at include/asm/time.h:97<BR>#1&nbsp; 0xc001f07c =
in panic=20
(fmt=3DVariable "fmt" is not available.<BR>) at =
kernel/panic.c:115<BR>#2&nbsp;=20
0xc0248dc4 in mount_block_root (name=3D0xc020f9f4 "/dev/root", =
flags=3D32768) at=20
init/do_mounts.c:277<BR>#3&nbsp; 0xc02491b0 in prepare_namespace () at=20
init/do_mounts.c:403<BR>#4&nbsp; 0xc02489a8 in kernel_init =
(unused=3DVariable=20
"unused" is not available.<BR>) at init/main.c:878<BR>#5&nbsp; =
0xc000cf08 in=20
kernel_thread ()<BR>Previous frame inner to this frame (corrupt =
stack?)<BR>(gdb)=20
</FONT></SPAN></DIV>
<DIV><SPAN class=3D155142821-27092008><FONT face=3DArial=20
size=3D2>---------------</DIV></FONT></SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C920E9.34D9CF1F--
