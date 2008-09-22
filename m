Return-Path: <mmeswani@miners.utep.edu>
Received: from blu0-omc4-s4.blu0.hotmail.com (blu0-omc4-s4.blu0.hotmail.com
	[65.55.111.143]) by ozlabs.org (Postfix) with ESMTP id ADA54DDE0D
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 04:15:51 +1000 (EST)
Message-ID: <BLU103-DS7C4EEE573B423B715F520934B0@phx.gbl>
From: "Mitesh R. Meswani" <mmeswani@miners.utep.edu>
To: <linuxppc-dev@ozlabs.org>
Subject: Problems with macros LOAD_REG_ADDR and LOAD_REG_IMMEDIATE 
Date: Mon, 22 Sep 2008 12:16:50 -0600
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00C0_01C91CAD.177F2BE0"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_00C0_01C91CAD.177F2BE0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I am having issues using LOAD_REG_ADDR and LOAD_REG_IMMEDIATE macros on =
a ppc64 kernel which I have tried on both 2.6.16 and 2.6.17 kernels.=20

I noticed that these macros by default loading value 0 instead of the =
actual address. Is this a bug of the compiler that can be fixed, I =
noticed when I did objdump for head_64.S on the following function=20
_GLOBAL(pSeries_secondary_smp_init) for the following instruction : =
LOAD_REG_IMMEDIATE(r13, paca)   /* Get base vaddr of paca array  */    I =
noticed this in some calls, whereas some calls seem to get symbol =
address.   Thanks =
*************************************************************************=
******       =20
Mitesh Meswani
"Success is a journey, Not a Destination "
Email : miteshnet@hotmail.com
*************************************************************************=
*****

************************************************
Mitesh R. Meswani
Research Associate
AHPCRC Research Group
Ph.D. Candidate
Department of Computer Science
University of Texas at El Paso
Tel: 915 747 6433 (O)
Email: mmeswani@miners.utep.edu
************************************************
 
------=_NextPart_000_00C0_01C91CAD.177F2BE0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type =
content=3Dtext/html;charset=3Diso-8859-1>
<META content=3D"MSHTML 6.00.6000.16705" name=3DGENERATOR></HEAD>
<BODY id=3DMailContainerBody=20
style=3D"PADDING-RIGHT: 10px; PADDING-LEFT: 10px; PADDING-TOP: 15px"=20
bgColor=3D#ffffff leftMargin=3D0 topMargin=3D0 CanvasTabStop=3D"true"=20
name=3D"Compose message area">
<DIV><FONT face=3DArial size=3D2>I am having issues using LOAD_REG_ADDR =
and=20
LOAD_REG_IMMEDIATE macros on a ppc64 kernel which I have tried on both =
2.6.16=20
and 2.6.17 kernels. </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I noticed that these macros by default =
loading=20
value 0 instead of the actual address. Is this a bug of the compiler =
that can be=20
fixed, I noticed when I did objdump for head_64.S on the following =
function=20
<SPAN class=3DApple-style-span=20
style=3D"WORD-SPACING: 0px; FONT: 16px -webkit-sans-serif; =
TEXT-TRANSFORM: none; COLOR: rgb(0,0,0); TEXT-INDENT: 0px; WHITE-SPACE: =
normal; LETTER-SPACING: normal; BORDER-COLLAPSE: separate; orphans: 2; =
widows: 2; -webkit-border-horizontal-spacing: 0px; =
-webkit-border-vertical-spacing: 0px; =
-webkit-text-decorations-in-effect: none; -webkit-text-size-adjust: =
auto; -webkit-text-stroke-width: 0"><PRE class=3Ddone =
style=3D"MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; PADDING-BOTTOM: 0px; =
MARGIN-LEFT: 0px; PADDING-TOP: 0px">_GLOBAL(pSeries_secondary_smp_init) =
for the following instruction :</PRE><PRE class=3Ddone =
style=3D"MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; PADDING-BOTTOM: 0px; =
MARGIN-LEFT: 0px; PADDING-TOP: 0px"><SPAN class=3DApple-style-span =
style=3D"WORD-SPACING: 0px; FONT: 16px -webkit-sans-serif; =
TEXT-TRANSFORM: none; COLOR: rgb(0,0,0); TEXT-INDENT: 0px; WHITE-SPACE: =
normal; LETTER-SPACING: normal; BORDER-COLLAPSE: separate; orphans: 2; =
widows: 2; -webkit-border-horizontal-spacing: 0px; =
-webkit-border-vertical-spacing: 0px; =
-webkit-text-decorations-in-effect: none; -webkit-text-size-adjust: =
auto; -webkit-text-stroke-width: 0"> LOAD_REG_IMMEDIATE(r13, paca)   /* =
Get base vaddr of paca array  */   </PRE><PRE class=3Ddone =
style=3D"MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; PADDING-BOTTOM: 0px; =
MARGIN-LEFT: 0px; PADDING-TOP: 0px">&nbsp;</PRE><PRE class=3Ddone =
style=3D"MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; PADDING-BOTTOM: 0px; =
MARGIN-LEFT: 0px; PADDING-TOP: 0px">I noticed this in some calls, =
whereas some calls seem to get symbol address. </PRE><PRE class=3Ddone =
style=3D"MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; PADDING-BOTTOM: 0px; =
MARGIN-LEFT: 0px; PADDING-TOP: 0px">&nbsp;</PRE><PRE class=3Ddone =
style=3D"MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; PADDING-BOTTOM: 0px; =
MARGIN-LEFT: 0px; PADDING-TOP: 0px">&nbsp;</PRE><PRE class=3Ddone =
style=3D"MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; PADDING-BOTTOM: 0px; =
MARGIN-LEFT: 0px; PADDING-TOP: 0px">Thanks</PRE><PRE class=3Ddone =
style=3D"MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; PADDING-BOTTOM: 0px; =
MARGIN-LEFT: 0px; PADDING-TOP: =
0px">&nbsp;</PRE></SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial=20
size=3D2>****************************************************************=
***************&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR>Mitesh Meswani<BR>"Success is a journey, Not a Destination =
"<BR>Email : <A=20
href=3D"wlmailhtml:{A6755B07-F4DC-48AF-A850-22AFF26BDE9D}mid://00000166/!=
x-usc:mailto:miteshnet@hotmail.com">miteshnet@hotmail.com</A><BR>********=
**********************************************************************</F=
ONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial=20
size=3D2>************************************************<BR>Mitesh R.=20
Meswani<BR>Research Associate<BR>AHPCRC Research Group<BR>Ph.D.=20
Candidate<BR>Department of Computer Science<BR>University of Texas at El =

Paso<BR>Tel: 915 747 6433 (O)<BR>Email: <A=20
href=3D"mailto:mmeswani@miners.utep.edu">mmeswani@miners.utep.edu</A><BR>=
************************************************<BR>&nbsp;</FONT></DIV></=
BODY></HTML>

------=_NextPart_000_00C0_01C91CAD.177F2BE0--
