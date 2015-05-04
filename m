Return-Path: <michal.simek@xilinx.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0077.outbound.protection.outlook.com [157.56.110.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 31C1D1A02EB
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2015 16:16:30 +1000 (AEST)
Date: Mon, 4 May 2015 08:00:19 +0200
From: Michal Simek <michal.simek@xilinx.com>
MIME-Version: 1.0
To: Suman Tripathi <stripathi@apm.com>, <chris@printf.net>,
 <anton@enomsg.org>, <arnd@arndb.de>, <michal.simek@xilinx.com>
Subject: Re: [PATCH v3 3/3] Documentation: mmc: Update Arasan SDHC
 documentation to support 4.9a version of Arasan SDHC controller.
References: <1430456052-8888-1-git-send-email-stripathi@apm.com>
 <1430456052-8888-4-git-send-email-stripathi@apm.com>
In-Reply-To: <1430456052-8888-4-git-send-email-stripathi@apm.com>
Content-Type: text/plain; charset="windows-1252"
Message-ID: <f442e594-ac5c-4e77-ab80-3055fb791066@BN1AFFO11FD021.protection.gbl>
Cc: devicetree@vger.kernel.org, mlangsdo@redhat.com, jcm@redhat.com,
 linux-mmc@vger.kernel.org, patches@apm.com, ddutile@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/01/2015 06:54 AM, Suman Tripathi wrote:
> This patch updates Arasan SDHC documentation to support
> 4.9a version of Arasan SDHC controller.
> 
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 98ee2ab..f01d41a 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -8,7 +8,8 @@ Device Tree Bindings for the Arasan SDHCI Controller
>    [3] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>  
>  Required Properties:
> -  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a'
> +  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' or
> +                'arasan,sdhci-4.9a'           
>    - reg: From mmc bindings: Register location and length.
>    - clocks: From clock bindings: Handles to clock inputs.
>    - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
> @@ -18,7 +19,7 @@ Required Properties:
>  
>  Example:
>  	sdhci@e0100000 {
> -		compatible = "arasan,sdhci-8.9a";
> +		compatible = "arasan,sdhci-8.9a", "arasan,sdhci-4.9a";

Is there any reason to change this example?
You probably want to have just one compatible string not both.

Thanks,
Michal
