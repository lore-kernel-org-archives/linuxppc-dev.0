Return-Path: <miteshnet@hotmail.com>
Received: from bay0-omc1-s10.bay0.hotmail.com (bay0-omc1-s10.bay0.hotmail.com
	[65.54.246.82]) by ozlabs.org (Postfix) with ESMTP id 4E1B2DDEE4
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 08:01:00 +1000 (EST)
Message-ID: <BAY124-DS64841966FB45DC23C85E2BE5E0@phx.gbl>
From: "Mitesh" <miteshnet@hotmail.com>
To: <linuxppc-dev@ozlabs.org>
Subject: loading values of global variables in assembler files 
Date: Wed, 3 Sep 2008 15:56:26 -0600
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0615_01C90DDD.9EF52810"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0615_01C90DDD.9EF52810
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable


I am trying to accomplish the following:=20


1) load base address of paca into a register=20

2) and value of a global variable that I have defined in another file, I =
have called it mitesh0_prio, this value is not a constant and can be =
changed by the user at runtime via the proc interface.=20


I have a POWER5 based p550 system with linux 2.6.16 ppc64 , and the =
additions are being made in head_64.S and entry_64.S assembly files



Thanks


------=_NextPart_000_0615_01C90DDD.9EF52810
Content-Type: text/html;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type =
content=3Dtext/html;charset=3DWindows-1252>
<META content=3D"MSHTML 6.00.6000.16705" name=3DGENERATOR></HEAD>
<BODY id=3DMailContainerBody=20
style=3D"PADDING-RIGHT: 10px; PADDING-LEFT: 10px; PADDING-TOP: 15px"=20
bgColor=3D#ffffff leftMargin=3D0 topMargin=3D0 CanvasTabStop=3D"true"=20
name=3D"Compose message area">
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I am trying to accomplish the =
following:=20
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>1) load base address of paca into a =
register=20
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>2) and value of a global variable that =
I have=20
defined in another file, I have called it mitesh0_prio, this value is =
not a=20
constant and can be changed by the user at runtime via the proc =
interface.=20
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have a POWER5 based p550 system with =
linux 2.6.16=20
ppc64 , and the additions are being made in head_64.S and entry_64.S =
assembly=20
files</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0615_01C90DDD.9EF52810--
