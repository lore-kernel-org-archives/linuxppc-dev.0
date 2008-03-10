Return-Path: <akhilesh@innomedia.soft.net>
Received: from gateway.innomedia.soft.net (mail.innomedia.soft.net
	[164.164.79.130])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D60B3DDFB2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Mar 2008 01:08:39 +1100 (EST)
Received: from akhileshld ([192.168.28.7]) (authenticated bits=0)
	by gateway.innomedia.soft.net (8.13.1/8.13.1) with ESMTP id
	m2ADDgLH007301
	for <linuxppc-embedded@ozlabs.org>; Mon, 10 Mar 2008 18:43:43 +0530
Message-ID: <002001c882b0$7e6bd430$071ca8c0@akhileshld>
From: "Akhilesh Soni" <akhilesh@innomedia.soft.net>
To: <linuxppc-embedded@ozlabs.org>
Subject: Query about Kernel Load address
Date: Mon, 10 Mar 2008 18:43:11 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_001D_01C882DE.974B3C60"
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

------=_NextPart_000_001D_01C882DE.974B3C60
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I''ve ported u-boot-1.1.1 sucessfully on my IBM STBx25xx  rewood6 =
platform (ppc405 core). Earlier in the ppcboot I used to load the =
zImage.treeboot directly via the bootloader and it used to relocate and =
run.=20

But with u-boot which image I should use and which address I should load =
the image. My board has 64 MB of RAM and out of which 32 MB is mapped at =
0x0000000 and another 32MB is mapped at 0xA0000000. The U-boot code is =
located at 0x1fe2000 in RAM.

Also is there any 2.6 kernel source supporting redwood6 IBM STBx25xx =
platform.

Thanx in advance.

Regards,
Akhilesh
------=_NextPart_000_001D_01C882DE.974B3C60
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.6000.16608" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I''ve ported =
u-boot-1.1.1&nbsp;sucessfully on my=20
IBM STBx25xx&nbsp; rewood6 platform (ppc405 core). Earlier in the =
ppcboot I used=20
to load the zImage.treeboot directly via the bootloader and it used to =
relocate=20
and run. </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>But with&nbsp;u-boot which image I =
should use and=20
which address I should load the image. My board has 64 MB of RAM and out =
of=20
which 32 MB is mapped at 0x0000000 and another 32MB is mapped at =
0xA0000000. The=20
U-boot code is located at 0x1fe2000 in RAM.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Also is there any 2.6 kernel source =
supporting=20
redwood6 IBM STBx25xx platform.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanx in advance.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Akhilesh</FONT></DIV></BODY></HTML>

------=_NextPart_000_001D_01C882DE.974B3C60--
