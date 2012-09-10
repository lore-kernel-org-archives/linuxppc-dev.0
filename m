Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 583B82C0096
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 14:42:32 +1000 (EST)
Message-ID: <1347251137.2385.145.camel@pasglop>
Subject: Re: [PATCH 6/6] powerpc: Implement PPR save/restore
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Haren Myneni <haren@linux.vnet.ibm.com>
In-Reply-To: <1347191067.3418.21.camel@hbabu-laptop>
References: <1347191067.3418.21.camel@hbabu-laptop>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 10 Sep 2012 14:25:37 +1000
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, paulus@samba.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 8d21cc4..034dbb7 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -33,6 +33,7 @@
>  #include <asm/irqflags.h>
>  #include <asm/ftrace.h>
>  #include <asm/hw_irq.h>
> +#include <asm/exception-64s.h>

entry_64.S is shared with BookE which uses a different header,
so that won't do.

Cheers,
Ben.

 
