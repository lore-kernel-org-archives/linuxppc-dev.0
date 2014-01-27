Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0211.outbound.protection.outlook.com [207.46.163.211])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9E9BF2C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 10:04:36 +1100 (EST)
Message-ID: <1390863856.24905.750.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/2][v6] driver/memory:Move Freescale IFC driver to a
 common driver
From: Scott Wood <scottwood@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Date: Mon, 27 Jan 2014 17:04:16 -0600
In-Reply-To: <1390651572-24468-1-git-send-email-prabhakar@freescale.com>
References: <1390651572-24468-1-git-send-email-prabhakar@freescale.com>
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

On Sat, 2014-01-25 at 17:36 +0530, Prabhakar Kushwaha wrote:
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index 29a11db..555d26f 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -50,4 +50,13 @@ config TEGRA30_MC
>  	  analysis, especially for IOMMU/SMMU(System Memory Management
>  	  Unit) module.
>  
> +config FSL_IFC
> +	bool "Freescale Integrated Flash Controller"
> +	default y

Don't use "default y".

-Scott
