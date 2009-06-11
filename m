Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8D1EDB7168
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 00:33:09 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 730FDDDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 00:33:09 +1000 (EST)
Subject: Re: "test" branch updates
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1242631175.18075.54.camel@pasglop>
References: <1242631175.18075.54.camel@pasglop>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-M3NE4WH8Oux1+wJd6w3v"
Date: Fri, 12 Jun 2009 00:33:07 +1000
Message-Id: <1244730787.4599.94.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-M3NE4WH8Oux1+wJd6w3v
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-05-18 at 17:19 +1000, Benjamin Herrenschmidt wrote:
> Just a quick note before I leave the office...
>=20
> I've just pushed out a bunch of stuff to my "test" branch. There's a
> couple of known breakage (iseries and 8xx) which will have to be sorted
> out before that stuff goes into "next". hopefully in a couple of days.
>=20
> Still... feel free to take a peek, test, etc...

The swiotlb stuff doesn't build:

arch/powerpc/kernel/dma-swiotlb.c
   In function =E2=80=98swiotlb_bus_to_virt=E2=80=99:
  29: warning: passing argument 1 of =E2=80=98swiotlb_bus_to_phys=E2=80=99 =
makes integer from pointer without a cast
  29: error: too many arguments to function =E2=80=98swiotlb_bus_to_phys=E2=
=80=99
   At top level:
  42: error: conflicting types for =E2=80=98swiotlb_bus_to_phys=E2=80=99


There's changes in linux-next that make it work, which look like they're
going via Ingo?

cheers

--=-M3NE4WH8Oux1+wJd6w3v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoxFaMACgkQdSjSd0sB4dJTBQCgmoCG8wWnKl4YKmR1hjDwgcBo
AdcAn3NVJ/vrGBezoPDUP2knXusMANqQ
=rQoT
-----END PGP SIGNATURE-----

--=-M3NE4WH8Oux1+wJd6w3v--
