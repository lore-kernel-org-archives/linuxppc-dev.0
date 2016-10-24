Return-Path: <shawnguo@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2V5W6lxPzDt1s
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 19:37:19 +1100 (AEDT)
Date: Mon, 24 Oct 2016 16:36:55 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Jia Hongtao <hongtao.jia@nxp.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org,
 scott.wood@nxp.com, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 1/5] powerpc/mpc85xx: Update TMU device tree node for
 T1040/T1042
Message-ID: <20161024083654.GB30578@tiger>
References: <1475995626-14049-1-git-send-email-hongtao.jia@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1475995626-14049-1-git-send-email-hongtao.jia@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Oct 09, 2016 at 02:47:02PM +0800, Jia Hongtao wrote:
> From: Hongtao Jia <hongtao.jia@nxp.com>
> 
> SoC compatible string and endianness property are added according to the
> new bindings.

The commit log doesn't seem to match the actual changes.  Same for patch
2/5.

Shawn

> 
> Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
> ---
> Changes for V2:
> * Rebase on latest linux-next tree (next-20161006).
> 
>  arch/powerpc/boot/dts/fsl/t1040si-post.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
> index 44e399b..145c7f4 100644
> --- a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
> @@ -526,7 +526,7 @@
>  
>  				       0x00030000 0x00000012
>  				       0x00030001 0x0000001d>;
> -		#thermal-sensor-cells = <0>;
> +		#thermal-sensor-cells = <1>;
>  	};
>  
>  	thermal-zones {
> @@ -534,7 +534,7 @@
>  			polling-delay-passive = <1000>;
>  			polling-delay = <5000>;
>  
> -			thermal-sensors = <&tmu>;
> +			thermal-sensors = <&tmu 2>;
>  
>  			trips {
>  				cpu_alert: cpu-alert {
> -- 
> 2.1.0.27.g96db324
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
