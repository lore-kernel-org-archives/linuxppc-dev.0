Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 3E801DDFF0
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 21:11:50 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH] powerpc: Implement GPIO LIB API on CPM2 Freescale SoC.
Date: Thu, 17 Apr 2008 13:11:41 +0200
References: <200804171148.11593.laurentp@cse-semaphore.com>
	<480722E0.2010609@scram.de>
In-Reply-To: <480722E0.2010609@scram.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1985810.yiPqr0Muxx";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200804171311.46781.laurentp@cse-semaphore.com>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1985810.yiPqr0Muxx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 17 April 2008 12:13, Jochen Friedrich wrote:
> Hi Laurent,
>=20
> > This patch implement GPIO LIB support for the CPM2 GPIOs.
> >=20
> > The code is based on Jochen Friedrich's patch for the CPM1.
>=20
> I guess most of this should go to cpm_common.c and should be used for
> Port E on CPM1, as well. This port uses the same layout as CPM2 while=20
> Port B uses a different layout. See the discussion in
> http://patchwork.ozlabs.org/linuxppc/patch?id=3D16282

The link doesn't seem to be related.

I'll rework the patch to move CPM2 GPIO support to cpm_common.c. Have you=20
thought about a proper name for the compatible property ?

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1985810.yiPqr0Muxx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIBzBy8y9gWxC9vpcRAvx3AJ45DhS1tYgYNhIwykhrEZULu5zrjQCdFBz7
sCxrxJ2dSJmFQXB3Ba85t8Y=
=Z2L9
-----END PGP SIGNATURE-----

--nextPart1985810.yiPqr0Muxx--
