Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 51141DE093
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 23:00:42 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] GPIO-based flow control in the cpm_uart driver
Date: Tue, 20 May 2008 15:00:35 +0200
References: <200804151522.36884.laurentp@cse-semaphore.com>
	<200804151547.44052.laurentp@cse-semaphore.com>
	<200805191731.33193.david-b@pacbell.net>
In-Reply-To: <200805191731.33193.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1433265.Im7f4YOspb";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200805201500.38236.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1433265.Im7f4YOspb
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 20 May 2008 02:31, David Brownell wrote:
> On Tuesday 15 April 2008, Laurent Pinchart wrote:
> > Or maybe some kind of gpio_set_option() with flags specific to the=20
> > controller ? This could be used to enable open-drain outputs or interna=
l=20
> > pull-ups for instance.
>=20
> That presumes that the pin config is associated with the GPIO
> controller, rather than being an independent modules...
>=20
> In the cases that a platform has such an association, there
> should be no problem just using a platform-specific code to
> do the relevant magic.

To call GPIO chip specific functions, the driver needs a way to get the GPI=
O=20
chip associated with the GPIO.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1433265.Im7f4YOspb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIMst28y9gWxC9vpcRAmkeAJ0YoTxw3K+QwU92Gn0KK7eXv43MpgCg2qc9
c960OYGz2FYpxgYN+Y1V+IY=
=VkdM
-----END PGP SIGNATURE-----

--nextPart1433265.Im7f4YOspb--
