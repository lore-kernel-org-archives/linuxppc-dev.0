Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id 7AAF7DDEC6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Aug 2007 19:16:26 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7E49D.1CC40D2B"
Subject: Badness in local_bh_enable at kernel/softirq.c:137
	(linux_denx_2.6.19.2)
Date: Wed, 22 Aug 2007 11:16:24 +0200
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8EA180A4@aquib01a>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
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

------_=_NextPart_001_01C7E49D.1CC40D2B
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sending ioctls to a socket I receive the following problem (only the
first time I send a ioctl):
=20
Badness in local_bh_enable at kernel/softirq.c:137
Call Trace:
[C0593C90] [C000A6E8] show_stack+0x48/0x190 (unreliable)
[C0593CC0] [C0003734] check_bug_trap+0xa4/0xb8
[C0593CD0] [C0004354] program_check_exception+0x2e4/0x4fc
[C0593CF0] [C0003344] ret_from_except_full+0x0/0x4c
[C0593DB0] [C01A1BD4] klist_iter_exit+0x28/0x44
[C0593DC0] [C01198E0] phy_read+0x40/0x58
[C0593DE0] [C0119A94] phy_mii_ioctl+0x70/0x18c
[C0593E00] [C011BFCC] fs_ioctl+0x60/0xb4
[C0593E20] [C0146C30] dev_ifsioc+0x174/0x3dc
[C0593E40] [C0147784] dev_ioctl+0x468/0x4d0
[C0593EB0] [C013A1D0] sock_ioctl+0x38/0x210
[C0593ED0] [C009C8D0] do_ioctl+0x38/0x84
[C0593EE0] [C009C9A8] vfs_ioctl+0x8c/0x418
[C0593F10] [C009CD74] sys_ioctl+0x40/0x74
[C0593F40] [C0002CE4] ret_from_syscall+0x0/0x38
=20
=20
=20

------_=_NextPart_001_01C7E49D.1CC40D2B
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D724495608-22082007>Sending ioctls to a=20
socket I receive the following problem (only the first time I send a=20
ioctl):</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D724495608-22082007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D724495608-22082007>Badness in=20
local_bh_enable at kernel/softirq.c:137<BR>Call Trace:<BR>[C0593C90] =
[C000A6E8]=20
show_stack+0x48/0x190 (unreliable)<BR>[C0593CC0] [C0003734]=20
check_bug_trap+0xa4/0xb8<BR>[C0593CD0] [C0004354]=20
program_check_exception+0x2e4/0x4fc<BR>[C0593CF0] [C0003344]=20
ret_from_except_full+0x0/0x4c<BR>[C0593DB0] [C01A1BD4]=20
klist_iter_exit+0x28/0x44<BR>[C0593DC0] [C01198E0]=20
phy_read+0x40/0x58<BR>[C0593DE0] [C0119A94]=20
phy_mii_ioctl+0x70/0x18c<BR>[C0593E00] [C011BFCC]=20
fs_ioctl+0x60/0xb4<BR>[C0593E20] [C0146C30] =
dev_ifsioc+0x174/0x3dc<BR>[C0593E40]=20
[C0147784] dev_ioctl+0x468/0x4d0<BR>[C0593EB0] [C013A1D0]=20
sock_ioctl+0x38/0x210<BR>[C0593ED0] [C009C8D0] =
do_ioctl+0x38/0x84<BR>[C0593EE0]=20
[C009C9A8] vfs_ioctl+0x8c/0x418<BR>[C0593F10] [C009CD74]=20
sys_ioctl+0x40/0x74<BR>[C0593F40] [C0002CE4]=20
ret_from_syscall+0x0/0x38</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D724495608-22082007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D724495608-22082007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D724495608-22082007></SPAN></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C7E49D.1CC40D2B--
