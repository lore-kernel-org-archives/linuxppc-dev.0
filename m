Return-Path: <Marc.Howard@KLA-Tencor.com>
Received: from ca1xpr03.adcorp.kla-tencor.com (mailout02.kla-tencor.com
	[192.146.1.172]) by ozlabs.org (Postfix) with SMTP id D433E2BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Nov 2004 13:33:59 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-6c4946bd-e9c6-430e-891a-d3ea73920fc1"
Date: Thu, 11 Nov 2004 18:19:02 -0800
Message-ID: <91B22F93A880FA48879475E134D6F0BE283EBD@CA1EXCLV02.adcorp.kla-tencor.com>
From: "Howard, Marc" <Marc.Howard@KLA-Tencor.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Trouble booting uboot on 440GX (ocotea) eval board after initial
	power-up boot
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

------=_NextPartTM-000-6c4946bd-e9c6-430e-891a-d3ea73920fc1
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4C85D.F6D1935D"

------_=_NextPart_001_01C4C85D.F6D1935D
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I've built and installed U-Boot 1.1.2 on an IBM 440GX eval board
(ocotea).  After powering the board I can get the uboot interactive
prompt.  If I type 'reset' or hit the reset button it hangs.  I get the
same results whether or not I use the BDI2000.  Doing a power cycle of
the board is the only way to get back to the prompt.

Is there some reconfiguation U-Boot does that causes the processor boot
address to change after the initial power-up?  Am I missing something
here?

Thanks,

Marc W. Howard



------_=_NextPart_001_01C4C85D.F6D1935D
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7226.0">
<TITLE>Trouble booting uboot on 440GX (ocotea) eval board after initial =
power-up boot</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I've built and installed U-Boot 1.1.2 =
on an IBM 440GX eval board (ocotea).&nbsp; After powering the board I =
can get the uboot interactive prompt.&nbsp; If I type 'reset' or hit the =
reset button it hangs.&nbsp; I get the same results whether or not I use =
the BDI2000.&nbsp; Doing a power cycle of the board is the only way to =
get back to the prompt.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Is there some reconfiguation U-Boot =
does that causes the processor boot address to change after the initial =
power-up?&nbsp; Am I missing something here?</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Marc W. Howard</FONT>
</P>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C4C85D.F6D1935D--

------=_NextPartTM-000-6c4946bd-e9c6-430e-891a-d3ea73920fc1--
