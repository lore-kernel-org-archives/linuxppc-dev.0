Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A2569DE2C2
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Apr 2008 12:03:10 +1000 (EST)
Date: Mon, 14 Apr 2008 12:03:02 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] [POWERPC] remove include of asm/of_device.h from pmi.h
Message-Id: <20080414120302.8601b25a.sfr@canb.auug.org.au>
In-Reply-To: <20080414120047.8144976b.sfr@canb.auug.org.au>
References: <20080414120047.8144976b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__14_Apr_2008_12_03_02_+1000_HHtjM9p_7ExGn6R6"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__14_Apr_2008_12_03_02_+1000_HHtjM9p_7ExGn6R6
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Apr 2008 12:00:47 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> pmi.h does not diectly reference anything in of_device.h and of the two
> files that include asm/pmi.h, one includes of_device.h and the other
> includes of_platform.h (which includes of_device.h).
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

I forgot to say this has been built for ppc64_defconfig and
cell_defconfig (the only two configs that use it).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__14_Apr_2008_12_03_02_+1000_HHtjM9p_7ExGn6R6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIArtaTgG2atn1QN8RAv+6AJ4xoDEc/AoNEe/qD3vI6s/SEUvixQCffJTx
Y112TgBuhHJMqLqpdh327Vc=
=g5Hc
-----END PGP SIGNATURE-----

--Signature=_Mon__14_Apr_2008_12_03_02_+1000_HHtjM9p_7ExGn6R6--
