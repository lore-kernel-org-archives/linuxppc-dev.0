Return-Path: <glikely@secretlab.ca>
Received: from mail-pw0-f67.google.com (mail-pw0-f67.google.com
	[209.85.160.67]) by ozlabs.org (Postfix) with ESMTP id 25F74100BC6
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Dec 2010 16:36:04 +1100 (EST)
Received: by pwi3 with SMTP id 3so1270441pwi.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Dec 2010 21:36:03 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Wed, 29 Dec 2010 22:36:01 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH 5/6] MPC8308RDB: add DMA controller device-tree node
Message-ID: <20101230053601.GD27954@angua.secretlab.ca>
References: <1285676696-5358-1-git-send-email-yanok@emcraft.com>
	<1288137180-3220-6-git-send-email-yanok@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1288137180-3220-6-git-send-email-yanok@emcraft.com>
Cc: vlad@emcraft.com, linuxppc-dev@lists.ozlabs.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 27, 2010 at 01:52:59AM +0200, Ilya Yanok wrote:
> MPC8308 has DMA controller compatible with mpc512x_dma driver. This
> patch adds device-tree node to support DMA controller on MPC8308RDB
> board.
> 
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>

Merged for -next, thanks.

g.

> ---
>  arch/powerpc/boot/dts/mpc8308rdb.dts |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/mpc8308rdb.dts b/arch/powerpc/boot/dts/mpc8308rdb.dts
> index 1e2b888..a0bd188 100644
> --- a/arch/powerpc/boot/dts/mpc8308rdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8308rdb.dts
> @@ -265,6 +265,14 @@
>  			interrupt-parent = < &ipic >;
>  		};
>  
> +		dma@2c000 {
> +			compatible = "fsl,mpc8308-dma", "fsl,mpc5121-dma";
> +			reg = <0x2c000 0x1800>;
> +			interrupts = <3 0x8
> +					94 0x8>;
> +			interrupt-parent = < &ipic >;
> +		};
> +
>  	};
>  
>  	pci0: pcie@e0009000 {
> -- 
> 1.7.2.3
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
