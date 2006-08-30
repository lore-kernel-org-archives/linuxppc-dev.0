Return-Path: <suneel.reddy@motorola.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id 4F37767B96
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Aug 2006 17:26:29 +1000 (EST)
Received: from il06exr03.mot.com (il06exr03.mot.com [129.188.137.133])
	by motgate8.mot.com (8.12.11/Motorola) with ESMTP id k7U7QRdw017424
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Aug 2006 00:26:27 -0700 (MST)
Received: from ZMY16EXM66.ds.mot.com (zmy16exm66.ap.mot.com [10.179.4.26])
	by il06exr03.mot.com (8.13.1/8.13.0) with ESMTP id k7U7QPSb021099
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Aug 2006 02:26:26 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6CC05.99925CA1"
Subject: booting Linux in Linux using kexec tools
Date: Wed, 30 Aug 2006 15:26:24 +0800
Message-ID: <405ECA8A30557F439A723E52D50838F9D829C6@ZMY16EXM66.ds.mot.com>
From: "Reddy Suneel-ASR125" <suneel.reddy@motorola.com>
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

------_=_NextPart_001_01C6CC05.99925CA1
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi
=20
I am trying to boot Linux (zImage.elf) in Linux using kexec tools.=20
=20
I am getting the folling crash
=20
sh-2.05b#
sh-2.05b# kexec -e
Shutting down gianfar ethernet
Shutting down gianfar ethernet
Shutting down gianfar ethernet
Starting new kernel
Bye!
Oops: kernel access of bad area, sig: 11 [#1]
PREEMPT
NIP: 2E5C0020 LR: C000A3CC SP: C8D97DF0 REGS: c8d97d40 TRAP: 0400    Not
taintedMSR: 00001000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
TASK =3D c82f84a0[665] 'kexec' THREAD: c8d96000
Last syscall: 88
GPR00: 00000000 C8D97DF0 C82F84A0 2E5C1002 2E5C0000 00000000 00000F35
C0307DBC
GPR08: 2E5C0020 C0350000 00000000 C8D96000 00000000 10030450 00000220
100CBD88
GPR16: FFFFFFFF 00000000 00000000 00000000 00000000 00000000 FFFFFFFF
42202442
GPR24: 100D71C8 100D7508 2E5C1002 C0A8DC80 EE5C0000 2E5C0000 00000000
C0A8DC80
Call trace: [c000a2fc]  [c00302d0]  [c000206c]
Segmentation fault
sh-2.05b#
=20
I am working on MPC8540 processor.
=20
can any one help me.
=20
Thanks&regards
Suneel

------_=_NextPart_001_01C6CC05.99925CA1
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<TITLE>Message</TITLE>

<META content=3D"MSHTML 6.00.2800.1561" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D432552107-30082006>Hi</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D432552107-30082006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D432552107-30082006>I am =
trying to boot=20
Linux (zImage.elf) in Linux using kexec tools. </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D432552107-30082006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D432552107-30082006>I am =
getting the=20
folling crash</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D432552107-30082006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D432552107-30082006>sh-2.05b#<BR>sh-2.05b# kexec -e<BR>Shutting =
down=20
gianfar ethernet<BR>Shutting down gianfar ethernet<BR>Shutting down =
gianfar=20
ethernet<BR>Starting new kernel<BR>Bye!<BR>Oops: kernel access of bad =
area, sig:=20
11 [#1]<BR>PREEMPT<BR>NIP: 2E5C0020 LR: C000A3CC SP: C8D97DF0 REGS: =
c8d97d40=20
TRAP: 0400&nbsp;&nbsp;&nbsp; Not taintedMSR: 00001000 EE: 0 PR: 0 FP: 0 =
ME: 1=20
IR/DR: 00<BR>TASK =3D c82f84a0[665] 'kexec' THREAD: c8d96000<BR>Last =
syscall:=20
88<BR>GPR00: 00000000 C8D97DF0 C82F84A0 2E5C1002 2E5C0000 00000000 =
00000F35=20
C0307DBC<BR>GPR08: 2E5C0020 C0350000 00000000 C8D96000 00000000 10030450 =

00000220 100CBD88<BR>GPR16: FFFFFFFF 00000000 00000000 00000000 00000000 =

00000000 FFFFFFFF 42202442<BR>GPR24: 100D71C8 100D7508 2E5C1002 C0A8DC80 =

EE5C0000 2E5C0000 00000000 C0A8DC80<BR>Call trace: [c000a2fc]&nbsp;=20
[c00302d0]&nbsp; [c000206c]<BR>Segmentation=20
fault<BR>sh-2.05b#</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D432552107-30082006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D432552107-30082006>I am =
working on=20
MPC8540 processor.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D432552107-30082006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D432552107-30082006>can =
any one help=20
me.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D432552107-30082006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D432552107-30082006>Thanks&amp;regards</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D432552107-30082006>Suneel</SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C6CC05.99925CA1--
