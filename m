Return-Path: <vinod.koul@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qtqhW01T1zDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 01:22:02 +1000 (AEST)
Date: Mon, 25 Apr 2016 20:56:43 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Zhou Wang <wangzhou1@hisilicon.com>, Tony Lindgren <tony@atomide.com>,
 Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Mark Brown <broonie@kernel.org>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Joe Perches <joe@perches.com>, devicetree@vger.kernel.org,
 linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org
Subject: Re: [PATCH 06/14] dmaengine: bcm2835: DT spelling
 s/interrupts-names/interrupt-names/
Message-ID: <20160425152643.GZ2274@localhost>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
 <1461166339-11109-7-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461166339-11109-7-git-send-email-geert+renesas@glider.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 20, 2016 at 05:32:11PM +0200, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/sound/davinci-mcbsp.txt | 2 +-

This change does not apply for me, can you please split it up and send the
sound ones thru sound tree

-- 
~Vinod

>  drivers/dma/bcm2835-dma.c                                 | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt b/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
> index 55b53e1fd72c9d6e..e0b6165c9cfcec19 100644
> --- a/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
> +++ b/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
> @@ -43,7 +43,7 @@ mcbsp0: mcbsp@1d10000 {
>  		<0x00310000 0x1000>;
>  	reg-names = "mpu", "dat";
>  	interrupts = <97 98>;
> -	interrupts-names = "rx", "tx";
> +	interrupt-names = "rx", "tx";
>  	dmas = <&edma0 3 1
>  		&edma0 2 1>;
>  	dma-names = "tx", "rx";
> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> index 974015193b93cdb3..d724393e904e9a41 100644
> --- a/drivers/dma/bcm2835-dma.c
> +++ b/drivers/dma/bcm2835-dma.c
> @@ -974,7 +974,7 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
>  
>  		/* legacy device tree case handling */
>  		dev_warn_once(&pdev->dev,
> -			      "missing interrupts-names property in device tree - legacy interpretation is used");
> +			      "missing interrupt-names property in device tree - legacy interpretation is used");
>  		/*
>  		 * in case of channel >= 11
>  		 * use the 11th interrupt and that is shared
> -- 
> 1.9.1
> 
