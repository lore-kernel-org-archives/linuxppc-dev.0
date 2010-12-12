Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4FCAAB70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 12 Dec 2010 19:47:13 +1100 (EST)
Date: Sun, 12 Dec 2010 09:47:07 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 1/2] powerpc, mpc5200: update defconfig to fit with
	2.6.37-rc4
Message-ID: <20101212084707.GA14580@pengutronix.de>
References: <1292047981-1435-1-git-send-email-hs@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
In-Reply-To: <1292047981-1435-1-git-send-email-hs@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 11, 2010 at 07:13:00AM +0100, Heiko Schocher wrote:
> Signed-off-by: Heiko Schocher <hs@denx.de>

I'd say the two patches can be merged. Dunno what Grant prefers whom you sh=
ould
CC as he is the maintainer.

> cc: Wolfram Sang <w.sang@pengutronix.de>
> cc: linuxppc-dev@lists.ozlabs.org
> ---
> - based against 2.6.37-rc4
> - I did the following steps to generate this patch:
>=20
>   make mpc5200_defconfig
>   make savedefconfig
>   cp ./defconfig arch/powerpc/configs/mpc5200_defconfig
>=20
>  arch/powerpc/configs/mpc5200_defconfig |    5 +----
>  1 files changed, 1 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/configs/mpc5200_defconfig b/arch/powerpc/config=
s/mpc5200_defconfig
> index 7376e27..6f75623 100644
> --- a/arch/powerpc/configs/mpc5200_defconfig
> +++ b/arch/powerpc/configs/mpc5200_defconfig
> @@ -1,5 +1,6 @@
>  CONFIG_EXPERIMENTAL=3Dy
>  CONFIG_SYSVIPC=3Dy
> +CONFIG_SPARSE_IRQ=3Dy
>  CONFIG_LOG_BUF_SHIFT=3D14
>  CONFIG_BLK_DEV_INITRD=3Dy
>  # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> @@ -20,7 +21,6 @@ CONFIG_PPC_BESTCOMM=3Dy
>  CONFIG_SIMPLE_GPIO=3Dy
>  CONFIG_NO_HZ=3Dy
>  CONFIG_HIGH_RES_TIMERS=3Dy
> -CONFIG_SPARSE_IRQ=3Dy
>  CONFIG_PM=3Dy
>  CONFIG_NET=3Dy
>  CONFIG_PACKET=3Dy
> @@ -52,7 +52,6 @@ CONFIG_PROC_DEVICETREE=3Dy
>  CONFIG_BLK_DEV_LOOP=3Dy
>  CONFIG_BLK_DEV_RAM=3Dy
>  CONFIG_BLK_DEV_RAM_SIZE=3D32768
> -CONFIG_EEPROM_AT24=3Dy

NACK.

>  CONFIG_SCSI_TGT=3Dy
>  CONFIG_BLK_DEV_SD=3Dy
>  CONFIG_CHR_DEV_SG=3Dy
> @@ -114,7 +113,6 @@ CONFIG_RTC_DRV_DS1307=3Dy
>  CONFIG_EXT2_FS=3Dy
>  CONFIG_EXT3_FS=3Dy
>  # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
> -CONFIG_INOTIFY=3Dy

Are you sure?

>  CONFIG_MSDOS_FS=3Dy
>  CONFIG_VFAT_FS=3Dy
>  CONFIG_PROC_KCORE=3Dy
> @@ -132,5 +130,4 @@ CONFIG_PRINTK_TIME=3Dy
>  CONFIG_DEBUG_KERNEL=3Dy
>  CONFIG_DETECT_HUNG_TASK=3Dy
>  CONFIG_DEBUG_INFO=3Dy
> -# CONFIG_RCU_CPU_STALL_DETECTOR is not set
>  # CONFIG_CRYPTO_ANSI_CPRNG is not set
> --=20
> 1.7.2.3
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk0EjAsACgkQD27XaX1/VRvNwACfavX7DxsgXNPBSIiM8lmFnG9u
eawAnR9z53aUbjm0mA4mWeBUP6DNpgBw
=Z7iP
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
