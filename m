Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A5534B6F80
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 05:43:00 +1000 (EST)
Date: Thu, 16 Jun 2011 21:42:00 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH][v3] Add support for RTC device: pt7c4338 in rtc-ds1307.c
Message-ID: <20110616194200.GA15925@pengutronix.de>
References: <1308197117-3586-1-git-send-email-Priyanka.Jain@freescale.com>
	<4DFA2363.3060004@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
In-Reply-To: <4DFA2363.3060004@freescale.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com, p_gortmaker@yahoo.com,
	Priyanka Jain <Priyanka.Jain@freescale.com>,
	galak@gate.crashing.org, akpm@linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 16, 2011 at 10:38:11AM -0500, Timur Tabi wrote:
> Priyanka Jain wrote:
> > PT7C4338 chip is being manufactured by Pericom Technology Inc.
> > It is a serial real-time clock which provides:
> > 1)Low-power clock/calendar.
> > 2)Programmable square-wave output.
> > It has 56 bytes of nonvolatile RAM.
> > Its register set is same as that of rtc device: DS1307.
> >=20
> >=20
> > Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
>=20
> Acked-by: Timur Tabi <timur@freescale.com>

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk36XIgACgkQD27XaX1/VRuuyQCgx9cieAtVaA+kmOG7kPf7Obw6
MhwAoIC0VHGtuEraevOnQ4GR/8XfLwZt
=4XU2
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
