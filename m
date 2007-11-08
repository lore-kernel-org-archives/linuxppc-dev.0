Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 791A0DDDFF
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 12:05:37 +1100 (EST)
Date: Thu, 8 Nov 2007 12:05:35 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [RFC] Modifying i2c-core to support alias driver names
	compatible with device trees
Message-Id: <20071108120535.769e4d73.sfr@canb.auug.org.au>
In-Reply-To: <9e4733910711061239g22b06863rbec37fcef138c869@mail.gmail.com>
References: <9e4733910711061239g22b06863rbec37fcef138c869@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__8_Nov_2007_12_05_35_+1100_0xKK2nGUQH.xjoKu"
Cc: Jean Delvare <khali@linux-fr.org>, Tjernlund <tjernlund@tjernlund.se>,
	i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__8_Nov_2007_12_05_35_+1100_0xKK2nGUQH.xjoKu
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Nov 2007 15:39:42 -0500 "Jon Smirl" <jonsmirl@gmail.com> wrote:
>
> It was requested to split this code out into a separate thread....
>=20
> This code modifies the i2c-core to support lists of alias names in the
> chip drivers.
> For example: .aliases	=3D (char const
> *[]){"ricoh,rs5c372a","ricoh,rs5c372b","ricoh,rv5c386","ricoh,rv5c387a",
> 0},

You should not need the (char const *[]) casts at all.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__8_Nov_2007_12_05_35_+1100_0xKK2nGUQH.xjoKu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHMmDjTgG2atn1QN8RAqn1AJ0S/3pTAA3i5LIXEA38YKRms1zX8gCeIvna
gLbPr7i/KYT1j9LhIT2bNB8=
=qljE
-----END PGP SIGNATURE-----

--Signature=_Thu__8_Nov_2007_12_05_35_+1100_0xKK2nGUQH.xjoKu--
