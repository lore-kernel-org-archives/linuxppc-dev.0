Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 588AB67B93
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 23:41:33 +1000 (EST)
In-Reply-To: <20060927235717.40cbd0e7@pb15>
References: <20060927235717.40cbd0e7@pb15>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <437E571F-79E3-4A2D-ADD1-83953022B053@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] ppc: fix build break
Date: Thu, 28 Sep 2006 08:41:57 -0500
To: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 27, 2006, at 11:57 PM, Olof Johansson wrote:

> Fix build break for some of the ARCH=ppc defconfigs
>
> Signed-off-by: Olof Johansson <olof@lixom.net>

This breakage exists in 2.6.18 as well?  If so would be good to send  
this patch to -stable if its not already there.

- k

>
> ---
>
> This was introduced by:
>
> [PATCH] ppc32: board-specific part of fs_enet update
>
>
> Index: linux-2.6/include/asm-ppc/cpm2.h
> ===================================================================
> --- linux-2.6.orig/include/asm-ppc/cpm2.h
> +++ linux-2.6/include/asm-ppc/cpm2.h
> @@ -1186,7 +1186,7 @@ typedef struct im_idma {
>  #define FCC_MEM_OFFSET(x) (CPM_FCC_SPECIAL_BASE + (x*128))
>  #define FCC1_MEM_OFFSET FCC_MEM_OFFSET(0)
>  #define FCC2_MEM_OFFSET FCC_MEM_OFFSET(1)
> -#define FCC2_MEM_OFFSET FCC_MEM_OFFSET(2)
> +#define FCC3_MEM_OFFSET FCC_MEM_OFFSET(2)
>
>  #endif /* __CPM2__ */
>  #endif /* __KERNEL__ */
