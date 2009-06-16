Return-Path: <wsa@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 96D9EB7082
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 19:10:01 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 18BE6DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 19:10:01 +1000 (EST)
Date: Tue, 16 Jun 2009 11:09:53 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH V2 2/2] mtd/maps/mtd-ram: add an of-platform driver
Message-ID: <20090616090953.GB21321@pengutronix.de>
References: <1244203514-12516-1-git-send-email-w.sang@pengutronix.de>
	<1244203514-12516-3-git-send-email-w.sang@pengutronix.de>
	<1244276049.3751.1176.camel@macbook.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
In-Reply-To: <1244276049.3751.1176.camel@macbook.infradead.org>
Cc: devicetree-discuss@ozlabs.org, albrecht.dress@arcor.de,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 06, 2009 at 09:14:08AM +0100, David Woodhouse wrote:
> On Fri, 2009-06-05 at 14:05 +0200, Wolfram Sang wrote:
> > Create an of-aware driver using the now exported generic functions from
> > plat-ram.c. Also add the documentation for the binding. Partitions are
> > not yet supported. Tested on a phyCORE-MPC5200B-IO.
>=20
> Do we have an ack for the device-tree bindings?=20

Well, Grant acked so far and he surely has a voice in the device-tree-world=
 :)
Or do you want a specific ack for that?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAko3YWEACgkQD27XaX1/VRvcdgCbBFBKLNAU2tQnGXIv4X4qajkg
t6sAmwclmDXrcP7Q/ui22VqPhv76cwih
=Ni7H
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
