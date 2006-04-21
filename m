Return-Path: <jmadl@kts.cz>
Received: from mail.kts.cz (kts.inway.net [213.151.75.230])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 28F1167B2D
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 16:52:17 +1000 (EST)
Received: from localhost ([127.0.0.1]) by mail.kts.cz (Kerio MailServer 5.7.10)
	for linuxppc-dev@ozlabs.org; Fri, 21 Apr 2006 08:21:57 +0200
Message-ID: <001201c6650b$e507b110$0c01a8c0@KTSJMXP>
From: =?iso-8859-2?Q?Josef_M=E1dl?= <jmadl@kts.cz>
To: <linuxppc-dev@ozlabs.org>
Subject: Fedora 5 on POWER5
Date: Fri, 21 Apr 2006 08:21:53 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000F_01C6651C.A57C1520"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_000F_01C6651C.A57C1520
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello to all,

I am trying to install fedora 5 on IBM i5 system. Instalation start, all =
seems to good to partitioning disk.
Fedora see two disks /dev/sda (real disk - virtual disk prepared with =
CRTNWSSTG) and /dev/sdb (booting disk of instalation - Prep).
I choise /dev/sda for creating linux partitions, fedora show me how it =
will be parted but try to write to /dev/sdb - it ends with error.

Do anybody know how solved this problem ?

I can send detail error from anaconda.

Josef
------=_NextPart_000_000F_01C6651C.A57C1520
Content-Type: text/html;
	charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-2">
<META content=3D"MSHTML 6.00.2900.2873" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hello to all,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I am trying to install fedora 5 on IBM =
i5 system.=20
Instalation start, all seems to good to partitioning disk.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Fedora see two disks /dev/sda (real =
disk - virtual=20
disk prepared with CRTNWSSTG) and /dev/sdb (booting disk of instalation =
-=20
Prep).</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I choise /dev/sda for creating linux =
partitions,=20
fedora show me how it will be parted but try to write to /dev/sdb - it =
ends with=20
error.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Do anybody know how solved this problem =

?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I can send detail error from =
anaconda.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Josef</FONT></DIV></BODY></HTML>

------=_NextPart_000_000F_01C6651C.A57C1520--
