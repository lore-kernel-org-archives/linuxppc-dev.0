Return-Path: <SRS0=TJyh=PE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C522C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Dec 2018 02:34:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84EE22148E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Dec 2018 02:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84EE22148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43QDS36KRmzDqPK
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Dec 2018 13:34:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=decadent.org.uk
 (client-ip=88.96.1.126; helo=shadbolt.e.decadent.org.uk;
 envelope-from=ben@decadent.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=decadent.org.uk
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
 [88.96.1.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43QDPw5VXfzDqLM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Dec 2018 13:32:19 +1100 (AEDT)
Received: from [192.168.4.242] (helo=deadeye)
 by shadbolt.decadent.org.uk with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ben@decadent.org.uk>)
 id 1gcLT1-0007BB-SM; Thu, 27 Dec 2018 02:32:11 +0000
Received: from ben by deadeye with local (Exim 4.91)
 (envelope-from <ben@decadent.org.uk>)
 id 1gcLT1-0000Sg-NV; Thu, 27 Dec 2018 02:32:11 +0000
Message-ID: <99f1a5d8ffcb3539b653a5f123ef32735f389af4.camel@decadent.org.uk>
Subject: Re: [PATCH] powerpc: Fix -mcpu= options for SPE-only compiler
From: Ben Hutchings <ben@decadent.org.uk>
To: Segher Boessenkool <segher@kernel.crashing.org>
Date: Thu, 27 Dec 2018 02:32:07 +0000
In-Reply-To: <20181226234552.GA28554@gate.crashing.org>
References: <20181226141511.3ag7uf6rvdgzlmxt@decadent.org.uk>
 <20181226234552.GA28554@gate.crashing.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-EmAlMc7ALx5E7Io3l5uk"
User-Agent: Evolution 3.30.3-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk);
 SAEximRunCond expanded to false
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, debian-kernel@lists.debian.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--=-EmAlMc7ALx5E7Io3l5uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-12-26 at 17:45 -0600, Segher Boessenkool wrote:
> Hi!
>=20
> On Wed, Dec 26, 2018 at 02:15:11PM +0000, Ben Hutchings wrote:
> > GCC for Debian's "powerpcspe" architecture only supports 32-bit
> > SPE targets, and using -mcpu=3Dpowerpc or -mcpu=3Dpowerpc64 is a fatal
> > error.
>=20
> I don't see where your patch touches -mcpu=3Dpowerpc, and I don't see how
> it would make a difference either?

Look at the assignments that are conditional on HAS_BIARCH.

> > +ifdef CONFIG_PPC64
> >  ifdef CONFIG_PPC_BOOK3S_64
> >  ifdef CONFIG_CPU_LITTLE_ENDIAN
> >  CFLAGS-$(CONFIG_GENERIC_CPU) +=3D -mcpu=3Dpower8
> > @@ -177,6 +178,7 @@ endif
> >  else
> >  CFLAGS-$(CONFIG_GENERIC_CPU) +=3D -mcpu=3Dpowerpc64
> >  endif
> > +endif
>=20
> How can CONFIG_PPC_BOOK3S_64 be true while CONFIG_PPC64 is fals?  That
> does not make a lot of sense.

But there is an "else" part here.

Ben.

--=20
Ben Hutchings
Life is what happens to you while you're busy making other plans.
                                                          - John Lennon



--=-EmAlMc7ALx5E7Io3l5uk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlwkOacACgkQ57/I7JWG
EQm+Cw//XmZeSD4gKpZiT296LG9A6QEGp+gWC3xEcM56M5hiPs17VG+/itXPGKn6
P88ZzUThia85D8Kgm/ENGu3UzulyL3bOLw0hNpzR4gJt2FChpv/U8tJfIoTebpL0
s1qLhbFwPDh4dfw/B+zqUvg7+QeQBEpdgWteDE8/1ayQRvs6fo/QRyQtmS0wfZ7R
BbHLbGMCXPciyGbGPfMujgkArZW+CmEKV+w+q9fQLFS+OkUDv5bT0DopTWIJpB0K
K+gy+yjzXTO+lihKvJXUUD+r4Pn56EbtIjXj4xQrdrjNtnbgEDEjBPOfg60v6uqT
6Ka3ulBWN9vFIS/5mceRUHcArSV2yUPp5Gz5HrbAeGxgr0QdsVIWVIXyZ9Jitm4e
OtL0aqTfvMOomsr1cbK9+DSgCsmU+zraa576cFZQLOdV0BqbDBuD/jol7x3rGe2v
w9bI8BfKR+dU7xHIIE73oYICAt1/6X1tcyffxWuONImcPz/uXGbhYfPlg4oEvxNm
QxtRWlG9aVqHwYdMsfPcwjvNtDXiuP0cbIWcfbZIBF93KJVnrs+eZfs1GjHyXeaa
Q+x8YQ+Duq0KNyK0uxEZK9rc2jvyW1SvAp0wrQ2+qVEEew6luBiM8ITgr8HxqnqO
2cDOMiPGrlkOQ3uNJ+AFa6vq2rOv6QsEjx4/vHeUfyGyAXtPy0Q=
=sxAl
-----END PGP SIGNATURE-----

--=-EmAlMc7ALx5E7Io3l5uk--
