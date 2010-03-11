Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6501BB7D0F
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 11:32:43 +1100 (EST)
Date: Thu, 11 Mar 2010 01:32:38 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Albrecht =?iso-8859-15?Q?Dre=DF?= <albrecht.dress@arcor.de>
Subject: Re: 5200B: BUG in 2.6.34-rc1-dirty while loading at24 driver
Message-ID: <20100311003238.GA22565@pengutronix.de>
References: <1268245563.2375.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
In-Reply-To: <1268245563.2375.0@antares>
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Albrecht,

> not sure if this is the right place to ask:  When I boot a custom 5200B (=
more

Check MAINTAINERS for AT24 ;)

> or less Lite-based) board with Linus' git tree (2.6.34-rc1-dirty), I alwa=
ys
> get the following bug:

Will send a patch in some minutes...

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuYOiYACgkQD27XaX1/VRu+GwCeIyty77v6mbYNOfpPYudgXs0I
MQIAnjAinQ2wJhRdtYQGAshZ7vZshWPe
=nl/3
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
