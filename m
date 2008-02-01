Return-Path: <bgholikh@cisco.com>
Received: from sj-iport-3.cisco.com (sj-iport-3.cisco.com [171.71.176.72])
	by ozlabs.org (Postfix) with ESMTP id ECA07DDFD2
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Feb 2008 09:17:53 +1100 (EST)
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id m11MHqom002735
	for <linuxppc-embedded@ozlabs.org>; Fri, 1 Feb 2008 14:17:52 -0800
Received: from xbh-sjc-221.amer.cisco.com (xbh-sjc-221.cisco.com
	[128.107.191.63])
	by sj-core-2.cisco.com (8.12.10/8.12.6) with ESMTP id m11MHo1t015758
	for <linuxppc-embedded@ozlabs.org>; Fri, 1 Feb 2008 22:17:52 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C86520.46BAAE8D"
Subject: Enabling MSR debugging mode on MPC8541cds
Date: Fri, 1 Feb 2008 14:17:48 -0800
Message-ID: <F795765B112E7344AF36AA911279641502D1AA26@xmb-sjc-212.amer.cisco.com>
From: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
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

------_=_NextPart_001_01C86520.46BAAE8D
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,
I am working on powerpc git tree version
Linux-2.6.22-rc4-geff2ebd2-dirty.
Our custom board is based on mpc8541cds. I am trying to use Jtag to
debug
the kernel issues. I have done the following changes to the source tree:
=20
On the top directory Makefile:
=20
CC                =3D $(CROSS_COMPILE)gcc -g2 -gdwarf-2
AFLAG_KERNEL =3D -Wa,gdwarf2
=20
include/asm-powerpc/reg_booke.h:
/* Default MSR for kernel mode. */=20
#if defined (CONFIG_40x)=20
#define MSR_KERNEL (MSR_ME|MSR_RI|MSR_IR|MSR_DR|MSR_CE|MSR_DE) =20
#elif defined(CONFIG_BOOKE)=20
#define MSR_KERNEL (MSR_ME|MSR_RI|MSR_CE|MSR_DE)
=20
However, I can see through Jtag that the MSR_DE (the debug bit) is not
set on the,=20
so I am not able to set break points.
=20
Any help greatly appreciated.
=20
Regards,
Bizhan

