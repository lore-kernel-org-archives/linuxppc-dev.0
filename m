Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 7F8AFDDDEA
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 11:45:38 +1000 (EST)
Date: Wed, 14 May 2008 11:45:23 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 3/6] [WATCHDOG] mpc83xx_wdt: rename to mpc8xxx_wdt
Message-Id: <20080514114523.ae20b0da.sfr@canb.auug.org.au>
In-Reply-To: <20080513141459.GC15717@polina.dev.rtsoft.ru>
References: <20080513141411.GA8981@polina.dev.rtsoft.ru>
	<20080513141459.GC15717@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__14_May_2008_11_45_23_+1000_w_pR2dEUMiDhy302"
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Wim Van Sebroeck <wim@iguana.be>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__14_May_2008_11_45_23_+1000_w_pR2dEUMiDhy302
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 13 May 2008 18:14:59 +0400 Anton Vorontsov <avorontsov@ru.mvista.co=
m> wrote:
>
> Rename the driver because now we support some MPC86xx processors.
>=20
> There are no changes to the mpc83xx_wdt.c file, yet. When possible, we do
> file renames and changes separately (because Linus once asked so, because
> it helps git to track the renamed files).
>=20
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  drivers/watchdog/Kconfig       |    4 +-
>  drivers/watchdog/Makefile      |    2 +-
>  drivers/watchdog/mpc83xx_wdt.c |  273 ----------------------------------=
------
>  drivers/watchdog/mpc8xxx_wdt.c |  273 ++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 276 insertions(+), 276 deletions(-)
>  delete mode 100644 drivers/watchdog/mpc83xx_wdt.c
>  create mode 100644 drivers/watchdog/mpc8xxx_wdt.c

Doing this status with "git diff -M --stat" would show us if the file was
just renamed or if there were some changes as well ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__14_May_2008_11_45_23_+1000_w_pR2dEUMiDhy302
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIKkQ3TgG2atn1QN8RAqp+AJ4qh/TGHrztSej+pYVH5ZRDEq/WLwCdHx1L
C2I4OaH0pFPZfl1QYziYM1M=
=YCVp
-----END PGP SIGNATURE-----

--Signature=_Wed__14_May_2008_11_45_23_+1000_w_pR2dEUMiDhy302--
