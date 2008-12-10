Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 7D44DDDF85
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 10:06:50 +1100 (EST)
Date: Thu, 11 Dec 2008 10:06:35 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Matteo Fortini <m.fortini@selcomgroup.com>
Subject: Re: [PATCH] ADS5121 Fix: put dummy byte to enable fixing EOF bug to
	first place in order not to break some drivers\nUse ALARM interrupt to
	avoid waiting for data to come in
Message-Id: <20081211100635.be00463c.sfr@canb.auug.org.au>
In-Reply-To: <49400F56.2040008@selcomgroup.com>
References: <49400F56.2040008@selcomgroup.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__11_Dec_2008_10_06_35_+1100_FT5I5Jzi7c_Ak8ph"
Cc: linuxppc-dev@ozlabs.org, John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__11_Dec_2008_10_06_35_+1100_FT5I5Jzi7c_Ak8ph
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Matteo,

On Wed, 10 Dec 2008 19:49:58 +0100 Matteo Fortini <m.fortini@selcomgroup.co=
m> wrote:
>
>  From d500e922b750a2bea554d32d8f12937f4da9c80a Mon Sep 17 00:00:00 2001
> From: Matteo Fortini <m.fortini@selcomgroup.com>
> Date: Wed, 10 Dec 2008 19:33:16 +0100
> Subject: [PATCH] Fix: put dummy byte to enable fixing EOF bug to first=20
> place in order not to break some drivers
>  Use ALARM interrupt to avoid waiting for data to come in

Please don't make unrelated cleanups in patches - it makes it very hard
for the reviewers to do their work.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__11_Dec_2008_10_06_35_+1100_FT5I5Jzi7c_Ak8ph
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklAS3wACgkQjjKRsyhoI8yM7gCgnhraiPw1DUsRZfmZ8q8DPkzV
Ph0An3ELgldVEONOxBhQ8nNnvW5vPNl8
=XJEM
-----END PGP SIGNATURE-----

--Signature=_Thu__11_Dec_2008_10_06_35_+1100_FT5I5Jzi7c_Ak8ph--
