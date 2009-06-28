Return-Path: <jonsmirl@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E7433B7066
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Jun 2009 04:06:35 +1000 (EST)
Received: from mail-qy0-f188.google.com (mail-qy0-f188.google.com
	[209.85.221.188]) by ozlabs.org (Postfix) with ESMTP id 3ADA5DDD0B
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jun 2009 04:06:34 +1000 (EST)
Received: by qyk26 with SMTP id 26so1287725qyk.17
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Jun 2009 11:06:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090628074109.26905.9927.stgit@localhost.localdomain>
References: <20090628074109.26905.9927.stgit@localhost.localdomain>
Date: Sun, 28 Jun 2009 14:06:32 -0400
Message-ID: <9e4733910906281106o6d61a6a6uef9023068415ec5e@mail.gmail.com>
Subject: Re: [PATCH 1/2] alsa/soc: Fix typo in MPC5200 PSC AC97 driver Kconfig
From: Jon Smirl <jonsmirl@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk,
	timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 28, 2009 at 3:41 AM, Grant Likely<grant.likely@secretlab.ca> wr=
ote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> ALSA SoC drivers should be specify SND_SOC_AC97_BUS instead, not AC97_BUS=
.
> Without SND_SOC_AC97_BUS defined, an AC97 device will not get correctly
> registered on the AC97 bus, which prevents thinks like the WM9712
> touchscreen driver from getting probed.
>
> Tested against 2.6.31-rc1.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Jon Smirl <jonsmirl@gmail.com>

> ---
>
> =A0sound/soc/fsl/Kconfig | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
>
> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> index 5dbebf8..5661876 100644
> --- a/sound/soc/fsl/Kconfig
> +++ b/sound/soc/fsl/Kconfig
> @@ -33,7 +33,7 @@ config SND_SOC_MPC5200_I2S
> =A0config SND_SOC_MPC5200_AC97
> =A0 =A0 =A0 =A0tristate "Freescale MPC5200 PSC in AC97 mode driver"
> =A0 =A0 =A0 =A0depends on PPC_MPC52xx && PPC_BESTCOMM
> - =A0 =A0 =A0 select AC97_BUS
> + =A0 =A0 =A0 select SND_SOC_AC97_BUS
> =A0 =A0 =A0 =A0select SND_MPC52xx_DMA
> =A0 =A0 =A0 =A0select PPC_BESTCOMM_GEN_BD
> =A0 =A0 =A0 =A0help
>
>



--=20
Jon Smirl
jonsmirl@gmail.com
