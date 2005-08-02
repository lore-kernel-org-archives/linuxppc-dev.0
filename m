Return-Path: <Baohua.WANG@alcatel-sbell.com.cn>
Received: from mail.alcatel-sbell.com.cn (nat1.alcatel-sbell.com.cn
	[202.96.203.177]) by ozlabs.org (Postfix) with ESMTP id F411567E06
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Aug 2005 12:12:54 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C59707.170C75E8"
Date: Tue, 2 Aug 2005 10:08:35 +0800
Message-ID: <A9DE2BAF233E444FA9C5E77A5825A01E8652F9@ydmail.sbell.com.cn>
From: "FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn>
To: <linuxppc-embedded@ozlabs.org>
Subject: Bad Magic Number when boot linux kernel with ppcboot (PPC860 board)
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

------_=_NextPart_001_01C59707.170C75E8
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
 it all print the same messages, How can I do?=20



------_=_NextPart_001_01C59707.170C75E8
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
<TITLE>Bad Magic Number when boot linux kernel with ppcboot (PPC860 =
board)</TITLE>
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
print the same messages, How can I do? </FONT></SPAN>
</P>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C59707.170C75E8--
