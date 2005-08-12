Return-Path: <Baohua.WANG@alcatel-sbell.com.cn>
Received: from mail.alcatel-sbell.com.cn (nat1.alcatel-sbell.com.cn
	[202.96.203.177]) by ozlabs.org (Postfix) with ESMTP id ED01A67A5F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Aug 2005 16:03:13 +1000 (EST)
Received: from asbmail4.sbell.com.cn (localhost [127.0.0.1])
	by mail.alcatel-sbell.com.cn (8.12.11/8.12.11/Alcanet1.0) with ESMTP id
	j7C61q6x013067
	for <linuxppc-embedded@ozlabs.org>; Fri, 12 Aug 2005 14:01:52 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C59F03.835E7F76"
Date: Fri, 12 Aug 2005 14:03:08 +0800
Message-ID: <A9DE2BAF233E444FA9C5E77A5825A01E86505F@ydmail.sbell.com.cn>
From: "FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn>
To: <linuxppc-embedded@ozlabs.org>
Subject: strange things about swap on NFS
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

------_=_NextPart_001_01C59F03.835E7F76
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Dear all:
  I use ELDK 3.1.1, kernel 2.4.25 on my HD860 board,  using NFS.  I add =
a "ext2.img" as mentioned in the ELDK doc.
  But I found that the "dd if=3D/dev/zero of=3Dswapfile bs=3D1M =
count=3D62" is not easy to executed:
  The system is often no response after execute this command. On several =
time, it add swap successfully.
   But  when I start to compile package. The system then no response !!
 =20
   How to slove the problem? Is the reason of my hard disk? I think not, =

   thanks!
=20

------_=_NextPart_001_01C59F03.835E7F76
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
<TITLE>strange things about swap on NFS</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">Dear =
all:</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; I use ELDK =
3.1.1, kernel 2.4.25 on my HD860 board,&nbsp; using NFS.&nbsp; I add a =
&quot;ext2.img&quot; as mentioned in the ELDK doc.</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; But I =
found that the &quot;dd if=3D/dev/zero of=3Dswapfile bs=3D1M =
count=3D62&quot; is not easy to executed:</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; The system =
is often no response after execute this command. On several time, it add =
swap successfully.</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp; =
But&nbsp; when I start to compile package. The system then no response =
!!</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; =
</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp; How =
to slove the problem? Is the reason of my hard disk? I think not, =
</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp; =
thanks!</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 =
FACE=3D"Arial"></FONT>&nbsp;</SPAN>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C59F03.835E7F76--
