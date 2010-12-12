Return-Path: <michael@ellerman.id.au>
Subject: Re: Getting the IRQ number (Was: Basic driver devel questions ?)
From: Michael Ellerman <michael@ellerman.id.au>
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
In-Reply-To: <201012101721.03689.dargaud@lpsc.in2p3.fr>
References: <201012011115.00960.dargaud@lpsc.in2p3.fr>
	<201012081652.13209.dargaud@lpsc.in2p3.fr>
	<1291854156.14490.32.camel@concordia>
	<201012101721.03689.dargaud@lpsc.in2p3.fr>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-jBsvhBoWpQFg5/I2F9pk"
Date: Mon, 13 Dec 2010 08:46:11 +1100
Message-ID: <1292190371.14908.4.camel@concordia>
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


--=-jBsvhBoWpQFg5/I2F9pk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-12-10 at 17:21 +0100, Guillaume Dargaud wrote:
> Hello all,

>=20
> > Also turn on CONFIG_DEBUG_DRIVER and see if that gives you anything
> > interesting.
>=20
> I see an unset CONFIG_DEBUG_KERNEL but no CONFIG_DEBUG_DRIVER in the .con=
fig of=20
> my current kernel.=20

Right you'd need to turn on CONFIG_DEBUG_KERNEL first, and then
CONFIG_DEBUG_DRIVER will appear.

> Does it need to be changed in the .config with a full kernel recompilatio=
n, or=20
> can I still benefit from it in my module only by doing a #define at the b=
egining=20
> of my code ? Some #defines like DEBUG seem to work locally on things like=
=20
> dev_dbg but I doubt the CONFIG_* work the same...

No you'd need to rebuild your kernel. DEBUG is the only #define I can
think of that has an effect locally. Using different values for a
CONFIG_ in the kernel vs modules will not work.

> > Er. Not sure sorry. I can't see anything obviously wrong. Maybe post
> > your driver code again.
>=20
> Err... I ran it again this morning and it worked farther. I now get into =
the=20
> probe function and can now register my interrupt, yeah!, but I don't see =
the=20
> ISR being called. I'm currently checking if it can be a hardware problem=
=20
> before coming back here for more questions !

Great!

> BTW, is errno/strerror used within the kernel ?

Nope.

cheers



--=-jBsvhBoWpQFg5/I2F9pk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk0FQqAACgkQdSjSd0sB4dKFTgCgsGXcmUIar1F058qgD+jqLhK+
RzQAn2sqrv6TO3fnIHGMit5BRXNdda8l
=PXLG
-----END PGP SIGNATURE-----

--=-jBsvhBoWpQFg5/I2F9pk--
