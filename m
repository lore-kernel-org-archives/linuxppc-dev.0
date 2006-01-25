Return-Path: <iluri@fagorautomation.es>
Received: from smtp2.sarenet.es (orhi.sarenet.es [192.148.167.5])
	by ozlabs.org (Postfix) with ESMTP id 87E6368926
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Jan 2006 18:44:54 +1100 (EST)
Received: from ntvir (unknown [212.81.206.17])
	by smtp2.sarenet.es (Postfix) with ESMTP id 8F539605E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Jan 2006 08:44:52 +0100 (CET)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C62183.39633C56"
Subject: Linux kernel and u-boot debugging with Eclipse IDE
Date: Wed, 25 Jan 2006 08:44:52 +0100
Message-ID: <918EB199DDDFFA42BEA2EB3A1C6021F39D21E1@correo.fagorautomation.net>
From: "IGOR LURI" <iluri@fagorautomation.es>
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

------_=_NextPart_001_01C62183.39633C56
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

We have a MPC5200Lite board running Linux 2.4.25 and u-boot 1.1.4. We =
are able to debug Linux kernel and U-boot using DDD/GDB and BDI2000, and =
we are trying to use Eclipse IDE (with CDT plugin) / BDI2000 to develop =
and debug software.

Eclipse works well to remote debugging aplications over ethernet,  =
however, we are not able to debug Linux kernel or u-boot using Eclipse. =
When it stops in the first breakpoint, I can=B4t view some variables and =
stepping into a function, it shows another. It  seems that Eclipse has =
problems with Linux kernel and u-boot symbols.

Someone uses Eclipse and BDI2000 to debug Linux kernel and u-boot?=20


Igor Luri
R&D Software Department
Fagor Automation S. Coop.



------_=_NextPart_001_01C62183.39633C56
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7232.36">
<TITLE>Linux kernel and u-boot debugging with Eclipse IDE</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi all,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">We have a MPC5200Lite board running =
Linux 2.4.25 and u-boot 1.1.4. We are able to debug Linux kernel and =
U-boot using DDD/GDB and BDI2000, and we are trying to use Eclipse IDE =
(with CDT plugin) / BDI2000 to develop and debug software.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Eclipse works well to remote debugging =
aplications over ethernet,&nbsp; however, we are not able to debug Linux =
kernel or u-boot using Eclipse. When it stops in the first breakpoint, I =
can=B4t view some variables and stepping into a function, it shows =
another. It&nbsp; seems that Eclipse has problems with Linux kernel and =
u-boot symbols.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Someone uses Eclipse and BDI2000 to =
debug Linux kernel and u-boot? </FONT>
</P>
<BR>

<P><B><FONT SIZE=3D2 FACE=3D"Arial">Igor Luri</FONT></B>

<BR><FONT SIZE=3D2 FACE=3D"Arial">R&amp;D Software =
Department</FONT><B></B>

<BR><B><FONT FACE=3D"Arial">Fagor Automation S. Coop.</FONT></B>
</P>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C62183.39633C56--
