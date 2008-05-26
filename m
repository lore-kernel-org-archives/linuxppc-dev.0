Return-Path: <stelian@popies.net>
Received: from sd-11162.dedibox.fr (sd-11162.dedibox.fr [88.191.70.230])
	by ozlabs.org (Postfix) with ESMTP id CDE1CDDFD2
	for <linuxppc-dev@ozlabs.org>; Mon, 26 May 2008 20:02:06 +1000 (EST)
Subject: Re: [PATCH 04/12] hwmon: use linux/of_platform.h instead of asm
From: Stelian Pop <stelian@popies.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080523162550.21eb90f2.sfr@canb.auug.org.au>
References: <20080523161627.a75d5010.sfr@canb.auug.org.au>
	<20080523162550.21eb90f2.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8
Date: Mon, 26 May 2008 11:42:20 +0200
Message-Id: <1211794940.6019.19.camel@galileo>
Mime-Version: 1.0
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>,
	ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Le vendredi 23 mai 2008 à 16:25 +1000, Stephen Rothwell a écrit :
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Stelian Pop <stelian@popies.net>

Thanks,

Stelian.

> ---
>  drivers/hwmon/ams/ams-core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/ams/ams-core.c b/drivers/hwmon/ams/ams-core.c
> index a112a03..fbefa82 100644
> --- a/drivers/hwmon/ams/ams-core.c
> +++ b/drivers/hwmon/ams/ams-core.c
> @@ -23,8 +23,8 @@
>  #include <linux/types.h>
>  #include <linux/errno.h>
>  #include <linux/init.h>
> +#include <linux/of_platform.h>
>  #include <asm/pmac_pfunc.h>
> -#include <asm/of_platform.h>
>  
>  #include "ams.h"
>  
> -- 
> 1.5.5.1
> 
-- 
Stelian Pop <stelian@popies.net>
