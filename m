Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 7201B1007D4
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 20:58:36 +1100 (EST)
Date: Wed, 18 Nov 2009 10:58:28 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Luotao Fu <l.fu@pengutronix.de>
Subject: Re: [PATCH] spi/mpc52xx-spi: cleanups
Message-ID: <20091118095828.GA5166@pengutronix.de>
References: <1258468268-9911-1-git-send-email-w.sang@pengutronix.de>
	<20091117144300.GB4850@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
In-Reply-To: <20091117144300.GB4850@pengutronix.de>
Cc: spi-devel-general@lists.sourceforge.net, linuxppc-dev@ozlabs.org
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

> > -		rc |=3D request_irq(ms->irq1, mpc52xx_spi_irq, IRQF_SAMPLE_RANDOM,
> > +		rc |=3D request_irq(ms->irq1, mpc52xx_spi_irq, 0,
> >  				  "mpc5200-spi-spiF", ms);
>=20
> The "spiF" here is probably also a typo.

Ack. Grant, if you think it is worth you may modify my patch to avoid a res=
end.
If it is easier for you, I will do the resend, of course.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksDxUQACgkQD27XaX1/VRsTigCgrkUG9+1oz/8cC7ECpaKl9Rny
6HQAniy4zbAJVxqn2tyQSTUAu52NWnJt
=YdQy
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
