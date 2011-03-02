Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C05B61007D5
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Mar 2011 08:23:45 +1100 (EST)
Date: Wed, 2 Mar 2011 22:08:03 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Albrecht =?iso-8859-15?Q?Dre=DF?= <albrecht.dress@arcor.de>
Subject: Re: [OT - MPC5200B] strange framing, break problems with uart
Message-ID: <20110302210803.GA32623@pengutronix.de>
References: <AANLkTi=gqFLtM7f01GFVKdSibxz4q5J9LtHrpOcH_1ta@mail.gmail.com>
	<1299097003.1795.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
In-Reply-To: <1299097003.1795.0@antares>
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>,
	Henk Stegeman <henk.stegeman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> After some discussions with Freescale's and FTDI's support, the reason se=
ems
> to be that the FTDI chips continues to send zero up to 4 chars *after* the
> RTSn line has been deactivated by the '5200B (actually, this is the behav=
iour
> of many uart's).

Russell described this behaviour nicely here:

http://www.spinics.net/lists/linux-serial/msg02136.html

=46rom that point of view, FTDI is not to blame.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk1usbMACgkQD27XaX1/VRtsmACfZssGe/zYI6IM6KvbJZf1MbO+
NH0An07+YI8upE5BqfeE2qxtwswsZ1re
=fg7U
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
