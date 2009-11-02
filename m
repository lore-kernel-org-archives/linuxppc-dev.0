Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id D62F310080B
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Nov 2009 04:19:05 +1100 (EST)
Date: Mon, 2 Nov 2009 18:18:57 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: mpc512x/clock: fix clk_get logic
Message-ID: <20091102171857.GA3805@pengutronix.de>
References: <1256894234-11264-1-git-send-email-w.sang@pengutronix.de>
	<1256939657.6372.81.camel@pasglop>
	<20091031130131.GA23009@pengutronix.de>
	<1257022082.7907.7.camel@pasglop>
	<20091102142232.GD4696@pengutronix.de>
	<fa686aa40911020837g78339e06rf8c1679b2d94c895@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
In-Reply-To: <fa686aa40911020837g78339e06rf8c1679b2d94c895@mail.gmail.com>
Cc: Wolfgang Denk <wd@denx.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Is this patch intended for mainline?  I've received so many 5121

Yes, my branch is based on linus-git as of today. The CAN driver addition w=
as
just posted to socketcan-devel. It is also independent of the denx-patches[=
1]
and will later be send to netdev, too.

[1] Of course, the FEC patches are still very handy to bring up a board ;)

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrvFIEACgkQD27XaX1/VRvTFQCgusUBjy1z+HKDwm66YHt/T4kM
QDsAn3ShuwiPSnDc0ErCY6O1NC7dTRTO
=DZj2
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
