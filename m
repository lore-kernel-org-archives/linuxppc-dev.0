Return-Path: <miteshnet@hotmail.com>
Received: from bay0-omc1-s6.bay0.hotmail.com (bay0-omc1-s6.bay0.hotmail.com
	[65.54.246.78]) by ozlabs.org (Postfix) with ESMTP id A5743DE040
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 07:13:02 +1000 (EST)
Message-ID: <BAY124-DS415CCF7A303D59AD03437BEA10@phx.gbl>
From: "Mitesh" <miteshnet@hotmail.com>
To: <linuxppc-dev@ozlabs.org>
Subject: Exit points for returning from kernel mode to user mode
Date: Tue, 24 Jun 2008 15:22:01 -0600
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0144_01C8D60E.0CDD8730"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0144_01C8D60E.0CDD8730
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

 I am trying to understand exit points from kernel mode to user mode. I =
believe this happens when the scheduler is invoked, there are =
interrupts, exceptions, or the kernel is executing system call in =
process context.=20

Is there a single function which is called in the ppc kernel when the =
mode is switched back to user mode ?=20

I have linux 2.6.16.21 kernel running on a 4-way p550 IBM pSeries with =
POWER5 processors. Everytime before a process begins executing in user =
mode I want to execute a special SMT thread priority assembler =
instruction.=20

What code files should I be looking at, is there one place this can be =
done? Any tips are appreciated.
------=_NextPart_000_0144_01C8D60E.0CDD8730
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type =
content=3Dtext/html;charset=3Diso-8859-1>
<META content=3D"MSHTML 6.00.6000.16674" name=3DGENERATOR></HEAD>
<BODY id=3DMailContainerBody=20
style=3D"PADDING-RIGHT: 10px; PADDING-LEFT: 10px; PADDING-TOP: 15px"=20
bgColor=3D#ffffff leftMargin=3D0 topMargin=3D0 CanvasTabStop=3D"true"=20
name=3D"Compose message area">
<DIV><FONT face=3DArial size=3D2>&nbsp;I am trying to understand exit =
points from=20
kernel mode to user mode. I believe this happens when the scheduler is =
invoked,=20
there are interrupts, exceptions, or the kernel is executing system call =
in=20
process context.=20
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Is there a single function which is =
called in the=20
ppc kernel when the mode is switched back to user mode ? </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have linux 2.6.16.21 kernel running =
on&nbsp;a=20
4-way p550 IBM pSeries with POWER5 processors. Everytime before a =
process begins=20
executing in user mode I want to&nbsp;execute a special SMT thread =
priority=20
assembler instruction. </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>What code files should I be looking at, =
is there=20
one place this can be done? Any tips are=20
appreciated.</FONT></DIV></FONT></DIV></BODY></HTML>

------=_NextPart_000_0144_01C8D60E.0CDD8730--
