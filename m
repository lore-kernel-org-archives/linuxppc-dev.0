Return-Path: <B22598@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 898A3B7087
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Sep 2009 15:48:07 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1E58FDDD04
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Sep 2009 15:48:06 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n885m2KJ008273
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Sep 2009 22:48:03 -0700 (MST)
Received: from zmy16exm21.fsl.freescale.net (zmy16exm21.ap.freescale.net
	[10.211.3.25])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n885nQCJ004146
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Sep 2009 00:49:27 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA3047.ECE8C01B"
Subject: Question about e300 core decrementer interrupt
Date: Tue, 8 Sep 2009 13:48:00 +0800
Message-ID: <FF7429C6AD6EFB489C0A5A2021CDFEFA7C30E6@zmy16exm21.fsl.freescale.net>
From: "Li Tao-B22598" <B22598@freescale.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA3047.ECE8C01B
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: quoted-printable

Dear all,

I have a problem in MPC5121 sleep mode. As you know MPC5121 use e300c4
core. When I make the e300c4 core into sleep mode, it will return to
full power mode when the=A1=B0decrementer interrupt=A1=B1 occurred.

But in the e300 core reference manual said that the =A1=B0decrementer
interrupt=A1=B1have no effect when e300 core in sleep mode, because the =
time
base and decrementer are disabled while the core is in sleep mode.
Can anybody explain about this procedure ?=20

Another question is how can I disable the=A1=B0decrementer =
interrupt=A1=B1without
disable int,smi, or mcpinternal signals.

Any help or suggestion would be very helpful.
Thank you for your time.

--=20
Best Regards,
 =20
Li Tao  =20

------_=_NextPart_001_01CA3047.ECE8C01B
Content-Type: text/html;
	charset="GB2312"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dgb2312">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>Question about e300 core decrementer interrupt</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Dear all,<BR>
<BR>
I have a problem in MPC5121 sleep mode. As you know MPC5121 use =
e300c4<BR>
core. When I make the e300c4 core into sleep mode, it will return to<BR>
full power mode when the=A1=B0decrementer interrupt=A1=B1 occurred.<BR>
<BR>
But in the e300 core reference manual said that the =
=A1=B0decrementer<BR>
interrupt=A1=B1have no effect when e300 core in sleep mode, because the =
time<BR>
base and decrementer are disabled while the core is in sleep mode.<BR>
Can anybody explain about this procedure ?<BR>
<BR>
Another question is how can I disable the=A1=B0decrementer =
interrupt=A1=B1without<BR>
disable int,smi, or mcpinternal signals.<BR>
<BR>
Any help or suggestion would be very helpful.<BR>
Thank you for your time.<BR>
<BR>
--<BR>
Best Regards,<BR>
&nbsp;<BR>
Li Tao&nbsp;&nbsp; </FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CA3047.ECE8C01B--
