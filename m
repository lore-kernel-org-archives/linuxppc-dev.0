Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id B1FACDDDE2
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jun 2009 14:38:27 +1000 (EST)
Date: Tue, 2 Jun 2009 06:38:19 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: MPC8272- Porting HDLC driver from 2.6.14 to 2.6.27-
	"no_irq_chip" error
Message-ID: <20090602043819.GA1069@pengutronix.de>
References: <547eba1b0905280037j3336d0av7cc5d4069622d8f4@mail.gmail.com>
	<4A1E6877.2060106@aimvalley.nl>
	<20090528123311.GA3112@pengutronix.de>
	<1243903641.591.19.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
In-Reply-To: <1243903641.591.19.camel@pasglop>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Daniel Ng <daniel.ng1234@gmail.com>,
	Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> I would object that you wouldn't have this problem if you weren't hard
> wiring your interrupt number and were using the device-tree properly
> instead. As to getting your patch merged, you'll have to argue with
> Scott Wood who, I think, maintains the CPM2 stuff lately.

I fully agree that the proper way is using the device tree. I can't recall
exactly why this wasn't an option to me a year ago, but I assume it had
something to do with this ugly out-of-tree-driver. I wouldn't really argue
about this patch, I just thought it might be useful as it seems there are
people trying to do the same for some reason. Then again, maybe it should be
skipped, as it makes it easier to not use the proper solution (=3D device t=
ree)
:)

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkokrLsACgkQD27XaX1/VRsOmACgpRuB6DdZ+AXxjPhrZtdgP7Co
TRMAoIt0uiNzpkRdWU2SaJSlJerohr3W
=p4cK
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
