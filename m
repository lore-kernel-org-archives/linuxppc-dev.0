Return-Path: <Lixin.Yao@HSTX.com>
Received: from mail.hstx.com (mail.hstx.com [64.95.133.106])
	by ozlabs.org (Postfix) with ESMTP id 47B25DE1AE
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 06:37:33 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9BED1.2FF61426"
Subject: powerpc-linux-gcc vs ppx_8xx-gcc and ppc_6xx-gcc
Date: Thu, 16 Apr 2009 13:23:21 -0700
Message-ID: <03D77CA4AC7F4D48A6AB5DA3F1001B3FB5BAC7@exchtxus2.HSTX.global.vpn>
From: "Lixin Yao" <Lixin.Yao@HSTX.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9BED1.2FF61426
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello, All,

I use ELDK 4.2 to work on platforms, one with MPC860 and the other with
MPC8248.

In installation, I see links:
ppc_8xx-gcc -> ppc-linux-gcc
ppc_6xx-gcc -> ppc-linux-gcc
ppc-linux-gcc -> powerpc-linux-gcc

I understand ppc_8xx-gcc needs to be used for MPC860 and ppc_6xx-gcc
needs to be used for MPC8248. But both point to the same
"powerpc-linux-gcc".=20

What are the differences between powerpc-linux-gcc, ppx_8xx-gcc and
ppc_6xx-gcc? What's the default target processorr of powerpc-linux-gcc?

Thanks.

Lixin Yao
Harris Strate Networks Inc.
RTP, North Carolina


------_=_NextPart_001_01C9BED1.2FF61426
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7651.59">
<TITLE>powerpc-linux-gcc vs ppx_8xx-gcc and ppc_6xx-gcc</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hello, All,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I use ELDK 4.2 to work on platforms, =
one with MPC860 and the other with MPC8248.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">In installation, I see links:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ppc_8xx-gcc -&gt; ppc-linux-gcc</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ppc_6xx-gcc -&gt; ppc-linux-gcc</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ppc-linux-gcc -&gt; =
powerpc-linux-gcc</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I understand ppc_8xx-gcc needs to be =
used for MPC860 and ppc_6xx-gcc needs to be used for MPC8248. But both =
point to the same &quot;powerpc-linux-gcc&quot;. </FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">What are the differences between =
powerpc-linux-gcc, ppx_8xx-gcc and ppc_6xx-gcc? What's the default =
target processorr of powerpc-linux-gcc?</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Lixin Yao</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Harris Strate Networks Inc.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTP, North Carolina</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C9BED1.2FF61426--
