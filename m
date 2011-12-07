Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F192BB70B1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2011 07:34:03 +1100 (EST)
Date: Wed, 7 Dec 2011 21:33:48 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH -resend 1/1] SPI: disable CONFIG_SPI_FSL_ESPI=m build
Message-ID: <20111207203348.GB2526@pengutronix.de>
References: <1323289096-13599-1-git-send-email-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
In-Reply-To: <1323289096-13599-1-git-send-email-jslaby@suse.cz>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 jirislaby@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2011 at 09:18:16PM +0100, Jiri Slaby wrote:
> When spi_fsl_espi is chosen to be built as a module, there is a build
> error because we test only CONFIG_SPI_FSL_ESPI in declaration of
> struct mpc8xxx_spi in drivers/spi/spi_fsl_lib.h. Also some called
> functions are not exported.
>=20
> So we forbid CONFIG_SPI_FSL_ESPI to be tristate here.
>=20
> The error looks like:
> drivers/spi/spi_fsl_espi.c: In function 'fsl_espi_bufs':
> drivers/spi/spi_fsl_espi.c:232: error: 'struct mpc8xxx_spi' has no member=
 named 'len'
> ...
>=20
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Acked-by: Kumar Gala <galak@kernel.crashing.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
> Maybe Grant is back already?

I just picked it up in the for-linus branch I am preparing while Grant
is away.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7fzawACgkQD27XaX1/VRtpxQCgwyLXks2mr1yGcO3fyIQyknX2
XxcAnRTjzECWSWEGOaZsyw6cMOt2tSzP
=UflB
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
