Return-Path: <matias.sundman@ericsson.com>
Received: from mailgw4.ericsson.se (mailgw4.ericsson.se [193.180.251.62])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 205DDDDE3B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Sep 2007 18:41:16 +1000 (EST)
Received: from mailgw4.ericsson.se (unknown [127.0.0.1])
	by mailgw4.ericsson.se (Symantec Mail Security) with ESMTP id
	1458C21164 for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Sep 2007 10:19:24 +0200 (CEST)
Received: from esealmw129.eemea.ericsson.se (unknown [153.88.254.124])
	by mailgw4.ericsson.se (Symantec Mail Security) with ESMTP id
	EEC9A210D0 for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Sep 2007 10:19:23 +0200 (CEST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7FB5E.F3698AD2"
Subject: 8270 & Watchdog - early start
Date: Thu, 20 Sep 2007 10:19:22 +0200
Message-ID: <AEA1A32F001C6B4F98614B5B80D7647D02D73DEB@esealmw115.eemea.ericsson.se>
From: "Matias Sundman" <matias.sundman@ericsson.com>
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

------_=_NextPart_001_01C7FB5E.F3698AD2
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi,
I have a custom MPC8270 board running Linux and u-boot.
Now, I enabled the watchdog on the 8270 and need to kick it regularly by
writing ;

0x556c
0xaa39

To the internal register @ 0x0x1000e.

When I am coming out from head.S to start_kernel I was thinking of
kicking
it a couple times "manually"
before a timer interrupt is inserted which will take care of it until a
"superdaemon" is taking over.

I tried to serve the register as follows;


*((volatile unsigned int*)(0xf001000e))=3D0x556c;
*((volatile unsigned int*)(0xf001000e))=3D0xaa39;

But it does not take effect. I thought that since u-boot had set up the
IMMR
to 0xf000'0000 I could
directly write to the register as above.


Any clues why this does not work?


Thx // Matias


------_=_NextPart_001_01C7FB5E.F3698AD2
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>8270 &amp; Watchdog - early start</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->
<BR>

<P><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Hi,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">I have a custom MPC8270 board =
running Linux and u-boot.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Now, I enabled the watchdog on =
the 8270 and need to kick it regularly by</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">writing ;</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Comic Sans MS">0x556c</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">0xaa39</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Comic Sans MS">To the internal register @ =
0x0x1000e.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Comic Sans MS">When I am coming out from =
head.S to start_kernel I was thinking of kicking</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">it a couple times =
&quot;manually&quot;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">before a timer interrupt is =
inserted which will take care of it until a</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">&quot;superdaemon&quot; is =
taking over.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Comic Sans MS">I tried to serve the register =
as follows;</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Comic Sans MS">*((volatile unsigned =
int*)(0xf001000e))=3D0x556c;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">*((volatile unsigned =
int*)(0xf001000e))=3D0xaa39;</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Comic Sans MS">But it does not take effect. I =
thought that since u-boot had set up the IMMR</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">to 0xf000'0000 I could</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">directly write to the register =
as above.</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Any clues why this does not =
work?</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Thx // Matias</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C7FB5E.F3698AD2--
