Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id ADE6ADDDEF
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2008 17:36:23 +1100 (EST)
Date: Mon, 10 Mar 2008 17:35:47 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: hs@denx.de
Subject: Re: [Patch] 8xx: MGSUVD support
Message-Id: <20080310173547.e3cfeaa1.sfr@canb.auug.org.au>
In-Reply-To: <47D4D686.8010101@denx.de>
References: <47D3B44D.8070909@denx.de>
	<20080310143217.11e2b10f.sfr@canb.auug.org.au>
	<47D4D686.8010101@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__10_Mar_2008_17_35_47_+1100_1iGiDzct2L3O1uR."
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__10_Mar_2008_17_35_47_+1100_1iGiDzct2L3O1uR.
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 10 Mar 2008 07:34:46 +0100 Heiko Schocher <hs@denx.de> wrote:
>
> >> +static struct of_device_id __initdata of_bus_ids[] =3D {
> >=20
> > Make this __initdata, please.
>=20
> Hmm.. it is __initdata, or? But I fix it to:

OOPS, brain not working again after break :-)

sorry.

> static  __initdata struct of_device_id of_bus_ids[]

It is right either way.  But linux/init.h says it should go just before
the '=3D' sign.

> I will send a overworked patch.

Nice :-)  ("overworked" means "having too much work to do" - I think you
meant "reworked")

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__10_Mar_2008_17_35_47_+1100_1iGiDzct2L3O1uR.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH1NbITgG2atn1QN8RAqpgAJ9JtuGepys/xOc2mqw7ZtONseTrXwCeNHkr
IRVOMoMYOjWO3673RhIWkVY=
=LxcI
-----END PGP SIGNATURE-----

--Signature=_Mon__10_Mar_2008_17_35_47_+1100_1iGiDzct2L3O1uR.--
