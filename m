Return-Path: <cthomas@Soneticom.com>
Received: from Soneticom.com (soneticom.com [209.114.210.150])
	by ozlabs.org (Postfix) with ESMTP id 6678A67B67
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Jul 2006 08:43:00 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6B039.F45657A4"
Subject: Booting Linux Kernel without bootloader
Date: Tue, 25 Jul 2006 18:30:39 -0400
Message-ID: <3C02138692C13C4BB675FE7EA240952915DF66@bluefin.Soneticom.local>
From: "Clint Thomas" <cthomas@Soneticom.com>
To: <linuxppc-embedded@ozlabs.org.>
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

------_=_NextPart_001_01C6B039.F45657A4
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hey guys,

I have gone through the Linuxppc embedded and dev lists for information
related to what I am trying to do, but was unable to find exactly what
i'm looking for.

Basically, the system I want linux running on does not require the
initialization of hardware that U-boot provides, or at least it does not
need it to boot the linux kernel. I want to load an uncompressed linux
kernel into memory and start the execution of the kernel, without using
any kind of bootloader. Is this possible? Or does linux need some kind
of firmware or other software to tell it to start executing? Thanks for
any info you might have.
=20
Clinton Thomas
cthomas@soneticom.com
=20

------_=_NextPart_001_01C6B039.F45657A4
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2912" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D675052722-25072006>Hey =
guys,<BR><BR>I=20
have gone through the Linuxppc embedded and dev lists for information =
related to=20
what I am trying to do, but was unable to find exactly what i'm looking=20
for.<BR><BR>Basically, the system I want linux running on does not =
require the=20
initialization of hardware that U-boot provides, or at least it does not =
need it=20
to boot the linux kernel. I want to load an uncompressed linux kernel =
into=20
memory and start the execution of the kernel, without using any kind of=20
bootloader. Is this possible? Or does linux need some kind of firmware =
or other=20
software to tell it to start executing? Thanks for any info you might=20
have.</SPAN></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>Clinton=20
Thomas<BR>cthomas@soneticom.com</FONT></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C6B039.F45657A4--
