Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 97E16DDE37
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 00:02:32 +1000 (EST)
Date: Thu, 18 Oct 2007 00:02:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [PATCH 3/4] [POWERPC] Add restart support for mpc52xx based
	platforms
Message-Id: <20071018000222.1bf53d3c.sfr@canb.auug.org.au>
In-Reply-To: <471607A8.6050203@semihalf.com>
References: <47160689.4020301@semihalf.com>
	<471607A8.6050203@semihalf.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__18_Oct_2007_00_02_22_+1000_Klm4lcKmiiIGQ=K5"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__18_Oct_2007_00_02_22_+1000_Klm4lcKmiiIGQ=K5
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Oct 2007 15:01:28 +0200 Marian Balakowicz <m8@semihalf.com> wrot=
e:
>
> +void __init
> +mpc52xx_map_wdt(void)
> +{
> +        const void *has_wdt;
   ^^^^^^^^
white space damage

> +	struct device_node *np;
> +
> +	/* mpc52xx_wdt is mapped here and used in mpc52xx_restart,
> +	 * possibly from a interrupt context. */
> +
> +	for (np =3D NULL;
> +	    (np =3D of_find_compatible_node(np, NULL, "fsl,mpc5200-gpt")) !=3D =
NULL;
> +	    ) {

	for_each_compatible_node(np, NULL, "fsl,mpc5200-gpt") {

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__18_Oct_2007_00_02_22_+1000_Klm4lcKmiiIGQ=K5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHFhX0TgG2atn1QN8RAt5vAJ9CiNfb9Q5VMyHuebPlQTgyLLIh/gCaA4i/
XJ7P4+aBlLJ1aTlEkejKuUU=
=wsKP
-----END PGP SIGNATURE-----

--Signature=_Thu__18_Oct_2007_00_02_22_+1000_Klm4lcKmiiIGQ=K5--
