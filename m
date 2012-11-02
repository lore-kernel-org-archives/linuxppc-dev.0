Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 70F602C034A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Nov 2012 14:24:24 +1100 (EST)
Message-ID: <1351826636.12271.246.camel@pasglop>
Subject: Re: [PATCH] powerpc: add finit_module syscall.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Date: Fri, 02 Nov 2012 14:23:56 +1100
In-Reply-To: <1351731507-9758-1-git-send-email-rusty@rustcorp.com.au>
References: <1351731507-9758-1-git-send-email-rusty@rustcorp.com.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-11-01 at 11:28 +1030, Rusty Russell wrote:
> (This is just for Acks: this won't work without the actual syscall patches,
>  sitting in my tree for -next at the moment).
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

>  arch/powerpc/include/asm/systbl.h      |    1 +
>  arch/powerpc/include/asm/unistd.h      |    2 +-
>  arch/powerpc/include/uapi/asm/unistd.h |    1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
> index 8408387..d0b27f8 100644
> --- a/arch/powerpc/include/asm/systbl.h
> +++ b/arch/powerpc/include/asm/systbl.h
> @@ -356,3 +356,4 @@ COMPAT_SYS_SPU(sendmmsg)
>  SYSCALL_SPU(setns)
>  COMPAT_SYS(process_vm_readv)
>  COMPAT_SYS(process_vm_writev)
> +SYSCALL(finit_module)
> diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
> index 921dce6..8d219a0 100644
> --- a/arch/powerpc/include/asm/unistd.h
> +++ b/arch/powerpc/include/asm/unistd.h
> @@ -12,7 +12,7 @@
>  #include <uapi/asm/unistd.h>
>  
> 
> -#define __NR_syscalls		353
> +#define __NR_syscalls		354
>  
>  #define __NR__exit __NR_exit
>  #define NR_syscalls	__NR_syscalls
> diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
> index 380b5d3..8c478c6 100644
> --- a/arch/powerpc/include/uapi/asm/unistd.h
> +++ b/arch/powerpc/include/uapi/asm/unistd.h
> @@ -375,6 +375,7 @@
>  #define __NR_setns		350
>  #define __NR_process_vm_readv	351
>  #define __NR_process_vm_writev	352
> +#define __NR_finit_module	353
>  
> 
>  #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
