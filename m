Return-Path: <Laurentiu.Tudor@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0238.outbound.protection.outlook.com [207.46.163.238])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 20EC21A0839
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jun 2014 19:59:31 +1000 (EST)
Message-ID: <538D9C79.20903@freescale.com>
Date: Tue, 3 Jun 2014 12:59:21 +0300
From: Tudor Laurentiu <b10716@freescale.com>
MIME-Version: 1.0
To: Chunhe Lan <Chunhe.Lan@freescale.com>
Subject: Re: [PATCH v2] powerpc/85xx: Add T4240RDB board support
References: <1401786611-30378-1-git-send-email-Chunhe.Lan@freescale.com>
In-Reply-To: <1401786611-30378-1-git-send-email-Chunhe.Lan@freescale.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Chunhe

Comment inline ...

On 06/03/2014 12:10 PM, Chunhe Lan wrote:
> T4240RDB board Specification
> ----------------------------
> Memory subsystem:
>       6GB DDR3
>       128MB NOR flash
>       2GB NAND flash
> Ethernet:
>       Eight 1G SGMII ports
>       Four 10Gbps SFP+ ports
> PCIe:
>       Two PCIe slots
> USB:
>       Two USB2.0 Type A ports
> SDHC:
>       One SD-card port
> SATA:
>       One SATA port
> UART:
>       Dual RJ45 ports
>
> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> Cc: Scott Wood <scottwood@freescale.com>
> ---

[snip]

>
> diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
> index 8e4b1e1..2f50526 100644
> --- a/arch/powerpc/platforms/85xx/corenet_generic.c
> +++ b/arch/powerpc/platforms/85xx/corenet_generic.c
> @@ -119,6 +119,7 @@ static const char * const boards[] __initconst = {
>   	"fsl,P5020DS",
>   	"fsl,P5040DS",
>   	"fsl,T4240QDS",
> +	"fsl,T4240RDB",

T4240RDB is supported & tested under hypervisor so please also add the 
hypervisor compatible in the "hv_boards" array below.

---
Thanks & Best Regards, Laurentiu
