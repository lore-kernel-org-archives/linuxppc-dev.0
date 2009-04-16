Return-Path: <yanok@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6C733DE10A
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 03:42:02 +1000 (EST)
Message-ID: <49E761CB.300@emcraft.com>
Date: Thu, 16 Apr 2009 20:50:19 +0400
From: Ilya Yanok <yanok@emcraft.com>
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH 3/3] powerpc: allow 256kB pages with SHMEM
References: <Pine.LNX.4.64.0904062151250.21044@blonde.anvils>
	<Pine.LNX.4.64.0904062156290.21044@blonde.anvils>
In-Reply-To: <Pine.LNX.4.64.0904062156290.21044@blonde.anvils>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>, prodyuth@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Hugh,

Hugh Dickins wrote:
> Now that shmem's divisions by zero and SHMEM_MAX_BYTES are fixed,
> let powerpc 256kB pages coexist with CONFIG_SHMEM again.
>
> Signed-off-by: Hugh Dickins <hugh@veritas.com>
>   

Acked-by: Ilya Yanok <yanok@emcraft.com>

> ---
> Added linuxppc-dev and some other Cc's for this 3/3: sorry
> if you didn't see 1/3 and 2/3, they were just in mm/shmem.c.
>
>  arch/powerpc/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- 2.6.29-git13/arch/powerpc/Kconfig	2009-04-06 11:47:57.000000000 +0100
> +++ linux/arch/powerpc/Kconfig	2009-04-06 18:18:47.000000000 +0100
> @@ -462,7 +462,7 @@ config PPC_64K_PAGES
>  
>  config PPC_256K_PAGES
>  	bool "256k page size" if 44x
> -	depends on !STDBINUTILS && (!SHMEM || BROKEN)
> +	depends on !STDBINUTILS
>  	help
>  	  Make the page size 256k.
>  
>   

Regards, Ilya.
