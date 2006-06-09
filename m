Return-Path: <khali@linux-fr.org>
Received: from kellthuzad.dmz.nerim.net (smtp-dmz-235-friday.dmz.nerim.net
	[195.5.254.235]) by ozlabs.org (Postfix) with ESMTP id 3966E67C56
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jun 2006 18:10:20 +1000 (EST)
Received: from mallaury.nerim.net (smtp-105-friday.noc.nerim.net [62.4.17.105])
	by kellthuzad.dmz.nerim.net (Postfix) with ESMTP id D197639EE9
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jun 2006 09:37:31 +0200 (CEST)
Date: Fri, 9 Jun 2006 09:37:37 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH 10/10 v2] Document I2C_MPC option for 86xx too.
Message-Id: <20060609093737.f66d5a41.khali@linux-fr.org>
In-Reply-To: <1149804296.23938.298.camel@cashmere.sps.mot.com>
References: <1149804296.23938.298.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jon,

Please add a paragraph explaining what the patch does. It will be used
as the git commit message.

> Signed-off-by: Jon Loeliger <jdl@freescale.com>
> 
> ---
>  drivers/i2c/busses/Kconfig |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index d6d4494..fbeae82 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -252,12 +252,12 @@ config I2C_POWERMAC
>  	  will be called i2c-powermac.
>  
>  config I2C_MPC
> -	tristate "MPC107/824x/85xx/52xx"
> +	tristate "MPC107/824x/85xx/52xx/86xx"

Maybe leave 52xx at the end, as it seems to be special?

>  	depends on I2C && PPC32
>  	help
>  	  If you say yes to this option, support will be included for the
>  	  built-in I2C interface on the MPC107/Tsi107/MPC8240/MPC8245 and
> -	  MPC85xx family processors. The driver may also work on 52xx
> +	  MPC85xx/MPC8641 family processors. The driver may also work on 52xx
>  	  family processors, though interrupts are known not to work.
>  
>  	  This driver can also be built as a module.  If so, the module
> 

This isn't very consistent, you first say 86xx as if several chips were
supported, then only list the MPC8641. Also, "MPC85xx family" made
sense but "MPC8641 family" doesn't.

When fixed, do you expect me to take that patch, or will it be merged
through the powerpc git tree?

-- 
Jean Delvare
