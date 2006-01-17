Return-Path: <Jose.Franca.Ext@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C61B9C.DFF0B982"
Subject: Linux-2.4.31 porting 
Date: Tue, 17 Jan 2006 19:33:21 -0000
Message-ID: <16FD2D70D281D44F9BFCF6ACF9B6117102AF6570@lisi053a.siemens.pt>
From: =?iso-8859-1?Q?Jose_Fran=E7a_=28Ext=5FGTBC=29?=
	<Jose.Franca.Ext@siemens.com>
To: <linuxppc-dev@ozlabs.org>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C61B9C.DFF0B982
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello u all!

	Have you already ported a linux-2.4.31 to be used on a PPC mpc8272 (or =
anyone from the family) based board?
	The problem that I have is that i don't have console. As far as i could =
debug, the kernel stucks on my_console_write (in =
arch/ppc/cpm2_io/uart.c), waiting for transmitter fifo to empty (line =
2298 - "while (bdp->cbd_sc & BD_SC_READY)").
	Any suggestions will be highly welcomed!



Thanks for reading!
Best regards,
Filipe.

------_=_NextPart_001_01C61B9C.DFF0B982
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.0.6487.1">
<TITLE>Linux-2.4.31 porting </TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Courier New">Hello u all!</FONT>
</P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Courier New">Have you already ported a linux-2.4.31 to be used =
on a PPC mpc8272 (or anyone from the family) based board?</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Courier New">The problem that I have is that i don't have =
console. As far as i could debug, the kernel stucks on my_console_write =
(in arch/ppc/cpm2_io/uart.c), waiting for transmitter fifo to empty =
(line 2298 - &quot;while (bdp-&gt;cbd_sc &amp; =
BD_SC_READY)&quot;).</FONT></P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Courier New">Any suggestions will be highly welcomed!</FONT>
</P>
<BR>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Thanks for reading!</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Best regards,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Filipe.</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C61B9C.DFF0B982--
