Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 8/8] Cell IOMMU fixed mapping support
From: Michael Ellerman <michael@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20080129151511.GA18975@lixom.net>
References: <56662c291890f09835ef7251f9b86f70fbee3ad2.1201616038.git.michael@ellerman.id.au>
	<1cbc0deea968ece13756e3c86ec3af0b7586b80b.1201616038.git.michael@ellerman.id.au>
	<20080129151511.GA18975@lixom.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-2W26lFmqaC5glXRnTnhH"
Date: Wed, 30 Jan 2008 02:13:45 +1100
Message-Id: <1201619625.10012.19.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-2W26lFmqaC5glXRnTnhH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-01-29 at 09:15 -0600, Olof Johansson wrote:
> On Wed, Jan 30, 2008 at 01:14:03AM +1100, Michael Ellerman wrote:
>=20
> > For example a machine with 4GB of memory would end up with the normal
> > IOMMU window from 0-2GB and the fixed mapping window from 2GB to 6GB. I=
n
> > this case a 64-bit device wishing to DMA to 1GB would be told to DMA to
> > 3GB, plus any offset required by firmware. The firmware offset is encod=
ed
> > in the "dma-ranges" property.
>=20
> Shouldn't the fixed mapping be between 4G and 8G (and the offset for 1G
> is at 5G), to account for the MMIO range at 2-4G?

I don't think so, ie. it works setup like that, but I'm not entirely
sure why. Presumably the 2-4GB for MMIO is only for cycles heading out
of the CPU.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-2W26lFmqaC5glXRnTnhH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHn0KpdSjSd0sB4dIRAmmjAJ4kxtGaxFWKESkCDS5egT49gBypjQCgg9x4
jMP15/GquFTMjXkGoiilQ0Y=
=/Yld
-----END PGP SIGNATURE-----

--=-2W26lFmqaC5glXRnTnhH--
