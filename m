Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id D9FDCDE1C1
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 00:45:58 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 1/3] gpiolib: make gpio_to_chip() public
Date: Thu, 14 Aug 2008 16:45:52 +0200
References: <20080808161717.GA19095@polina.dev.rtsoft.ru>
	<200808141604.22287.laurentp@cse-semaphore.com>
	<20080814141428.GA32296@oksana.dev.rtsoft.ru>
In-Reply-To: <20080814141428.GA32296@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1427864.eYTl2Dx6rT";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200808141645.56418.laurentp@cse-semaphore.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <greg@kroah.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1427864.eYTl2Dx6rT
Content-Type: text/plain;
  charset="windows-1251"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 14 August 2008, Anton Vorontsov wrote:
> On Thu, Aug 14, 2008 at 04:04:18PM +0200, Laurent Pinchart wrote:
> > On Friday 08 August 2008, Anton Vorontsov wrote:
> > > We'll need this function to write platform-specific hooks to deal
> > > with pin's dedicated functions. Quite obviously this will work only
> > > for the platforms with 1-to-1 GPIO to PIN mapping.
> > >=20
> > > This is stopgap solution till we think out and implement a proper
> > > api (pinlib?).
> >=20
> > How do you support reverting the GPIO mode to non-dedicated ?
>=20
> As we always do with the GPIO API: gpio_direction_*() calls.

So the proper sequence to configure a pin in dedicated mode is to set the d=
irection first (which will unset the dedicated mode bit) and then set dedic=
ated mode (which will not touch the direction bit) ?

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1427864.eYTl2Dx6rT
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkikRSQACgkQ8y9gWxC9vpfKrACgxwIOgShMPlS42X8wUSXenXh4
T0MAnAg8qU96gLqeiLaphE/gzQ+K7LqC
=r5Er
-----END PGP SIGNATURE-----

--nextPart1427864.eYTl2Dx6rT--
