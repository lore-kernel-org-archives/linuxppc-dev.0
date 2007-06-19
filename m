Return-Path: <Mike.Shelley@viasat.com>
Received: from VCAEXCH02.hq.corp.viasat.com (kestrel.viasat.com
	[199.106.52.139]) by ozlabs.org (Postfix) with ESMTP id 904FDDDF15
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Jun 2007 10:02:41 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7B205.9D8490ED"
Subject: booting zImage.elf
Date: Mon, 18 Jun 2007 17:05:59 -0700
Message-ID: <821B2170E9E7F04FA38DF7EC21DE4871084A0ED0@VCAEXCH01.hq.corp.viasat.com>
From: "Shelley, Mike" <Mike.Shelley@viasat.com>
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

------_=_NextPart_001_01C7B205.9D8490ED
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I've been trying to read up on how elf works and how to boot the linux =
kernel image with a custom boot loader.  I can't seem to find anything =
about booting an elf image.  I'm using a PCI Express XpressFX Board =
(which has a Virtex4), by PLDA, with DDR2 memory.  I've got the kernel =
image booting using a BDI to load it. Now I need to get it to load =
without the BDI.

The quick question is, Is it possible to load zImage.elf straight into =
memory, then jump to the address it was loaded to?  If not, how do I =
convert the elf image into just a bootable image that I can jump to?

I looked at the uboot code to load elf files, and it appears to copy the =
sections around.  Is this necessary?

Pointers on where else to look or how to do this would be greatly =
appreciated.

Michael

------_=_NextPart_001_01C7B205.9D8490ED
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7651.59">
<TITLE>booting zImage.elf</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>I've been trying to read up on how elf works and how =
to boot the linux kernel image with a custom boot loader.&nbsp; I can't =
seem to find anything about booting an elf image.&nbsp; I'm using a PCI =
Express XpressFX Board (which has a Virtex4), by PLDA, with DDR2 =
memory.&nbsp; I've got the kernel image booting using a BDI to load it. =
Now I need to get it to load without the BDI.<BR>
<BR>
The quick question is, Is it possible to load zImage.elf straight into =
memory, then jump to the address it was loaded to?&nbsp; If not, how do =
I convert the elf image into just a bootable image that I can jump =
to?<BR>
<BR>
I looked at the uboot code to load elf files, and it appears to copy the =
sections around.&nbsp; Is this necessary?<BR>
<BR>
Pointers on where else to look or how to do this would be greatly =
appreciated.<BR>
<BR>
Michael</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C7B205.9D8490ED--
