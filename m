Return-Path: <YoavS@Go-WLAN.com>
Received: from owa.go-wlan.com (owa.go-wlan.com [192.114.175.10])
	by ozlabs.org (Postfix) with ESMTP id 170D42BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Oct 2004 07:04:48 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4BD30.32E95B6C"
Date: Thu, 28 Oct 2004 22:53:38 +0200
Message-ID: <699F7BBB368A10479166148511F524174C2310@gn-ex01.Go80211.com>
From: "Yoav Steinberg" <YoavS@Go-WLAN.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: ioremap questions
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

------_=_NextPart_001_01C4BD30.32E95B6C
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,
i'm trying to map a physical address on the 440GP's external bus to a =
virtual address so I can access it from kernel space. While looking at =
the ebony.c file under the drivers/mtd/maps I saw that a function called =
ioremap64 was used.
My questions:
1) Why use the ioremap64 function which receives a 64bit physical =
address when the CPU is a 32 bit CPU? It seems like this is a special =
function for th 44x series, is this true?
2) There seem to be multiple ioremap functions: ioremap/64/_nocache etc. =
which is the most appropriate one? What are the differences?
3) Do I need to call iounmap before remapping somethig previouslly =
mapped with ioremap?
=20
Thank's

------_=_NextPart_001_01C4BD30.32E95B6C
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"><HTML =
DIR=3Dltr><HEAD><META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1"></HEAD><BODY><DIV><FONT face=3D'Arial' =
color=3D#000000 size=3D2>Hello,</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2>i'm trying to map a physical address on =
the 440GP's =0A=
external bus to a virtual address so I can access it from kernel space. =
While =0A=
looking at the ebony.c file under the drivers/mtd/maps I saw that a =
function =0A=
called ioremap64 was used.</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2>My questions:</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2>1) Why use the ioremap64 function which =
receives a =0A=
64bit physical address when the CPU is a 32 bit CPU? It seems like this =
is a =0A=
special function for th 44x series, is this true?</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2>2) There seem to be multiple ioremap =
functions: =0A=
ioremap/64/_nocache etc. which is the most appropriate one? What are the =0A=
differences?</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2>3) Do I need to call iounmap before =
remapping =0A=
somethig previouslly mapped with ioremap?</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>Thank's</FONT></DIV></BODY></HTML>
------_=_NextPart_001_01C4BD30.32E95B6C--
