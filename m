Return-Path: <mark.rutland@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qrwxq3tPTzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 23:11:59 +1000 (AEST)
Date: Fri, 22 Apr 2016 14:11:51 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-i2c@vger.kernel.org, iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org, ulf.hansson@linaro.org, scott.wood@nxp.com,
 Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>,
 Jochen Friedrich <jochen@scram.de>, Joerg Roedel <joro@8bytes.org>,
 Claudiu Manoil <claudiu.manoil@freescale.com>,
 Bhupesh Sharma <bhupesh.sharma@freescale.com>,
 Zhao Qiang <qiang.zhao@freescale.com>, Kumar Gala <galak@codeaurora.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, leoyang.li@nxp.com,
 xiaobo.xie@nxp.com
Subject: Re: [v8, 1/7] Documentation: DT: update Freescale DCFG compatible
Message-ID: <20160422131151.GJ10606@leverpostej>
References: <1461306464-19521-1-git-send-email-yangbo.lu@nxp.com>
 <1461306464-19521-2-git-send-email-yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461306464-19521-2-git-send-email-yangbo.lu@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 22, 2016 at 02:27:38PM +0800, Yangbo Lu wrote:
> Update Freescale DCFG compatible with 'fsl,<chip>-dcfg' instead
> of 'fsl,ls1021a-dcfg' to include more chips.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
> Changes for v8:
> 	- Added this patch
> ---
>  Documentation/devicetree/bindings/arm/fsl.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
> index 752a685..1d5f512 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.txt
> +++ b/Documentation/devicetree/bindings/arm/fsl.txt
> @@ -119,7 +119,7 @@ Freescale DCFG
>  configuration and status for the device. Such as setting the secondary
>  core start address and release the secondary core from holdoff and startup.
>    Required properties:
> -  - compatible: should be "fsl,ls1021a-dcfg"
> +  - compatible: should be "fsl,<chip>-dcfg"

Please list specific values expected for <chip>, while jusy saying
<chip> may be more generic, it makes it practically impossible to search
for the correct binding given a compatible string, and it's vague as to
exaclty what <chip> should be.

Thanks,
Mark.



>    - reg : should contain base address and length of DCFG memory-mapped registers
>  
>  Example:
> -- 
> 2.1.0.27.g96db324
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
