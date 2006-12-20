Return-Path: <cthomas@Soneticom.com>
Received: from Soneticom.com (soneticom.com [209.114.210.150])
	by ozlabs.org (Postfix) with ESMTP id 93E6EDDEBA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Dec 2006 03:52:07 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C72457.2D9C8803"
Subject: Define Linux system memory
Date: Wed, 20 Dec 2006 11:52:04 -0500
Message-ID: <3C02138692C13C4BB675FE7EA2409529261209@bluefin.Soneticom.local>
From: "Clint Thomas" <cthomas@Soneticom.com>
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

------_=_NextPart_001_01C72457.2D9C8803
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

To anybody who has done this before or understands how to do this, I was
wondering if you know how to "tell" the kernel how much memory there is
in the system. An example would be if I have 512MB of RAM, but only want
the system to know that there is about 500MB in RAM, so that 12MB does
not exist to the OS/kernel. Would this require mucking about in U-boot?
or can I just define this in the kernel source? Thanks
=20
Clinton Thomas
=20

------_=_NextPart_001_01C72457.2D9C8803
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.5730.11" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D346164916-20122006><FONT face=3DArial size=3D2>To =
anybody who has=20
done this before or understands how to do this, I was wondering if you =
know how=20
to "<STRONG>tell</STRONG>" the kernel how much memory there is in the =
system. An=20
example would be if I have 512MB of RAM, but only want the system to =
know that=20
there is about 500MB in RAM, so that 12MB does not exist to the =
OS/kernel. Would=20
this require mucking about in U-boot? or can I just define this in the =
kernel=20
source? Thanks</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>Clinton =
Thomas</FONT></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C72457.2D9C8803--
