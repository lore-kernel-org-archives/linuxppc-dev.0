Return-Path: <peda@axentia.se>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0136.outbound.protection.outlook.com [104.47.2.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zcXzF5M0FzF10D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Feb 2018 20:32:23 +1100 (AEDT)
Subject: Re: [PATCH] powerpc/fsl/dts: fix the i2c-mux compatible for t104xqds
To: linux-kernel@vger.kernel.org, Scott Wood <oss@buserror.net>,
 Kumar Gala <galak@kernel.crashing.org>,
 Prabhakar Kushwaha <prabhakar@freescale.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20170803125934.14960-1-peda@axentia.se>
From: Peter Rosin <peda@axentia.se>
Message-ID: <da15288b-f656-8126-7bc9-eb2fd58adccb@axentia.se>
Date: Thu, 8 Feb 2018 10:32:12 +0100
MIME-Version: 1.0
In-Reply-To: <20170803125934.14960-1-peda@axentia.se>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Adding some people whom seem relevant but did not get fingered by
get_maintainer.pl]

On 2017-08-03 14:59, Peter Rosin wrote:
> The sanctioned compatible is "nxp,pca9547".
Ping.

Cheers,
Peter

> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  arch/powerpc/boot/dts/fsl/t104xqds.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/boot/dts/fsl/t104xqds.dtsi b/arch/powerpc/boot/dts/fsl/t104xqds.dtsi
> index 2fd4cbe7098f..615479732252 100644
> --- a/arch/powerpc/boot/dts/fsl/t104xqds.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/t104xqds.dtsi
> @@ -269,7 +269,7 @@
>  
>  		i2c@118000 {
>  			pca9547@77 {
> -				compatible = "philips,pca9547";
> +				compatible = "nxp,pca9547";
>  				reg = <0x77>;
>  			};
>  			rtc@68 {
> 
