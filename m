Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id BE55EDDEB7
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 16:54:10 +1000 (EST)
Date: Wed, 9 May 2007 08:42:03 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/2] [POWERPC] Wire up sys_utimensat
Message-ID: <20070509064203.GY18236@moe.telargo.com>
References: <20070509162151.6a54507a.sfr@canb.auug.org.au>
	<20070509162442.11760e79.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070509162442.11760e79.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 09/05/07 16:24 +1000, Stephen Rothwell wrote:
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  include/asm-powerpc/systbl.h |    1 +
>  include/asm-powerpc/unistd.h |    3 ++-
>  2 files changed, 3 insertions(+), 1 deletions(-)
> 
> This depends on the patch to declare {compat_}sys_utimensat
> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> 
> diff --git a/include/asm-powerpc/unistd.h b/include/asm-powerpc/unistd.h
> index 2baedbe..2b11631 100644
> --- a/include/asm-powerpc/unistd.h
> +++ b/include/asm-powerpc/unistd.h
> @@ -326,10 +326,11 @@
>  #define __NR_move_pages		301
>  #define __NR_getcpu		302
>  #define __NR_epoll_pwait	303
> +#define __NR_utimensat		303

					^ 304?


	Domen

>  
>  #ifdef __KERNEL__
>  
> -#define __NR_syscalls		304
> +#define __NR_syscalls		305
>  
>  #define __NR__exit __NR_exit
>  #define NR_syscalls	__NR_syscalls
> -- 
> 1.5.1.3
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
