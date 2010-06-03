Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: unconditionally enabled irq stacks
From: Michael Ellerman <michael@ellerman.id.au>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20100603082426.GA6110@lst.de>
References: <20100603082426.GA6110@lst.de>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-ppjeqZgX/US0kV8KnW79"
Date: Thu, 03 Jun 2010 23:39:41 +1000
Message-ID: <1275572381.32304.9.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-ppjeqZgX/US0kV8KnW79
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-06-03 at 10:24 +0200, Christoph Hellwig wrote:
> Irq stacks provide an essential protection from stack overflows through
> external interrupts, at the cost of two additionals stacks per CPU.
>=20
> Enable them unconditionally to simplify the kernel build and prevent
> people from accidentally disabling them.

Since when did we worry about simplifying the kernel build? :)

I'm thinking embedded folks might prefer the reduction in stack space,
though I guess we'll let them speak for themselves. Perhaps it could
depend on EMBEDDED?

It's not like it's a lot of extra code.

cheers




--=-ppjeqZgX/US0kV8KnW79
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkwHsJoACgkQdSjSd0sB4dLvAgCgrml9tYUBhnyC2uC1QqfCzJ8V
sjIAoIyIyDPyNsCP8ikXbyi/8A1DwB1b
=Wclo
-----END PGP SIGNATURE-----

--=-ppjeqZgX/US0kV8KnW79--
