Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 7/7] MPIC MSI backend
From: Michael Ellerman <michael@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <829d8b36a3c78c662f29437c59290609@kernel.crashing.org>
References: <20070419073556.73A6BDDE4A@ozlabs.org>
	<e4520bd4be50f2884003a9421863627c@bga.com>
	<ca8197808a747b83c14461f6fec375db@kernel.crashing.org>
	<20070422193017.GA27048@lixom.net>
	<829d8b36a3c78c662f29437c59290609@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-4kOz29Ckl9LUXjq3n2+k"
Date: Mon, 23 Apr 2007 18:31:55 +1000
Message-Id: <1177317115.3889.39.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>,
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


--=-4kOz29Ckl9LUXjq3n2+k
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-04-23 at 10:24 +0200, Segher Boessenkool wrote:
> >> mpic_htmsi deals with MSIs that come in over hypertransport
> >> to the MPIC on CPC925/CPC945; this has nothing to
> >> do with HT APICs.
> >
> > Maybe it should be named mpic_cpc9x5msi instead?
>=20
> Yeah probably, esp. since there are more MSI sources
> on those chips, not just HT; and if support for those
> sources gets added later, it should go to this file :-)

Actually I think I'll call it mpic_u3_msi.c, which although not quite as
accurate as cpc9x5, is more inline with the rest of the code that refers
to U3 - which really means U3/U4.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-4kOz29Ckl9LUXjq3n2+k
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGLG77dSjSd0sB4dIRAprlAJ0cLurXFEei8c9lxUZw15K4fa0kPACffvdN
ylacfrkEF6U2pf5nG2X9u4g=
=zo71
-----END PGP SIGNATURE-----

--=-4kOz29Ckl9LUXjq3n2+k--
