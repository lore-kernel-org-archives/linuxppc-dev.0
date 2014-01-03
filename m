Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0238.outbound.protection.outlook.com [207.46.163.238])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1F1702C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Jan 2014 09:55:22 +1100 (EST)
Message-ID: <1388789710.11795.78.camel@snotra.buserror.net>
Subject: Re: [PATCH 3/4] powerpc/fsl-booke: Add support for T2080/T2081 SoC
From: Scott Wood <scottwood@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Date: Fri, 3 Jan 2014 16:55:10 -0600
In-Reply-To: <1387966018-10131-3-git-send-email-Shengzhou.Liu@freescale.com>
References: <1387966018-10131-1-git-send-email-Shengzhou.Liu@freescale.com>
 <1387966018-10131-3-git-send-email-Shengzhou.Liu@freescale.com>
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

On Wed, 2013-12-25 at 18:06 +0800, Shengzhou Liu wrote:
> +/* controller at 0x270000 */
> +&pci3 {
> +	compatible = "fsl,t208x-pcie", "fsl,qoriq-pcie";

Don't use wildcards in compatible strings.

> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/*
> +		 * Temporarily add next-level-cache info in each cpu node so
> +		 * that uboot can do L2 cache fixup. This can be removed once
> +		 * u-boot can create cpu node with cache info.
> +		 */

This sort of thing is why these dts files belong in U-Boot and not the
Linux tree.

-Scott
