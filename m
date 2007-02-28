Return-Path: <cthomas@Soneticom.com>
Received: from Soneticom.com (soneticom.com [209.114.210.150])
	by ozlabs.org (Postfix) with ESMTP id ECD96DDE26
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Mar 2007 05:41:38 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C75B68.127A3FE8"
Subject: MTD and U-boot
Date: Wed, 28 Feb 2007 13:41:36 -0500
Message-ID: <3C02138692C13C4BB675FE7EA24095292E0871@bluefin.Soneticom.local>
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

------_=_NextPart_001_01C75B68.127A3FE8
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hey,

I want to be able to write/read from the same boot flash U-boot resides
on. Right now, u-boot and the vmlinux.img reside on the same 16bit NAND
flash. Is it possible to setup the flash so that from linux, I can erase
and write an updated vmlinux.img when I want to update a kernel build on
the system, without partitioning off a section of it away from U-boot?
=20
Clinton Thomas

=20

------_=_NextPart_001_01C75B68.127A3FE8
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.6000.16414" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D418412818-28022007><FONT face=3DArial =
size=3D2>Hey,<BR><BR>I want=20
to be able to write/read from the same boot flash U-boot resides on. =
Right now,=20
u-boot and the vmlinux.img reside on the same 16bit NAND flash. Is it =
possible=20
to setup the flash so that from linux, I can erase and write an updated=20
vmlinux.img when I want to update a kernel build on the system, without=20
partitioning off a section of it away from U-boot?</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>Clinton =
Thomas<BR></FONT></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C75B68.127A3FE8--
