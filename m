Return-Path: <albrecht.dress@arcor.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5016EB7183
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 03:43:33 +1000 (EST)
Date: Mon, 15 Jun 2009 19:43:20 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: [PATCH V2 2/2] mtd/maps/mtd-ram: add an of-platform driver
To: Wolfram Sang <w.sang@pengutronix.de>
In-Reply-To: <1244203514-12516-3-git-send-email-w.sang@pengutronix.de> (from
	w.sang@pengutronix.de on Fri Jun  5 14:05:14 2009)
Message-Id: <1245087807.3185.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-HGg7XGzhpDPjZ7JQ1k94"
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>,
	Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-HGg7XGzhpDPjZ7JQ1k94
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 05.06.09 14:05 schrieb(en) Wolfram Sang:
> Create an of-aware driver using the now exported generic functions =20
> from plat-ram.c. Also add the documentation for the binding. =20
> Partitions are not yet supported. Tested on a phyCORE-MPC5200B-IO.

Dumb question: what is the current status of this patch?  I ask because =20
I re-wrote my '5200 16-bit Local Plus Bus patch' according to Grant's =20
suggestions, and I believe of_ram_probe() of your patch is the right =20
place to check if it's attached to "fsl,mpc5200-lpb", and to change the =20
write cb if the bankwidth equals 2.

Thanks, Albrecht.

--=-HGg7XGzhpDPjZ7JQ1k94
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD8DBQBKNog/n/9unNAn/9ERAmCHAJ9Mgz/9s1GXCFbyRDPOpAWBuCLvTgCgmJX2
y4964cya7xLRQUCs5otf3CQ=
=mXMd
-----END PGP SIGNATURE-----

--=-HGg7XGzhpDPjZ7JQ1k94--
