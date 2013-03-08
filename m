Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 683E22C03D1
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Mar 2013 07:38:21 +1100 (EST)
Subject: Re: [PATCH] powerpc/85xx: Add platform_device declaration to fsl_pci.h
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1362386409-15907-1-git-send-email-B38951@freescale.com>
Date: Fri, 8 Mar 2013 14:38:10 -0600
Message-Id: <CC45B9DD-7BB6-4E88-B5A0-F3E7A30608A7@kernel.crashing.org>
References: <1362386409-15907-1-git-send-email-B38951@freescale.com>
To: Jia Hongtao <B38951@freescale.com>
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 4, 2013, at 2:40 AM, Jia Hongtao wrote:

> mpc85xx_pci_err_probe(struct platform_device *op) need platform_device
> declaration for definition. Otherwise, it will cause compile error if any
> files including fsl_pci.h without declaration of platform_device.
> 
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_pci.h |    2 ++
> 1 files changed, 2 insertions(+), 0 deletions(-)
> 

Where does the compile error show up?

- k

> diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
> index c495c00..df66721 100644
> --- a/arch/powerpc/sysdev/fsl_pci.h
> +++ b/arch/powerpc/sysdev/fsl_pci.h
> @@ -14,6 +14,8 @@
> #ifndef __POWERPC_FSL_PCI_H
> #define __POWERPC_FSL_PCI_H
> 
> +#include <linux/platform_device.h>
> +
> #define PCIE_LTSSM	0x0404		/* PCIE Link Training and Status */
> #define PCIE_LTSSM_L0	0x16		/* L0 state */
> #define PCIE_IP_REV_2_2		0x02080202 /* PCIE IP block version Rev2.2 */
> -- 
> 1.7.5.1
> 
