Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4115FDDDCA
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 09:36:16 +1100 (EST)
Date: Tue, 6 Nov 2007 09:36:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] Replace some #includes of asm/of_platform.h with
	linux/of_platform.h.
Message-Id: <20071106093607.329b29f6.sfr@canb.auug.org.au>
In-Reply-To: <1194296705.7158.45.camel@ld0161-tx32>
References: <1194296705.7158.45.camel@ld0161-tx32>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__6_Nov_2007_09_36_07_+1100_5Y1f/sebuOjoznnC"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__6_Nov_2007_09_36_07_+1100_5Y1f/sebuOjoznnC
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jon,

Thanks for starting this.

On Mon, 05 Nov 2007 15:05:06 -0600 Jon Loeliger <jdl@freescale.com> wrote:
>
> From: Jon Loeliger <jdl@freescale.com>
>=20
> Signed-off-by: Jon Loeliger <jdl@freescale.com>

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

>  #include <asm/of_device.h>

asm/of_device.h -> linux/of_device.h as well?  :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__6_Nov_2007_09_36_07_+1100_5Y1f/sebuOjoznnC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHL5riTgG2atn1QN8RAg6uAJwLi/EApWDqPr2VV/dswMav10ne5wCeMYlX
p9UMNHGmSXJTMm5kl5mkfZ0=
=Pulk
-----END PGP SIGNATURE-----

--Signature=_Tue__6_Nov_2007_09_36_07_+1100_5Y1f/sebuOjoznnC--
