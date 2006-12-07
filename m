Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 3/4] add rtas_service_present() helper
From: Michael Ellerman <michael@ellerman.id.au>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <11654526533213-git-send-email-ntl@pobox.com>
References: <11654526463043-git-send-email-ntl@pobox.com>
	<11654526511379-git-send-email-ntl@pobox.com>
	<11654526533213-git-send-email-ntl@pobox.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-nFBTp8Pl2NNWQlGHQF3a"
Date: Thu, 07 Dec 2006 13:51:33 +1100
Message-Id: <1165459893.14780.0.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-nFBTp8Pl2NNWQlGHQF3a
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-12-06 at 18:50 -0600, Nathan Lynch wrote:
> To test for the existence of an RTAS function, we typically do:
>=20
>    foo_token =3D rtas_token("foo");
>    if (foo_token =3D=3D RTAS_UNKNOWN_SERVICE)
>       return;
>=20
> Add a rtas_service_present method, which provides a more conventional
> boolean interface for testing the existence of an RTAS method.


I like it a lot ..

But should it be called rtas_token_present() ? :D

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-nFBTp8Pl2NNWQlGHQF3a
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFd4G1dSjSd0sB4dIRAoR8AKCZW70XpRrDdSdjnIE9HWEunorXpwCfRGtM
OArTIvG90iN/FAKNcPaJfgM=
=ROWd
-----END PGP SIGNATURE-----

--=-nFBTp8Pl2NNWQlGHQF3a--