------_=_NextPart_001_01C86520.46BAAE8D
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3243" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2>
<DIV><SPAN class=3D156430622-01022008><SPAN =
class=3D359181022-01022008>Hi=20
All,</SPAN></SPAN></DIV>
<DIV><SPAN class=3D156430622-01022008><SPAN class=3D359181022-01022008>I =
am working=20
on powerpc git tree version=20
Linux-2.6.22-rc4-geff2ebd2-dirty.</SPAN></SPAN></DIV>
<DIV><SPAN class=3D156430622-01022008><SPAN =
class=3D359181022-01022008>Our custom=20
board is based on mpc8541cds. I am trying to use Jtag to=20
debug</SPAN></SPAN></DIV>
<DIV><SPAN class=3D156430622-01022008><SPAN =
class=3D359181022-01022008>the kernel=20
issues. I have done the following changes to the source=20
tree:</SPAN></SPAN></DIV>
<DIV><SPAN class=3D156430622-01022008></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D156430622-01022008>On the top directory =
Makefile:</SPAN></DIV>
<DIV><SPAN class=3D156430622-01022008></SPAN>&nbsp;</DIV>
<DIV><SPAN=20
class=3D156430622-01022008>CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
=3D $(CROSS_COMPILE)gcc -g2 -gdwarf-2</SPAN></DIV>
<DIV><SPAN class=3D156430622-01022008>AFLAG_KERNEL =3D =
-Wa,gdwarf2</SPAN></DIV>
<DIV><SPAN class=3D156430622-01022008></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D156430622-01022008><SPAN=20
class=3D359181022-01022008>include/asm-powerpc/</SPAN>reg_booke.h:</SPAN>=
</DIV>
<DIV><SPAN class=3D156430622-01022008><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-fareast-font-family: =
'Times New Roman'; mso-ansi-language: EN-US; mso-fareast-language: =
EN-US; mso-bidi-language: AR-SA">/*=20
Default MSR for kernel mode. */</SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Times New Roman'; =
mso-fareast-font-family: 'Times New Roman'; mso-ansi-language: EN-US; =
mso-fareast-language: EN-US; mso-bidi-language: AR-SA">=20
<BR></SPAN><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-fareast-font-family: =
'Times New Roman'; mso-ansi-language: EN-US; mso-fareast-language: =
EN-US; mso-bidi-language: AR-SA">#if=20
defined (CONFIG_40x)</SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Times New Roman'; =
mso-fareast-font-family: 'Times New Roman'; mso-ansi-language: EN-US; =
mso-fareast-language: EN-US; mso-bidi-language: AR-SA">=20
<BR></SPAN><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-fareast-font-family: =
'Times New Roman'; mso-ansi-language: EN-US; mso-fareast-language: =
EN-US; mso-bidi-language: AR-SA">#define=20
MSR_KERNEL (MSR_ME|MSR_RI|MSR_IR|MSR_DR|MSR_CE|<SPAN=20
style=3D"COLOR: red">MSR_DE</SPAN>)&nbsp;</SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Times New Roman'; =
mso-fareast-font-family: 'Times New Roman'; mso-ansi-language: EN-US; =
mso-fareast-language: EN-US; mso-bidi-language: AR-SA">=20
<BR></SPAN><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-fareast-font-family: =
'Times New Roman'; mso-ansi-language: EN-US; mso-fareast-language: =
EN-US; mso-bidi-language: AR-SA">#elif=20
defined(CONFIG_BOOKE)</SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Times New Roman'; =
mso-fareast-font-family: 'Times New Roman'; mso-ansi-language: EN-US; =
mso-fareast-language: EN-US; mso-bidi-language: AR-SA">=20
<BR></SPAN><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-fareast-font-family: =
'Times New Roman'; mso-ansi-language: EN-US; mso-fareast-language: =
EN-US; mso-bidi-language: AR-SA">#define=20
MSR_KERNEL (MSR_ME|MSR_RI|MSR_CE|<SPAN=20
style=3D"COLOR: red">MSR_DE)</SPAN></SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D156430622-01022008><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-fareast-font-family: =
'Times New Roman'; mso-ansi-language: EN-US; mso-fareast-language: =
EN-US; mso-bidi-language: AR-SA"><SPAN=20
style=3D"COLOR: red"></SPAN></SPAN></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D156430622-01022008><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-fareast-font-family: =
'Times New Roman'; mso-ansi-language: EN-US; mso-fareast-language: =
EN-US; mso-bidi-language: AR-SA"><SPAN=20
style=3D"COLOR: red"><SPAN class=3D359181022-01022008>However, I can see =
through=20
Jtag that the MSR_DE (the debug bit) is not set on the,=20
</SPAN></SPAN></SPAN></SPAN></DIV>
<DIV><SPAN class=3D156430622-01022008><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-fareast-font-family: =
'Times New Roman'; mso-ansi-language: EN-US; mso-fareast-language: =
EN-US; mso-bidi-language: AR-SA"><SPAN=20
style=3D"COLOR: red"><SPAN class=3D359181022-01022008>so I am not able =
to set break=20
points.</SPAN></SPAN></SPAN></SPAN></DIV>
<DIV><SPAN class=3D156430622-01022008><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-fareast-font-family: =
'Times New Roman'; mso-ansi-language: EN-US; mso-fareast-language: =
EN-US; mso-bidi-language: AR-SA"><SPAN=20
style=3D"COLOR: red"><SPAN=20
class=3D359181022-01022008></SPAN></SPAN></SPAN></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D156430622-01022008><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-fareast-font-family: =
'Times New Roman'; mso-ansi-language: EN-US; mso-fareast-language: =
EN-US; mso-bidi-language: AR-SA"><SPAN=20
style=3D"COLOR: red"><SPAN class=3D359181022-01022008>Any help greatly=20
appreciated.</SPAN></SPAN></SPAN></SPAN></DIV>
<DIV><SPAN class=3D156430622-01022008><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-fareast-font-family: =
'Times New Roman'; mso-ansi-language: EN-US; mso-fareast-language: =
EN-US; mso-bidi-language: AR-SA"><SPAN=20
style=3D"COLOR: red"><SPAN=20
class=3D359181022-01022008></SPAN></SPAN></SPAN></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D156430622-01022008><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-fareast-font-family: =
'Times New Roman'; mso-ansi-language: EN-US; mso-fareast-language: =
EN-US; mso-bidi-language: AR-SA"><SPAN=20
style=3D"COLOR: red"><SPAN=20
class=3D359181022-01022008>Regards,</SPAN></SPAN></SPAN></SPAN></DIV>
<DIV><SPAN class=3D156430622-01022008><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-fareast-font-family: =
'Times New Roman'; mso-ansi-language: EN-US; mso-fareast-language: =
EN-US; mso-bidi-language: AR-SA"><SPAN=20
style=3D"COLOR: red"><SPAN=20
class=3D359181022-01022008>Bizhan</SPAN></SPAN></SPAN></SPAN></DIV></FONT=
></DIV></BODY></HTML>

------_=_NextPart_001_01C86520.46BAAE8D--
