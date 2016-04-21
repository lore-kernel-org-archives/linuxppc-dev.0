Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrZDR5H6FzDqhB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 09:08:23 +1000 (AEST)
Message-ID: <1461280096.32510.213.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org
Cc: ulf.hansson@linaro.org, Rob Herring <robh+dt@kernel.org>,
 scott.wood@nxp.com
Date: Thu, 21 Apr 2016 18:08:16 -0500
In-Reply-To: <1461147644-18041-1-git-send-email-yangbo.lu@nxp.com>
References: <1461147644-18041-1-git-send-email-yangbo.lu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH 1/2] powerpc/85xx: adapt QorIQ eSDHC to the new clocking
 model
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-04-20 at 18:20 +0800, Yangbo Lu wrote:
> Provide clocks property instead of clock-frequency for QorIQ eSDHC
> dts node to adapt to the new clocking model, so that the driver
> could get clock value by the common clk API and the u-boot could
> remove the clock fixup.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
>  arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi
> b/arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi
> index 20835ae..ddbe562 100644
> --- a/arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi
> @@ -36,5 +36,5 @@ sdhc: sdhc@114000 {
>  	compatible = "fsl,esdhc";
>  	reg = <0x114000 0x1000>;
>  	interrupts = <48 2 0 0>;
> -	clock-frequency = <0>;
> +	clocks = <&clockgen 4 1>;
>  };

Binding update?

-Scott
