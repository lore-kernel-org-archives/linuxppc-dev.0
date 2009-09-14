Return-Path: <w.sang@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7F35CB7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Sep 2009 18:03:33 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 1C8FBDDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 18:03:32 +1000 (EST)
Date: Mon, 14 Sep 2009 10:03:23 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH] mpc5200: support for the MAN mpc5200 based board mucmc52
Message-ID: <20090914080322.GA3164@pengutronix.de>
References: <4AADF93C.3030604@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
In-Reply-To: <4AADF93C.3030604@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> +		mpc5200_pic: interrupt-controller@500 {
> +			// 5200 interrupts are encoded into two levels;

Grant, maybe this comment could be dropped also for the in-kernel dts-files=
? I
think it is sufficently described in mpc5200.txt. I could prepare a patch if
you agree.

> +		i2c@3d40 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			compatible =3D "fsl,mpc5200-i2c","fsl-i2c";
> +			reg =3D <0x3d40 0x40>;
> +			interrupts =3D <2 16 0>;
> +			fsl5200-clocking;

Please drop the clocking-line. It became obsolete.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqt+MoACgkQD27XaX1/VRuY6QCfb0xykZ/jD5gg+Kf4aAfdhWCF
HzsAoME9oLYAhxAgwhVrhJ6iCMUebtV9
=skHo
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
