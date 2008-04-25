Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id A31D2DE159
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 21:53:17 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] [MTD] Add support for RAM & ROM
	=?iso-8859-1?q?mappings=09in=09the=09physmap=5Fof_MTD?= driver.
Date: Fri, 25 Apr 2008 13:53:10 +0200
References: <200803261344.03438.laurentp@cse-semaphore.com>
	<1208895496.9212.671.camel@pmac.infradead.org>
	<480F19B9.1070403@ru.mvista.com>
In-Reply-To: <480F19B9.1070403@ru.mvista.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1348340.kMds0ggu8j";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200804251353.13698.laurentp@cse-semaphore.com>
Cc: ben@simtec.co.uk, linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	David Woodhouse <dwmw2@infradead.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1348340.kMds0ggu8j
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 23 April 2008 13:12, Sergei Shtylyov wrote:
> David Woodhouse wrote:
>=20
> >>>>Ok. I'll submit a new patch as soon as we agree on a compatible name.
>=20
> >>>Did we?
>=20
> >>    IIRC, The latest agreement was that we don't need the "compatible" =
and=20
> >>will match on node name.
>=20
> > Ok. Is there a current patch I should be merging?
>=20
>     Looks like it was decided to revert to the platform device method, no=
t=20
> sure why -- so, no changes. Laurent?

Last thing I heard was that the device tree should not encode a device's=20
expected usage, so memory nodes should not have any compatible property tha=
t=20
would automatically associated them to an MTD driver. I've been adviced to=
=20
add platform-specific code to instantiate a platform device manually=20
(possibly checking if the required memory node is present in the device=20
tree). This arguably makes sense, but adds more platform-specific code.

So, no need for a patch so far.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1348340.kMds0ggu8j
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIEcYp8y9gWxC9vpcRAqpPAJ9pgoC/J7pU8528wM7jjShyVIA4NQCg2lju
9PJv5uWyxitlFdXinauxy1c=
=DZmk
-----END PGP SIGNATURE-----

--nextPart1348340.kMds0ggu8j--
