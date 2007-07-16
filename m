Return-Path: <michael@ellerman.id.au>
Subject: Re: possible dead CONFIG-related content under arch/powerpc
From: Michael Ellerman <michael@ellerman.id.au>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.62.0707161116280.1072@pademelon.sonytel.be>
References: <Pine.LNX.4.64.0707141816470.9751@localhost.localdomain>
	<Pine.LNX.4.62.0707161116280.1072@pademelon.sonytel.be>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ZuLm5th3bD8Cg/2/cBPm"
Date: Mon, 16 Jul 2007 23:05:14 +1000
Message-Id: <1184591114.17330.1.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>,
	"Robert P. J. Day" <rpjday@mindspring.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-ZuLm5th3bD8Cg/2/cBPm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-07-16 at 11:16 +0200, Geert Uytterhoeven wrote:
> On Sat, 14 Jul 2007, Robert P. J. Day wrote:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SPE_BASE =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > arch/powerpc/mm/hash_utils_64.c:612:#ifdef CONFIG_SPE_BASE
> > arch/powerpc/mm/hash_utils_64.c:747:#ifdef CONFIG_SPE_BASE
>=20
> Interesting, should this one be CONFIG_SPU_BASE?

Yes, ouch.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-ZuLm5th3bD8Cg/2/cBPm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGm20KdSjSd0sB4dIRAlP/AJ9t1IMOcGsQ9UovpK56vByQ4uT1pwCgs3Mx
LIn3U8DxD+c+aEFluAJK4Fs=
=MEXu
-----END PGP SIGNATURE-----

--=-ZuLm5th3bD8Cg/2/cBPm--
