Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 692412C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 11:24:22 +1000 (EST)
Message-ID: <1380158651.24959.239.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/fsl/defconfig: enable CONFIG_AT803X_PHY
From: Scott Wood <scottwood@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Date: Wed, 25 Sep 2013 20:24:11 -0500
In-Reply-To: <1378196906-9850-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1378196906-9850-1-git-send-email-Shengzhou.Liu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-09-03 at 16:28 +0800, Shengzhou Liu wrote:
> Enable CONFIG_AT803X_PHY to support AR8030/8033/8035 PHY.
> 
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> ---
>  arch/powerpc/configs/corenet32_smp_defconfig |    1 +
>  arch/powerpc/configs/mpc85xx_defconfig       |    1 +
>  arch/powerpc/configs/mpc85xx_smp_defconfig   |    1 +
>  3 files changed, 3 insertions(+), 0 deletions(-)

Why not corenet64_smp_defconfig?  Which boards have this PHY?

-Scott
