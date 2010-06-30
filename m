Return-Path: <B04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1C3A1B6F06
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 11:16:15 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o5U1GC0b009053
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 18:16:12 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o5U1QRMb027391
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 20:26:28 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CB17F1.D3E50F5B"
Subject: Re: [linuxppc-release] [PATCH] powerpc: introduce basic support	for
	the Freescale P1022DS reference board
Date: Tue, 29 Jun 2010 18:16:08 -0700
Message-ID: <5610599F537DD74A8D1F5CC946A7507303478FFA@az33exm25.fsl.freescale.net>
In-Reply-To: <20100630011000.GA2684@lixom.net>
References: <1277847274-24648-1-git-send-email-timur@freescale.com>
	<22ED4111-892C-4715-BF70-C1E62F838DDA@kernel.crashing.org>
	<5610599F537DD74A8D1F5CC946A7507303478FF8@az33exm25.fsl.freescale.net>
	<20100630011000.GA2684@lixom.net>
From: "Tabi Timur-B04825" <B04825@freescale.com>
To: "Olof Johansson" <olof@lixom.net>
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

------_=_NextPart_001_01CB17F1.D3E50F5B
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Olof Johansson wrote:
> Sure, the family-defconfigs are supposed to be supersets that can boot
> everywhere. If you're concerned about static kernel size you can =
always
> enable it as modules instead.

It just seems wrong to add full support for audio and video in the =
kernel,=20
when it can be used only on one, relatively obscure chip.  Video support =

would need to be in-kernel only in order to get the console working, and =
I=20
suspect that core ALSA support would need to be in-kernel as well.

--=20
Timur Tabi
Linux kernel developer

------_=_NextPart_001_01CB17F1.D3E50F5B
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
<TITLE>Re: [linuxppc-release] [PATCH] powerpc: introduce basic support	=
for the Freescale P1022DS reference board</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Olof Johansson wrote:<BR>
&gt; Sure, the family-defconfigs are supposed to be supersets that can =
boot<BR>
&gt; everywhere. If you're concerned about static kernel size you can =
always<BR>
&gt; enable it as modules instead.<BR>
<BR>
It just seems wrong to add full support for audio and video in the =
kernel,<BR>
when it can be used only on one, relatively obscure chip.&nbsp; Video =
support<BR>
would need to be in-kernel only in order to get the console working, and =
I<BR>
suspect that core ALSA support would need to be in-kernel as well.<BR>
<BR>
--<BR>
Timur Tabi<BR>
Linux kernel developer<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CB17F1.D3E50F5B--
