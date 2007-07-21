Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AEEBDDDE3E
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jul 2007 08:11:35 +1000 (EST)
Subject: Re: [PATCH][09/37] Clean up duplicate includes in drivers/macintosh/
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
In-Reply-To: <200707211702.30610.jesper.juhl@gmail.com>
References: <200707211702.30610.jesper.juhl@gmail.com>
Content-Type: text/plain
Date: Sun, 22 Jul 2007 08:11:14 +1000
Message-Id: <1185055874.5439.49.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-07-21 at 17:02 +0200, Jesper Juhl wrote:
> Hi,
> 
> This patch cleans up duplicate includes in
> 	drivers/macintosh/
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> 
> diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
> index 4177ff0..2c21d4f 100644
> --- a/drivers/macintosh/rack-meter.c
> +++ b/drivers/macintosh/rack-meter.c
> @@ -30,7 +30,6 @@
>  #include <asm/machdep.h>
>  #include <asm/pmac_feature.h>
>  #include <asm/dbdma.h>
> -#include <asm/dbdma.h>
>  #include <asm/macio.h>
>  #include <asm/keylargo.h>
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
