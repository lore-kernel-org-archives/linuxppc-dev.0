Return-Path: <shawn.guo@linaro.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F0D491400A6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Apr 2014 17:58:59 +1000 (EST)
Date: Wed, 9 Apr 2014 15:58:15 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH v3 2/2] ARM: dts: Append clock bindings for sai2 on VF610
 platform
Message-ID: <20140409075812.GC28420@dragon>
References: <cover.1396605772.git.Guangyu.Chen@freescale.com>
 <08ba57a2fdce1a404a6bcb61e21e25509fcd6b30.1396605772.git.Guangyu.Chen@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <08ba57a2fdce1a404a6bcb61e21e25509fcd6b30.1396605772.git.Guangyu.Chen@freescale.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org,
 broonie@kernel.org, ijc+devicetree@hellion.org.uk,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, timur@tabi.org,
 Li.Xiubo@freescale.com, rob@landley.net, galak@codeaurora.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 04, 2014 at 06:08:13PM +0800, Nicolin Chen wrote:
> Since we added fours clock to the DT binding, we should update the current
> SAI dts/dtsi so as not to break their functions.

If so, shouldn't the change be in the same patch as driver change?

Shawn

> 
> Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
> Tested-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
>  arch/arm/boot/dts/vf610.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
> index d31ce1b..9fd0007 100644
> --- a/arch/arm/boot/dts/vf610.dtsi
> +++ b/arch/arm/boot/dts/vf610.dtsi
> @@ -139,8 +139,10 @@
>  				compatible = "fsl,vf610-sai";
>  				reg = <0x40031000 0x1000>;
>  				interrupts = <0 86 0x04>;
> -				clocks = <&clks VF610_CLK_SAI2>;
> -				clock-names = "sai";
> +				clocks = <&clks VF610_CLK_SAI2>,
> +				       <&clks VF610_CLK_SAI2>,
> +				       <&clks 0>, <&clks 0>;
> +				clock-names = "bus", "mclk1", "mclk2", "mclk3";
>  				status = "disabled";
>  			};
>  
> -- 
> 1.8.4
> 
> 
