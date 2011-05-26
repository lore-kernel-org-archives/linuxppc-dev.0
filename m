Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 38072B6F7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 May 2011 19:10:37 +1000 (EST)
Date: Thu, 26 May 2011 11:10:20 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Priyanka Jain <Priyanka.Jain@freescale.com>
Subject: Re: [PATCH] Add support for pt7c4338 (rtc device) in rtc-ds1307 driver
Message-ID: <20110526091020.GA2201@pengutronix.de>
References: <1306393409-16153-1-git-send-email-Priyanka.Jain@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
In-Reply-To: <1306393409-16153-1-git-send-email-Priyanka.Jain@freescale.com>
Cc: a.zummo@towertech.it, akpm@linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org, rtc-linux@googlegroups.com,
	p_gortmaker@yahoo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 26, 2011 at 12:33:29PM +0530, Priyanka Jain wrote:

> PT7C4338 chip is being manufactured by Pericom Technology Inc.
> It is a serial real-time clock which provides:
> 1)Low-power clock/calendar.
> 2)Programmable square-wave output.
> It has 56 bytes of nonvolatile RAM.
> Its register set is same as that of rtc device: DS1307.
>=20
> Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>

So it is identical to ds1307? Then why not name your platform_device
simply 'ds1307'?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk3eGPwACgkQD27XaX1/VRs+igCdEePS8deCtGF51j3GGWNzpGc1
REQAn3WN1ggLXw03I1o2FedBAlJ2h77w
=He6N
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
