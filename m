Return-Path: <Yuantian.Tang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0106.outbound.protection.outlook.com [157.56.111.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 38C731A0C2E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Feb 2015 13:54:31 +1100 (AEDT)
From: Yuantian Tang <Yuantian.Tang@freescale.com>
To: Emilian Medve <Emilian.Medve@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Scott Wood
 <scottwood@freescale.com>, "mturquette@linaro.org" <mturquette@linaro.org>,
 "haokexin@gmail.com" <haokexin@gmail.com>
Subject: RE: [PATCH v2 08/10] powerpc/corenet: Enable CLK_QORIQ
Date: Wed, 4 Feb 2015 02:54:22 +0000
Message-ID: <DM2PR03MB5740F66E8866C3CC943DC27FA3A0@DM2PR03MB574.namprd03.prod.outlook.com>
References: <1421834611-9656-1-git-send-email-Emilian.Medve@Freescale.com>
 <1421834611-9656-9-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1421834611-9656-9-git-send-email-Emilian.Medve@Freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Emilian Medve <Emilian.Medve@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Emil Medve [mailto:Emilian.Medve@Freescale.com]
> Sent: Wednesday, January 21, 2015 6:04 PM
> To: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421;
> mturquette@linaro.org; haokexin@gmail.com; Tang Yuantian-B29983
> Cc: Medve Emilian-EMMEDVE1
> Subject: [PATCH v2 08/10] powerpc/corenet: Enable CLK_QORIQ
>=20
> Change-Id: I1a80ad7b9f6854791bd270b746f93a91439155a6
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> ---
>  arch/powerpc/configs/corenet32_smp_defconfig | 1 +
> arch/powerpc/configs/corenet64_smp_defconfig | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/arch/powerpc/configs/corenet32_smp_defconfig
> b/arch/powerpc/configs/corenet32_smp_defconfig
> index 611efe9..cce62e9 100644
> --- a/arch/powerpc/configs/corenet32_smp_defconfig
> +++ b/arch/powerpc/configs/corenet32_smp_defconfig
> @@ -147,6 +147,7 @@ CONFIG_STAGING=3Dy
>  CONFIG_MEMORY=3Dy
>  CONFIG_VIRT_DRIVERS=3Dy
>  CONFIG_FSL_HV_MANAGER=3Dy
> +CONFIG_CLK_QORIQ=3Dy
>  CONFIG_EXT2_FS=3Dy
>  CONFIG_EXT3_FS=3Dy
>  # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set diff --git
> a/arch/powerpc/configs/corenet64_smp_defconfig
> b/arch/powerpc/configs/corenet64_smp_defconfig
> index be24a18..c9e8057 100644
> --- a/arch/powerpc/configs/corenet64_smp_defconfig
> +++ b/arch/powerpc/configs/corenet64_smp_defconfig
> @@ -117,6 +117,7 @@ CONFIG_DMADEVICES=3Dy
>  CONFIG_FSL_DMA=3Dy
>  CONFIG_VIRT_DRIVERS=3Dy
>  CONFIG_FSL_HV_MANAGER=3Dy
> +CONFIG_CLK_QORIQ=3Dy
>  CONFIG_FSL_CORENET_CF=3Dy
>  CONFIG_MEMORY=3Dy
>  CONFIG_EXT2_FS=3Dy
> --
> 2.2.1

Acked-by: Tang Yuantian <Yuantian.Tang@freescale.com>

Regards,
Yuantian
