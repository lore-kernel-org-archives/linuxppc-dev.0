Return-Path: <markc@mail.com>
Received: from relay04.roc.ny.frontiernet.net (relay04.roc.ny.frontiernet.net
	[66.133.182.167]) by ozlabs.org (Postfix) with ESMTP id 8F94D68957
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 Jan 2006 00:59:04 +1100 (EST)
Message-ID: <004201c612c6$ee3ede80$6601a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: <linuxppc-embedded@ozlabs.org>,
	<batsayan.das@tcs.com>
References: <OF114C07C5.7CED9F64-ON652570EE.00481B82-652570EE.00489CCF@tcs.com>
Date: Fri, 6 Jan 2006 08:41:41 -0500
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_003F_01C6129D.04601910"
Subject: Re: How to enable PHY
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

------=_NextPart_000_003F_01C6129D.04601910
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


>I found that ADS8260 board enables PHY by the following lines of code=20
>
>#ifndef CONFIG_ADS8260=20
>        /* Enable the PHY.=20
>        */=20
>        *(volatile uint *)(BCSR_ADDR + 4) &=3D ~BCSR1_FETHIEN;=20
>        *(volatile uint *)(BCSR_ADDR + 4) |=3D  BCSR1_FETH_RST;=20
>#endif=20
>
>Our board does not have BCSR. My question is how to enable PHY for =
MPC8260 based customs board without BCSR?=20

If your board does not have the BCSR you can just leave this code out.  =
Usually, you only need to configure which MDII=20
interface your PHY is connected to and which IRQ it uses.  But of course =
I don't know how your PHY is wired up on your
custom board.

Mark Chambers



------=_NextPart_000_003F_01C6129D.04601910
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1528" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff><FONT face=3DArial size=3D2></FONT>
<DIV><FONT face=3DArial size=3D2></FONT><BR><FONT face=3Dsans-serif =
size=3D2>&gt;I found=20
that ADS8260 board enables PHY by the following lines of code</FONT> =
<BR><FONT=20
face=3DArial size=3D2>&gt;</FONT><BR><FONT face=3Dsans-serif =
size=3D2>&gt;#ifndef=20
CONFIG_ADS8260</FONT> <BR><FONT face=3Dsans-serif size=3D2>&gt;&nbsp; =
&nbsp; &nbsp;=20
&nbsp; /* Enable the PHY.</FONT> <BR><FONT face=3Dsans-serif =
size=3D2>&gt;&nbsp;=20
&nbsp; &nbsp; &nbsp; */</FONT> <BR><FONT face=3Dsans-serif =
size=3D2>&gt;&nbsp;=20
&nbsp; &nbsp; &nbsp; *(volatile uint *)(BCSR_ADDR + 4) &amp;=3D=20
~BCSR1_FETHIEN;</FONT> <BR><FONT face=3Dsans-serif size=3D2>&gt;&nbsp; =
&nbsp; &nbsp;=20
&nbsp; *(volatile uint *)(BCSR_ADDR + 4) |=3D =
&nbsp;BCSR1_FETH_RST;</FONT>=20
<BR><FONT face=3Dsans-serif size=3D2>&gt;#endif</FONT> <BR><FONT =
face=3DArial=20
size=3D2>&gt;</FONT></DIV>
<DIV><FONT face=3Dsans-serif size=3D2>&gt;Our board does not have BCSR. =
My question=20
is how to enable PHY for MPC8260 based customs board without BCSR? =
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>If your board does not have the BCSR =
you can=20
just&nbsp;leave this code out.&nbsp; </FONT><FONT face=3DArial=20
size=3D2>Usually,&nbsp;</FONT><FONT face=3DArial size=3D2>you only need =
to configure=20
which MDII </FONT></DIV>
<DIV><FONT face=3DArial size=3D2>interface your PHY is&nbsp;</FONT><FONT =
face=3DArial=20
size=3D2>connected to and which IRQ it uses.&nbsp; But of course I don't =
know how=20
your PHY is wired up on your</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>custom board.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Mark Chambers</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT><FONT face=3DArial=20
size=3D2></FONT><BR><BR>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_003F_01C6129D.04601910--
