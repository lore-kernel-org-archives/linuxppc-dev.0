Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tVTHd6svkzDw2W
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2016 20:24:13 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alistair Popple <alistair@popple.id.au>
Cc: linuxppc-dev@ozlabs.org, bsingharora@gmail.com,
 Alistair Popple <alistair@popple.id.au>
Subject: Re: [PATCH v2] powerpc/powernv: Initialise nest mmu
In-Reply-To: <1480656588-25504-1-git-send-email-alistair@popple.id.au>
References: <1480656588-25504-1-git-send-email-alistair@popple.id.au>
Date: Fri, 02 Dec 2016 20:24:09 +1100
Message-ID: <871sxqznt2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alistair Popple <alistair@popple.id.au> writes:

> diff --git a/arch/powerpc/platforms/powernv/powernv.h b/arch/powerpc/platforms/powernv/powernv.h
> index da7c843..6fa9551 100644
> --- a/arch/powerpc/platforms/powernv/powernv.h
> +++ b/arch/powerpc/platforms/powernv/powernv.h
> @@ -9,6 +9,12 @@ static inline void pnv_smp_init(void) { }
>  
>  struct pci_dev;
>  
> +#ifdef CONFIG_PPC_POWERNV
> +extern void powernv_set_ptcr(unsigned long ptcr);
> +#else
> +static inline void powernv_set_ptcr(unisigned long ptcr) { }
                                         ^
                                         Your shout next time we're at the pub ;)

cheers
