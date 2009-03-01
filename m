Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id CA8CADDE0A
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Mar 2009 21:18:22 +1100 (EST)
Date: Sun, 1 Mar 2009 11:18:15 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/mpc52xx: add Phytec phyCORE-MPC5200B-IO board
	(pcm032)
Message-ID: <20090301101815.GC23093@pengutronix.de>
References: <1235575933-29691-1-git-send-email-w.sang@pengutronix.de>
	<fa686aa40902262131i6c75687foaf42daeb4fc7a3b7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
In-Reply-To: <fa686aa40902262131i6c75687foaf42daeb4fc7a3b7@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

thanks for the review!

On Thu, Feb 26, 2009 at 10:31:24PM -0700, Grant Likely wrote:
> Thanks for the patch Wolfram.  Comments below.
>=20
> On Wed, Feb 25, 2009 at 8:32 AM, Wolfram Sang <w.sang@pengutronix.de> wro=
te:
> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> > ---
> > =A0arch/powerpc/boot/dts/pcm032.dts =A0 =A0 =A0 =A0 =A0 =A0 | =A0391 ++=
+++++
> > =A0arch/powerpc/configs/52xx/pcm032_defconfig =A0 | 1394 ++++++++++++++=
++++++++++++
>=20
> Do you really need a separate defconfig for this board?  Can it be
> merged with an existing defconfig?

Will have a look if I can make a pcm03x_defconfig out of pcm030_defconfig.

> motionpro.dts is a good example of what it should look like.

Ah, thanks for the pointer. Will have a look there. Guess I'll need to upda=
te
pcm030.dts later, too (from which I copied this one). Will rewrite the
localbus-node addressing the comments you gave.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmqYOcACgkQD27XaX1/VRt5DgCgj2chdus0lTbI8yvRemhhlA03
xaMAnA2XdnwlqLt8bi4qjGXVujAxmBR2
=qEol
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--
