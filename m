Return-Path: <Bjorn.Ostby@combitechsystems.com>
Received: from ms-101.aerotechtelub.se (ms-101.aerotechtelub.se
	[192.176.33.163]) by ozlabs.org (Postfix) with ESMTP id 886EB67A89
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Mar 2005 22:05:23 +1100 (EST)
Received: from ratatosk.combitechsystems.com (unverified) by
	ms-101.aerotechtelub.se (Clearswift SMTPRS 5.0.4) with ESMTP id
	<T6f895075adc0b021a1fd8@ms-101.aerotechtelub.se> for
	<linuxppc-embedded@ozlabs.org>; Mon, 7 Mar 2005 12:05:21 +0100
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C52305.1F6077D0"
Date: Mon, 7 Mar 2005 12:02:15 +0100
Message-ID: <004B1D7A5257174C9044A1B7BD0E60ED0178CBF5@ratatosk.combitechsystems.com>
From: =?iso-8859-1?B?Qmr2cm4g1nN0Ynk=?= <Bjorn.Ostby@combitechsystems.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Read TCN-register in user space
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

------_=_NextPart_001_01C52305.1F6077D0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I'm currently using ELDK 3.0 (kernel 2.4.25) and a mpc823e trying to do =
some latency measurements for my final thesis project.

I'm wondering if there is any possibility to read the Timer Counter =
Register (TCN1) in user space. I have initially used gettimeofday(), =
which provides sufficient resolution (usec), but I suppose that solution =
probably adds on some kind of unknown context-switch latency. Does =
anyone have a clue on how to access this in user space? Could inline =
assembler or perhaps mmap() do the trick (I'm using C as programming =
language)?.


Regards,
Bjorn=20





------_=_NextPart_001_01C52305.1F6077D0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.0.6249.1">
<TITLE>Read TCN-register in user space</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">I'm currently using =
ELDK 3.0 (kernel 2.4.25) and a mpc823e trying to do some latency =
measurements for my final thesis project.</FONT></SPAN></P>

<P><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">I'm wondering if =
there is any possibility to read the Timer Counter Register (TCN1) in =
user space. I have initially used gettimeofday(), which provides =
sufficient resolution (usec), but I suppose that solution probably adds =
on some kind of unknown context-switch latency. Does anyone have a clue =
on how to access this in user space? Could inline assembler or perhaps =
mmap() do the trick (I'm using C as programming =
language)?.</FONT></SPAN></P>
<BR>

<P><SPAN LANG=3D"sv"><FONT SIZE=3D2 =
FACE=3D"Arial">Regards,</FONT></SPAN>

<BR><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">Bjorn </FONT></SPAN>
</P>
<BR>
<BR>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C52305.1F6077D0--
