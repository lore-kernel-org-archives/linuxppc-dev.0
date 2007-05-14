Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B35D2DDEC4
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 13:56:03 +1000 (EST)
In-Reply-To: <20070514135033.07c1b840.sfr@canb.auug.org.au>
References: <20070514135033.07c1b840.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1AF532FF-A994-47AF-9394-5DFFC6C8FDA1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Wire up some more syscalls
Date: Sun, 13 May 2007 22:55:01 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>, paulus@samba.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 13, 2007, at 10:50 PM, Stephen Rothwell wrote:

> signalfd, timerfd and eventfd
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  include/asm-powerpc/systbl.h |    3 +++
>  include/asm-powerpc/unistd.h |    5 ++++-
>  2 files changed, 7 insertions(+), 1 deletions(-)
>
> This depends on the patch I just sent to declare  
> compat_sys_signalfd and
> compat_sys_timerfd.  And I am assuming that the SPU's want these.
>
> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
>
> diff --git a/include/asm-powerpc/systbl.h b/include/asm-powerpc/ 
> systbl.h
> index 3d44446..700ca59 100644
> --- a/include/asm-powerpc/systbl.h
> +++ b/include/asm-powerpc/systbl.h
> @@ -308,3 +308,6 @@ COMPAT_SYS_SPU(move_pages)
>  SYSCALL_SPU(getcpu)
>  COMPAT_SYS(epoll_pwait)
>  COMPAT_SYS_SPU(utimensat)
> +COMPAT_SYS_SPU(signalfd)
> +COMPAT_SYS_SPU(timerfd)
> +SYSCALL_SPU(eventfd)

Just out of interest, what makes a syscall COMPAT_SYS_SPU vs  
SYSCALL_SPU?

- k
