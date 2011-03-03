Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3E58EB70E9
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Mar 2011 20:39:17 +1100 (EST)
Date: Thu, 3 Mar 2011 10:22:39 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] [PATCH] RTC driver(Linux) for PT7C4338 chip.
Message-ID: <20110303092239.GB3649@pengutronix.de>
References: <1299124299-26991-1-git-send-email-Priyanka.Jain@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
In-Reply-To: <1299124299-26991-1-git-send-email-Priyanka.Jain@freescale.com>
Cc: a.zummo@towertech.it, akpm@linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org, Priyanka Jain <Priyanka.Jain@freescale.com>,
	p_gortmaker@yahoo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> +/*
> + * This file provides Date & Time support (no alarms) for PT7C4338 chip.
> + *
> + * This file is based on drivers/rtc/rtc-ds1307.c

Please explain why you can't use rtc-ds1307 directly (or with slight
modifications). I might have missed something but the register-set looks
identical to me?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1vXd8ACgkQD27XaX1/VRseRACgjYlZl9ofPxQaRxI+j8MDwH9M
8a4An312eaw0VNM4dTYj+qFaadEybW64
=ydDS
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
