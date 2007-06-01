Return-Path: <sivakumarkk@cornetindia.com>
Received: from smtpserver.rdsindia.com (smtpserver.rdsindia.com
	[64.62.254.191])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EF077DE026
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Jun 2007 02:25:12 +1000 (EST)
Received: from SIVA (ABTS-TN-dynamic-069.174.164.122.airtelbroadband.in
	[122.164.174.69] (may be forged)) (authenticated bits=0)
	by smtpserver.rdsindia.com (8.12.10/8.12.11) with ESMTP id
	l51ET3hG032724
	for <linuxppc-embedded@ozlabs.org>; Fri, 1 Jun 2007 07:29:05 -0700
Message-ID: <000601c7a45f$5b3d9780$9000a8c0@SIVA>
From: "Sivakumar K K" <sivakumarkk@cornetindia.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: linux 2.6 driver for tsi148
Date: Fri, 1 Jun 2007 20:43:01 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0003_01C7A48D.71D27370"
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

------=_NextPart_000_0003_01C7A48D.71D27370
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi guys,
   i am cirrently working on vme driver integration with linux 2.6 =
kernel for powerpc based SBC. Tundra giving driver to tsi148 for =
2.4kernel  , but i required it for 2.6 kernel.
If anybody have the driver in 2.6 kernel, please reply to me.

    I tried to convert 2.4 driver to support 2.6 finally i got struc at =
"kiobuf" structure all other changes i made. kiobuf structure is in =
iobuf.h, i have searched it in 2.6 kernel but i didn,t get the result. I =
need a help how to resolve this issue, is there any equivqlent functions =
and structures are available in 2.6 kerenel? If anybody knows how to =
resole it please reply to me.

Thanks and Regards
Siva
Firmware Engineer
------=_NextPart_000_0003_01C7A48D.71D27370
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2180" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi guys,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp; i am cirrently working =
on&nbsp;vme=20
driver&nbsp;integration with linux 2.6 kernel for powerpc =
based&nbsp;SBC. Tundra=20
giving driver to tsi148 for&nbsp;2.4kernel&nbsp;&nbsp;, but i required =
it for=20
2.6 kernel.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>If anybody have the driver in 2.6 =
kernel, please=20
reply to me.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp; I tried to convert =
2.4 driver to=20
support 2.6 finally i got struc at "<STRONG>kiobuf"</STRONG> structure =
all other=20
changes i made. kiobuf structure is in <STRONG>iobuf.h,</STRONG> i have =
searched=20
it in 2.6 kernel but i didn,t get the result. I need a help how to =
resolve this=20
issue, is there any equivqlent functions and structures are available in =
2.6=20
kerenel? If anybody knows how to resole it please reply to =
me.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks and Regards</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Siva</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Firmware =
Engineer</FONT></DIV></BODY></HTML>

------=_NextPart_000_0003_01C7A48D.71D27370--
