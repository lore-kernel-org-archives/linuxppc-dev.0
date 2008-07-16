Return-Path: <duykynguyen@hotmail.com>
Received: from bay0-omc1-s32.bay0.hotmail.com (bay0-omc1-s32.bay0.hotmail.com
	[65.54.246.104]) by ozlabs.org (Postfix) with ESMTP id 059C0DDF28
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Jul 2008 11:03:41 +1000 (EST)
Message-ID: <BLU119-DAV11096F9EACC27956DCC87BBB8F0@phx.gbl>
From: "Duy-Ky Nguyen" <duykynguyen@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Failure of request_irq()  for MPC8313 using arch=powerpc
Date: Tue, 15 Jul 2008 17:58:34 -0700
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0060_01C8E6A4.662A1C80"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0060_01C8E6A4.662A1C80
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

I had no problem in using request_irq() for MPC8272 with arch=3Dppc from =
Montavista Linux

But I have failure for MPC8313 with arch=3Dpowerpc from FreeScale LTIB =
Linux with error code -38

I found its header file mpc83xx.h under include/asm-ppc, while it's =
supposed to be under include/asm-powerpc.

I did try to copy the header file to directory asm-powerpc

>From MPC8313 datasheet, I have=20

GPIO_IRQ =3D 74

and I use

DEVICE_NAME =3D "ppc"
IRQ_FLAG =3D IRQF_SHARED    // use new flag
here my function call

request_irq (GPIO_IRQ,
      ppc_ISR, =20
      IRQ_FLAG,
      DEVICE_NAME,  =20
      NULL);  =20

I'd appreciate any help on this problem.

Best Regards,

Duy-Kyng


------=_NextPart_000_0060_01C8E6A4.662A1C80
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.6000.16587" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hello,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I had no problem in using request_irq() =
for MPC8272=20
with arch=3Dppc from Montavista Linux</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>But I have failure for MPC8313 with =
arch=3Dpowerpc=20
from FreeScale LTIB Linux with error code -38</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I found its header file mpc83xx.h under =

include/asm-ppc, while it's supposed to be under=20
include/asm-powerpc.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I did try to copy the header file to =
directory=20
asm-powerpc</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>From MPC8313 datasheet, I have =
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>GPIO_IRQ =3D 74</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>and I use</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>DEVICE_NAME =3D "ppc"</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>IRQ_FLAG =3D =
IRQF_SHARED&nbsp;&nbsp;&nbsp; // use new=20
flag</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>here my function call</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>request_irq (GPIO_IRQ,</FONT></DIV>
<DIV><FONT face=3DArial=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ppc_ISR,&nbsp;&nbsp;</FONT><=
/DIV>
<DIV><FONT face=3DArial=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;IRQ_FLAG,<BR>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;DEVICE_NAME,&nbsp;&nbsp;&nbsp;<BR>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;NULL);&nbsp;&nbsp;&nbsp;<BR></FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I'd appreciate any help on this=20
problem.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Best Regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Duy-Kyng</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;</DIV></FONT>
<DIV><FONT face=3DArial size=3D2>&nbsp;</DIV></FONT></BODY></HTML>

------=_NextPart_000_0060_01C8E6A4.662A1C80--
