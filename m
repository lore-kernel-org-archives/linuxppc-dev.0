Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CC45F68A8E
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Feb 2006 15:04:50 +1100 (EST)
In-Reply-To: <Pine.LNX.4.61.0602072127510.3872@cde-tx32-ldt329.sps.mot.com>
References: <Pine.LNX.4.61.0602072127510.3872@cde-tx32-ldt329.sps.mot.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D0C7D30F-B6CE-43EC-84BC-36A584B168BF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: lindent 85xx platform code
Date: Tue, 7 Feb 2006 22:04:45 -0600
To: Becky Bruce <bgill@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>  /*
>   * Internal interrupts are all Level Sensitive, and Positive Polarity
>   *
> @@ -47,28 +46,27 @@ unsigned long isa_mem_base = 0;
>   */
>  static u_char mpc85xx_ads_openpic_initsenses[] __initdata = {
>  	MPC85XX_INTERNAL_IRQ_SENSES,
> -	0x0,						/* External  0: */
> +	0x0,			/* External  0: */
>  #if defined(CONFIG_PCI)
>  	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext 1: PCI slot 0 */
>  	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext 2: PCI slot 1 */
>  	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext 3: PCI slot 2 */
>  	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext 4: PCI slot 3 */
>  #else
> -	0x0,				/* External  1: */
> -	0x0,				/* External  2: */
> -	0x0,				/* External  3: */
> -	0x0,				/* External  4: */
> +	0x0,			/* External  1: */
> +	0x0,			/* External  2: */
> +	0x0,			/* External  3: */
> +	0x0,			/* External  4: */
>  #endif
>  	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 5: PHY */
> -	0x0,				/* External  6: */
> +	0x0,			/* External  6: */
>  	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 7: PHY */
> -	0x0,				/* External  8: */
> -	0x0,				/* External  9: */
> -	0x0,				/* External 10: */
> -	0x0,				/* External 11: */
> +	0x0,			/* External  8: */
> +	0x0,			/* External  9: */
> +	0x0,			/* External 10: */
> +	0x0,			/* External 11: */
>  };

Can you fix the tabs so the comments line up again.  Lindent does  
this I dont really care for it.

- k
