Return-Path: <kari.davidsson@marel.is>
Received: from mail.marel.com (mail.marel.com [213.167.134.96])
	by ozlabs.org (Postfix) with ESMTP id C350ADDF8B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Mar 2008 06:17:12 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C88606.4DD16BE0"
Subject: External interrupt type?
Date: Fri, 14 Mar 2008 19:05:36 -0000
Message-ID: <1205521536.28630.4.camel@marel2693>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kari.davidsson@marel.is>
To: <linuxppc-embedded@ozlabs.org>
Reply-To: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kari.davidsson@marel.com>
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

------_=_NextPart_001_01C88606.4DD16BE0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

I am dealing with external interrupts on an custom board of the
mpc5200b. Kernel is 2.6.24 from kernel.org.

I can declare the interrupt in the dts for the board and the=20
control register is set correctly, i.e. the correct external interrupt
is enabled.

On the other hand the type is ignored and is always level interrupt
active low.

Is this intended behaviour?
How can I pass in the interrupt type from the dts to the kernel?

I need to have the interrupt as edge interrupt, rising edge type?

rg
kd

------_=_NextPart_001_01C88606.4DD16BE0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>External interrupt type?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hello,<BR>
<BR>
I am dealing with external interrupts on an custom board of the<BR>
mpc5200b. Kernel is 2.6.24 from kernel.org.<BR>
<BR>
I can declare the interrupt in the dts for the board and the<BR>
control register is set correctly, i.e. the correct external =
interrupt<BR>
is enabled.<BR>
<BR>
On the other hand the type is ignored and is always level interrupt<BR>
active low.<BR>
<BR>
Is this intended behaviour?<BR>
How can I pass in the interrupt type from the dts to the kernel?<BR>
<BR>
I need to have the interrupt as edge interrupt, rising edge type?<BR>
<BR>
rg<BR>
kd<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C88606.4DD16BE0--
