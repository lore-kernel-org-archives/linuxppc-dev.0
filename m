Return-Path: <Qi.W@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 7334567B7C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Oct 2006 22:49:37 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k9ICnZ5r019652 for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Oct 2006 05:49:35 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k9ICnWPh017372
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Oct 2006 07:49:34 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6F2B3.DB37C3E8"
Subject: About the RFI instruction on Linux Powerpc
Date: Wed, 18 Oct 2006 20:49:28 +0800
Message-ID: <54A124D27BDE0F449E2032F42ED617583197A6@zch01exm21.fsl.freescale.net>
From: "Wang Matthew-R59995" <Qi.W@freescale.com>
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

------_=_NextPart_001_01C6F2B3.DB37C3E8
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi folks,
=20
Currently I meet an issue about rfi instruction. Please see the
following source code. This source code is contained at the
head_fsl_booke.h of ./arch/powerpc/kernel directory.
=20
 xori r6,r4,1
 slwi r6,r6,5  /* setup new context with other address space */
 bl 1f  /* Find our address */
1: mflr r9
 rlwimi r7,r9,0,20,31
 addi r7,r7,24
 mtspr SPRN_SRR0,r7
 mtspr SPRN_SRR1,r6
 rfi

I found that rfi instruction can't jump to the address of SRR0. I take
the MPC8555CDS board to do those test. And I don't take U-Boot as
bootloader, while the Vxwerks Bootrom.
=20
I just want to try if Bootrom can bring up the Linux Powerpc kernel.
=20
Any suggestion for that?
=20
B.R
Wang Qi.
E-Mail: Qi.W@freescale.com <blocked::mailto:Qi.W@freescale.com>=20
=20
=20

------_=_NextPart_001_01C6F2B3.DB37C3E8
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2963" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D507434212-18102006>Hi=20
folks,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D507434212-18102006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D507434212-18102006>Currently I meet an=20
issue about rfi instruction. Please see the following source code. This =
source=20
code is contained at the head_fsl_booke.h of ./arch/powerpc/kernel=20
directory.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D507434212-18102006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D507434212-18102006>&nbsp;xori&nbsp;r6,r4,1<BR>&nbsp;slwi&nbsp;r6,=
r6,5&nbsp;&nbsp;/*=20
setup new context with other address space =
*/<BR>&nbsp;bl&nbsp;1f&nbsp;&nbsp;/*=20
Find our address=20
*/<BR>1:&nbsp;mflr&nbsp;r9<BR>&nbsp;rlwimi&nbsp;r7,r9,0,20,31<BR>&nbsp;ad=
di&nbsp;r7,r7,24<BR>&nbsp;mtspr&nbsp;SPRN_SRR0,r7<BR>&nbsp;mtspr&nbsp;SPR=
N_SRR1,r6<BR>&nbsp;rfi<BR></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D507434212-18102006>I =
found that rfi=20
instruction can't jump to the address of SRR0. I take the MPC8555CDS =
board to do=20
those test. And I don't take U-Boot as bootloader, while the Vxwerks=20
Bootrom.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D507434212-18102006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D507434212-18102006>I just =
want to try=20
if Bootrom can bring up the Linux Powerpc kernel.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D507434212-18102006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D507434212-18102006>Any =
suggestion for=20
that?</DIV></SPAN></FONT>
<DIV>&nbsp;</DIV>
<DIV align=3Dleft>
<DIV><SPAN class=3D535105723-09102006><FONT face=3DArial=20
size=3D2>B.R</FONT></SPAN></DIV>
<DIV><SPAN class=3D535105723-09102006><FONT face=3DArial size=3D2>Wang=20
Qi.</FONT></SPAN></DIV>
<DIV>
<DIV><SPAN class=3D535105723-09102006><FONT face=3DArial=20
size=3D2></FONT></SPAN></DIV><SPAN class=3D535105723-09102006><FONT =
face=3DArial=20
size=3D2>E-Mail: <A=20
href=3D"blocked::mailto:Qi.W@freescale.com">Qi.W@freescale.com</A></FONT>=
</SPAN></DIV>
<DIV><SPAN class=3D535105723-09102006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D535105723-09102006></SPAN><SPAN=20
class=3D535105723-09102006></SPAN></DIV></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C6F2B3.DB37C3E8--
