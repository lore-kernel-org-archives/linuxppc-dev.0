Return-Path: <timur@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D40A2B7F42
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 Aug 2009 10:38:34 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6C61DDDD04
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Aug 2009 10:38:34 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n7V0cPpk008806
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Aug 2009 17:38:26 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n7V0dn0V019380
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Aug 2009 19:39:50 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA29D3.58AD7957"
Subject: RE: [PATCH 2/5] powerpc/85xx/86xx: Add suspend/resume support
Date: Sun, 30 Aug 2009 17:38:05 -0700
Message-ID: <5610599F537DD74A8D1F5CC946A7507301DCCC8B@az33exm25.fsl.freescale.net>
References: <20090830193625.GA14693@oksana.dev.rtsoft.ru>
	<20090830193718.GB17519@oksana.dev.rtsoft.ru>
From: "Tabi Timur-B04825" <timur@freescale.com>
To: "Anton Vorontsov" <avorontsov@ru.mvista.com>,
	"Kumar Gala" <galak@kernel.crashing.org>
Cc: Wood Scott-B07421 <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA29D3.58AD7957
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


What about the 8610?

-----Original Message-----
From: Anton Vorontsov [mailto:avorontsov@ru.mvista.com]
Sent: Sun 8/30/2009 2:37 PM
To: Kumar Gala
Cc: Tabi Timur-B04825; Wood Scott-B07421; linuxppc-dev@ozlabs.org
Subject: [PATCH 2/5] powerpc/85xx/86xx: Add suspend/resume support
=20
This patch adds suspend/resume support for MPC8540, MPC8569 and
MPC8641D-compatible CPUs.

MPC8540 and MPC8641D-compatible PMCs are trivial: we just write
the SLP bit into the PM control and status register.

MPC8569 is a bit trickier, QE turns off during suspend, thus on
resume we must reload QE microcode and reset QE.

So far we don't support Deep Sleep mode as found in newer MPC85xx
CPUs (i.e. MPC8536). It can be relatively easy implemented though,
and for it we reserve 'mem' suspend type.




------_=_NextPart_001_01CA29D3.58AD7957
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>RE: [PATCH 2/5] powerpc/85xx/86xx: Add suspend/resume =
support</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>What about the 8610?<BR>
<BR>
-----Original Message-----<BR>
From: Anton Vorontsov [<A =
HREF=3D"mailto:avorontsov@ru.mvista.com">mailto:avorontsov@ru.mvista.com<=
/A>]<BR>
Sent: Sun 8/30/2009 2:37 PM<BR>
To: Kumar Gala<BR>
Cc: Tabi Timur-B04825; Wood Scott-B07421; linuxppc-dev@ozlabs.org<BR>
Subject: [PATCH 2/5] powerpc/85xx/86xx: Add suspend/resume support<BR>
<BR>
This patch adds suspend/resume support for MPC8540, MPC8569 and<BR>
MPC8641D-compatible CPUs.<BR>
<BR>
MPC8540 and MPC8641D-compatible PMCs are trivial: we just write<BR>
the SLP bit into the PM control and status register.<BR>
<BR>
MPC8569 is a bit trickier, QE turns off during suspend, thus on<BR>
resume we must reload QE microcode and reset QE.<BR>
<BR>
So far we don't support Deep Sleep mode as found in newer MPC85xx<BR>
CPUs (i.e. MPC8536). It can be relatively easy implemented though,<BR>
and for it we reserve 'mem' suspend type.<BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CA29D3.58AD7957--
