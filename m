Return-Path: <michael@ellerman.id.au>
Subject: Re: powerpc commits for 2.6.24
From: Michael Ellerman <michael@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18190.49302.918402.952580@cargo.ozlabs.ibm.com>
References: <18190.5965.836544.396721@cargo.ozlabs.ibm.com>
	<1192148887.6274.10.camel@concordia>
	<18190.49302.918402.952580@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-EIJrOy4bbp+yKjm8O0Rp"
Date: Fri, 12 Oct 2007 10:37:41 +1000
Message-Id: <1192149461.6274.14.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-EIJrOy4bbp+yKjm8O0Rp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-10-12 at 10:32 +1000, Paul Mackerras wrote:
> Michael Ellerman writes:
>=20
> > Anything wrong with my patch "Fail early in lmb_remove_region()", it
> > generated no comment ..
>=20
> Just seems a little unnecessary given that the function in question is
> static, that's all...

Yeah true. I figured it was nice to have it spelled out in the code that
the routine is only valid for certain values of r - but I'm not fussed.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-EIJrOy4bbp+yKjm8O0Rp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHDsHVdSjSd0sB4dIRArNuAKDBcQvryTZ5LtEy+RLYWeJxFKIqFACgsTmt
qy+OKQj96bMZLnM7Gwcesxc=
=zfDn
-----END PGP SIGNATURE-----

--=-EIJrOy4bbp+yKjm8O0Rp--
