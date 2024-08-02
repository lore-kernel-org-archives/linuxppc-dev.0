Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3C0C3DA64
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Aug 2024 03:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1722568838;
	bh=kGRbpysvEg9nkhuWc3cjjTBxH5smVeo5U5B2p/BIuPE=;
	h=Date:To:Subject:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=IaLzo3IvEL5TQfLV+YQTeenizOqhnfun5gHy0efroUnRGonXkVQRIZBMeJ2Nqohi2
	 r4j3QEo2gjDqlqtSY2Cn3bXfMC5HvWYA0BhEAwfUa19i3Tt3cMyoYeXH79op1zcstY
	 +KMaGZH1pxcx3+ZKxQnCzgHq2T/czcMxNFc4ZptczvwUylsZ4wX0Zi34hg1psEdny5
	 ZuHP3FoMyza1iHdDGZGHkB2O9ZXTZms+wTeZ0Ch6OLOQHQ2AmX/KygOOgTtVVCCsEW
	 Oi5f4MPF0wfsTTl4BPpBtR7DvQFz0zElYXp4QrLajfo6IUAHpAV1jrlB7Iu/i/VRbo
	 YZ615vRT/0Z9A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WZrgp5GH9z3dTb
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Aug 2024 13:20:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.a=rsa-sha256 header.s=201702 header.b=Q828ydfB;
	dkim-atps=neutral
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WZrfw46bXz3cQ7
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Aug 2024 13:19:52 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WZrfw34czz4wbR
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Aug 2024 13:19:52 +1000 (AEST)
Date: Fri, 2 Aug 2024 13:19:51 +1000
To: ppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: List change - munging for From addresses
Message-ID: <20240802131951.326baaec@canb.auug.org.au>
In-Reply-To: <20240802130347.383a1b49@canb.auug.org.au>
References: <20240802130347.383a1b49@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yb0.WjwAZaABJU/E37TeghZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
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
From: Stephen Rothwell via Linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Reply-To: Stephen Rothwell <sfr@canb.auug.org.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/yb0.WjwAZaABJU/E37TeghZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all

On Fri, 2 Aug 2024 13:03:47 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> As more and more sites are using DKIM signing or emails (and DMARC),
> more and more of the list traffic is not being delivered due to Mailman
> altering messages in subtle ways (so the DKIM signature is no longer
> valid).  The easiest thing to do is to tell Mailman to munge the From:
> address so that the messages come from the mailing list itself.  It
> also adds a Reply-To: header with the original sender's address.
>=20
> So a message from me to the list will now have
>=20
> From: Stephen Rothwell via Linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
> Reply-To: Stephen Rothwell <sfr@canb.auug.org.au>
>=20
> The only real downside to this (I think) is that if you take a message
> from the list containing a patch and apply that to a git tree you will
> have to fix up the Author appropriately.

This has now been turned on (hopefully :-)).
--=20
Cheers,
Stephen Rothwell

--Sig_/yb0.WjwAZaABJU/E37TeghZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmasUFcACgkQAVBC80lX
0GzSNAf/SQF4MdeaoaFVW0QctCOgQGn79ZnVKtDxJcFJp8cacR24GZlIt9mPmSf7
exrl/O/eagUgizUJTU4x9b0QptwiQyEP/aSA4j3p/+oXKSUoXUBNuDZgfZL4rdIu
1Zfbm6iI58AQzHNoeLYfKtXYJivydU2jO0GTbYNKpp3w1xPaP/I9TDH38GTLIYkK
B9RTiUPjcGqclNsZn94Innb9UWrDDmju6GAUmkjN1NIDyX0ohN7e4pDqXsqj4kHg
OyZ8AV5Nfs5tqdIj2oOYPhSOGPx5ZWObaMVhCW+cUuCBAP02n5bJO983ZicvMiig
iGdInOXSb3NpSQZTtOGgF6VVYYYzIA==
=oEVf
-----END PGP SIGNATURE-----

--Sig_/yb0.WjwAZaABJU/E37TeghZ--
