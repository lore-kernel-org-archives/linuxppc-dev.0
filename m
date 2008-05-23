Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 415D3DE506
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 22:20:34 +1000 (EST)
Subject: Re: [PATCH 05/12] macintosh: use linux/of_{device,platform}.h
	instead of asm
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080523162702.26bf3937.sfr@canb.auug.org.au>
References: <20080523161627.a75d5010.sfr@canb.auug.org.au>
	<20080523162702.26bf3937.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Fri, 23 May 2008 08:20:21 -0400
Message-Id: <1211545221.8297.297.camel@pasglop>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-05-23 at 16:27 +1000, Stephen Rothwell wrote:
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


> ---
>  drivers/macintosh/smu.c              |    4 ++--
>  drivers/macintosh/therm_adt746x.c    |    2 +-
>  drivers/macintosh/therm_pm72.c       |    4 ++--
>  drivers/macintosh/therm_windtunnel.c |    2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
> index 45c3a88..0372eba 100644
> --- a/drivers/macintosh/smu.c
> +++ b/drivers/macintosh/smu.c
> @@ -36,6 +36,8 @@
>  #include <linux/poll.h>
>  #include <linux/mutex.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
>  
>  #include <asm/byteorder.h>
>  #include <asm/io.h>
> @@ -46,8 +48,6 @@
>  #include <asm/sections.h>
>  #include <asm/abs_addr.h>
>  #include <asm/uaccess.h>
> -#include <asm/of_device.h>
> -#include <asm/of_platform.h>
>  
>  #define VERSION "0.7"
>  #define AUTHOR  "(c) 2005 Benjamin Herrenschmidt, IBM Corp."
> diff --git a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
> index 54f4942..7f0e20e 100644
> --- a/drivers/macintosh/therm_adt746x.c
> +++ b/drivers/macintosh/therm_adt746x.c
> @@ -24,13 +24,13 @@
>  #include <linux/kthread.h>
>  #include <linux/moduleparam.h>
>  #include <linux/freezer.h>
> +#include <linux/of_platform.h>
>  
>  #include <asm/prom.h>
>  #include <asm/machdep.h>
>  #include <asm/io.h>
>  #include <asm/system.h>
>  #include <asm/sections.h>
> -#include <asm/of_platform.h>
>  
>  #undef DEBUG
>  
> diff --git a/drivers/macintosh/therm_pm72.c b/drivers/macintosh/therm_pm72.c
> index ddfb426..817607e 100644
> --- a/drivers/macintosh/therm_pm72.c
> +++ b/drivers/macintosh/therm_pm72.c
> @@ -123,14 +123,14 @@
>  #include <linux/i2c.h>
>  #include <linux/kthread.h>
>  #include <linux/mutex.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
>  #include <asm/prom.h>
>  #include <asm/machdep.h>
>  #include <asm/io.h>
>  #include <asm/system.h>
>  #include <asm/sections.h>
> -#include <asm/of_device.h>
>  #include <asm/macio.h>
> -#include <asm/of_platform.h>
>  
>  #include "therm_pm72.h"
>  
> diff --git a/drivers/macintosh/therm_windtunnel.c b/drivers/macintosh/therm_windtunnel.c
> index d11821a..6d9e7ac 100644
> --- a/drivers/macintosh/therm_windtunnel.c
> +++ b/drivers/macintosh/therm_windtunnel.c
> @@ -37,13 +37,13 @@
>  #include <linux/slab.h>
>  #include <linux/init.h>
>  #include <linux/kthread.h>
> +#include <linux/of_platform.h>
>  
>  #include <asm/prom.h>
>  #include <asm/machdep.h>
>  #include <asm/io.h>
>  #include <asm/system.h>
>  #include <asm/sections.h>
> -#include <asm/of_platform.h>
>  #include <asm/macio.h>
>  
>  #define LOG_TEMP		0			/* continously log temperature */
> -- 
> 1.5.5.1
> 
