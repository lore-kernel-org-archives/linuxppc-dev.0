Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 58A391007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Mar 2011 18:03:49 +1100 (EST)
Date: Wed, 9 Mar 2011 07:46:33 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [rtc-linux] [PATCH] RTC driver(Linux) for PT7C4338 chip.
Message-ID: <20110309064633.GA29025@pengutronix.de>
References: <1299124299-26991-1-git-send-email-Priyanka.Jain@freescale.com>
	<20110303092239.GB3649@pengutronix.de>
	<20110308165531.92c09a8a.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
In-Reply-To: <20110308165531.92c09a8a.akpm@linux-foundation.org>
Cc: a.zummo@towertech.it, linuxppc-dev@lists.ozlabs.org,
	Priyanka Jain <Priyanka.Jain@freescale.com>,
	rtc-linux@googlegroups.com, p_gortmaker@yahoo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 08, 2011 at 04:55:31PM -0800, Andrew Morton wrote:
> On Thu, 3 Mar 2011 10:22:39 +0100
> Wolfram Sang <w.sang@pengutronix.de> wrote:
>=20
> > Hi,
> >=20
> > > +/*
> > > + * This file provides Date & Time support (no alarms) for PT7C4338 c=
hip.
> > > + *
> > > + * This file is based on drivers/rtc/rtc-ds1307.c
> >=20
> > Please explain why you can't use rtc-ds1307 directly (or with slight
> > modifications). I might have missed something but the register-set looks
> > identical to me?
> >=20
>=20
> Was there an answer to this question?

I didn't get one.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk13IkkACgkQD27XaX1/VRvM6wCfY53L8HSm8QqXFQRtWIdkfOBY
Ou0An1hF64DCOGtADsY7G6MwzMQpPR0B
=rE1E
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
