Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/1] ibmvscsi: Non SCSI error status fixup
From: Michael Ellerman <michael@ellerman.id.au>
To: Dave Boutcher <boutcher@cs.umn.edu>
In-Reply-To: <18481.41759.969242.972595@gargle.gargle.HOWL>
References: <12112108763801-patch-mail.ibm.com>
	<18481.41759.969242.972595@gargle.gargle.HOWL>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-L5gvyCOdoAj7bRlE13sR"
Date: Tue, 20 May 2008 11:08:08 +1000
Message-Id: <1211245688.12970.0.camel@localhost>
Mime-Version: 1.0
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-L5gvyCOdoAj7bRlE13sR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-05-19 at 10:56 -0500, Dave Boutcher wrote:
> On Mon, 19 May 2008 10:27:56 -0500, Brian King <brking@linux.vnet.ibm.com=
> said:
> >=20
> > Some versions of the Virtual I/O Server on Power
> > return 0x99 in the non-SCSI error status field as success,
> > rather than 0. This fixes the ibmvscsi driver to treat this
> > response as success.
>=20
> Yeah....0x99...that's an intuitive value for success.

Hopefully there are no versions that return 0x99 for an error? :)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-L5gvyCOdoAj7bRlE13sR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD4DBQBIMiR4dSjSd0sB4dIRAofBAJ0R/N+dI3Caoi90uWFds1UcvKGgVQCYlzq2
18Dexvr0XL1KAZ3oOvULsw==
=olCB
-----END PGP SIGNATURE-----

--=-L5gvyCOdoAj7bRlE13sR--
