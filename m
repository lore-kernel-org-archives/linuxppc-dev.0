Return-Path: <waite@skycomputers.com>
Received: from sky.skycomputers.com (sky.skycomputers.com [198.4.246.2])
	by ozlabs.org (Postfix) with ESMTP id 3E8F067A71
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Mar 2005 03:21:57 +1100 (EST)
Received: from dayton (dayton [192.9.200.220])
	by sky.skycomputers.com (Postfix) with ESMTP id A4CDC14F29C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Mar 2005 11:30:19 -0500 (EST)
From: Brian Waite <waite@skycomputers.com>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 17 Mar 2005 11:11:34 -0500
References: <200503170953.02626.waite@skycomputers.com>
In-Reply-To: <200503170953.02626.waite@skycomputers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2136143.xvohWgiUH2";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200503171111.39210.waite@skycomputers.com>
Subject: Re: [PATCH] ppc32: 3/2 HDPU platform fix PCI bus 1 enumeration
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--nextPart2136143.xvohWgiUH2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

  Signed-off-by: Brian Waite <waite@skycomputers.com>
  Add the proper bus enumeration code that was missing for bus 1.

=3D=3D=3D=3D=3D linux-2.5/arch/ppc/platforms/hdpu.c 1.2 vs edited =3D=3D=3D=
=3D=3D
262a263,273
> 	mv64x60_set_bus(&bh, 0, 0);
> 	bh.hose_a->first_busno =3D 0;
> 	bh.hose_a->last_busno =3D 0xff;
> 	bh.hose_a->last_busno =3D pciauto_bus_scan(bh.hose_a, 0);
>=20
> 	bh.hose_b->first_busno =3D bh.hose_a->last_busno + 1;
> 	mv64x60_set_bus(&bh, 1, bh.hose_b->first_busno);
> 	bh.hose_b->last_busno =3D 0xff;
> 	bh.hose_b->last_busno =3D pciauto_bus_scan(bh.hose_b,
> 		bh.hose_b->first_busno);
>=20

--nextPart2136143.xvohWgiUH2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCOaw7mxLCz0u+Ko8RAo90AKCFksFOIKfhhWO+lLKmxiahkEGLYQCfTtZa
3sQ9VQ70hnktu5xbAUneats=
=zMrI
-----END PGP SIGNATURE-----

--nextPart2136143.xvohWgiUH2--
