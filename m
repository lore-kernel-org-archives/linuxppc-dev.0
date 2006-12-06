Return-Path: <kenneth.fairweather@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 38367679A6
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Dec 2006 02:55:31 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	kB6FtRFU008255
	for <linuxppc-embedded@ozlabs.org>; Wed, 6 Dec 2006 08:55:27 -0700 (MST)
Received: from zuk35exm20.fsl.freescale.net (zuk35exm20.ea.freescale.net
	[10.210.1.54])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id kB6FtQZL014170
	for <linuxppc-embedded@ozlabs.org>; Wed, 6 Dec 2006 09:55:26 -0600 (CST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7194E.F1958A3C"
Subject: Compiling 2.6.19 for powerpc 8xx
Date: Wed, 6 Dec 2006 15:51:14 -0000
Message-ID: <BB9BA263E5615D44AF737CA35FB045F5420AA0@zuk35exm20.fsl.freescale.net>
From: "Fairweather Kenneth-R61777" <kenneth.fairweather@freescale.com>
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

------_=_NextPart_001_01C7194E.F1958A3C
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi,

I am trying to compile a 2.6.19 kernel for 8xx on powerpc branch. It
fails on drivers/serial/cpm_uart/cpm_uart_cpm1.c for undefined __res
variable

It looks like cpm1.c doesn't have the open firmware changes that cpm2.c
has.

I have looked for a patch for this on the site, and havent found one. I
have applied Vitaly Bordug's 5 patches for 8xx, but they don't appear to
address this issue.

If anyone has any pearls of wisdom, please help.=20

Thanks
Kenny
------------------------
Kenny Fairweather




------_=_NextPart_001_01C7194E.F1958A3C
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7651.28">
<TITLE>Compiling 2.6.19 for powerpc 8xx</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I am trying to compile a 2.6.19 kernel =
for 8xx on powerpc branch. It fails on =
drivers/serial/cpm_uart/cpm_uart_cpm1.c for undefined __res =
variable</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">It looks like cpm1.c doesn&#8217;t have =
the open firmware changes that cpm2.c has.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I have looked for a patch for this on =
the site, and havent found one. I have applied Vitaly Bordug's 5 patches =
for 8xx, but they don&#8217;t appear to address this issue.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">If anyone has any pearls of wisdom, =
please help. </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Kenny</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">------------------------</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Kenny Fairweather</FONT>
</P>
<BR>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C7194E.F1958A3C--
