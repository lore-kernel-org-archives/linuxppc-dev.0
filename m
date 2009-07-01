Return-Path: <w.sang@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DAC89B70E0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jul 2009 18:56:47 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 44E8CDDD0C
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Jul 2009 18:56:46 +1000 (EST)
Date: Wed, 1 Jul 2009 10:56:33 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] alsa/soc: add locking to mpc5200-psc-ac97 driver
Message-ID: <20090701085633.GB3144@pengutronix.de>
References: <20090629234214.12670.9082.stgit@localhost.localdomain>
	<20090630061847.GA24164@pengutronix.de>
	<9e4733910906300642o4f1c0e2cn45423c426e3aff7e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
In-Reply-To: <9e4733910906300642o4f1c0e2cn45423c426e3aff7e@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jon,

> Wolfram, do you have any way to test the on the Phytec hardware? The
> WM9712 on the baseboard supports a touchscreen, is it brought out to a
> header?

Sorry, I didn't get it: Shall I test something specific?

The touchscreen connector is X19 BTW (assuming a PCM-973 baseboard).

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpLJMEACgkQD27XaX1/VRs/cwCgn7p7ffxr8WGoW7MwALkBMKtD
VtYAoIa5/viinyvFF5cQP3BvH9WP3a5I
=Zrq3
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
