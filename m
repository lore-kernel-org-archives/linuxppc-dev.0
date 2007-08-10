Return-Path: <bgholikh@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	by ozlabs.org (Postfix) with ESMTP id 2C288DDEA0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Aug 2007 22:18:01 +1000 (EST)
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id l7AC8Bct025338
	for <linuxppc-embedded@ozlabs.org>; Fri, 10 Aug 2007 05:08:11 -0700
Received: from xbh-sjc-221.amer.cisco.com (xbh-sjc-221.cisco.com
	[128.107.191.63])
	by sj-core-1.cisco.com (8.12.10/8.12.6) with ESMTP id l7AC8BF4022389
	for <linuxppc-embedded@ozlabs.org>; Fri, 10 Aug 2007 12:08:11 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7DB47.1EC3F6E8"
Subject: Unwinding stack frame
Date: Fri, 10 Aug 2007 05:08:10 -0700
Message-ID: <F795765B112E7344AF36AA911279641502D1A57F@xmb-sjc-212.amer.cisco.com>
From: "Bizhan Gholikhamseh \(bgholikh\)" <bgholikh@cisco.com>
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

------_=_NextPart_001_01C7DB47.1EC3F6E8
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
We are using MPC 8541 processor. Running Linux 2.6.11.
=20
I have a question regarding unwinding stack frame in userland.
=20
To understand the stack frame format, I am using gdb to walk through
nested function calls frame.
I am not able to understand where the PC (program counter) of callee
functions is saved on the stack/register.
=20
Here are my questions:
1- Is there any available software like "pstack" ported to powerpc that
I can use?
I know the stack pointer of  the last frame is save in "R1" register.
2- How about PC, and number of the input parameters to the function.
=20
Many thanks in advance,
BZ

------_=_NextPart_001_01C7DB47.1EC3F6E8
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1498" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D204555411-10082007>Hi,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D204555411-10082007>We are =
using MPC=20
8541 processor. Running Linux 2.6.11.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D204555411-10082007>I have =
a question=20
regarding unwinding stack frame in userland.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D204555411-10082007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D204555411-10082007>To =
understand the=20
stack frame format, I am using gdb to walk through nested function calls =

frame.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D204555411-10082007>I am =
not able to=20
understand&nbsp;where the PC (program counter) of callee =
functions&nbsp;is saved=20
on the stack/register.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D204555411-10082007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D204555411-10082007>Here =
are my=20
questions:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D204555411-10082007><SPAN=20
class=3D204555411-10082007>1- Is there any available software like =
"pstack" ported=20
to powerpc that I can use?</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D204555411-10082007><SPAN=20
class=3D204555411-10082007>I know the stack pointer&nbsp;of &nbsp;the =
last frame=20
is save in "R1" register.</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D204555411-10082007><SPAN=20
class=3D204555411-10082007>2- How about PC, and number of the input =
parameters to=20
the function.</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D204555411-10082007><SPAN=20
class=3D204555411-10082007></SPAN></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D204555411-10082007><SPAN=20
class=3D204555411-10082007>Many thanks in =
advance,</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D204555411-10082007><SPAN=20
class=3D204555411-10082007>BZ</SPAN></SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C7DB47.1EC3F6E8--
