Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3215EB7D1C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 30 Jan 2010 03:15:55 +1100 (EST)
Date: Fri, 29 Jan 2010 17:15:36 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v4 1/3] i2c-mpc: use __devinit[data] for initialization
	functions and data
Message-ID: <20100129161536.GI7812@pengutronix.de>
References: <1264685141-26391-1-git-send-email-wg@grandegger.com>
	<1264685141-26391-2-git-send-email-wg@grandegger.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SEFvVLxbW/dEDtN8"
In-Reply-To: <1264685141-26391-2-git-send-email-wg@grandegger.com>
Cc: Wolfgang Grandegger <wg@denx.de>, Devicetree-discuss@lists.ozlabs.org,
	Linuxppc-dev@lists.ozlabs.org, Linux-i2c@vger.kernel.org,
	Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--SEFvVLxbW/dEDtN8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 28, 2010 at 02:25:39PM +0100, Wolfgang Grandegger wrote:
> From: Wolfgang Grandegger <wg@denx.de>
>=20
> "__devinit[data]" has not yet been used for all initialization functions
> and data. To avoid truncating lines, the struct "mpc_i2c_match_data" has
> been renamed to "mpc_i2c_data", which is even the better name.
>=20
> Signed-off-by: Wolfgang Grandegger <wg@denx.de>

Tested-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--SEFvVLxbW/dEDtN8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktjCagACgkQD27XaX1/VRss6gCgqU4T3rNacYhxkXTV3ONXZk/v
ruIAn3fubKdVhp+glZvI7ksPYm7/qtGJ
=Af01
-----END PGP SIGNATURE-----

--SEFvVLxbW/dEDtN8--
