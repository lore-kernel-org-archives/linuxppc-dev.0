Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 082ECDDF48
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jun 2008 01:16:04 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCHv2 1/2] [POWERPC] CPM2: Implement GPIO LIB API on CPM2
	Freescale SoC.
Date: Fri, 13 Jun 2008 17:15:56 +0200
References: <4808D75B.9000002@scram.de>
	<200806131446.27552.laurentp@cse-semaphore.com>
	<20080613145730.GA27615@polina.dev.rtsoft.ru>
In-Reply-To: <20080613145730.GA27615@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2013701.Ra6LxCl7f2";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200806131715.59345.laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart2013701.Ra6LxCl7f2
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 13 June 2008 16:57, Anton Vorontsov wrote:
> On Fri, Jun 13, 2008 at 02:46:20PM +0200, Laurent Pinchart wrote:
> > On Friday 18 April 2008 19:16, Jochen Friedrich wrote:
> > > Based on earlier work by Laurent Pinchart.
> > >=20
> > > This patch implement GPIO LIB support for the CPM2 GPIOs.
> > >=20
> > > Signed-off-by: Jochen Friedrich <jochen@scram.de>
> > > Cc: Laurent Pinchart <laurentp@cse-semaphore.com>
> >=20
> > Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
> >=20
> > Is there any showstopper or can this one be applied to powerpc-next ?
>=20
> One comment below.
>=20
> [...]
> > > +	mm_gc->save_regs =3D cpm2_gpio32_save_regs;
> > > +	of_gc->gpio_cells =3D 1;
>=20
> I would strongly suggest to use gpio_cells =3D 2, otherwise you will not
> able to pass GPIO flags (such as active-low etc) without breaking the
> compatibility with older trees.

Agreed. Jochen, will you resubmit or should I do it ?

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart2013701.Ra6LxCl7f2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIUo8v8y9gWxC9vpcRArvvAKDF0QBBD3iKqCdQkfjCjNAWeHYEOgCg0Tig
Cx+dIz9l0/lGkUn1aYjrEXs=
=Q/0b
-----END PGP SIGNATURE-----

--nextPart2013701.Ra6LxCl7f2--
