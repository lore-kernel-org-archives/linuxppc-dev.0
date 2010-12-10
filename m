Return-Path: <michael@ellerman.id.au>
Subject: RE: Problem with MPC8536 and external IRQs when using a loadable
	kernel module
From: Michael Ellerman <michael@ellerman.id.au>
To: Mark Pearson <Mark.Pearson@bladenetwork.net>
In-Reply-To: <11BA25866A2E3A45A797B469B2344B3901554D94@blademail.bladenetwork.net>
References: <11BA25866A2E3A45A797B469B2344B3901554D3D@blademail.bladenetwork.net>
	<1291937594.3523.20.camel@concordia>
	<11BA25866A2E3A45A797B469B2344B3901554D94@blademail.bladenetwork.net>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-8WKRMf9oFwC/MnDXBm0W"
Date: Fri, 10 Dec 2010 14:07:28 +1100
Message-ID: <1291950448.3574.5.camel@concordia>
Mime-Version: 1.0
Cc: b24347@freescale.com, linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-8WKRMf9oFwC/MnDXBm0W
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-12-09 at 17:20 -0800, Mark Pearson wrote:
> Magical - thank you very very much. The patch fixes the problem
>=20
> Really appreciate the quick response - and I would never have found that =
in a million years.

No worries.

Looks like someone should send 78e2e68a2b to the stable crew. FSL guys?

cheers

--=-8WKRMf9oFwC/MnDXBm0W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk0BmW0ACgkQdSjSd0sB4dKheQCfZpKeto2GAJzQhprbIvS0N6KL
h7YAoJCNaCSwW7qBKwsxJ4nMhO3i4guJ
=ohJd
-----END PGP SIGNATURE-----

--=-8WKRMf9oFwC/MnDXBm0W--
