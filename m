Return-Path: <albrecht.dress@arcor.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 63EC3B7BB1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  1 Aug 2009 06:16:15 +1000 (EST)
Date: Fri, 31 Jul 2009 21:47:10 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: [PATCH] mtd/maps: add mtd-ram support to physmap_of
To: Wolfram Sang <w.sang@pengutronix.de>
In-Reply-To: <1247834363-28198-1-git-send-email-w.sang@pengutronix.de> (from
	w.sang@pengutronix.de on Fri Jul 17 14:39:23 2009)
Message-Id: <1249069643.3687.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-6wC/KUIJ0WEPnkpS4mA1"
Cc: devicetree-discuss@ozlabs.org, Vitaly Wool <vwool@ru.mvista.com>,
	Artem Bityutskiy <dedekind@infradead.org>,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Ken MacLeod <ken@bitsko.slc.ut.us>, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-6wC/KUIJ0WEPnkpS4mA1
Content-Type: text/plain; charset=ISO-8859-1; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 17.07.09 14:39 schrieb(en) Wolfram Sang:
> Use physmap_of to access RAMs as mtd and add documenation for it. =20
> This approach is a lot less intrusive as adding an of-wrapper around =20
> plat-ram.c. As most extensions of plat-ram.c (e.g. custom =20
> map-functions) can't be mapped to the device tree anyhow, extending =20
> physmap_of seems to be the cleanest approach.

The patch works nicely on a custom (roughly Icecube) based 5200B board, =20
with a Renesas static ram, no partitions and a jffs2 file system on =20
it.  I had to add some more tweaks to physmap_of.c as to work around =20
the 5200's limitations accessing chips in 16-bit mode through the local =20
bus, which is a lot easier and cleaner with this patch than with the =20
old one (of 05 June 09).

Acked-by: Albrecht Dre=DF <albrecht.dress@arcor.de>

--=-6wC/KUIJ0WEPnkpS4mA1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD8DBQBKc0pLn/9unNAn/9ERAndaAJ46tL+3fxURYv2K1m+v4Z9UJ00B2QCcCv19
sk5JUodhOC7jIvauB43/ImU=
=kGsX
-----END PGP SIGNATURE-----

--=-6wC/KUIJ0WEPnkpS4mA1--
