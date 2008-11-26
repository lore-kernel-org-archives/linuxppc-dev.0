Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 2396FDDDE6
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2008 02:11:15 +1100 (EST)
Date: Wed, 26 Nov 2008 16:11:09 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [U-Boot] MPC5200B: Trouble with config pins
Message-ID: <20081126151109.GG4356@pengutronix.de>
References: <200811211336.41159.jbe@pengutronix.de>
	<fa686aa40811210709x4b8d10a3p568a1a4dbb8c7a8a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y+xroYBkGM9OatJL"
In-Reply-To: <fa686aa40811210709x4b8d10a3p568a1a4dbb8c7a8a@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, u-boot@lists.denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--Y+xroYBkGM9OatJL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Fri, Nov 21, 2008 at 08:09:20AM -0700, Grant Likely wrote:

> Juergen, I haven't seen this behaviour.  Have you asked you Freescale FAE?
>=20
> Hey John, have you ever seen this sort of issue?

To keep you updated: It was the PHY which would drive the lines high if
the reset signal was "too long". Next revision of the PHY will have this
fixed. (Yeah, next revision, sigh...)

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--Y+xroYBkGM9OatJL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkktZw0ACgkQD27XaX1/VRs4KACgh/bUFIZZ+Mc382bz6AGG8I2E
RUYAn20DwUJac8aew/FgT6ILQ8TNn9fY
=qmvG
-----END PGP SIGNATURE-----

--Y+xroYBkGM9OatJL--
