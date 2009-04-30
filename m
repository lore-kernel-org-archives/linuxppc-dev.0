Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8CD86DDE26
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 14:31:03 +1000 (EST)
Date: Thu, 30 Apr 2009 14:30:50 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Feng Kan <fkan@amcc.com>
Subject: Re: [PATCH 1/2] Add support for Designware SATA controller driver
Message-Id: <20090430143050.d51c29a6.sfr@canb.auug.org.au>
In-Reply-To: <1241041345-19479-1-git-send-email-fkan@amcc.com>
References: <1241041345-19479-1-git-send-email-fkan@amcc.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__30_Apr_2009_14_30_50_+1000_hedQktUkifZ6AUDp"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__30_Apr_2009_14_30_50_+1000_hedQktUkifZ6AUDp
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Apr 2009 14:42:25 -0700 Feng Kan <fkan@amcc.com> wrote:
>
> Signed-off-by: Feng Kan <fkan@amcc.com>
> ---
>  drivers/ata/Kconfig    |   76 +-
>  drivers/ata/Makefile   |    1 +
>  drivers/ata/sata_dwc.c | 2047 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 2091 insertions(+), 33 deletions(-)
>  create mode 100644 drivers/ata/sata_dwc.c
>=20
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 0bcf264..5321e47 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -72,56 +72,66 @@ config SATA_FSL
> =20
>  	  If unsure, say N.
> =20
> -config ATA_SFF
> -	bool "ATA SFF support"
> -	default y
> +config SATA_DWC
> +	tristate "DesignWare Cores SATA support"
> +	depends on 460EX
>  	help
> -	  This option adds support for ATA controllers with SFF
> -	  compliant or similar programming interface.
> +	  This option enables support for the Synopsys DesignWare Cores SATA
> +	  controller.
> +	  It can be found on the AMCC 460EX.
> =20
> -	  SFF is the legacy IDE interface that has been around since
> -	  the dawn of time.  Almost all PATA controllers have an
> -	  SFF interface.  Many SATA controllers have an SFF interface
> -	  when configured into a legacy compatibility mode.
> +	  If unsure, say N.
> =20
> -	  For users with exclusively modern controllers like AHCI,
> -	  Silicon Image 3124, or Marvell 6440, you may choose to
> -	  disable this uneeded SFF support.
> +config ATA_SFF
> +bool "ATA SFF support"
> +default y
> +help
> +  This option adds support for ATA controllers with SFF
> +  compliant or similar programming interface.

You seem to have reformatted some of this file (hopefully)
unintentionally ...

And the linuxppc-embedded mailing list has gone away.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__30_Apr_2009_14_30_50_+1000_hedQktUkifZ6AUDp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkn5KXoACgkQjjKRsyhoI8yqCACfcpBqm1gdehLapO9Ij/d7gvhx
Yd8An07gvvTkJsAiyzwYPbuURbBj2GxS
=Wb/8
-----END PGP SIGNATURE-----

--Signature=_Thu__30_Apr_2009_14_30_50_+1000_hedQktUkifZ6AUDp--
