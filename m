Return-Path: <sfr@canb.auug.org.au>
Date: Wed, 26 Sep 2007 10:59:18 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH 2/2] fsl/embedded6xx: don't cast the result of
	of_get_property
Message-Id: <20070926105918.b3ca3db5.sfr@canb.auug.org.au>
In-Reply-To: <200709261052.25044.jk@ozlabs.org>
References: <1189748800.165136.731062325870.1.gpush@pokey>
	<1189748800.165997.810365539433.2.gpush@pokey>
	<20070926104419.1b92002e.sfr@canb.auug.org.au>
	<200709261052.25044.jk@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__26_Sep_2007_10_59_18_+1000_FItAePLfQD54dryl"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__26_Sep_2007_10_59_18_+1000_FItAePLfQD54dryl
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Sep 2007 10:52:23 +1000 Jeremy Kerr <jk@ozlabs.org> wrote:
>
> Stephen,
>=20
> > If you don't use the value of the len variable, then you can pass
> > NULL to of_get_property.
>=20
> Sure, but that's probably a separate patch, no ?

OK.

> > Not *phys_addr?
>=20
> That's what the existing code does. I'm guessing that it treats=20
> phys_addr as an array with one entry, not a single u32.

OK.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__26_Sep_2007_10_59_18_+1000_FItAePLfQD54dryl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG+a7qTgG2atn1QN8RAjK7AJ9MRsOm3Le08iGM2R45rWgJ3I16GQCeJqt+
abZ2hURfuK6CXASecNSAU3o=
=uerr
-----END PGP SIGNATURE-----

--Signature=_Wed__26_Sep_2007_10_59_18_+1000_FItAePLfQD54dryl--
