Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yFmnf08sXzDrFt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 16:18:46 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v4 2/5] powerpc/mce: align the print of physical address
 better
In-Reply-To: <20170929042655.14570-3-bsingharora@gmail.com>
References: <20170929042655.14570-1-bsingharora@gmail.com>
 <20170929042655.14570-3-bsingharora@gmail.com>
Date: Mon, 16 Oct 2017 16:18:45 +1100
Message-ID: <87po9nllfu.fsf@concordia.ellerman.id.au>
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

Balbir Singh <bsingharora@gmail.com> writes:

> Use the same alignment as Effective address
> and rename phyiscal address to Page Frame Number

You didn't do the 2nd part AFAICS?

Will fix it up.

cheers

> diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
> index e254399..fef1408 100644
> --- a/arch/powerpc/kernel/mce.c
> +++ b/arch/powerpc/kernel/mce.c
> @@ -340,7 +340,7 @@ void machine_check_print_event_info(struct machine_check_event *evt,
>  			printk("%s    Effective address: %016llx\n",
>  			       level, evt->u.ue_error.effective_address);
>  		if (evt->u.ue_error.physical_address_provided)
> -			printk("%s      Physical address: %016llx\n",
> +			printk("%s    Physical address:  %016llx\n",
>  			       level, evt->u.ue_error.physical_address);
>  		break;
>  	case MCE_ERROR_TYPE_SLB:
> -- 
> 2.9.5
