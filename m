Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 41254DDDDB
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Dec 2007 01:09:32 +1100 (EST)
Date: Sun, 16 Dec 2007 01:09:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 2/3] [libata] pata_of_platform: OF-Platform PATA device
	driver
Message-Id: <20071216010922.13ef21d0.sfr@canb.auug.org.au>
In-Reply-To: <20071214182438.GB1017@localhost.localdomain>
References: <20071214182109.GA858@localhost.localdomain>
	<20071214182438.GB1017@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__16_Dec_2007_01_09_22_+1100_WWFH_=wHbbmcA3im"
Cc: Jeff Garzik <jeff@garzik.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mundt <lethal@linux-sh.org>, Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__16_Dec_2007_01_09_22_+1100_WWFH_=wHbbmcA3im
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Dec 2007 21:24:38 +0300 Anton Vorontsov <avorontsov@ru.mvista.co=
m> wrote:
>
> +	prop =3D (u32 *)of_get_property(dn, "reg-shift", NULL);

This cast is unnecessary.

> +	if (prop)
> +		reg_shift =3D *prop;
> +
> +	prop =3D (u32 *)of_get_property(dn, "pio-mode", NULL);

So is this one.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__16_Dec_2007_01_09_22_+1100_WWFH_=wHbbmcA3im
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHY+AYTgG2atn1QN8RAp21AJ9zGiZQPsyFbyuofbsH57ogiqT92ACaAgKx
N6dQf7DMBkJo7F3DFGm8gMY=
=4aw3
-----END PGP SIGNATURE-----

--Signature=_Sun__16_Dec_2007_01_09_22_+1100_WWFH_=wHbbmcA3im--
