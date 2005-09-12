Return-Path: <iluri@fagorautomation.es>
Received: from smtp2.sarenet.es (orhi.sarenet.es [192.148.167.5])
	by ozlabs.org (Postfix) with ESMTP id 19B0468230
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Sep 2005 17:33:18 +1000 (EST)
Received: from ntvir (unknown [212.81.206.17])
	by smtp2.sarenet.es (Postfix) with ESMTP id D60283069
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Sep 2005 09:02:44 +0200 (CEST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5B767.F92587E9"
Date: Mon, 12 Sep 2005 09:02:42 +0200
Message-ID: <918EB199DDDFFA42BEA2EB3A1C6021F356ECFD@correo.fagorautomation.net>
From: "IGOR LURI" <iluri@fagorautomation.es>
To: <linuxppc-embedded@ozlabs.org>
Subject: Building Linux kernel with GCC 3.4.3 fails
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

------_=_NextPart_001_01C5B767.F92587E9
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all

I have a MPC5200 Lite evaluation board and I use uClibc buildroot=20
to build toolchain and root file system.

If I build toolchain using binutils 2.16.1 and gcc 3.4.3, 3.4.4 or =
3.3.6, =20
I can`t build u-boot and kernel properly.

With binutils version 2.14.90.0.8 and GCC 3.4.3,=20
I can build u-boot correctly, and it works. But I can=B4t boot a Linux =
kernel=20
compiled with this gcc, when Linux is booting it crashes with a =
segmentation fault.=20

However, if I use gcc 2.95.4 and binutils 2.12.1 to build u-boot and =
kernel, everything works.

I want to use gcc version 3.x . What version of binutils and gcc should =
I use to build u-boot and Linux kernel properly?
Have someone use buildroot with to obtain a toolchain for PowerPC?


-Igor





------_=_NextPart_001_01C5B767.F92587E9
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<TITLE>Building Linux kernel with GCC 3.4.3 fails</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><SPAN LANG=3D"es"><FONT SIZE=3D2 FACE=3D"Arial">Hi all</FONT></SPAN>
</P>

<P><SPAN LANG=3D"es"><FONT SIZE=3D2 FACE=3D"Arial">I have a MPC5200 Lite =
evaluation board and I use uClibc buildroot </FONT></SPAN>

<BR><SPAN LANG=3D"es"><FONT SIZE=3D2 FACE=3D"Arial">to build toolchain =
and root file system.</FONT></SPAN>
</P>

<P><SPAN LANG=3D"es"><FONT SIZE=3D2 FACE=3D"Arial">If I build toolchain =
using binutils 2.16.1 and gcc 3.4.3, 3.4.4 or 3.3.6,&nbsp; =
</FONT></SPAN>

<BR><SPAN LANG=3D"es"><FONT SIZE=3D2 FACE=3D"Arial">I can`t build u-boot =
and kernel properly.</FONT></SPAN>
</P>

<P><SPAN LANG=3D"es"><FONT SIZE=3D2 FACE=3D"Arial">W</FONT></SPAN><SPAN =
LANG=3D"es"><FONT SIZE=3D2 FACE=3D"Arial">ith binutils version =
2.14.90.0.8 and GCC 3.4.3, </FONT></SPAN>

<BR><SPAN LANG=3D"es"><FONT SIZE=3D2 FACE=3D"Arial">I can build u-boot =
correctly, and it works. But I can=B4t boot a Linux kernel =
</FONT></SPAN>

<BR><SPAN LANG=3D"es"><FONT SIZE=3D2 FACE=3D"Arial">compiled with this =
gcc, when Linux is booting it crashes with a segmentation fault. =
</FONT></SPAN>
</P>

<P><SPAN LANG=3D"es"><FONT SIZE=3D2 FACE=3D"Arial">However, if I use gcc =
2.95.4 and binutils 2.12.1 to build</FONT></SPAN><SPAN LANG=3D"es"> =
<FONT SIZE=3D2 FACE=3D"Arial">u-boot and kernel</FONT></SPAN><SPAN =
LANG=3D"es"><FONT SIZE=3D2 FACE=3D"Arial">,</FONT></SPAN><SPAN =
LANG=3D"es"> <FONT SIZE=3D2 FACE=3D"Arial">everything =
works.</FONT></SPAN><SPAN LANG=3D"es"></SPAN>
</P>

<P><SPAN LANG=3D"es"><FONT SIZE=3D2 FACE=3D"Arial">I want to use gcc =
version 3.x . What version of binutils and gcc should I use to build =
u-boot and Linux kernel properly?</FONT></SPAN><SPAN =
LANG=3D"es"></SPAN></P>

<P><SPAN LANG=3D"es"><FONT SIZE=3D2 FACE=3D"Arial">Have someone use =
buildroot with to obtain a toolchain for PowerPC?</FONT></SPAN>
</P>
<BR>

<P><SPAN LANG=3D"es"><FONT SIZE=3D2 =
FACE=3D"Arial">-Igor</FONT></SPAN><SPAN LANG=3D"es"></SPAN>
</P>
<BR>
<BR>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C5B767.F92587E9--
