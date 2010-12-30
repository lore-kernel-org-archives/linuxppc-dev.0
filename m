Return-Path: <glikely@secretlab.ca>
Received: from mail-iy0-f195.google.com (mail-iy0-f195.google.com
	[209.85.210.195]) by ozlabs.org (Postfix) with ESMTP id AC49C1007F4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Dec 2010 16:35:59 +1100 (EST)
Received: by mail-iy0-f195.google.com with SMTP id 17so5149333iyj.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Dec 2010 21:35:59 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Wed, 29 Dec 2010 22:35:55 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH 6/6] mpc8308_p1m: add DMA controller device-tree node
Message-ID: <20101230053555.GC27954@angua.secretlab.ca>
References: <1285676696-5358-1-git-send-email-yanok@emcraft.com>
	<1288137180-3220-7-git-send-email-yanok@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1288137180-3220-7-git-send-email-yanok@emcraft.com>
Cc: vlad@emcraft.com, linuxppc-dev@lists.ozlabs.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 27, 2010 at 01:53:00AM +0200, Ilya Yanok wrote:
> MPC8308 has DMA controller compatible with mpc512x_dma driver. This
> patch adds device-tree node to support DMA controller on MPC8308 P1M
> board.
> 
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>

Merged for -next, thanks.

g.

> ---
>  arch/powerpc/boot/dts/mpc8308_p1m.dts |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/mpc8308_p1m.dts b/arch/powerpc/boot/dts/mpc8308_p1m.dts
> index 05a76cc..697b3f6 100644
> --- a/arch/powerpc/boot/dts/mpc8308_p1m.dts
> +++ b/arch/powerpc/boot/dts/mpc8308_p1m.dts
> @@ -297,6 +297,14 @@
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
