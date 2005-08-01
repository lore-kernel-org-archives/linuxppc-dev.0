Return-Path: <Baohua.WANG@alcatel-sbell.com.cn>
Received: from mail.alcatel-sbell.com.cn (nat1.alcatel-sbell.com.cn
	[202.96.203.177]) by ozlabs.org (Postfix) with ESMTP id 2803E67E11
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  1 Aug 2005 14:53:55 +1000 (EST)
Received: from asbmail4.sbell.com.cn (localhost [127.0.0.1])
	by mail.alcatel-sbell.com.cn (8.12.11/8.12.11/Alcanet1.0) with ESMTP id
	j714qmWN029040
	for <linuxppc-embedded@ozlabs.org>; Mon, 1 Aug 2005 12:52:48 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C59655.021382FB"
Date: Mon, 1 Aug 2005 12:53:50 +0800
Message-ID: <A9DE2BAF233E444FA9C5E77A5825A01E86504F@ydmail.sbell.com.cn>
From: "FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn>
To: <linuxppc-embedded@ozlabs.org>
Subject: How to config the  linux kernel under PPC860 board
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

------_=_NextPart_001_01C59655.021382FB
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Dear All
  When I load the kernel 2.4.25 in PPC860 board's RAM , the emulator =
display A "software error at 0x100 ", I think the "reset" function error =

  when booting.  So how to config the kernel to avoid the problem ?=20
  I use VisionClICK to emulate the PPC860 board, if direct download to =
RAM with TFTP, there is nothing on serial port after printing=20
 "starting at 0x10000" and the serial port is no input or output after =
serval seconds. But during the few seconds, I can input any characters =
on it.
  How to slove it? thanks !

------_=_NextPart_001_01C59655.021382FB
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
<TITLE>How to config the  linux kernel under PPC860 board</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">Dear =
All</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; When I =
load the kernel 2.4.25 in PPC860 board's RAM , the emulator display A =
&quot;software error at 0x100 &quot;, I think the &quot;reset&quot; =
function error </FONT></SPAN></P>

<P><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; when =
booting.&nbsp; So how to config the kernel to avoid the problem ? =
</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; I use =
VisionClICK to emulate the PPC860 board, if direct download to RAM with =
TFTP, there is nothing on serial port after printing </FONT></SPAN></P>

<P><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&quot;starting at 0x10000&quot; and the serial port =
is no input or output after serval seconds. But during the few seconds, =
I can input any characters on it.</FONT></SPAN></P>

<P><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; How to =
slove it? thanks !</FONT></SPAN>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C59655.021382FB--
