Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id AFAB4DE394
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 03:07:57 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: RFC: Could cpm2_clk_setup and cpm2_set_pin be exported ?
Date: Thu, 28 Aug 2008 19:07:49 +0200
References: <200808281757.16903.laurentp@cse-semaphore.com>
	<20080828164142.GB1185@ld0162-tx32.am.freescale.net>
In-Reply-To: <20080828164142.GB1185@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2661842.IqiUU8RjiB";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200808281907.53607.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart2661842.IqiUU8RjiB
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 28 August 2008, Scott Wood wrote:
> On Thu, Aug 28, 2008 at 05:57:13PM +0200, Laurent Pinchart wrote:
> > I'm facing a situation where I need to call cpm2_clk_setup and
> > cpm2_set_pin from a device driver compiled as a module. Before
> > submitting a patch to export both functions, I'd like to make sure
> > there isn't a cleaner way to implement the desired functionality
> > without calling functions that are supposed to be used by board setup
> > code.
>=20
> Have you looked at using the GPIO API?

Yes, but the GPIO API doesn't support dedicated pin usage. Basically all I =
can do is configure a pin as a general purpose input or output, and set its=
 level when configured as an output. The GPIO API doesn't provide any way t=
o access the PAR and SOR registers.

Beside, the GPIO API won't help configuring clock routing.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart2661842.IqiUU8RjiB
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAki222kACgkQ8y9gWxC9vpf7tgCcDUsQw8DI5F1QoM8zagzTnC8r
kRUAoK04utXKFZfCuc1jWJenmJGR4gI+
=ifu1
-----END PGP SIGNATURE-----

--nextPart2661842.IqiUU8RjiB--
