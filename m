Return-Path: <sinan.awad@med.ge.com>
Received: from ext-ch1gw-2.online-age.net (ext-ch1gw-2.online-age.net
	[216.34.191.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-ch1gw.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 71464DDE43
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Jan 2008 19:48:23 +1100 (EST)
Received: from int-ch1gw-6.online-age.net (int-ch1gw-6 [3.159.232.70])
	by ext-ch1gw-2.online-age.net (8.13.6/8.13.6/20051111-SVVS-TLS-DNSBL)
	with ESMTP id m038UtIA013599
	for <linuxppc-embedded@ozlabs.org>; Thu, 3 Jan 2008 03:30:55 -0500 (EST)
Received: from cinmlef09.e2k.ad.ge.com (int-ch1gw-6 [3.159.232.70])
	by int-ch1gw-6.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m038S7jM030969
	for <linuxppc-embedded@ozlabs.org>; Thu, 3 Jan 2008 03:28:12 -0500
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C84DE2.EE936D00"
Subject: 
Date: Thu, 3 Jan 2008 09:33:24 +0100
Message-ID: <22A704B880BBD94A9E52BD6FA90C63D702F4483A@BUDMLVEM08.e2k.ad.ge.com>
From: "Awad, Sinan (GE Healthcare)" <sinan.awad@med.ge.com>
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

------_=_NextPart_001_01C84DE2.EE936D00
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hello all
=20
I'm trying to understand if we need to move from MPC8347 to MPC8360 in
our boards.
One of the features that most attracts, is the eTSEC which includes
support for IEEE 1588 PTP time synchronization.
I need to synchronize the clock of 3 boards via ethernet, I need a time
resolution of under 1ms.
=20
Has anyone had the pleasure of playing around with time synchronization
?
Do I really need the hardware capabilities for this type of time
resolution ? or can I implement it in software ?
=20
Thanks in advance.
Sinan
=20


------_=_NextPart_001_01C84DE2.EE936D00
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3132" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D248482908-03012008>Hello=20
all</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D248482908-03012008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D248482908-03012008>I'm =
trying to=20
understand if we need to move from MPC8347 to MPC8360 in our=20
boards.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D248482908-03012008>One of =
the features=20
that most attracts, is the eTSEC which includes support for IEEE 1588 =
PTP time=20
synchronization.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D248482908-03012008>I need =
to=20
synchronize&nbsp;the clock of 3 boards via ethernet, I need a time =
resolution of=20
under 1ms.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D248482908-03012008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D248482908-03012008>Has =
anyone had the=20
pleasure of playing around with time synchronization =
?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D248482908-03012008>Do I =
really need the=20
hardware capabilities for this type of time resolution ? or can I =
implement it=20
in software ?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D248482908-03012008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D248482908-03012008>Thanks =
in=20
advance.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D248482908-03012008>Sinan</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft>
<DIV dir=3Dltr align=3Dleft>
<P style=3D"MARGIN: 0in 0in 0pt"><SPAN=20
style=3D"FONT-SIZE: 10pt; COLOR: black; FONT-FAMILY: =
Arial"><?xml:namespace prefix=20
=3D o ns =3D "urn:schemas-microsoft-com:office:office"=20
/><o:p></o:p></SPAN></P></DIV></DIV></BODY></HTML>

------_=_NextPart_001_01C84DE2.EE936D00--
