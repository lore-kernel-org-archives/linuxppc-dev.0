Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0123.outbound.protection.outlook.com [207.46.100.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5A2AC1A04E2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2015 08:32:09 +1100 (AEDT)
Message-ID: <1421098314.4961.109.camel@freescale.com>
Subject: Re: [PATCH] powerpc/fsl: Add empty ranges to etsec2 dts files
From: Scott Wood <scottwood@freescale.com>
To: Martin Hicks <mort@bork.org>
Date: Mon, 12 Jan 2015 15:31:54 -0600
In-Reply-To: <20150112152749.GA5450@darwin.bork.org>
References: <20150112152749.GA5450@darwin.bork.org>
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

On Mon, 2015-01-12 at 10:27 -0500, Martin Hicks wrote:
> 
> With an earlier change (746c9e9f - Fix PowerPC address parsing hack), ethernet
> has broken on Freescale boards such as the P1022.  All ranges used by the
> ethernet controllers are also covered by sub-devices that properly
> declared the used ranges.  The error shown is:
> 
> fsl-gianfar: probe of soc@ffe00000:ethernet@b0000 failed with error -12
> 
> Signed-off-by: Martin Hicks <mort@bork.org>
> ---
>  arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi |    1 +
>  arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi |    1 +
>  arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi |    1 +
>  3 files changed, 3 insertions(+)

http://patchwork.ozlabs.org/patch/422446/

> diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi
> index 1382fec..d1a6c48 100644
> --- a/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi
> @@ -43,6 +43,7 @@ mdio@24000 {
>  ethernet@b0000 {
>  	#address-cells = <1>;
>  	#size-cells = <1>;
> +	ranges = <>;

The " = <>" is usually omitted for empty properties.

-Scott
