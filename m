Return-Path: <suneel.reddy@motorola.com>
Received: from mail119.messagelabs.com (mail119.messagelabs.com
	[216.82.241.179]) by ozlabs.org (Postfix) with SMTP id EF1F867C30
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Nov 2006 17:32:00 +1100 (EST)
Received: from az33exr03.mot.com (az33exr03.mot.com [10.64.251.233])
	by motgate.mot.com (Motorola/Motorola) with ESMTP id kA76VtfU010317
	for <linuxppc-embedded@ozlabs.org>; Mon, 6 Nov 2006 23:31:56 -0700 (MST)
Received: from ZMY16EXM66.ds.mot.com (zmy16exm66.ap.mot.com [10.179.4.26])
	by az33exr03.mot.com (8.13.1/8.13.0) with ESMTP id kA76Vsgs028458
	for <linuxppc-embedded@ozlabs.org>; Tue, 7 Nov 2006 00:31:55 -0600 (CST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C70236.656B94BD"
Subject: Error in compiling the linux kernel 
Date: Tue, 7 Nov 2006 14:31:45 +0800
Message-ID: <405ECA8A30557F439A723E52D50838F90104DC4D@ZMY16EXM66.ds.mot.com>
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

------_=_NextPart_001_01C70236.656B94BD
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi
=20
I applied the gcov patch for Linux 2.6 and I try to compile it.  I am
getting the following error.
=20
arch/ppc/kernel/built-in.o(.text+0x8f8): In function `_switch':
arch/ppc/kernel/entry.S: relocation truncated to fit: R_PPC_REL14
against symbol `do_syscall_trace' defined in .text section in
arch/ppc/kernel/built-in.o
make: *** [.tmp_vmlinux1] Error 1
=20
Linux kernel is cpmpiled for MPC8548 Powerpc processor.
=20
Can anybody knows the root cause of this problem?
=20
suneel   =20
=20

------_=_NextPart_001_01C70236.656B94BD
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
class=3D208482506-07112006>Hi</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D208482506-07112006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D208482506-07112006>I =
applied the gcov=20
patch for Linux 2.6 and I try to compile it.&nbsp; I am getting the =
following=20
error.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D208482506-07112006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D208482506-07112006>arch/ppc/kernel/built-in.o(.text+0x8f8): In =
function=20
`_switch':<BR>arch/ppc/kernel/entry.S: relocation truncated to fit: =
R_PPC_REL14=20
against symbol `do_syscall_trace' defined in .text section in=20
arch/ppc/kernel/built-in.o<BR>make: *** [.tmp_vmlinux1] Error=20
1</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D208482506-07112006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D208482506-07112006>Linux =
kernel is=20
cpmpiled for MPC8548 Powerpc processor.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D208482506-07112006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D208482506-07112006>Can =
anybody knows=20
the root cause of this problem?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D208482506-07112006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D208482506-07112006>suneel&nbsp;&nbsp;&nbsp; </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D208482506-07112006></SPAN></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C70236.656B94BD--
