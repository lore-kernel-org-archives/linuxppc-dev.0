Return-Path: <jay_chen@alphanetworks.com>
Received: from Sweeper2.alphanetworks.com (sweeper2.alphanetworks.com
	[210.202.42.140]) by ozlabs.org (Postfix) with ESMTP id C6B88DDEED
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Jun 2008 13:08:01 +1000 (EST)
From: "jay_chen" <jay_chen@alphanetworks.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: move kernel virtual base
Date: Fri, 6 Jun 2008 10:52:20 +0800
Message-ID: <21AEE3D91E624CAC8D489201712AAB54@alphajay>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0205_01C8C7C3.67D854C0"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0205_01C8C7C3.67D854C0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="us-ascii"

Hi:
 
I am using mpc8548 and linux 2.6.14.5
For some reasons, I would like to move kernel virtua base from 0xC0000000 to
0x60000000.
But I encounter many problems. (I am still trying to figure out where is the
true problem)
Does anyone know any possible problem? Any clue is welcome.
Thanks a lot.
 
I tried to move it to 0xA0000000 before. It worked fine.
 
 
                   Jay...
 
 

------=_NextPart_000_0205_01C8C7C3.67D854C0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset="us-ascii"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.6000.16640" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN=20
class=3D812344502-06062008>Hi:</SPAN></FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN=20
class=3D812344502-06062008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN =
class=3D812344502-06062008>I am using mpc8548=20
and linux 2.6.14.5</SPAN></FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN =
class=3D812344502-06062008>For some reasons, I=20
would like to move kernel virtua base from 0xC0000000 to=20
0x60000000.</SPAN></FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN =
class=3D812344502-06062008>But I encounter many=20
problems. (I am still trying to figure out where is the true=20
problem)</SPAN></FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN =
class=3D812344502-06062008>Does anyone know any=20
possible problem? Any clue is welcome.</SPAN></FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN =
class=3D812344502-06062008>Thanks a=20
lot.</SPAN></FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN=20
class=3D812344502-06062008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN =
class=3D812344502-06062008>I tried to move it to=20
0xA0000000 before. It worked&nbsp;fine.</SPAN></FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN=20
class=3D812344502-06062008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN=20
class=3D812344502-06062008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN=20
class=3D812344502-06062008>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
Jay...</SPAN></FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN=20
class=3D812344502-06062008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN=20
class=3D812344502-06062008></SPAN></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0205_01C8C7C3.67D854C0--
