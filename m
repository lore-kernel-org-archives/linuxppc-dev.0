Return-Path: <B04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5C67DB6F35
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 09:38:03 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o5TNc0pe000241
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 16:38:00 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o5TNmFoK028008
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 18:48:16 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CB17E4.1C1A640E"
Subject: Re: [linuxppc-release] [PATCH] powerpc: introduce basic support for
	the Freescale P1022DS reference board
Date: Tue, 29 Jun 2010 16:37:59 -0700
Message-ID: <5610599F537DD74A8D1F5CC946A7507303478FF8@az33exm25.fsl.freescale.net>
In-Reply-To: <22ED4111-892C-4715-BF70-C1E62F838DDA@kernel.crashing.org>
References: <1277847274-24648-1-git-send-email-timur@freescale.com>
	<22ED4111-892C-4715-BF70-C1E62F838DDA@kernel.crashing.org>
From: "Tabi Timur-B04825" <B04825@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CB17E4.1C1A640E
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Kumar Gala wrote:

> Drop the defconfig and update mpc85xx_{smp_}defconfig to build p1022.

What about video and audio support?  I'm going to add that later?  We =
don't=20
want to compile the DIU and SSI drivers on all 85xx systems, do we?

--=20
Timur Tabi
Linux kernel developer

------_=_NextPart_001_01CB17E4.1C1A640E
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
<TITLE>Re: [linuxppc-release] [PATCH] powerpc: introduce basic support =
for the Freescale P1022DS reference board</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Kumar Gala wrote:<BR>
<BR>
&gt; Drop the defconfig and update mpc85xx_{smp_}defconfig to build =
p1022.<BR>
<BR>
What about video and audio support?&nbsp; I'm going to add that =
later?&nbsp; We don't<BR>
want to compile the DIU and SSI drivers on all 85xx systems, do we?<BR>
<BR>
--<BR>
Timur Tabi<BR>
Linux kernel developer<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CB17E4.1C1A640E--
