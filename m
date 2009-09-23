Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 069CFB7B7B
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 21:59:56 +1000 (EST)
Date: Wed, 23 Sep 2009 15:59:54 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Gao Guanhua <B22826@freescale.com>
Subject: Re: [PATCH 6/6] P2020DS: Remove sdhci-dma-broken and
	sdhci-ahb2mag-irq-bypass properties
Message-ID: <20090923115954.GC6425@oksana.dev.rtsoft.ru>
References: <1253696892-15262-1-git-send-email-B22826@freescale.com>
	<1253696892-15262-2-git-send-email-B22826@freescale.com>
	<1253696892-15262-3-git-send-email-B22826@freescale.com>
	<1253696892-15262-4-git-send-email-B22826@freescale.com>
	<1253696892-15262-5-git-send-email-B22826@freescale.com>
	<1253696892-15262-6-git-send-email-B22826@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1253696892-15262-6-git-send-email-B22826@freescale.com>
Cc: linuxppc-dev@ozlabs.org, sdhci-devel@lists.ossman.eu
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 23, 2009 at 05:08:12PM +0800, Gao Guanhua wrote:
> The SDHC on P2020DS board use DMA mode by default.
> This patch remove the properties used in PIO mode.

You just added the properties in 3/6 and 4/6, and now you instantly
remove them?

> ---
>  arch/powerpc/boot/dts/p2020ds.dts |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/p2020ds.dts b/arch/powerpc/boot/dts/p2020ds.dts
> index 29989fb..3263397 100644
> --- a/arch/powerpc/boot/dts/p2020ds.dts
> +++ b/arch/powerpc/boot/dts/p2020ds.dts
> @@ -459,8 +459,6 @@
>  			reg = <0x2e000 0x1000>;
>  			interrupts = <72 0x2>;
>  			interrupt-parent = <&mpic>;
> -			fsl,sdhci-dma-broken;
> -			fsl,sdhci-ahb2mag-irq-bypass;
>  			fsl,sdhci-adjust-timeout;
>  			clock-frequency = <0>;
>  		};
> -- 
> 1.6.4

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
