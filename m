Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E6616B6F08
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Jan 2010 03:21:19 +1100 (EST)
Date: Thu, 7 Jan 2010 17:21:13 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH net-next v3 2/3] can: mscan-mpc5xxx: add support for
	the MPC512x processor
Message-ID: <20100107162113.GB7394@pengutronix.de>
References: <1262873421-6863-1-git-send-email-wg@grandegger.com>
	<1262873421-6863-2-git-send-email-wg@grandegger.com>
	<1262873421-6863-3-git-send-email-wg@grandegger.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
In-Reply-To: <1262873421-6863-3-git-send-email-wg@grandegger.com>
Cc: Socketcan-core@lists.berlios.de, Netdev@vger.kernel.org,
	Devicetree-discuss@lists.ozlabs.org,
	Linuxppc-dev@lists.ozlabs.org, Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 07, 2010 at 03:10:20PM +0100, Wolfgang Grandegger wrote:
> From: Wolfgang Grandegger <wg@denx.de>
>=20
> The main differences compared to the MSCAN on the MPC5200 are:
>=20
> - More flexibility in choosing the CAN source clock and frequency:
>=20
>   Three different clock sources can be selected: "ip", "ref" or "sys".
>   For the latter two, a clock divider can be defined as well. If the
>   clock source is not specified by the device tree, we first try to
>   find an optimal CAN source clock based on the system clock. If that
>   is not possible, the reference clock will be used.
>=20
> - The behavior of bus-off recovery is configurable:
>=20
>   To comply with the usual handling of Socket-CAN bus-off recovery,
>   "recovery on request" is selected (instead of automatic recovery).
>=20
> Note that only MPC5121 Rev. 2 and later is supported.
>=20
> Signed-off-by: Wolfgang Grandegger <wg@denx.de>

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

It still works with our board and I didn't find anything else to comment on.

Thanks, Wolfgang!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktGCfkACgkQD27XaX1/VRvi2wCeM7HN2IBscYMOag2R4a9yJ7kP
lq4An0z/WN5ENEN/YU01eFA34W2GxMLh
=ECwy
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
