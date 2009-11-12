Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id DF1B4B7B94
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 06:56:52 +1100 (EST)
Date: Thu, 12 Nov 2009 20:56:46 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Albrecht =?iso-8859-15?Q?Dre=DF?= <albrecht.dress@arcor.de>
Subject: Re: [PATCHv2 3/3] mpc52xx/wdt: remove obsolete old WDT implementation
Message-ID: <20091112195646.GB13350@pengutronix.de>
References: <1258051520.2280.3@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
In-Reply-To: <1258051520.2280.3@antares>
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>,
	Devicetree Discussions <devicetree-discuss@lists.ozlabs.org>,
	Wim Van Sebroeck <wim@iguana.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2009 at 07:45:20PM +0100, Albrecht Dre=DF wrote:
> Remove the old WDT implementation.
>=20
> Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>
> ---
>=20
> Change against v1: WDT stuff now fully merged into the file
> arch/powerpc/platforms/52xx/mpc52xx_gpt.c.
>=20
> Note: The file drivers/watchdog/mpc5200_wdt.c is now obsolete and should =
be removed.

Ehrm, this is possible within a patch :)

>=20
>  drivers/watchdog/Kconfig  |    4 +++-
>  drivers/watchdog/Makefile |    1 -
>  2 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 3711b88..d958b76 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -861,8 +861,10 @@ config GEF_WDT
>  	  Watchdog timer found in a number of GE Fanuc single board computers.
> =20
>  config MPC5200_WDT
> -	tristate "MPC5200 Watchdog Timer"
> +	bool "MPC52xx Watchdog Timer"
>  	depends on PPC_MPC52xx
> +	help
> +	  Use General Purpose Timer (GPT) 0 on the MPC5200 as Watchdog.

s/5200/52xx/ here too.

> =20
>  config 8xxx_WDT
>  	tristate "MPC8xxx Platform Watchdog Timer"
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 699199b..89c045d 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -118,7 +118,6 @@ obj-$(CONFIG_TXX9_WDT) +=3D txx9wdt.o
> =20
>  # POWERPC Architecture
>  obj-$(CONFIG_GEF_WDT) +=3D gef_wdt.o
> -obj-$(CONFIG_MPC5200_WDT) +=3D mpc5200_wdt.o
>  obj-$(CONFIG_8xxx_WDT) +=3D mpc8xxx_wdt.o
>  obj-$(CONFIG_MV64X60_WDT) +=3D mv64x60_wdt.o
>  obj-$(CONFIG_PIKA_WDT) +=3D pika_wdt.o
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkr8aH4ACgkQD27XaX1/VRsdEwCgrOgjgL2n3WzSosnIcsux+AgL
EuAAnjCqdtHI0Spx7oUmgZfwSll3Ymm0
=ebpH
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
