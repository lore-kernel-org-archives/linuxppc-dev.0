Return-Path: <cbouatmailru@gmail.com>
Received: from mail-bw0-f42.google.com (mail-bw0-f42.google.com
	[209.85.214.42]) by ozlabs.org (Postfix) with ESMTP id D444CB6EF1
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 03:33:26 +1000 (EST)
Received: by bwz17 with SMTP id 17so2413048bwz.15
	for <linuxppc-dev@ozlabs.org>; Mon, 09 Aug 2010 10:33:24 -0700 (PDT)
Date: Mon, 9 Aug 2010 21:33:20 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: [PATCH 3/3 v2] dts: Add ESDHC weird voltage bits workaround
Message-ID: <20100809173320.GA7665@oksana.dev.rtsoft.ru>
References: <1280805072-26112-1-git-send-email-tie-fei.zang@freescale.com>
	<1280805072-26112-2-git-send-email-tie-fei.zang@freescale.com>
	<1280805072-26112-3-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1280805072-26112-3-git-send-email-tie-fei.zang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-mmc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 03, 2010 at 11:11:12AM +0800, Roy Zang wrote:
> P4080 ESDHC controller does not support 1.8V and 3.0V voltage. but the
> host controller capabilities register wrongly set the bits.
> This patch adds the workaround to correct the weird voltage setting bits.
> Only 3.3V voltage is supported for P4080 ESDHC controller.
> 
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Btw, where is implementation for the voltage-ranges handling?

> ---
>  arch/powerpc/boot/dts/p4080ds.dts |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
> index efa0091..2f0de24 100644
> --- a/arch/powerpc/boot/dts/p4080ds.dts
> +++ b/arch/powerpc/boot/dts/p4080ds.dts
> @@ -280,6 +280,7 @@
>  			reg = <0x114000 0x1000>;
>  			interrupts = <48 2>;
>  			interrupt-parent = <&mpic>;
> +			voltage-ranges = <3300 3300>;
>  			sdhci,auto-cmd12;
>  		};
>  
> -- 
> 1.5.6.5
