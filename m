Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B2135DDE3C
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 01:48:27 +1100 (EST)
Date: Tue, 5 Feb 2008 01:48:21 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] [POWERPC] qe_lib: fix few fluffy negligences (was: Re:
	[PATCH 1/5] [POWERPC] qe_lib and users: get rid of most device_types
	and model)
Message-Id: <20080205014821.863e020d.sfr@canb.auug.org.au>
In-Reply-To: <20080204134617.GA10377@localhost.localdomain>
References: <20080124151850.GA15190@localhost.localdomain>
	<20080124153959.GA23246@localhost.localdomain>
	<20080205001318.5fbc60fa.sfr@canb.auug.org.au>
	<20080204134617.GA10377@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__5_Feb_2008_01_48_21_+1100_S9W9_7DHgiW3HsVW"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__5_Feb_2008_01_48_21_+1100_S9W9_7DHgiW3HsVW
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Feb 2008 16:46:17 +0300 Anton Vorontsov <avorontsov@ru.mvista.com=
> wrote:
>
> On Tue, Feb 05, 2008 at 12:13:18AM +1100, Stephen Rothwell wrote:
> >=20
> > If you don't care about the returned length (argument three to
> > of_get_property), you can just pass NULL (and dispense with "size").
> > Also, what happens if prop is NULL?
>=20
> All this was in the old code already, I just didn't fix that.

I appreciate that, but it did need fixing.

> - - - -
> From: Anton Vorontsov <avorontsov@ru.mvista.com>
> Subject: [POWERPC] qe_lib: fix few fluffy negligences
>=20
> One is intoduced by me (of_node_put() absence) and another was
> present already (not checking for NULL).
>=20
> Found by Stephen Rothwell.
>=20
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__5_Feb_2008_01_48_21_+1100_S9W9_7DHgiW3HsVW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHpyW7TgG2atn1QN8RAve8AJ9hl5Ngh8bk6gTD2c7kjJfHzbiivQCfc2Dd
WjXzd3dIB5DRIklUnuhFaWk=
=Lzv1
-----END PGP SIGNATURE-----

--Signature=_Tue__5_Feb_2008_01_48_21_+1100_S9W9_7DHgiW3HsVW--
