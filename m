Return-Path: <michael@ellerman.id.au>
Subject: Re: Getting the IRQ number (Was: Basic driver devel questions ?)
From: Michael Ellerman <michael@ellerman.id.au>
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
In-Reply-To: <201012081652.13209.dargaud@lpsc.in2p3.fr>
References: <201012011115.00960.dargaud@lpsc.in2p3.fr>
	<201012081118.13977.dargaud@lpsc.in2p3.fr>
	<1291815910.12093.15.camel@concordia>
	<201012081652.13209.dargaud@lpsc.in2p3.fr>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-inBhvivyPyBPVa/y7jk6"
Date: Thu, 09 Dec 2010 11:22:36 +1100
Message-ID: <1291854156.14490.32.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-inBhvivyPyBPVa/y7jk6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-12-08 at 16:52 +0100, Guillaume Dargaud wrote:
> > Sorry I assumed you were working on mainline. In 2.6.35 you still need
> > to use an of_platform_driver, I'll describe below.
>=20
> > So basically you need to change all occurrences of platform_driver to
> > of_platform_driver.
>=20
> OK, thanks, I did that, compiled and ran the driver and its test prog... =
no=20
> changes: xad_driver_probe() doesn't get called.
> ...?

Er. Not sure sorry. I can't see anything obviously wrong. Maybe post
your driver code again.

Also turn on CONFIG_DEBUG_DRIVER and see if that gives you anything
interesting.

cheers



--=-inBhvivyPyBPVa/y7jk6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk0AIUwACgkQdSjSd0sB4dKyAwCfUX1NEL2KTUZDINog1bxbCUmZ
SMIAn3N/c7adHjFvBopzK3oXo6QaZmjx
=bMjN
-----END PGP SIGNATURE-----

--=-inBhvivyPyBPVa/y7jk6--
