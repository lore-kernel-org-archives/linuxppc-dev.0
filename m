Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8D117DDE0E
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Dec 2007 03:54:34 +1100 (EST)
Message-Id: <4CD1A887-18CE-44F2-A3AA-A2DA2400F857@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jochen Friedrich <jochen@scram.de>
In-Reply-To: <476D61DB.2090201@scram.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH/RFC] powerpc: DBox2 Board Support
Date: Mon, 24 Dec 2007 10:53:55 -0600
References: <476D61DB.2090201@scram.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>
> diff --git a/include/asm-powerpc/mpc8xx.h b/include/asm-powerpc/ 
> mpc8xx.h
> index 2be014b..b6fd7d6 100644
> --- a/include/asm-powerpc/mpc8xx.h
> +++ b/include/asm-powerpc/mpc8xx.h
> @@ -23,6 +23,10 @@
> #include <platforms/8xx/mpc885ads.h>
> #endif
>
> +#if defined(CONFIG_DBOX2)
> +#include <platforms/8xx/dbox2.h>
> +#endif
> +
> #ifdef CONFIG_PCMCIA_M8XX
> extern struct mpc8xx_pcmcia_ops m8xx_pcmcia_ops;
> #endif

is this really needed?  if so why.  we should work towards not having  
to do this going forward.

(I cant believe its needed since dbox2.h doesn't seem to have anything  
defined we'd need anywhere else).

- k
