Return-Path: <michal.simek@xilinx.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0069.outbound.protection.outlook.com [207.46.100.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 16EA51A024B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 00:13:42 +1000 (AEST)
Date: Mon, 4 May 2015 16:13:23 +0200
From: Michal Simek <michal.simek@xilinx.com>
MIME-Version: 1.0
To: Suman Tripathi <stripathi@apm.com>, <chris@printf.net>,
 <anton@enomsg.org>, <arnd@arndb.de>, <michal.simek@xilinx.com>
Subject: Re: [PATCH v4 3/3] Documentation: mmc: Update Arasan SDHC
 documentation to support 4.9a version of Arasan SDHC controller.
References: <1430746792-32574-1-git-send-email-stripathi@apm.com>
 <1430746792-32574-4-git-send-email-stripathi@apm.com>
In-Reply-To: <1430746792-32574-4-git-send-email-stripathi@apm.com>
Content-Type: text/plain; charset="windows-1252"
Message-ID: <eb09e430-53dd-47ac-8395-6b5becf62517@BN1AFFO11FD044.protection.gbl>
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

On 05/04/2015 03:39 PM, Suman Tripathi wrote:
> This patch updates Arasan SDHC documentation to support
> 4.9a version of Arasan SDHC controller.
> 
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 98ee2ab..6dd3d60 100644
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
> --
> 1.8.2.1
> 

Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
