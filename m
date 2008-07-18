Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id E9147DDEE4
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 19:26:54 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2] fs_enet: MDIO on GPIO support
Date: Fri, 18 Jul 2008 11:26:43 +0200
References: <200805261152.37636.laurentp@cse-semaphore.com>
	<200806261321.24338.laurentp@cse-semaphore.com>
	<20080626175523.54728d07@vitb.ru.mvista.com>
In-Reply-To: <20080626175523.54728d07@vitb.ru.mvista.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2242542.1L37p45jF7";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200807181126.48246.laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Jeff Garzik <jgarzik@pobox.com>,
	Vitaly Bordug <vbordug@ru.mvista.com>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart2242542.1L37p45jF7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 26 June 2008, Vitaly Bordug wrote:
> On Thu, 26 Jun 2008 13:21:23 +0200
> Laurent Pinchart <laurentp@cse-semaphore.com> wrote:
>=20
> > > There should be no dependencies. When the OF GPIO support is not
> > > selected linux/of_gpio.h will define of_get_gpio() as a stub, so the
> > > fs_enet driver will fall back to the legacy binding. =20
> >=20
> > Have we reached a consensus on which tree the patch should go to ?
> I think it should go through powerpc tree, not seeing too much
> netdev-generic stuff in here. If noone will object, Kumar will pick it up=
 I
> guess...=20

Kumar, could you pick it up ? I'd like to see this in 2.6.27.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart2242542.1L37p45jF7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiAYdgACgkQ8y9gWxC9vpcylQCeP9v241eeSA2tmrCd3KgEg4kz
TNcAoN3ygIWKOz/WUpLCSpXsSG6ZXgUL
=Lmbt
-----END PGP SIGNATURE-----

--nextPart2242542.1L37p45jF7--
