Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1C6A41007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Dec 2010 21:06:54 +1100 (EST)
Date: Mon, 13 Dec 2010 11:06:47 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 1/2] powerpc, mpc5200: update defconfig to fit with
	2.6.37-rc4
Message-ID: <20101213100647.GA5911@pengutronix.de>
References: <1292047981-1435-1-git-send-email-hs@denx.de>
	<20101212084707.GA14580@pengutronix.de> <4D05C68F.4030600@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
In-Reply-To: <4D05C68F.4030600@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Heiko,

> >> -CONFIG_EEPROM_AT24=3Dy
> >=20
> > NACK.
>=20
> ... I did just the steps above mentioned, so this is
> automagically done by "make mpc5200_defconfig" !

Yes, I understood that, but I can't help it: it is still wrong. I need
it.

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk0F8DcACgkQD27XaX1/VRs1TQCgnr3nYp9pWMJhMwArXzbJqJGi
fKwAoMe0trDVmO0grhGC0hA1qiGV1k2R
=neFK
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
