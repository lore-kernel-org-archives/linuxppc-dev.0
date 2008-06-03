Return-Path: <laigui.qin@ge.com>
Received: from ext-nj2ut-9.online-age.net (ext-nj2ut-9.online-age.net
	[64.14.54.239])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-nj2ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id F0B8DDE12B
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Jun 2008 02:24:17 +1000 (EST)
Received: from int-nj2ut-1.online-age.net (int-nj2ut-1.online-age.net
	[3.159.237.70])
	by ext-nj2ut-9.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id m53FJarC030770
	for <linuxppc-embedded@ozlabs.org>; Tue, 3 Jun 2008 11:19:36 -0400
Received: from ALPMLEF02.e2k.ad.ge.com (int-nj2ut-1.online-age.net
	[3.159.237.70])
	by int-nj2ut-1.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m53FJZ1n029474
	for <linuxppc-embedded@ozlabs.org>; Tue, 3 Jun 2008 11:19:35 -0400
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8C58D.373EE006"
Subject: No console output when booting linux from uboot
Date: Tue, 3 Jun 2008 20:47:18 +0530
Message-ID: <A9D89E0D76AFF24B9441851F2AC72D7203B7D468@BANMLVEM05.e2k.ad.ge.com>
From: "Qin, Laigui (GE EntSol, Security)" <laigui.qin@ge.com>
To: <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C8C58D.373EE006
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

I am trying to boot linux kernel (2.6.23) from uboot (1.3.2) for my
custom board. The uboot works well, the kernel booting hit the
start_kernel(). But there is nothing output from console.=20

With debugger, I saw that the printk() functions were called many times
without any console output. Tracing into the source code, I found that
the printk() called "con->write" operation...=20

Can anyone guide me to solve this?

Mike Qin
GE Security

GE imagination at work


------_=_NextPart_001_01C8C58D.373EE006
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7653.29">
<TITLE>No console output when booting linux from uboot</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT FACE=3D"GE Inspira">Hi all,</FONT>
</P>

<P><FONT FACE=3D"GE Inspira">I am trying to boot linux kernel (2.6.23) =
from uboot (1.3.2) for my custom board. The uboot works well, the kernel =
booting hit the start_kernel(). But there is nothing output from =
console. </FONT></P>

<P><FONT FACE=3D"GE Inspira">With debugger, I saw that the printk() =
functions were called many times without any console output. Tracing =
into the source code, I found that the printk() called =
&quot;con-&gt;write&quot; operation... </FONT></P>

<P><FONT FACE=3D"GE Inspira">Can anyone guide me to solve this?</FONT>
</P>

<P><B><SPAN LANG=3D"en-gb"><FONT SIZE=3D2 FACE=3D"Arial">Mike =
Qin</FONT></SPAN></B>

<BR><SPAN LANG=3D"en-gb"><FONT SIZE=3D2 FACE=3D"Arial">GE =
Security</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-gb"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">GE imagination at work</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8C58D.373EE006--
