Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id DD890DDE1B
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 14:01:43 +1000 (EST)
Date: Thu, 4 Oct 2007 14:01:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH] fsl_spi_init: Support non-QE processors
Message-Id: <20071004140126.99c0fab0.sfr@canb.auug.org.au>
In-Reply-To: <87lkakxky1.fsf@macbook.be.48ers.dk>
References: <87lkakxky1.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__4_Oct_2007_14_01_26_+1000_7H4mtDsBr+Z+kGNn"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__4_Oct_2007_14_01_26_+1000_7H4mtDsBr+Z+kGNn
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 03 Oct 2007 17:43:50 +0200 Peter Korsgaard <jacmet@sunsite.dk> wrot=
e:
>
> @@ -1220,14 +1220,17 @@ int __init fsl_spi_init(struct spi_board_info *bo=
ard_infos,
>  {
>  	struct device_node *np;
>  	unsigned int i;
> -	const u32 *sysclk;
> +	const u32 *qe_sysclk =3D 0, *soc_sysclk =3D 0;

Please use NULL when referring to pointers.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__4_Oct_2007_14_01_26_+1000_7H4mtDsBr+Z+kGNn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHBGWaTgG2atn1QN8RAgFBAJ9iN+iN1o90jIMFW4YuFSqtvoYvQwCeMUuU
FUoH9MvtD/RZPZZBxirqLL4=
=81Rt
-----END PGP SIGNATURE-----

--Signature=_Thu__4_Oct_2007_14_01_26_+1000_7H4mtDsBr+Z+kGNn--
