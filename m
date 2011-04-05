Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1FB86B6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Apr 2011 09:48:30 +1000 (EST)
Date: Wed, 6 Apr 2011 01:48:24 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Carlos Roberto Moratelli <carlos.moratelli@digitel.com.br>
Subject: Re: sdhc/mpc8536 - SDCard always detected like read-only
Message-ID: <20110405234824.GB5611@pengutronix.de>
References: <1302028796.10112.59.camel@moratelli-host.digitel.com.br>
	<20110405190204.GB12723@pengutronix.de>
	<1302031171.10112.66.camel@moratelli-host.digitel.com.br>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
In-Reply-To: <1302031171.10112.66.camel@moratelli-host.digitel.com.br>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> 		sdhci@2e000 {
> 			compatible =3D "fsl,mpc8536-esdhc", "fsl,esdhc";
> 			reg =3D <0x2e000 0x1000>;
> 			interrupts =3D <72 0x2>;
> 			interrupt-parent =3D <&mpic>;
> 			/* Filled in by U-Boot */
> 			clock-frequency =3D <0>;
> 		};

Hmm, I am not too familiar with those SoCs, yet some 83xx needed

	sdhci,wp-inverted;

here. Maybe yours, too? Would fit the symptoms.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk2bqkgACgkQD27XaX1/VRts4wCghSpYMhIyC202Hh742g+AkOiP
dj4Ani2JWiUNhmHwNWczQpNrgRp67m1S
=bgZW
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
