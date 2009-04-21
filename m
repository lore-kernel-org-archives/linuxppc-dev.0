Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id A6627DDEEC
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 19:56:19 +1000 (EST)
Date: Tue, 21 Apr 2009 11:56:04 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] keywest: Convert to new-style i2c driver
Message-ID: <20090421095604.GC3100@pengutronix.de>
References: <20090420225659.7b92a184@hyperion.delvare>
	<18924.63578.495727.152443@cargo.ozlabs.ibm.com>
	<s5hzleah5x4.wl%tiwai@suse.de>
	<20090421114853.7a9d82c1@hyperion.delvare>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
In-Reply-To: <20090421114853.7a9d82c1@hyperion.delvare>
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Not removing it now has a high risk of developers continuing to ignore
> the deprecation warnings and adding new legacy drivers, which I then
> must convert to the new model. This never ends.
>=20
> I know my behavior may seem a bit rude, but apparently this is the only
> way to get things to actually happen. I've been waiting for over a year
> already!
>=20
> I don't think the risk is that high, at least not for sound drivers.
> The conversions are fairly easy and if something really went wrong,
> fixing it is a matter of minutes.
>=20
> Please note that the removal of the legacy model isn't my goal per se.
> The fact is that the legacy model needs to be removed for further
> developments of i2c-core to happen, in particular the support of i2C
> bus multiplexers. There are patches waiting for inclusion since early
> February, which I can't take as long as the legacy i2c model is in.
> This is why I am pushing.

Full ACK!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkntmDQACgkQD27XaX1/VRvN7ACguh9w2d9l9wLw6o6t1XI15Hqa
CN8AniHkFvxCZ91/ZcB8C6xPDXsJpC6m
=dk3S
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--
