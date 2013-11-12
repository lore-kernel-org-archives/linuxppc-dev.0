Return-Path: <scottwood@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 549D32C0096
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Nov 2013 09:05:00 +1100 (EST)
Received: from mail210-ch1 (localhost [127.0.0.1])	by
 mail210-ch1-R.bigfish.com (Postfix) with ESMTP id 319E53A017C	for
 <linuxppc-dev@ozlabs.org>; Tue, 12 Nov 2013 22:04:57 +0000 (UTC)
Received: from CH1EHSMHS033.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.235])	by mail210-ch1.bigfish.com (Postfix) with ESMTP id
 C73091600CD	for <linuxppc-dev@ozlabs.org>; Tue, 12 Nov 2013 22:04:55 +0000
 (UTC)
Message-ID: <1384293891.1403.70.camel@snotra.buserror.net>
Subject: Re: [PATCH V2] powerpc/85xx: Merge 85xx/p1023_defconfig into
 mpc85xx_smp_defconfig and mpc85xx_defconfig
From: Scott Wood <scottwood@freescale.com>
To: Lijun Pan <Lijun.Pan@freescale.com>
Date: Tue, 12 Nov 2013 16:04:51 -0600
In-Reply-To: <1384197913-24610-1-git-send-email-Lijun.Pan@freescale.com>
References: <1383952632-5770-1-git-send-email-Lijun.Pan@freescale.com>
 <1384197913-24610-1-git-send-email-Lijun.Pan@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-11-11 at 13:25 -0600, Lijun Pan wrote:
> mpc85xx_smp_defconfig and mpc85xx_defconfig already have CONFIG_P1023RDS=y.
> Merge CONFIG_P1023RDB=y and other relevant configurations into mpc85xx_smp_defconfig and mpc85_defconfig.
> 
> Signed-off-by: Lijun Pan <Lijun.Pan@freescale.com>
> ---
>  arch/powerpc/configs/85xx/p1023_defconfig  |  188 ----------------------------
>  arch/powerpc/configs/mpc85xx_defconfig     |   18 +++
>  arch/powerpc/configs/mpc85xx_smp_defconfig |   17 +++
>  3 files changed, 35 insertions(+), 188 deletions(-)
>  delete mode 100644 arch/powerpc/configs/85xx/p1023_defconfig

Are we still going to want to have one defconfig if and when we finally
get datapath support upstream?  That's a lot of code to add to the 85xx
config just for this one chip.

-Scott
