Return-Path: <roubert@df.lth.se>
Received: from df.lth.se (mail.df.lth.se [194.47.250.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B7D6467BD4
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Sep 2006 00:49:56 +1000 (EST)
Date: Wed, 27 Sep 2006 16:49:48 +0200
From: Fredrik Roubert <roubert@df.lth.se>
To: Matthew McClintock <msm@freescale.com>
Subject: Re: How to move from /ppc/ to /powerpc/
Message-ID: <20060927144948.GA22745@igloo.df.lth.se>
References: <20060912153316.GC16340@igloo.df.lth.se>
	<20060912105830.3923d537.kim.phillips@freescale.com>
	<20060913132817.GD18263@igloo.df.lth.se>
	<20060921160808.GB4828@igloo.df.lth.se>
	<1159202991.5485.0.camel@localhost>
	<20060925171754.GB21204@igloo.df.lth.se>
	<1159204851.5485.6.camel@localhost>
	<20060925174101.GC21204@igloo.df.lth.se>
	<1159210763.5485.10.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
In-Reply-To: <1159210763.5485.10.camel@localhost>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 25 Sep 20:59 CEST 2006, Matthew McClintock wrote:

> Can you verify the flat device tree passed to the kernel is correct?
> Specifically these properties:
>
>                 timebase-frequency =3D <0>;       // from bootloader
>                 bus-frequency =3D <0>;            // from bootloader
>                 clock-frequency =3D <0>;          // from bootloader

Right on target! These values were not set up correctly, and after
fixing that I can now boot an unmodified powerpc 2.6.18 kernel.

Thank you so very much!

Are your flat device tree patches going to be included in the mainline
U-Boot in the future, or is it likely that some other method will be
used?

Cheers // Fredrik Roubert

--=20
Visserij 192  |  +32 473 344527 / +46 708 776974
BE-9000 Gent  |  http://www.df.lth.se/~roubert/

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (SunOS)

iQCVAwUBRRqPi8RKuLhQMn35AQJ5rAP/XSbjYkY24QVy8pnVKc8WH0hTDqMOa7xU
M+uASUnzY66qB5YhiC+f7/S4FPHSPv3TMWuqsRRXkBWgxxZcuxz2t5/HIekKGg0L
bGosOzy4CGj/zNxoV8SiaEdjlH4ot/+A5bOzdlOCEK+y1RCSCZQuRrpUJ7PjAWwH
JovqNELL3dg=
=ucXN
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
