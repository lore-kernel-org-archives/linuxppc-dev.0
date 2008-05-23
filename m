Return-Path: <michael@ellerman.id.au>
Subject: RE: [PATCH] [POWERPC] Fix return value check logic
From: Michael Ellerman <michael@ellerman.id.au>
To: Medve Emilian <Emilian.Medve@freescale.com>
In-Reply-To: <598D5675D34BE349929AF5EDE9B03E2701F48298@az33exm24.fsl.freescale.net>
References: <1211485762-29637-1-git-send-email-Emilian.Medve@Freescale.com>
	<1211505190.7671.6.camel@localhost>
	<598D5675D34BE349929AF5EDE9B03E2701F4828E@az33exm24.fsl.freescale.net>
	<598D5675D34BE349929AF5EDE9B03E2701F48298@az33exm24.fsl.freescale.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-muIyDinwju9bJagU6ZOn"
Date: Sat, 24 May 2008 00:52:05 +1000
Message-Id: <1211554325.16348.8.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linuxppc-embedded@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-muIyDinwju9bJagU6ZOn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-05-23 at 07:39 -0700, Medve Emilian wrote:
> Hello Michael,
>=20
>=20
> > > That won't work if CONFIG_DEBUG_FS is not defined, because in=20
> > > that case
> > > debugfs_create_file() returns -ENODEV.
> >=20
> > Will respin.
>=20
> At a second glance in arch/powerpc/Kconfig.debug, VIRQ_DEBUG depends on
> DEBUG_FS so I think that the patch should work as is.

You're right, thanks for checking. In that case:

Acked-by: Michael Ellerman <michael@ellerman.id.au>

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-muIyDinwju9bJagU6ZOn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBINtoVdSjSd0sB4dIRAv7RAJ0Tt8XGDOCOaj3va1d/EYBoJL5QywCgufBF
wRUMzFdRM/PHTVVVIje1f5s=
=lK8v
-----END PGP SIGNATURE-----

--=-muIyDinwju9bJagU6ZOn--
