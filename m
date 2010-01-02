Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F41E81007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  3 Jan 2010 00:27:29 +1100 (EST)
Date: Sat, 2 Jan 2010 14:27:22 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH net-next 0/3] can: mscan-mpc5xxx: add support for the
	Freescale MPC512x
Message-ID: <20100102132722.GA2239@pengutronix.de>
References: <1262420274-16586-1-git-send-email-wg@grandegger.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
In-Reply-To: <1262420274-16586-1-git-send-email-wg@grandegger.com>
Cc: Socketcan-core@lists.berlios.de, Netdev@vger.kernel.org,
	Devicetree-discuss@lists.ozlabs.org, Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 02, 2010 at 09:17:51AM +0100, Wolfgang Grandegger wrote:
> This patch series adds support for the MPC512x from Freescale to
> the mpc5xxx_can MSCAN driver.

Yay, cool :) I will test the patches with our board when I am back in the
office next week. So far, a few comments by having a look will follow.

Happy new 2010,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAks/SboACgkQD27XaX1/VRsk6gCePPyzkJNymwhYHl/op6wIkZyr
m0gAn25b7MOuJXGTcY0iITXb5cFdC3u1
=Cnne
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
