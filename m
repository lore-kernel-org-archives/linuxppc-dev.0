Return-Path: <akhilesh@innomedia.soft.net>
Received: from gateway.innomedia.soft.net (unknown [220.227.188.61])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A2BE2679FD
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Aug 2006 14:54:58 +1000 (EST)
Received: from innomedia ([192.168.18.10]) (authenticated bits=0)
	by gateway.innomedia.soft.net (8.12.11/8.12.11) with ESMTP id
	k7Q4spvZ024923
	for <linuxppc-embedded@ozlabs.org>; Sat, 26 Aug 2006 10:24:51 +0530
Message-ID: <005601c6c8cb$67bc0750$0a12a8c0@innomedia>
From: "Akhilesh Soni" <akhilesh@innomedia.soft.net>
To: <linuxppc-embedded@ozlabs.org>
Subject: Difference between zImage.treeboot zImage
Date: Sat, 26 Aug 2006 10:22:16 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0053_01C6C8F9.8163A180"
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

------=_NextPart_000_0053_01C6C8F9.8163A180
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm using opebios on IBM redwood6 ppc405 platform. Currently when I =
compile my kernel by doing "make zImage" I get one file zImage.treeboot. =
I just want to know what is the difference between normal zImage and =
zImage.treeboot.

One more thing I've noticed that there is also a small boot program =
inside the kernel also (arch/ppc/boot/simple) which decompresses the =
kernel and jumps to start of zImage. Why this is required ? In normal =
U-boot which I've worked earlier directly decompresses the zImage by =
bootm command and starts its execution. Please help me in understanding =
this mechanism.

Also If I want to build linux kernel 2.6 then will my opebios will work =
with it or I'll have to change to uboot for for 2.6 kernel.


regards,
Akhilesh


------=_NextPart_000_0053_01C6C8F9.8163A180
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2600.0" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I'm using opebios on IBM redwood6 =
ppc405 platform.=20
Currently when I compile my kernel&nbsp;by doing "make zImage" I get one =
file=20
zImage.treeboot. I just want to know what is the difference between =
normal=20
zImage and zImage.treeboot.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>One more thing I've noticed that there =
is also a=20
small boot program inside the kernel also (arch/ppc/boot/simple) which=20
decompresses the kernel and jumps to start of zImage. Why this is =
required ? In=20
normal U-boot which I've worked earlier directly decompresses the zImage =
by=20
bootm command and starts its execution. Please help me in understanding =
this=20
mechanism.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Also If I want to build linux kernel =
2.6 then will=20
my opebios will work with it or I'll have to change to uboot for for 2.6 =

kernel.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Akhilesh</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0053_01C6C8F9.8163A180--
