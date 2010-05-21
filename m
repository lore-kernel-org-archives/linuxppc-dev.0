Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 532E4B7D71
	for <linuxppc-dev@ozlabs.org>; Fri, 21 May 2010 23:04:43 +1000 (EST)
Date: Fri, 21 May 2010 15:04:17 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [git pull] Please pull powerpc.git next branch
Message-ID: <20100521130417.GB27829@pengutronix.de>
References: <1274433088.1931.63.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
In-Reply-To: <1274433088.1931.63.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Wolfram Sang (4):
>       powerpc/pmac: Fix dangling pointers
>       i2c/mpc: Drop NO_IRQ
>       i2c/cpm: Drop NO_IRQ
>       i2c/ibm-iic: Drop NO_IRQ

Sorry for the confusion, but the other Ben (Dooks) has pushed those
NO_IRQ-thigies meanwhile.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkv2hNEACgkQD27XaX1/VRu60QCgm3W5fvkTNJzcby/If0cSWC9d
I8EAn1MORnPkXUZ46HFyr5w9P2TDOxaT
=Ocp+
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
