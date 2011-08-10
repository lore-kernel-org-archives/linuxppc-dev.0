Return-Path: <mkl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1FA79B71DF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Aug 2011 21:10:09 +1000 (EST)
Message-ID: <4E426704.8040003@pengutronix.de>
Date: Wed, 10 Aug 2011 13:09:56 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>
Subject: Re: [PATCH v10 0/5] [flexcan/powerpc] Add support for powerpc flexcan
	(freescale p1010)
References: <1312945564-6626-1-git-send-email-holt@sgi.com>
In-Reply-To: <1312945564-6626-1-git-send-email-holt@sgi.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig68ADE052ECC1292443A072A7"
Cc: netdev@vger.kernel.org, U Bhaskar-B22300 <B22300@freescale.com>,
	socketcan-core@lists.berlios.de, PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig68ADE052ECC1292443A072A7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/10/2011 05:05 AM, Robin Holt wrote:
> With all the patches applied, my p1010rdb works for communicating betwe=
en
> its two can ports and also can communicate with an external PSOC.  I ha=
ve
> done no testing beyond compile testing on an arm system as I have no
> access to an arm based system.
>=20
> For the first three patches in the series, I believe they are all ready=

> for forwarding to David S. Miller for the netdev tree.  I think patch
> 4 is ready for submission to the PPC85xx maintainer.  Patch 5 changed
> from the previous post by adding a second compatible string for the
> fsl,p1010_flexcan.

This patch series is working on phytec's pcm043 (mx35) based on current
net-next. Feel free to add my Acked-by to all patches.

good work,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig68ADE052ECC1292443A072A7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5CZwcACgkQjTAFq1RaXHNvQgCfdEVElyqMmYAGvIovBn3jKdyH
woYAn1NLNjsbGAhwu+uRfaUzkJkOF+2Z
=jRKd
-----END PGP SIGNATURE-----

--------------enig68ADE052ECC1292443A072A7--
