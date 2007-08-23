Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 80ADFDDEEE
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 13:24:28 +1000 (EST)
Date: Thu, 23 Aug 2007 13:24:21 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH v6 1/2] [POWERPC] fsl_soc: add support for fsl_spi
Message-Id: <20070823132421.d2b230af.sfr@canb.auug.org.au>
In-Reply-To: <20070822145732.GA22686@localhost.localdomain>
References: <20070822145415.GA22595@localhost.localdomain>
	<20070822145732.GA22686@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__23_Aug_2007_13_24_21_+1000_1Uv65YVrVEW33B53"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__23_Aug_2007_13_24_21_+1000_1Uv65YVrVEW33B53
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Anton,

On Wed, 22 Aug 2007 18:57:32 +0400 Anton Vorontsov <avorontsov@ru.mvista.co=
m> wrote:
>
> +	sysclk =3D *(u32 *)of_get_property(np, "bus-frequency", NULL);

I just cringe everytime I see someone dereference a pointer they got from
somewhere (effectively) external without checking for NULL.  I realise
that sometimes "that can't happen" ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__23_Aug_2007_13_24_21_+1000_1Uv65YVrVEW33B53
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGzP3rTgG2atn1QN8RAgn9AKCXdCgNtU2PY3ZrpVLDW78/PygcJgCgjLKd
AktaQgALXG/TVs5+uMN1rSE=
=07uE
-----END PGP SIGNATURE-----

--Signature=_Thu__23_Aug_2007_13_24_21_+1000_1Uv65YVrVEW33B53--
