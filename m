Return-Path: <fkan@amcc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 42A38B70D7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 22 Aug 2009 04:58:13 +1000 (EST)
Received: from sdcmail01.amcc.com (sdcmail01.amcc.com [198.137.200.72])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id A25A1DDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Aug 2009 04:58:12 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA2291.532C29F2"
Subject: RE: [PATCH 1/1] Fix ECC Correction bug for SMC ordering for NDFC
	driver.
Date: Fri, 21 Aug 2009 11:56:13 -0700
Message-ID: <2B3B2AA816369A4E87D7BE63EC9D2F260615A3D3@SDCEXCHANGE01.ad.amcc.com>
References: <1250813957-1786-1-git-send-email-fkan@amcc.com>
	<20090821145506.53275701@lappy.seanm.ca>
From: "Feng Kan" <fkan@amcc.com>
To: "Sean MacLennan" <smaclennan@pikatech.com>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA2291.532C29F2
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Yes, I have considered that. However, it would make the #define rather =
confusing
for the rest.

Cheers,
Feng


-----Original Message-----
From: Sean MacLennan [mailto:smaclennan@pikatech.com]
Sent: Fri 8/21/2009 11:55 AM
To: Feng Kan
Cc: linuxppc-dev@ozlabs.org; linux-mtd@lists.infradead.org; Feng Kan
Subject: Re: [PATCH 1/1] Fix ECC Correction bug for SMC ordering for =
NDFC driver.
=20
On Thu, 20 Aug 2009 17:19:17 -0700
Feng Kan <fkan@amcc.com> wrote:

> Fix ECC Correction bug where the byte offset location were double
> fliped causing correction routine to toggle the wrong byte location
> in the ECC segment. The ndfc_calculate_ecc routine change the order
> of getting the ECC code.

It looks like another fix for this bug is to leave the current code
alone and turn off CONFIG_MTD_NAND_ECC_SMC.

This could be a better fix if this is the way u-boot currently works.
Has anybody verified if the current u-boot has the ECC problem?

Cheers,
   Sean


------_=_NextPart_001_01CA2291.532C29F2
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7653.38">
<TITLE>RE: [PATCH 1/1] Fix ECC Correction bug for SMC ordering for NDFC =
driver.</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Yes, I have considered that. However, it would make =
the #define rather confusing<BR>
for the rest.<BR>
<BR>
Cheers,<BR>
Feng<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: Sean MacLennan [<A =
HREF=3D"mailto:smaclennan@pikatech.com">mailto:smaclennan@pikatech.com</A=
>]<BR>
Sent: Fri 8/21/2009 11:55 AM<BR>
To: Feng Kan<BR>
Cc: linuxppc-dev@ozlabs.org; linux-mtd@lists.infradead.org; Feng Kan<BR>
Subject: Re: [PATCH 1/1] Fix ECC Correction bug for SMC ordering for =
NDFC driver.<BR>
<BR>
On Thu, 20 Aug 2009 17:19:17 -0700<BR>
Feng Kan &lt;fkan@amcc.com&gt; wrote:<BR>
<BR>
&gt; Fix ECC Correction bug where the byte offset location were =
double<BR>
&gt; fliped causing correction routine to toggle the wrong byte =
location<BR>
&gt; in the ECC segment. The ndfc_calculate_ecc routine change the =
order<BR>
&gt; of getting the ECC code.<BR>
<BR>
It looks like another fix for this bug is to leave the current code<BR>
alone and turn off CONFIG_MTD_NAND_ECC_SMC.<BR>
<BR>
This could be a better fix if this is the way u-boot currently =
works.<BR>
Has anybody verified if the current u-boot has the ECC problem?<BR>
<BR>
Cheers,<BR>
&nbsp;&nbsp; Sean<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CA2291.532C29F2--
