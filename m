Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6BEAE2C018E
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Aug 2013 10:30:58 +1000 (EST)
Received: from mail104-ch1 (localhost [127.0.0.1])	by
 mail104-ch1-R.bigfish.com (Postfix) with ESMTP id 3B73A3E0214	for
 <linuxppc-dev@ozlabs.org>; Thu,  8 Aug 2013 00:30:56 +0000 (UTC)
Received: from CH1EHSMHS032.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.234])	by mail104-ch1.bigfish.com (Postfix) with ESMTP id
 3ED33A0031
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Aug 2013 00:30:54 +0000 (UTC)
Date: Wed, 7 Aug 2013 19:30:51 -0500
From: Scott Wood <scottwood@freescale.com>
To: Zhenhua Luo <zhenhua.luo@freescale.com>
Subject: Re: Enable CONFIG_DEVTMPFS_MOUNT to ensure /dev can be mounted
 correctly
Message-ID: <20130808003051.GA3847@home.buserror.net>
References: <1365688591-5323-1-git-send-email-zhenhua.luo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1365688591-5323-1-git-send-email-zhenhua.luo@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 11, 2013 at 09:56:30PM +0800, Zhenhua Luo wrote:
> When using recent udev, the /dev node mount requires CONFIG_DEVTMPFS_MOUNT
> is enabled in Kernel. The patch enables the option in defconfig of Freescale
> QorIQ targets.
> 
> Changed defconfig list:
>    arch/powerpc/configs/85xx/p1023rds_defconfig
>    arch/powerpc/configs/corenet32_smp_defconfig
>    arch/powerpc/configs/corenet64_smp_defconfig
>    arch/powerpc/configs/mpc85xx_smp_defconfig
> 
> Signed-off-by: Zhenhua Luo <zhenhua.luo@freescale.com>
> 
> ---
> arch/powerpc/configs/85xx/p1023rds_defconfig |    1 +
>  arch/powerpc/configs/corenet32_smp_defconfig |    1 +
>  arch/powerpc/configs/corenet64_smp_defconfig |    1 +
>  arch/powerpc/configs/mpc85xx_smp_defconfig   |    1 +
>  4 files changed, 4 insertions(+), 0 deletions(-)

Applied with mpc85xx_defconfig and mpc83xx_defconfig added.

-Scott
