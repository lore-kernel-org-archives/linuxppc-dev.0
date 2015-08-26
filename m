Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B0E9F1A0179
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 01:54:44 +1000 (AEST)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0133.outbound.protection.outlook.com [207.46.100.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A98EB140332
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2015 01:54:42 +1000 (AEST)
Message-ID: <1440598867.16577.112.camel@freescale.com>
Subject: Re: [PATCH] powerpc: Update defconfigs
From: Scott Wood <scottwood@freescale.com>
To: Michael Ellerman <mpe@ellerman.id.au>
CC: <linuxppc-dev@ozlabs.org>
Date: Wed, 26 Aug 2015 09:21:07 -0500
In-Reply-To: <1440589636-14616-1-git-send-email-mpe@ellerman.id.au>
References: <1440589636-14616-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-08-26 at 21:47 +1000, Michael Ellerman wrote:
> Mostly uninteresting, though a few worth noting:
> 
>   CONFIG_BLK_DEV_XIP                  -> CONFIG_BLK_DEV_RAM_DAX
>   CONFIG_CLK_PPC_CORENET              -> CONFIG_CLK_QORIQ
>   CONFIG_CRYPTO_ANSI_CPRNG            -> was default=m, not anymore
>   CONFIG_EXT2_FS_XIP                  -> CONFIG_FS_DAX
>   CONFIG_I2O=y                                -> removed
>   CONFIG_KEYS_DEBUG_PROC_KEYS=y               -> removed
>   CONFIG_NUMA_BALANCING_DEFAULT_ENABLED       -> now default y
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/configs/40x/acadia_defconfig         |  1 -
>  arch/powerpc/configs/40x/ep405_defconfig          |  1 -
>  arch/powerpc/configs/40x/kilauea_defconfig        |  1 -
>  arch/powerpc/configs/40x/makalu_defconfig         |  1 -
>  arch/powerpc/configs/40x/obs600_defconfig         |  1 -
>  arch/powerpc/configs/40x/virtex_defconfig         |  1 -
>  arch/powerpc/configs/40x/walnut_defconfig         |  1 -
>  arch/powerpc/configs/44x/akebono_defconfig        |  1 -
>  arch/powerpc/configs/44x/bamboo_defconfig         |  1 -
>  arch/powerpc/configs/44x/currituck_defconfig      |  1 -
>  arch/powerpc/configs/44x/ebony_defconfig          |  1 -
>  arch/powerpc/configs/44x/eiger_defconfig          |  4 ----
>  arch/powerpc/configs/44x/icon_defconfig           |  1 -
>  arch/powerpc/configs/44x/iss476-smp_defconfig     |  1 -
>  arch/powerpc/configs/44x/katmai_defconfig         |  1 -
>  arch/powerpc/configs/44x/rainier_defconfig        |  1 -
>  arch/powerpc/configs/44x/redwood_defconfig        |  4 ----
>  arch/powerpc/configs/44x/sequoia_defconfig        |  1 -
>  arch/powerpc/configs/44x/taishan_defconfig        |  1 -
>  arch/powerpc/configs/44x/virtex5_defconfig        |  1 -
>  arch/powerpc/configs/44x/warp_defconfig           |  1 -
>  arch/powerpc/configs/52xx/cm5200_defconfig        |  1 -
>  arch/powerpc/configs/52xx/lite5200b_defconfig     |  1 -
>  arch/powerpc/configs/52xx/motionpro_defconfig     |  1 -
>  arch/powerpc/configs/52xx/tqm5200_defconfig       |  1 -
>  arch/powerpc/configs/83xx/asp8347_defconfig       |  1 -
>  arch/powerpc/configs/83xx/mpc8313_rdb_defconfig   |  1 -
>  arch/powerpc/configs/83xx/mpc8315_rdb_defconfig   |  1 -
>  arch/powerpc/configs/83xx/mpc832x_mds_defconfig   |  1 -
>  arch/powerpc/configs/83xx/mpc832x_rdb_defconfig   |  1 -
>  arch/powerpc/configs/83xx/mpc834x_itx_defconfig   |  1 -
>  arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig |  1 -
>  arch/powerpc/configs/83xx/mpc834x_mds_defconfig   |  1 -
>  arch/powerpc/configs/83xx/mpc836x_mds_defconfig   |  1 -
>  arch/powerpc/configs/83xx/mpc836x_rdk_defconfig   |  1 -
>  arch/powerpc/configs/83xx/mpc837x_mds_defconfig   |  1 -
>  arch/powerpc/configs/83xx/mpc837x_rdb_defconfig   |  1 -
>  arch/powerpc/configs/83xx/sbc834x_defconfig       |  1 -
>  arch/powerpc/configs/85xx/ge_imp3a_defconfig      |  1 -
>  arch/powerpc/configs/85xx/kmp204x_defconfig       |  3 +--
>  arch/powerpc/configs/85xx/ksi8560_defconfig       |  1 -
>  arch/powerpc/configs/85xx/mpc8540_ads_defconfig   |  1 -
>  arch/powerpc/configs/85xx/mpc8560_ads_defconfig   |  1 -
>  arch/powerpc/configs/85xx/mpc85xx_cds_defconfig   |  1 -
>  arch/powerpc/configs/85xx/sbc8548_defconfig       |  1 -
>  arch/powerpc/configs/85xx/socrates_defconfig      |  1 -
>  arch/powerpc/configs/85xx/stx_gp3_defconfig       |  1 -
>  arch/powerpc/configs/85xx/tqm8540_defconfig       |  1 -
>  arch/powerpc/configs/85xx/tqm8541_defconfig       |  1 -
>  arch/powerpc/configs/85xx/tqm8548_defconfig       |  1 -
>  arch/powerpc/configs/85xx/tqm8555_defconfig       |  1 -
>  arch/powerpc/configs/85xx/tqm8560_defconfig       |  1 -
>  arch/powerpc/configs/85xx/xes_mpc85xx_defconfig   |  3 +--
>  arch/powerpc/configs/86xx/gef_ppc9a_defconfig     |  1 -
>  arch/powerpc/configs/86xx/gef_sbc310_defconfig    |  1 -
>  arch/powerpc/configs/86xx/gef_sbc610_defconfig    |  2 --
>  arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig  |  1 -
>  arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig  |  1 -
>  arch/powerpc/configs/86xx/sbc8641d_defconfig      |  2 --
>  arch/powerpc/configs/amigaone_defconfig           |  1 -
>  arch/powerpc/configs/c2k_defconfig                |  3 ---
>  arch/powerpc/configs/cell_defconfig               |  2 --
>  arch/powerpc/configs/chrp32_defconfig             |  1 -
>  arch/powerpc/configs/corenet32_smp_defconfig      |  5 ++---
>  arch/powerpc/configs/corenet64_smp_defconfig      |  3 +--
>  arch/powerpc/configs/ep8248e_defconfig            |  1 -
>  arch/powerpc/configs/g5_defconfig                 |  4 +---
>  arch/powerpc/configs/linkstation_defconfig        |  1 -
>  arch/powerpc/configs/maple_defconfig              |  3 +--
>  arch/powerpc/configs/mgcoge_defconfig             |  1 -
>  arch/powerpc/configs/mpc512x_defconfig            |  5 ++---
>  arch/powerpc/configs/mpc5200_defconfig            |  1 -
>  arch/powerpc/configs/mpc7448_hpc2_defconfig       |  1 -
>  arch/powerpc/configs/mpc8272_ads_defconfig        |  1 -
>  arch/powerpc/configs/mpc83xx_defconfig            |  1 -
>  arch/powerpc/configs/mpc85xx_defconfig            |  1 -
>  arch/powerpc/configs/mpc85xx_smp_defconfig        |  1 -
>  arch/powerpc/configs/mpc866_ads_defconfig         |  1 -
>  arch/powerpc/configs/mpc86xx_defconfig            |  1 -
>  arch/powerpc/configs/mvme5100_defconfig           |  1 -
>  arch/powerpc/configs/pasemi_defconfig             |  1 -
>  arch/powerpc/configs/pmac32_defconfig             |  2 --
>  arch/powerpc/configs/ppc40x_defconfig             |  1 -
>  arch/powerpc/configs/ppc44x_defconfig             |  1 -
>  arch/powerpc/configs/ppc64_defconfig              |  8 +++-----
>  arch/powerpc/configs/ppc64e_defconfig             |  3 +--
>  arch/powerpc/configs/ppc6xx_defconfig             |  7 ++-----
>  arch/powerpc/configs/pq2fads_defconfig            |  1 -
>  arch/powerpc/configs/ps3_defconfig                |  2 --
>  arch/powerpc/configs/pseries_defconfig            | 10 ++++------
>  arch/powerpc/configs/wii_defconfig                |  1 -
>  91 files changed, 19 insertions(+), 128 deletions(-)

This conflicts with the 85xx config fragment patches that I've already sent 
you a pull request for...

-Scott
