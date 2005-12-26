Return-Path: <W22390@motorola.com>
Received: from ftpbox.mot.com (ftpbox.mot.com [129.188.136.101])
	by ozlabs.org (Postfix) with ESMTP id 2956968926
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Dec 2005 23:43:55 +1100 (EST)
Received: from az33exr01.mot.com (az33exr01.mot.com [10.64.251.231])
	by ftpbox.mot.com (Motorola/Ftpbox) with ESMTP id jBQChrK1006972
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Dec 2005 05:43:53 -0700 (MST)
Received: from zmy16exm62.ds.mot.com (zmy16exm62.ap.mot.com [10.179.4.33])
	by az33exr01.mot.com (8.13.5/8.13.0) with ESMTP id jBQCxZu8026531
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Dec 2005 06:59:37 -0600 (CST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C60A1A.055ADE34"
Date: Mon, 26 Dec 2005 20:43:49 +0800
Message-ID: <917BB953409D9D4E86FDD8AE553CA873214B24@zmy16exm62.ds.mot.com>
From: "Zhang Xin-W22390" <W22390@motorola.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Can I use the system call provided by uboot in an assembly language
	program as in ppcbug?
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

------_=_NextPart_001_01C60A1A.055ADE34
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,
I want to call some system calls to do input/ouput in assembly language
program, and does uboot provide such syscall? As in PPCBUG, I can
program the following code:
  li r10,0x0022
  sc
to do an output to console.
=20
I know I can program a standalone application using printf() to achieve
this function, as illustrated by the example uboot provides. Instead, I
want to use assembly language.=20
=20
Thanks and Regards.
=20
Zhang Xin
MOTO Networks CDC
Phone: 86 10 58830720
=20

------_=_NextPart_001_01C60A1A.055ADE34
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1528" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D359053512-26122005><FONT =
size=3D2>Hello,</FONT></SPAN></DIV>
<DIV><SPAN class=3D359053512-26122005><FONT size=3D2>I want to call some =
system=20
calls to do input/ouput in assembly language program, and does uboot =
provide=20
such syscall? As in PPCBUG, I can program the following=20
code:</FONT></SPAN></DIV>
<DIV><SPAN class=3D359053512-26122005><FONT size=3D2>&nbsp; li=20
r10,0x0022</FONT></SPAN></DIV>
<DIV><SPAN class=3D359053512-26122005><FONT size=3D2>&nbsp; =
sc</FONT></SPAN></DIV>
<DIV><SPAN class=3D359053512-26122005><FONT size=3D2>to do an output to=20
console.</FONT></SPAN></DIV>
<DIV><SPAN class=3D359053512-26122005><FONT =
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D359053512-26122005><FONT size=3D2>I know I can =
program a=20
standalone application using printf() to achieve this function, as =
illustrated=20
by the example uboot provides. Instead, I want to use assembly language. =

</FONT></SPAN></DIV>
<DIV><SPAN class=3D359053512-26122005><FONT =
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D359053512-26122005><FONT size=3D2>Thanks and=20
Regards.</FONT></SPAN></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV align=3Dleft><FONT size=3D2>Zhang Xin</FONT></DIV>
<DIV align=3Dleft><FONT size=3D2>MOTO Networks CDC</FONT></DIV>
<DIV align=3Dleft><FONT size=3D2>Phone: 86 10 58830720</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C60A1A.055ADE34--
