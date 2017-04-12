Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2l803fvpzDqCC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 10:25:52 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id o123so2194149pga.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 17:25:52 -0700 (PDT)
Message-ID: <1491956745.8380.10.camel@gmail.com>
Subject: Re: [PATCH 6/9] powerpc, mm: Enable ZONE_DEVICE on powerpc
From: Balbir Singh <bsingharora@gmail.com>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: arbab@linux.vnet.ibm.com, linux-nvdimm@lists.01.org
Date: Wed, 12 Apr 2017 10:25:45 +1000
In-Reply-To: <20170411174233.21902-7-oohall@gmail.com>
References: <20170411174233.21902-1-oohall@gmail.com>
 <20170411174233.21902-7-oohall@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-12 at 03:42 +1000, Oliver O'Halloran wrote:
> Flip the switch. Running around and screaming "IT'S ALIVE" is optional,
> but recommended.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
>  mm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 43d000e44424..d696af58f97f 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -724,7 +724,7 @@ config ZONE_DEVICE
>  	depends on MEMORY_HOTPLUG
>  	depends on MEMORY_HOTREMOVE
>  	depends on SPARSEMEM_VMEMMAP
> -	depends on X86_64 #arch_add_memory() comprehends device memory
> +	depends on (X86_64 || PPC_BOOK3S_64)  #arch_add_memory() comprehends device memory

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
