Return-Path: <Baohua.WANG@alcatel-sbell.com.cn>
Received: from mail.alcatel-sbell.com.cn (nat1.alcatel-sbell.com.cn
	[202.96.203.177]) by ozlabs.org (Postfix) with ESMTP id 44114681EF
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Sep 2005 16:20:29 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5B506.6D332A5D"
Date: Fri, 9 Sep 2005 14:19:25 +0800
Message-ID: <A9DE2BAF233E444FA9C5E77A5825A01E86506A@ydmail.sbell.com.cn>
From: "FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn>
To: <thomas@corelatus.com>, <Steven.Scholz@imc-berlin.de>
Cc: mattl@mvista.com, linuxppc-embedded@ozlabs.org
Subject: Can the mpc8270 provide the direct IDE interface?
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

------_=_NextPart_001_01C5B506.6D332A5D
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Dear All:
 I have a question when I port the PCMCIA  driver to MPC8270 board:
 Can the  mpc8270 provide the direct IDE interface without using the =
PCMCIA  controller? If it can, what's the different with the=20
 drivers\ide\ppc\mpc8xx.c ? Can you provide some resource about the =
"direct IDE interface " on MPC82xx ?=20
 My PCMCIA  CF card has a specially CPLD to read/write the status of the =
CF card. What's the codes need to be modified if using=20
 the Card Services package? What's the performance between the direct =
IDE mode and card service?
=20
 thanks a lot!


------_=_NextPart_001_01C5B506.6D332A5D
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
<TITLE>Can the mpc8270 provide the direct IDE interface?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">Dear =
All:</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;I have a =
question when I port the PCMCIA&nbsp; driver to MPC8270 =
board:</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;Can =
the&nbsp; mpc8270 provide the direct IDE interface without using the =
PCMCIA&nbsp; controller? If it can, what's the different with the =
</FONT></SPAN></P>

<P><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;drivers\ide\ppc\mpc8xx.c ? Can you provide some =
resource about the &quot;direct IDE interface &quot; on MPC82xx ? =
</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;My =
PCMCIA&nbsp; CF card has a specially CPLD to read/write the status of =
the CF card. What's the codes need to be modified if using =
</FONT></SPAN></P>

<P><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;the Card =
Services package? What's the performance between the direct IDE mode and =
card service?</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;thanks a =
lot!</FONT></SPAN>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C5B506.6D332A5D--
