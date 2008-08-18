Return-Path: <mmeswani@miners.utep.edu>
Received: from blu0-omc4-s20.blu0.hotmail.com (blu0-omc4-s20.blu0.hotmail.com
	[65.55.111.159]) by ozlabs.org (Postfix) with ESMTP id 3EE08DE111
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 09:38:26 +1000 (EST)
Message-ID: <BLU103-DS41DBE50328F80B52EA442936E0@phx.gbl>
From: "Mitesh R. Meswani" <mmeswani@miners.utep.edu>
To: <linuxppc-dev@ozlabs.org>
Subject: Finding cpuid in entry_64.S
Date: Mon, 18 Aug 2008 17:33:26 -0600
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0128_01C90158.855CEFA0"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0128_01C90158.855CEFA0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello=20

I am trying to find the cpuid when the functions that handle return from =
context switch and interrupts are called, based on the cpu the return =
code is executing on, I want to take some specific actions.=20

I have been trying to use the following code segments :
        LOAD_REG_IMMEDIATE(r13, paca)   /* Get base vaddr of paca array  =
*/
        lhz     r6,PACAHWCPUID(r13)     /* Load HW procid from paca      =
*/
        cmpwi   0,r6,7                  /* Compare to our id             =
*/


My kernel is 2.6.16.21
and I am inserting the above code segments in the file entry_64.S in the =
following functions:=20
_switch
return from system calls, and=20
_ret_from_except

I can give line #s and the modified file itself.=20


The problem is my kernel does not boot and halts at the point where it =
reads the command line boot parameters. Any help would be appreciated .=20


Thanks,=20
Mitesh=20

------=_NextPart_000_0128_01C90158.855CEFA0
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
<DIV><FONT face=3DArial size=3D2>Hello </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I am trying to find the cpuid when the =
functions=20
that handle return from context switch and interrupts are called, based =
on the=20
cpu the return code is executing on, I want to take some specific =
actions.=20
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have been trying to use the following =
code=20
segments :</FONT></DIV>
<DIV><FONT face=3DArial =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
LOAD_REG_IMMEDIATE(r13, paca)&nbsp;&nbsp; /* Get base vaddr of paca =
array&nbsp;=20
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
lhz&nbsp;&nbsp;&nbsp;&nbsp;=20
r6,PACAHWCPUID(r13)&nbsp;&nbsp;&nbsp;&nbsp; /* Load HW procid from=20
paca&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmpwi&nbsp;&nbsp;=20
0,r6,7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
/* Compare to our=20
id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;=20
*/<BR></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>My kernel is 2.6.16.21</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>and I am inserting the above code =
segments in the=20
file entry_64.S in the following functions: </FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2>_switch</FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2>return from system calls, and=20
</FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT =
size=3D2>_ret_from_except</FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT size=3D2>I can give line #s and the =
modified file=20
itself. </FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT size=3D2></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT size=3D2>The problem is my kernel does not =
boot and=20
halts at the point where it reads the command line boot parameters. Any =
help=20
would be appreciated . </FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT size=3D2></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT size=3D2>Thanks, </FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2>Mitesh =
</FONT><FONT></DIV></FONT></FONT>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0128_01C90158.855CEFA0--
