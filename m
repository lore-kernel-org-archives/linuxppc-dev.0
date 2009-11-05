Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] PCI: Fix regression in powerpc MSI-X
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <200911041303.19695.adetsch@br.ibm.com>
References: <200911041303.19695.adetsch@br.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-M0SueCfVAxJvn4wr3GKn"
Date: Thu, 05 Nov 2009 12:17:57 +1100
Message-Id: <1257383877.2361.10.camel@concordia>
Mime-Version: 1.0
Cc: Andre Detsch <adetsch@br.ibm.com>, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-M0SueCfVAxJvn4wr3GKn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-11-04 at 13:03 -0200, Andre Detsch wrote:
> Patch f598282f5145036312d90875d0ed5c14b49fd8a7 exposed a problem in
> powerpc MSI-X functionality, making network interfaces such as ixgbe
> and cxgb3 stop to work when MSI-X is enabled. RX interrupts were not
> being generated.

Which means we'd like it in 32 please Ben.

Also Andre, once Ben has merged this you should forward it to
stable@kernel.org for the 31 stable series.

cheers

--=-M0SueCfVAxJvn4wr3GKn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkryJ8UACgkQdSjSd0sB4dLXWACbBC6x25E2k+fq03c3YUl13nm6
nEwAn3KaWb3j6Fii++6/yrGashS5P2Zz
=DaD/
-----END PGP SIGNATURE-----

--=-M0SueCfVAxJvn4wr3GKn--
