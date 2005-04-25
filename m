Return-Path: <stuart.yoder@conformative.com>
Received: from relay3.mail.twtelecom.net (relay3.mail.twtelecom.net
	[216.136.95.10]) by ozlabs.org (Postfix) with ESMTP id 40A9267A6C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Apr 2005 07:27:49 +1000 (EST)
Received: from Spaceballs (66-194-80-47.gen.twtelecom.net [66.194.80.47])
	by relay3.mail.twtelecom.net (Postfix) with ESMTP id 8EFB24AC3
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Apr 2005 16:10:37 -0500 (CDT)
From: "Stuart Yoder" <stuart.yoder@conformative.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Mon, 25 Apr 2005 16:10:28 -0500
Message-ID: <052201c549db$37e8b430$2f010a0a@foundation.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0523_01C549B1.4F12AC30"
Subject: PowerPC + SMP
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

------=_NextPart_000_0523_01C549B1.4F12AC30
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi.
 
I am trying to figure out where in the PowerPC kernel the HID1 register
is updated to enable bits dealing with cache coherency in an SMP system.
Grepping through the arch/ppc source does not reveal much.
 
I have two 7447A processors and somewhere the ABE and SYNCBE bits in
HID1 need to be turned on to enable cache coherency.   Is supposed to
happen in the bootloader prior to the kernel running??
 
Thanks,
Stuart Yoder

------=_NextPart_000_0523_01C549B1.4F12AC30
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<TITLE>Message</TITLE>

<META content=3D"MSHTML 6.00.2800.1400" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D754450621-25042005><FONT face=3DArial=20
size=3D2>Hi.</FONT></SPAN></DIV>
<DIV><SPAN class=3D754450621-25042005><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D754450621-25042005><FONT face=3DArial size=3D2>I am =
trying to=20
figure out where in the PowerPC kernel the HID1 register is updated to =
enable=20
bits dealing with cache coherency in an SMP system.&nbsp;&nbsp; Grepping =
through=20
the arch/ppc source does not reveal much.</FONT></SPAN></DIV>
<DIV><SPAN class=3D754450621-25042005><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D754450621-25042005><FONT face=3DArial size=3D2>I =
have&nbsp;two=20
7447A processors and somewhere the ABE and SYNCBE bits in HID1&nbsp;need =
to be=20
turned on to enable cache coherency.&nbsp;&nbsp; Is supposed to happen =
in the=20
bootloader prior to the kernel running??</FONT></SPAN></DIV>
<DIV><SPAN class=3D754450621-25042005><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D754450621-25042005><FONT face=3DArial=20
size=3D2>Thanks,</FONT></SPAN></DIV>
<DIV><SPAN class=3D754450621-25042005><FONT face=3DArial size=3D2>Stuart =

Yoder</FONT></SPAN></DIV></BODY></HTML>

------=_NextPart_000_0523_01C549B1.4F12AC30--
