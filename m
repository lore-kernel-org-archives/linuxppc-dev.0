Return-Path: <B04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 12A46B6EFE
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Jul 2010 22:48:56 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o63CmaQi003269
	for <linuxppc-dev@ozlabs.org>; Sat, 3 Jul 2010 05:48:47 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o63D17Q1011558
	for <linuxppc-dev@ozlabs.org>; Sat, 3 Jul 2010 08:01:08 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CB1AAE.0C5D1306"
Subject: Re: [PATCH] [v2] powerpc: introduce basic support for the Freescale
	P1022DS reference board
Date: Sat, 3 Jul 2010 05:48:32 -0700
Message-ID: <5610599F537DD74A8D1F5CC946A7507303479009@az33exm25.fsl.freescale.net>
In-Reply-To: <4C2EE056.1050506@embedded-sol.com>
References: <1278109503-7604-1-git-send-email-timur@freescale.com>
	<4C2EE056.1050506@embedded-sol.com>
From: "Tabi Timur-B04825" <B04825@freescale.com>
To: "Felix Radensky" <felix@embedded-sol.com>
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

------_=_NextPart_001_01CB1AAE.0C5D1306
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Felix Radensky wrote:
>
> There are currently no drivers in mainline for FSL eSPI controller and
> eSPI flash.
> They are present only in FSL BSP kernel. Do you think it makes sense =
to
> keep
> DTS entries for something that is not supported ?

Yes, for two reasons:

1) The DTS is supposed to describe the hardware, regardless as to =
whether=20
there are drivers for everything.  There's no audio support, but I have =
the=20
SSI node there anyway.

2) We will eventually support the SPI in the mainline kernel.  I think =
our=20
plan is to merge the SPI and eSPI drivers together first.

--=20
Timur Tabi
Linux kernel developer

------_=_NextPart_001_01CB1AAE.0C5D1306
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
<TITLE>Re: [PATCH] [v2] powerpc: introduce basic support for the =
Freescale P1022DS reference board</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Felix Radensky wrote:<BR>
&gt;<BR>
&gt; There are currently no drivers in mainline for FSL eSPI controller =
and<BR>
&gt; eSPI flash.<BR>
&gt; They are present only in FSL BSP kernel. Do you think it makes =
sense to<BR>
&gt; keep<BR>
&gt; DTS entries for something that is not supported ?<BR>
<BR>
Yes, for two reasons:<BR>
<BR>
1) The DTS is supposed to describe the hardware, regardless as to =
whether<BR>
there are drivers for everything.&nbsp; There's no audio support, but I =
have the<BR>
SSI node there anyway.<BR>
<BR>
2) We will eventually support the SPI in the mainline kernel.&nbsp; I =
think our<BR>
plan is to merge the SPI and eSPI drivers together first.<BR>
<BR>
--<BR>
Timur Tabi<BR>
Linux kernel developer<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CB1AAE.0C5D1306--
