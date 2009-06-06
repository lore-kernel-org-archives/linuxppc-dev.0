Return-Path: <albrecht.dress@arcor.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5BC66B7098
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Jun 2009 02:16:12 +1000 (EST)
Date: Sat, 06 Jun 2009 18:16:06 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: [PATCH V2 2/2] mtd/maps/mtd-ram: add an of-platform driver
To: Grant Likely <grant.likely@secretlab.ca>
References: <1244203514-12516-1-git-send-email-w.sang@pengutronix.de>
	<1244203514-12516-3-git-send-email-w.sang@pengutronix.de>
	<fa686aa40906060905y1d39dce1j87d993ceb94273be@mail.gmail.com>
In-Reply-To: <fa686aa40906060905y1d39dce1j87d993ceb94273be@mail.gmail.com>
	(from grant.likely@secretlab.ca on Sat Jun  6 18:05:41 2009)
Message-Id: <1244304966.6356.1@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-QxzQ4Qam/pys6+fWyUaj"
Cc: devicetree-discuss@ozlabs.org, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-QxzQ4Qam/pys6+fWyUaj
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 06.06.09 18:05 schrieb(en) Grant Likely:
> > + - bank-width : Width (in bytes) of the RAM bank.
>=20
> Question: why is bank-width even relevant for a RAM device?

At least if the RAM is attached to the 5200's Local Plus Bus in 16-bit =20
mode, no byte write accesses are allowed (byte /reads/ work, though).  =20
I have a tweak (which I will post next week) to address this case, =20
which depends upon this setting.  No idea if the same happens on other =20
chips and/or on 5200 in 32-bit (muxed) mode, but I guess similar =20
effects will pop up there, too.

Cheers, Albrecht.

--=-QxzQ4Qam/pys6+fWyUaj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD8DBQBKKpZGn/9unNAn/9ERAqQuAJ9kKc52W8PvIqI0f/yQu/7uioICEgCeKTA9
L8skza7amytWvqUF8YmMMGY=
=5UdO
-----END PGP SIGNATURE-----

--=-QxzQ4Qam/pys6+fWyUaj--
