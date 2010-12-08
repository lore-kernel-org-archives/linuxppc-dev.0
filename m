Return-Path: <michael@ellerman.id.au>
Subject: Re: Getting the IRQ number (Was: Basic driver devel questions ?)
From: Michael Ellerman <michael@ellerman.id.au>
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
In-Reply-To: <201012071346.13434.dargaud@lpsc.in2p3.fr>
References: <201012011115.00960.dargaud@lpsc.in2p3.fr>
	<201012031558.35557.dargaud@lpsc.in2p3.fr>
	<1291613340.11896.216.camel@concordia>
	<201012071346.13434.dargaud@lpsc.in2p3.fr>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-h6WYmbdS21eKnY/SP9Xq"
Date: Wed, 08 Dec 2010 11:50:35 +1100
Message-ID: <1291769435.2041.88.camel@concordia>
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


--=-h6WYmbdS21eKnY/SP9Xq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-12-07 at 13:46 +0100, Guillaume Dargaud wrote:
> Michael,=20
> in your example, when is foo_driver_probe() actually called ?
> It's not being called when I do an insmod.

It should be called when the driver core finds a device that matches
your match table.

When you register your driver the driver core will iterate over all
devices on the platform bus and if they match then it will call your
probe routine.

I assume you've update the compatible property in the match table, I'm
not sure what else could be causing it to not be called.

cheers

--=-h6WYmbdS21eKnY/SP9Xq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkz+1lsACgkQdSjSd0sB4dLQEwCffHy4YU2dMDAvNgcszZEmldQD
OM0AoKO6Jh1rEgwuO4dLk6Q+4C2E9eVe
=cOTW
-----END PGP SIGNATURE-----

--=-h6WYmbdS21eKnY/SP9Xq--
