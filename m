Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 10/14] powerpc: Consolidate feature fixup macros for
	64/32 bit
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <C05CA179-C72C-4BAB-8EFE-6D326B9E130D@kernel.crashing.org>
References: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
	<f05ebfb9b74b4244142895b4252be6a70905e69e.1214271072.git.michael@ellerman.id.au>
	<C05CA179-C72C-4BAB-8EFE-6D326B9E130D@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-NeixBcQaApkOd/PsNR5H"
Date: Thu, 26 Jun 2008 13:47:20 +1000
Message-Id: <1214452040.32022.9.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-NeixBcQaApkOd/PsNR5H
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-06-24 at 08:48 -0500, Kumar Gala wrote:
> On Jun 23, 2008, at 8:32 PM, Michael Ellerman wrote:
>=20
> > Currentl we have three versions of MAKE_FTR_SECTION_ENTRY(), the =20
> > macro that
> > generates a feature section entry. There is 64bit version, a 32bit =20
> > version
> > and version for 32bit code built with a 64bit kernel.
>=20
> typo in 'currentl'

Damn it, I thought I fixed that one, or perhaps it was the "currently"
in the other patch.

Perhaps paulus can fix it for me when he commits :D

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-NeixBcQaApkOd/PsNR5H
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIYxFIdSjSd0sB4dIRAhnzAJ46e9OnlyJYd/VSHE+OvwSG6g86bwCgykln
/DvhUYibsKDkIVOtEEbkuBE=
=nkhQ
-----END PGP SIGNATURE-----

--=-NeixBcQaApkOd/PsNR5H--
