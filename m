Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 3E81DDDF00
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 20:07:47 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCHv2 2/3] ep8248e: Reference SMC parameter RAM base in the
	device tree.
Date: Thu, 27 Mar 2008 10:07:41 +0100
References: <200803261217.46671.laurentp@cse-semaphore.com>
	<200803261220.43039.laurentp@cse-semaphore.com>
	<20080326155741.GA3460@loki.buserror.net>
In-Reply-To: <20080326155741.GA3460@loki.buserror.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1805603.z2E6as76lC";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803271007.44886.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1805603.z2E6as76lC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 26 March 2008 16:57, Scott Wood wrote:
> On Wed, Mar 26, 2008 at 12:20:42PM +0100, Laurent Pinchart wrote:
> > diff --git a/arch/powerpc/boot/dts/ep8248e.dts=20
b/arch/powerpc/boot/dts/ep8248e.dts
> > index 5d2fb76..756758f 100644
> > --- a/arch/powerpc/boot/dts/ep8248e.dts
> > +++ b/arch/powerpc/boot/dts/ep8248e.dts
> > @@ -121,8 +121,7 @@
> > =20
> >  				data@0 {
> >  					compatible =3D "fsl,cpm-muram-data";
> > -					reg =3D <0 0x1100 0x1140
> > -					       0xec0 0x9800 0x800>;
> > +					reg =3D <0 0x2000 0x9800 0x800>;
> >  				};
>=20
> Can we leave this as reserved, so that udbg still works?

Ok. Should I add a comment to the DTS to explain additional muram can be=20
reclaimed if udbg isn't used ?

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1805603.z2E6as76lC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH62Pg8y9gWxC9vpcRAk/3AJ416xz/Ccnn5xhUbLg3ixOd3DBC3QCfaPm+
YXl9bPGd2B93TOoOPqmu2CU=
=a1Rt
-----END PGP SIGNATURE-----

--nextPart1805603.z2E6as76lC--
