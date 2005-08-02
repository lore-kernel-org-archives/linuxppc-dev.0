Return-Path: <Baohua.WANG@alcatel-sbell.com.cn>
Received: from mail.alcatel-sbell.com.cn (nat1.alcatel-sbell.com.cn
	[202.96.203.177]) by ozlabs.org (Postfix) with ESMTP id 092A267D77
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Aug 2005 12:37:23 +1000 (EST)
Received: from asbmail4.sbell.com.cn (localhost [127.0.0.1])
	by mail.alcatel-sbell.com.cn (8.12.11/8.12.11/Alcanet1.0) with ESMTP id
	j722aC2N010392
	for <linuxppc-embedded@ozlabs.org>; Tue, 2 Aug 2005 10:36:17 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5970A.5C0C0188"
Date: Tue, 2 Aug 2005 10:31:59 +0800
Message-ID: <A9DE2BAF233E444FA9C5E77A5825A01E8652FA@ydmail.sbell.com.cn>
From: "FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn>
To: <linuxppc-embedded@ozlabs.org>
Subject: Reply: Bad Magic Number when boot linux kernel with ppcboot (PPC860
	board)
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

------_=_NextPart_001_01C5970A.5C0C0188
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Dear All:
  I use a PPC860 board and ELDK 3.1.1 (kernel 2.4.25) to boot the linux =
kernel, after I loaded it print the following messages:

=3D> bootm 0x180000
## Booting image at 00000000 ...
Bad Magic Number
=3D>


How to slove it, thanks a lot!
I use:  zImage,=20
vmlinux.UBoot,
 vmlinux=20
 it all print the same messages,=20
 I use "imi 0x180000"
 is also print the
 "
Checking Image at 00000000 ...
   Bad Magic Number"

How can I do? =20

------_=_NextPart_001_01C5970A.5C0C0188
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
<TITLE>Reply: Bad Magic Number when boot linux kernel with ppcboot =
(PPC860 board)</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">Dear =
All:</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; I use a =
PPC860 board and ELDK 3.1.1 (kernel 2.4.25) to boot the linux kernel, =
after I loaded it print the following messages:</FONT></SPAN></P>

<P><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"=CB=CE=CC=E5">=3D&gt; =
bootm 0x180000</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"=CB=CE=CC=E5">## Booting =
image at 00000000 ...</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"=CB=CE=CC=E5">Bad Magic =
Number</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 =
FACE=3D"=CB=CE=CC=E5">=3D&gt;</FONT></SPAN>
</P>
<BR>

<P><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">How to slove it, =
thanks a lot!</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">I use:&nbsp; =
zImage,</FONT> </SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 =
FACE=3D"=CB=CE=CC=E5">vmlinux.UBoot,</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 =
FACE=3D"=CB=CE=CC=E5"></FONT>&nbsp;<FONT SIZE=3D2 FACE=3D"Arial">vmlinux =
</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;it all =
print the same messages, </FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;I use =
&quot;imi 0x180000&quot;</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;is also =
print the</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&quot;</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">Checking Image at =
00000000 ...</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp; Bad =
Magic Number&quot;</FONT></SPAN>
</P>

<P><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">How can I =
do?&nbsp;</FONT> </SPAN>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C5970A.5C0C0188--
