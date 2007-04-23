Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 7/7] MPIC MSI backend
From: Michael Ellerman <michael@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070422193017.GA27048@lixom.net>
References: <20070419073556.73A6BDDE4A@ozlabs.org>
	<e4520bd4be50f2884003a9421863627c@bga.com>
	<ca8197808a747b83c14461f6fec375db@kernel.crashing.org>
	<20070422193017.GA27048@lixom.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-X7k2LeRHp0JCpN7BJzx1"
Date: Mon, 23 Apr 2007 14:24:05 +1000
Message-Id: <1177302245.3889.34.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>,
	Milton Miller <miltonm@bga.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-X7k2LeRHp0JCpN7BJzx1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2007-04-22 at 14:30 -0500, Olof Johansson wrote:
> On Sun, Apr 22, 2007 at 09:06:15AM +0200, Segher Boessenkool wrote:
>=20
> > mpic_htmsi deals with MSIs that come in over hypertransport
> > to the MPIC on CPC925/CPC945; this has nothing to
> > do with HT APICs.
>=20
> Maybe it should be named mpic_cpc9x5msi instead?

Yeah, seems fair enough.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-X7k2LeRHp0JCpN7BJzx1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGLDTldSjSd0sB4dIRAmtaAJ9fh/HJqFLNloNWYVCaETC2uvaZ3wCgis3e
6YvmGcjN3Rd3R8D2XRqJ2Y4=
=9x8u
-----END PGP SIGNATURE-----

--=-X7k2LeRHp0JCpN7BJzx1--
