Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6E658B6F6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 30 May 2011 18:24:46 +1000 (EST)
Date: Mon, 30 May 2011 10:24:29 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Jain Priyanka-B32167 <B32167@freescale.com>
Subject: Re: [PATCH] Add support for pt7c4338 (rtc device) in rtc-ds1307 driver
Message-ID: <20110530082429.GA3409@pengutronix.de>
References: <1306393409-16153-1-git-send-email-Priyanka.Jain@freescale.com>
	<20110526091020.GA2201@pengutronix.de>
	<470DB7CE2CD0944E9436E7ADEFC02FE316DCB8@039-SN1MPN1-002.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
In-Reply-To: <470DB7CE2CD0944E9436E7ADEFC02FE316DCB8@039-SN1MPN1-002.039d.mgd.msft.net>
Cc: "a.zummo@towertech.it" <a.zummo@towertech.it>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"p_gortmaker@yahoo.com" <p_gortmaker@yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi, Priyanka,

> Yes, It is possible to directly use platform device 'ds1307' in device
> tree.=20

Great, thanks for testing.

> But I have one query of how to capture the information that pericom,
> pt7c4338 device is compatible with dallas, ds1307. Can it be done in
> somewhere in some document or some code. Actually for pt7c4338 device

Yes, it should definately be documented in the source.

> driver, I actually started by asking if there is any already existing
> rtc device driver which is compatible with pericom pt7c4338 device on
> mailing list and as there was no answer or help then, I actually ended
> up writing device driver for that=20

The first place where this should be mentioned is the datasheet of the
pt-chip, so you might ask the producer to add this information (don't
expect much to happen, though). For such generic devices, it is then
useful to look for similar register sets in existing drivers to find a
duplicate. Please don't forget that such lists are voluntary, there is
no guarantee that mails get replied to.

> and then on the suggestion using ds1307 device driver for this.

IIRC I asked you explicitly for the differences between the chips. If
there are none, you can use the driver directly, right? :)

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk3jVD0ACgkQD27XaX1/VRtjhQCfVyayXSSD4Mkap8ce5kiTWO8u
fmoAoMBrq7mO6HhJ3w/pSudoLQrJhsWE
=fnIJ
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
