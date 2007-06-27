Return-Path: <bgholikh@cisco.com>
Received: from sj-iport-1.cisco.com (sj-iport-1-in.cisco.com [171.71.176.70])
	by ozlabs.org (Postfix) with ESMTP id CFE33DDF8B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jun 2007 07:41:20 +1000 (EST)
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-4.cisco.com (8.12.11/8.12.11) with ESMTP id l5RLfI1f013996
	for <linuxppc-embedded@ozlabs.org>; Wed, 27 Jun 2007 14:41:18 -0700
Received: from xbh-sjc-221.amer.cisco.com (xbh-sjc-221.cisco.com
	[128.107.191.63])
	by sj-core-2.cisco.com (8.12.10/8.12.6) with ESMTP id l5RLfIn0013742
	for <linuxppc-embedded@ozlabs.org>; Wed, 27 Jun 2007 21:41:18 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7B903.E4E2A6C4"
Subject: ARCH=ppc or ARCH=powerpc
Date: Wed, 27 Jun 2007 14:41:17 -0700
Message-ID: <F795765B112E7344AF36AA911279641502D1A42C@xmb-sjc-212.amer.cisco.com>
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

------_=_NextPart_001_01C7B903.E4E2A6C4
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,
Sorry for asking this question again, I am still not clear on some of
the issues.
Background:
We have developed a custom board based on Freescale reference board:
MPC8555_CDS with MPC8541E processor running Linux 2.6.11 and uboot 1.1.2
version.
=20
I would like to update the Linux kernel to the latest available kernel
2.6.21.
Here are my questions:
1- Should I use ARCH=3Dppc or ARCH=3Dpowerpc to build the kernel?
2- I have seen similar filenames under arch/ppc and arch/powerpc, which
one applies to MPC8541E?
3- Once I build the kernel, could I load the kernel with uboot version
1.1.2 or not? if not what I should do?
=20
Many thanks in advance,
Bizhan
=20

------_=_NextPart_001_01C7B903.E4E2A6C4
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1498" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D245352421-27062007>Hi=20
All,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D245352421-27062007>Sorry =
for asking=20
this question again, I am still not clear on some of the=20
issues.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D245352421-27062007>Background:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D245352421-27062007>We =
have developed=20
a&nbsp;custom board based on Freescale reference board: =
MPC8555_CDS&nbsp;with=20
MPC8541E processor running Linux 2.6.11 and uboot 1.1.2=20
version.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D245352421-27062007>&nbsp;</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D245352421-27062007>I =
would like to=20
update the Linux kernel to the latest available kernel=20
2.6.21.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D245352421-27062007>Here =
are my=20
questions:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D245352421-27062007>1- =
Should I use=20
ARCH=3Dppc or ARCH=3Dpowerpc to build the kernel?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D245352421-27062007>2- I =
have seen=20
similar filenames under arch/ppc and arch/powerpc, which one applies to=20
MPC8541E?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D245352421-27062007>3- =
Once I build the=20
kernel, could I load the kernel with uboot version 1.1.2 or not? if not =
what I=20
should do?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D245352421-27062007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D245352421-27062007>Many =
thanks in=20
advance,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D245352421-27062007>Bizhan</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D245352421-27062007></SPAN></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C7B903.E4E2A6C4--
