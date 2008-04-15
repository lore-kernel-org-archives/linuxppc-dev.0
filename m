Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 40A4CDE21E
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 02:03:59 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC] Using two baud rate generators with the cpm_uart driver
Date: Tue, 15 Apr 2008 18:03:56 +0200
References: <200804151532.27057.laurentp@cse-semaphore.com>
	<200804151754.21664.laurentp@cse-semaphore.com>
	<4804D0EB.5020508@freescale.com>
In-Reply-To: <4804D0EB.5020508@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5102985.7ahpLTo4jS";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200804151803.56383.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart5102985.7ahpLTo4jS
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 15 April 2008 17:59, Scott Wood wrote:
> Laurent Pinchart wrote:
> >> The clean solution would be to have an abstracted clock API, similar t=
o=20
> >> phylib, where the caller doesn't know details about BRGs and such.=20
> >> Maybe the linux/clk.h API would be suitable; I haven't looked at it in=
=20
> >> detail.
> >=20
> > The clock API would have to be quite advanced to express things like "t=
he SCC4=20
> > clock is a combination of BRG2 and BRG5" (and I don't even consider=20
> > adding "with BRG2 set to 16x the baud rate and BRG5 to the baud rate").
>=20
> What I was picturing was platform code providing a clock object that the=
=20
> cpm_uart driver could be pointed at (possibly by modifying the device=20
> tree in platform init); the knowledge of the multiple BRG weirdness=20
> would be contained in platform code.

I'll think about it.

Thanks.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart5102985.7ahpLTo4jS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIBNHs8y9gWxC9vpcRAkh0AKCh2I2MIoeauppPY5ZI+JPnreQ6AACgim2M
XH8gU/Fwf4B+FKMWq/2vgZs=
=XJZm
-----END PGP SIGNATURE-----

--nextPart5102985.7ahpLTo4jS--
