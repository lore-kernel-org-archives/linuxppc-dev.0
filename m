Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id AA3E6DDDEC
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 09:26:44 +1100 (EST)
Date: Mon, 12 Mar 2007 15:26:52 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 01/19] bootwrapper: Add stddef.h to ops.h
Message-ID: <20070312222652.GA31268@mag.az.mvista.com>
References: <20070312204138.GA28545@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070312204138.GA28545@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 12, 2007 at 02:41:38PM -0600, Scott Wood wrote:
> ops.h references NULL, so include stddef.h, so files including ops.h
> don't have to.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Acked-by: Mark A. Greer <mgreer@mvista.com>

> ---
>  arch/powerpc/boot/ops.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
> index cad4eee..2b569ad 100644
> --- a/arch/powerpc/boot/ops.h
> +++ b/arch/powerpc/boot/ops.h
> @@ -11,6 +11,7 @@
>  #ifndef _PPC_BOOT_OPS_H_
>  #define _PPC_BOOT_OPS_H_
>  
> +#include <stddef.h>
>  #include "types.h"
>  
>  #define	COMMAND_LINE_SIZE	512
> -- 
> 1.5.0.3
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
