Return-Path: <bgholikh@cisco.com>
Received: from sj-iport-1.cisco.com (sj-iport-1-in.cisco.com [171.71.176.70])
	by ozlabs.org (Postfix) with ESMTP id 1C24B67A0E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Jun 2006 04:36:04 +1000 (EST)
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-3.cisco.com (8.12.11/8.12.11) with ESMTP id k5QIQ78D004904
	for <linuxppc-embedded@ozlabs.org>; Mon, 26 Jun 2006 11:26:07 -0700
Received: from xbh-sjc-211.amer.cisco.com (xbh-sjc-211.cisco.com
	[171.70.151.144])
	by sj-core-2.cisco.com (8.12.10/8.12.6) with ESMTP id k5QIQ0lG017756
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Jun 2006 11:26:07 -0700 (PDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6994D.FAF3839E"
Subject: zero-copy support on TSEC?
Date: Mon, 26 Jun 2006 11:26:02 -0700
Message-ID: <F795765B112E7344AF36AA9112796415019ED1C6@xmb-sjc-212.amer.cisco.com>
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

------_=_NextPart_001_01C6994D.FAF3839E
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi ALL,
We have developed a custom board mother board based on
MPC8541 processor running Linux 2.6.11.
=20
In our system, most of the ingress UDP packets  are retransmitted
with one modification to data portion of the packet (one byte). As you=20
see there are many copy overhead due to copy from system to userland=20
and vise versa which has impacted our system performance.=20
=20
Is there a zero-copy support for TSEC=20
to eliminate the buffer copy from kernel to userland and vise versa?
=20
Are there any other technique that we need to do to eliminate packet
coping?
=20
Many thanks in advance,
Bizhan

------_=_NextPart_001_01C6994D.FAF3839E
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1498" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D268331218-26062006>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D284292418-13092005>Hi=20
ALL,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D284292418-13092005>We&nbsp;<SPAN=20
class=3D268331218-26062006>have</SPAN> develop<SPAN=20
class=3D268331218-26062006>ed</SPAN> a custom board mother board based=20
on</SPAN></FONT></DIV>
<DIV><SPAN class=3D284292418-13092005><FONT face=3DArial><FONT =
size=3D2>MPC8541=20
processor&nbsp;<SPAN class=3D268331218-26062006>running</SPAN> Linux =
2.6.11<SPAN=20
class=3D268331218-26062006>.</SPAN></FONT></FONT></SPAN></DIV>
<DIV><SPAN class=3D284292418-13092005><FONT face=3DArial><FONT =
size=3D2><SPAN=20
class=3D268331218-26062006></SPAN></FONT></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D284292418-13092005><FONT size=3D2><SPAN=20
class=3D268331218-26062006>In our system,&nbsp;most of&nbsp;the ingress =
UDP=20
packets&nbsp; are retransmitted</SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D284292418-13092005><FONT size=3D2><SPAN=20
class=3D268331218-26062006>with one modification to data portion of the =
packet=20
(one byte). As you </SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D284292418-13092005><FONT size=3D2><SPAN=20
class=3D268331218-26062006>see there are many copy overhead due to copy =
from=20
system to userland </SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D284292418-13092005><FONT size=3D2><SPAN=20
class=3D268331218-26062006>and vise versa which has =
</SPAN></FONT></SPAN><SPAN=20
class=3D284292418-13092005><FONT size=3D2><SPAN =
class=3D268331218-26062006>impacted=20
our system performance. </SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D284292418-13092005><FONT size=3D2><SPAN=20
class=3D268331218-26062006></SPAN></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D284292418-13092005><FONT size=3D2><SPAN=20
class=3D268331218-26062006>Is there a zero-copy support for TSEC=20
</SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D284292418-13092005><FONT size=3D2><SPAN=20
class=3D268331218-26062006>to eliminate the buffer copy from kernel to =
userland=20
and vise versa?</SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D284292418-13092005><FONT size=3D2><SPAN=20
class=3D268331218-26062006></SPAN></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D284292418-13092005><FONT size=3D2><SPAN=20
class=3D268331218-26062006>Are there any other technique that we need to =
do to=20
eliminate packet</SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D284292418-13092005><FONT size=3D2><SPAN=20
class=3D268331218-26062006>coping?</SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D284292418-13092005><FONT size=3D2><SPAN=20
class=3D268331218-26062006></SPAN></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D284292418-13092005><FONT size=3D2><SPAN=20
class=3D268331218-26062006>Many thanks in =
advance,</SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D284292418-13092005><FONT size=3D2><SPAN=20
class=3D268331218-26062006>Bizhan</SPAN></FONT></SPAN></DIV></SPAN></DIV>=
</BODY></HTML>

------_=_NextPart_001_01C6994D.FAF3839E--
