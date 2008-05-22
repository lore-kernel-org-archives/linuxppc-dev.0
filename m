Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 9A359DDFFD
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 02:46:46 +1000 (EST)
Message-ID: <48359B96.2020303@mvista.com>
Date: Thu, 22 May 2008 09:13:10 -0700
From: Dave Jiang <djiang@mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] edac: mpc85xx - Fix building as a module
References: <Pine.LNX.4.64.0805212326000.32442@blarg.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0805212326000.32442@blarg.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	bluesmoke-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, dougthompson@xmission.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Acked-by: Dave Jiang <djiang@mvista.com>

Kumar Gala wrote:
> including of <asm/mpc85xx.h> causes build problems since it doesn't exist.
> 
> Also removed warning:
> drivers/edac/mpc85xx_edac.c:45: warning: 'mpc85xx_ctl_name' defined but not used
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> 
> This is a fix for 2.6.26.
> 
> - k
> 
>  drivers/edac/mpc85xx_edac.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
> index 065732d..d49361b 100644
> --- a/drivers/edac/mpc85xx_edac.c
> +++ b/drivers/edac/mpc85xx_edac.c
> @@ -20,7 +20,6 @@
> 
>  #include <linux/of_platform.h>
>  #include <linux/of_device.h>
> -#include <asm/mpc85xx.h>
>  #include "edac_module.h"
>  #include "edac_core.h"
>  #include "mpc85xx_edac.h"
> @@ -43,8 +42,6 @@ static u32 orig_pci_err_en;
>  static u32 orig_l2_err_disable;
>  static u32 orig_hid1;
> 
> -static const char *mpc85xx_ctl_name = "MPC85xx";
> -
>  /************************ MC SYSFS parts ***********************************/
> 
>  static ssize_t mpc85xx_mc_inject_data_hi_show(struct mem_ctl_info *mci,


-- 

------------------------------------------------------
Dave Jiang
Software Engineer
MontaVista Software, Inc.
http://www.mvista.com
------------------------------------------------------
