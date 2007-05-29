Return-Path: <ganesh.narayanan@netapp.com>
Received: from mx2.netapp.com (mx2.netapp.com [216.240.18.37])
	by ozlabs.org (Postfix) with ESMTP id BD743DDF2C
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 02:45:17 +1000 (EST)
Received: from svlexrs01.hq.netapp.com (svlexrs01.corp.netapp.com
	[10.57.156.158])
	by smtp2.corp.netapp.com (8.13.1/8.13.1/NTAP-1.6) with ESMTP id
	l4TGZBce011943
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 09:35:20 -0700 (PDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7A20F.54AE9EE9"
Subject: AMD to ST migration issues
Date: Tue, 29 May 2007 09:35:12 -0700
Message-ID: <7619F3097FAB384287CF636FF92D0CA109943577@exsvl01.hq.netapp.com>
From: "Narayanan, Ganesh" <ganesh.narayanan@netapp.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7A20F.54AE9EE9
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
We have been using PPC with a AMD flash (Spansion S29GL128M) on it for
our applications.  We are running Montavista linux on it.  Recently we
replaced the AMD flash with ST flash (M29W128FH).  The u-boot boots up
and during the kernel boot, I am getting the following error messages
and the system doesn't boot after this:
=20

jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000000:
0x0020 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000001c:
0x2212 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000020:
0x0020 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000003c:
0x2212 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000040:
0x0020 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000005c:
0x2212 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000060:
0x0020 instead
=20
It would be really great if someone could let me know what is going
wrong in this.
=20
Thanks,
Ganesh
=20
=20

------_=_NextPart_001_01C7A20F.54AE9EE9
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.6000.16441" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2>Hi,</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>We have been using PPC with a AMD flash =
(Spansion=20
S29GL128M) on it for our applications.&nbsp; We are running Montavista =
linux on=20
it.&nbsp; Recently we replaced the AMD flash with ST flash =
(M29W128FH).&nbsp;=20
The u-boot boots up and during the kernel boot, I am getting the =
following error=20
messages and the system doesn't boot after this:</FONT></DIV>
<DIV>&nbsp;</DIV><FONT face=3DArial size=3D2>
<DIV><BR>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at =
0x00000000:=20
0x0020 instead<BR>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not =
found at=20
0x0000001c: 0x2212 instead<BR>jffs2_scan_eraseblock(): Magic bitmask =
0x1985 not=20
found at 0x00000020: 0x0020 instead<BR>jffs2_scan_eraseblock(): Magic =
bitmask=20
0x1985 not found at 0x0000003c: 0x2212 =
instead<BR>jffs2_scan_eraseblock(): Magic=20
bitmask 0x1985 not found at 0x00000040: 0x0020=20
instead<BR>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at=20
0x0000005c: 0x2212 instead<BR>jffs2_scan_eraseblock(): Magic bitmask =
0x1985 not=20
found at 0x00000060: 0x0020 instead</DIV>
<DIV>&nbsp;</DIV>
<DIV>It would be really great if someone could let me know what is going =
wrong=20
in this.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks,<BR>Ganesh</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C7A20F.54AE9EE9--
