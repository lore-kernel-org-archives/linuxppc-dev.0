Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 8274DB7BAB
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 19:06:33 +1100 (EST)
Date: Tue, 6 Oct 2009 10:06:23 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v2] mpc5200: support for the MAN mpc5200 based board uc101
Message-ID: <20091006080623.GA3487@pengutronix.de>
References: <4AADF93C.3030604@denx.de> <20090914080322.GA3164@pengutronix.de>
	<fa686aa40909140745u2cf1dba7q8ae2af53c87bd216@mail.gmail.com>
	<4AC9A463.1080903@denx.de> <20091005095340.GA3890@pengutronix.de>
	<4AC9C6AA.6060009@denx.de>
	<fa686aa40910050646p168c2bbfi4b432778827102c9@mail.gmail.com>
	<4ACAD35D.4060904@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
In-Reply-To: <4ACAD35D.4060904@denx.de>
Cc: linuxppc-dev@ozlabs.org
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


> Hmm.. currently I prefer to remove it, because it is not a uc101 special
> wdt driver. When this wdt driver go in mainline, it is easy to readd it
> to this board support.

Great, another one interested in a mainline GPIO-WDT-driver :) I'll check a=
gain
what happened last time and summarize it later this day. The we can hopeful=
ly
work out something.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrK+n8ACgkQD27XaX1/VRsOzgCdF/1vx7hXlliKlJgGobGpWhuU
O+QAniUSdKERvM4I1b0FPZCfq+CXc8T2
=NE85
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
