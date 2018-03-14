Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RGL4gsSzDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:27:54 +1100 (AEDT)
In-Reply-To: <20180225172236.29650-5-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [04/21] powerpc: Mark both tmp variables as unused
Message-Id: <401RGG5XsHz9sVh@ozlabs.org>
Date: Wed, 14 Mar 2018 20:27:50 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2018-02-25 at 17:22:19 UTC, Mathieu Malaterre wrote:
> Since the value of `tmp` is never intended to be read, declare both `tmp`
> variables as unused. Fix warning (treated as error in W=1):
> 
>   CC      arch/powerpc/kernel/signal_32.o
> arch/powerpc/kernel/signal_32.c: In function ‘sys_swapcontext’:
> arch/powerpc/kernel/signal_32.c:1048:16: error: variable ‘tmp’ set but not used [-Werror=unused-but-set-variable]
>   unsigned char tmp;
>                 ^~~
> arch/powerpc/kernel/signal_32.c: In function ‘sys_debug_setcontext’:
> arch/powerpc/kernel/signal_32.c:1234:16: error: variable ‘tmp’ set but not used [-Werror=unused-but-set-variable]
>   unsigned char tmp;
>                 ^~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/67b464a89c21c9edd45ad15c457bb5

cheers
