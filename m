Return-Path: <RKumar@nvidia.com>
Received: from hqemgate00.nvidia.com (hqemgate00.nvidia.com [216.228.112.144])
	by ozlabs.org (Postfix) with ESMTP id 927572BE83
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Nov 2004 06:28:46 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4D0C8.C477B236"
Date: Mon, 22 Nov 2004 11:23:38 -0800
Message-ID: <8E5ACAE05E6B9E44A2903C693A5D4E8A023EC8C0@hqemmail02.nvidia.com>
From: "Ratin Kumar" <RKumar@nvidia.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: (no subject)
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

------_=_NextPart_001_01C4D0C8.C477B236
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I am trying to build a toolchain for MPC5200 using gcc 3.4.1.

The bootstrap compiler build fails with a complain that it could not
locate "signal.h". This happens even though I have the kernel headers
(with signal.h) installed. A quick search on google shows that some
other people have also run into this issue, although no patches/sloution
appears. Any ideas??

Also, has anyone tried using 3.4.1 compiler for kernel 2.4.23 ????

What are the matching glibc and binutils to use with 3.4.1?? Any
patches??

Thanks,
Rk.

------_=_NextPart_001_01C4D0C8.C477B236
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7226.0">
<TITLE></TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I am trying to build a toolchain for =
MPC5200 using gcc 3.4.1.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">The bootstrap compiler build fails with =
a complain that it could not locate &quot;signal.h&quot;. This happens =
even though I have the kernel headers (with signal.h) installed. A quick =
search on google shows that some other people have also run into this =
issue, although no patches/sloution appears. Any ideas??</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Also, has anyone tried using 3.4.1 =
compiler for kernel 2.4.23 ????</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">What are the matching glibc and =
binutils to use with 3.4.1?? Any patches??</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Rk.</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C4D0C8.C477B236--
