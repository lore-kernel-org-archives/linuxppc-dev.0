Return-Path: <Baohua.WANG@alcatel-sbell.com.cn>
Received: from mail.alcatel-sbell.com.cn (nat1.alcatel-sbell.com.cn
	[202.96.203.177]) by ozlabs.org (Postfix) with ESMTP id 152D768123
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Aug 2005 10:52:40 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5ADC6.1F80F391"
Date: Wed, 31 Aug 2005 08:51:29 +0800
Message-ID: <A9DE2BAF233E444FA9C5E77A5825A01E865067@ydmail.sbell.com.cn>
From: "FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn>
To: <linuxppc-embedded@ozlabs.org>, <wd@denx.de>
Cc: Jack_liu@usish.com, Tsi-Chung.Liew@freescale.com
Subject: Question about SMC serial port on MPC8270 in u-boot 
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

------_=_NextPart_001_01C5ADC6.1F80F391
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Dear All:
 When i port the u-boot 1.1.3 on my MPC8270 board, the serial port has =
the following question:
  1. the Dual port ram cannot be revised manually, but can be revised by =
the u-boot code. What's the problem?
   2. the serial_putc() in serial_smc.c is loop forever on  "while =
(tbdf->cbd_sc & BD_SC_READY);". How to slove the bug?
   3. the speed.c calc the wrong cpm, cpu, brg_clk, I had hard coded the =
right   cpm, cpu, brg_clk values. But the "m8260_cpm_setbrg()" is still =
wrong? Why?
       the registers are all right.
   4. Can you tell me the ALL items about the SMC1  UART output? I had =
checked almost all the concerned SMC registers, IO ports,
        data structures, they all seems right, but the UART cannot work. =
How could I find the problem?=20
   thanks a lot !=20



------_=_NextPart_001_01C5ADC6.1F80F391
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
<TITLE>Question about SMC serial port on MPC8270 in u-boot </TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000000" SIZE=3D2 =
FACE=3D"Arial">Dear All:</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000000" SIZE=3D2 =
FACE=3D"Arial">&nbsp;When i port the u-boot 1.1.3 on my MPC8270 board, =
the serial port has the following question:</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000000" SIZE=3D2 =
FACE=3D"Arial">&nbsp; 1. the Dual port ram cannot be revised manually, =
but can be revised by the u-boot code. What's the problem?</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000000" SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp; 2. the serial_putc() in serial_smc.c is loop =
forever on&nbsp; &quot;while (tbdf-&gt;cbd_sc &amp; BD_SC_READY);&quot;. =
How to slove the bug?</FONT></SPAN></P>

<P><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000000" SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp; 3. the speed.c calc the wrong cpm, cpu, =
brg_clk, I had hard coded the right&nbsp;&nbsp; cpm, cpu, brg_clk =
values. But the &quot;m8260_cpm_setbrg()&quot; is still wrong? =
Why?</FONT></SPAN></P>

<P><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000000" SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the registers are =
all right.</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000000" SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp; 4. Can you tell me the ALL items about the =
SMC1&nbsp; UART output? I had checked almost all the concerned SMC =
registers, IO ports,</FONT></SPAN></P>

<P><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000000" SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =
structures, they all seems right, but the UART cannot work. How could I =
find the problem? </FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000000" SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp; thanks a lot ! </FONT></SPAN>
</P>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C5ADC6.1F80F391--
