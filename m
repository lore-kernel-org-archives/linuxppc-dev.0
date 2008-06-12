Return-Path: <wsa@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id C575FDDF07
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 19:04:42 +1000 (EST)
Received: from leda.ptxnet.pengutronix.de ([10.1.0.71] ident=Debian-exim)
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <wsa@pengutronix.de>) id 1K6ijS-00025o-7G
	for linuxppc-dev@ozlabs.org; Thu, 12 Jun 2008 11:04:34 +0200
Received: from wsa by leda.ptxnet.pengutronix.de with local (Exim 4.67)
	(envelope-from <wsa@pengutronix.de>) id 1K6ijR-0002iL-3B
	for linuxppc-dev@ozlabs.org; Thu, 12 Jun 2008 11:04:33 +0200
Date: Thu, 12 Jun 2008 11:04:33 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: Merging seperate FDT-blobs?
Message-ID: <20080612090433.GA4235@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

a project I am working on consists of different hardware modules, which
can be combined in a lot of variations (not at runtime, though). As each
module shall contain an I2C-eeprom, the idea is now to put a fragment of
a FDT-blob into that EEPROM and let the bootloader combine these
fragments. Such an approach was also sketched by David Gibson recently.
(http://ozlabs.org/pipermail/linuxppc-dev/2008-February/051630.html)

(As a sidenote, I am not quite sure and could not find anything about
what the mentioned 'fdt_graft' should actually do, in my case something
like a 'fdt_add_blob_subnode' function would be sufficent, I guess.)

My question: Is there already an effort towards such an approach to
which I could contribute, or do I have to start from scratch?

Kind regards,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD4DBQFIUOagD27XaX1/VRsRAgNeAJY9w4+t6qtEUbKSdAq5bkcUk7JhAKCpl6fu
ScFfw8FCN2++iy4r3I4u1g==
=Z/0v
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
