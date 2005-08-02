Return-Path: <Baohua.WANG@alcatel-sbell.com.cn>
Received: from mail.alcatel-sbell.com.cn (nat1.alcatel-sbell.com.cn
	[202.96.203.177]) by ozlabs.org (Postfix) with ESMTP id 6B85C67D7A
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Aug 2005 14:52:09 +1000 (EST)
Received: from asbmail4.sbell.com.cn (localhost [127.0.0.1])
	by mail.alcatel-sbell.com.cn (8.12.11/8.12.11/Alcanet1.0) with ESMTP id
	j724p13J019128
	for <linuxppc-embedded@ozlabs.org>; Tue, 2 Aug 2005 12:51:01 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5971D.ED77D1D9"
Date: Tue, 2 Aug 2005 12:52:04 +0800
Message-ID: <A9DE2BAF233E444FA9C5E77A5825A01E8652FD@ydmail.sbell.com.cn>
From: "FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn>
To: <linuxppc-embedded@ozlabs.org>
Subject: serial console no response after print "Transferring control to
	Linux (at address 00000000)" on PPC860
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

------_=_NextPart_001_01C5971D.ED77D1D9
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Dear All:
  I use ppcboot and ELDK 3.1.1 kernel 2.4.25 to boot a PPC860 board, I =
select the ttyS0, 9600, root=3D/de/ram during config the kernel.
   I select the SMC1,SMC2 device too.=20
  But when bootm 180000, it print the "Transferring control to Linux (at =
address 00000000)"  then halt.=20
  How can I do? Tell me the detail when config the kernel, thanks!

 =20

------_=_NextPart_001_01C5971D.ED77D1D9
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
<TITLE>serial console no response after print &quot;Transferring control =
to Linux (at address 00000000)&quot; on PPC860 </TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">Dear =
All:</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; I use =
ppcboot and ELDK 3.1.1 kernel 2.4.25 to boot a PPC860 board, I select =
the ttyS0, 9600, root=3D/de/ram during config the =
kernel.</FONT></SPAN></P>

<P><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp; I =
select the SMC1,SMC2 device too. </FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; But when =
bootm 180000, it print the &quot;Transferring control to Linux (at =
address 00000000)&quot;&nbsp; then halt. </FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; How can I =
do? Tell me the detail when config the kernel, thanks!</FONT></SPAN>
</P>

<P><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;</FONT> =
</SPAN>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C5971D.ED77D1D9--
