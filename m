Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0139.outbound.protection.outlook.com [207.46.163.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C81D9140E42
 for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2014 05:05:01 +1000 (EST)
Message-ID: <1399316691.15726.93.camel@snotra.buserror.net>
Subject: Re: [PATCH v2] powerpc/mpc85xx: Remove P1023 RDS support
From: Scott Wood <scottwood@freescale.com>
To: Lijun Pan <Lijun.Pan@freescale.com>
Date: Mon, 5 May 2014 14:04:51 -0500
In-Reply-To: <1399314195-28616-1-git-send-email-Lijun.Pan@freescale.com>
References: <1399314195-28616-1-git-send-email-Lijun.Pan@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Emilian.Medve@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-05-05 at 13:23 -0500, Lijun Pan wrote:
> P1023RDS is no longer supported/manufactured by Freescale while P1023RDB is.
> 
> Signed-off-by: Lijun Pan <Lijun.Pan@freescale.com>
> ---
>  arch/powerpc/boot/dts/p1023rds.dts                 | 219 ---------------------
>  arch/powerpc/configs/mpc85xx_defconfig             |   1 -
>  arch/powerpc/configs/mpc85xx_smp_defconfig         |   1 -
>  arch/powerpc/platforms/85xx/Kconfig                |   6 +-
>  arch/powerpc/platforms/85xx/Makefile               |   2 +-
>  .../platforms/85xx/{p1023_rds.c => p1023_rdb.c}    |  36 +---
>  6 files changed, 10 insertions(+), 255 deletions(-)
>  delete mode 100644 arch/powerpc/boot/dts/p1023rds.dts
>  rename arch/powerpc/platforms/85xx/{p1023_rds.c => p1023_rdb.c} (75%)

What changed from v1?

If you want this patch merged, please respond to the comments on v1.

-Scott
