Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ywyXV6kbGzDqmM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Dec 2017 22:39:22 +1100 (AEDT)
In-Reply-To: <1504232234-4161-1-git-send-email-wei.guo.simon@gmail.com>
To: wei.guo.simon@gmail.com, Anshuman Khandual <khandual@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: Re: selftests/powerpc: fix build error in powerpc ptrace selftests.
Message-Id: <3ywyXV3x38z9t7B@ozlabs.org>
Date: Tue, 12 Dec 2017 22:39:21 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-09-01 at 02:17:14 UTC, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> GCC 7 will take "r2" in clobber list as an error will it will get following
> build errors for powerpc ptrace selftests even with -fno-pic option:
>   ptrace-tm-vsx.c: In function ‘tm_vsx’:
>   ptrace-tm-vsx.c:42:2: error: PIC register clobbered by ‘r2’ in ‘asm’
>     asm __volatile__(
>     ^~~
>   make[1]: *** [ptrace-tm-vsx] Error 1
>   ptrace-tm-spd-vsx.c: In function ‘tm_spd_vsx’:
>   ptrace-tm-spd-vsx.c:55:2: error: PIC register clobbered by ‘r2’ in ‘asm’
>     asm __volatile__(
>     ^~~
>   make[1]: *** [ptrace-tm-spd-vsx] Error 1
>   ptrace-tm-spr.c: In function ‘tm_spr’:
>   ptrace-tm-spr.c:46:2: error: PIC register clobbered by ‘r2’ in ‘asm’
>     asm __volatile__(
>     ^~~
> 
> This patch fix the build error by removing "r2" out of clobber list.
> 
> Reported-by: Seth Forshee <seth.forshee@canonical.com>
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> Tested-by: Seth Forshee <seth.forshee@canonical.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f36dbfe1a504b85c7b3bf89fdd9999

cheers
