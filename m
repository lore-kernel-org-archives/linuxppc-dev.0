Return-Path: <Baohua.WANG@alcatel-sbell.com.cn>
Received: from mail.alcatel-sbell.com.cn (nat1.alcatel-sbell.com.cn
	[202.96.203.177]) by ozlabs.org (Postfix) with ESMTP id F3D9267D19
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jul 2005 14:21:59 +1000 (EST)
Received: from asbmail4.sbell.com.cn (localhost [127.0.0.1])
	by mail.alcatel-sbell.com.cn (8.12.11/8.12.11/Alcanet1.0) with ESMTP id
	j6S4FxcD016454
	for <linuxppc-embedded@ozlabs.org>; Thu, 28 Jul 2005 12:15:59 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5932B.304A4165"
Date: Thu, 28 Jul 2005 12:16:55 +0800
Message-ID: <A9DE2BAF233E444FA9C5E77A5825A01E8652D4@ydmail.sbell.com.cn>
From: "FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn>
To: <linuxppc-embedded@ozlabs.org>
Subject: How to load a linux kernel under vxworks bootloader (PPC860 board)
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

------_=_NextPart_001_01C5932B.304A4165
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Dear All:
  I want to boot a linux 2.4.25 kernel under vxworks bootloader. When I =
using flat mode(0x200000 -->  0x10000) kernel  uncompressed ELF format ( =
vmlinux ),
 and download it using TFTP of vxworks, it print the "starting at 0x1000 =
...." and  freeze.  No input or output on serial port.
 The version of vxworks is 5.3.1.=20
 can you give me some detail advice or give me a tool to slove it? =
thanks !

------_=_NextPart_001_01C5932B.304A4165
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dgb2312">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.0.6603.0">
<TITLE>How to load a linux kernel under vxworks bootloader (PPC860 =
board)</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">Dear =
All:</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; I want to =
boot a linux 2.4.25 kernel under vxworks bootloader. When I using flat =
mode(0x200000 --&gt;&nbsp; 0x10000) kernel&nbsp; uncompressed ELF format =
( vmlinux ),</FONT></SPAN></P>

<P><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;and download =
it using TFTP of vxworks, it print the &quot;starting at 0x1000 =
....&quot; and&nbsp; freeze.&nbsp; No input or output on serial =
port.</FONT></SPAN></P>

<P><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;The version =
of vxworks is 5.3.1. </FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;can you =
give me some detail advice or give me a tool to slove it? thanks =
!</FONT></SPAN>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C5932B.304A4165--
