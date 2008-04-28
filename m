Return-Path: <wsa@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id E8788DE51B
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 01:58:46 +1000 (EST)
Date: Mon, 28 Apr 2008 17:35:43 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [i2c] [PATCH 0/2] i2c: Add support for device alias names
Message-ID: <20080428153543.GB4353@pengutronix.de>
References: <20080428113052.6d024bda@hyperion.delvare>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
In-Reply-To: <20080428113052.6d024bda@hyperion.delvare>
Cc: Sievers <kay.sievers@vrfy.org>, Laurent@ATrpms.net,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mundt <lethal@linux-sh.org>, Linux I2C <i2c@lm-sensors.org>,
	Kay@ATrpms.net, Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jean,

I tested on this hardware

 MPC8260 (powerpc) + PCF8575 (io expander) + LM84 (sensor)
 + RS5C372 (rtc) + X24645 (eeprom)

the following software

 2.6.25-git11 + your 2 patches + Patches 5-7 from Jochen's series
 (for the CPM2-bus-driver)

The rtc and the eeprom were assigend through of-tree. The expander
and the sensor were assigned via the old-binding method using
force-parameters.

It builds fine, except for two warnings of redefinitions in Jochen's
patches. (I think they need a few updates anyhow). The output in
modules.alias and /sys make sense. I2C works flawlessly for all
devices.

Please let me know, if you need to more information.

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIFe7PD27XaX1/VRsRApJ0AJ4hu0eSjFjaM/lgiLv3bOoz7mv+zQCdH9jE
aPqEJiBlQhXddi3O389OFrI=
=5Vz8
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--
