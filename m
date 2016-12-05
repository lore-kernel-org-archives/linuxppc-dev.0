Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXH0904R5zDvhQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2016 18:47:05 +1100 (AEDT)
In-Reply-To: <20161128014226.7656-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 Nicholas Piggin <npiggin@gmail.com>, Alan Modra <amodra@gmail.com>
Subject: Re: powerpc/boot: request no dynamic linker for boot wrapper
Message-Id: <3tXH085YGKz9tlW@ozlabs.org>
Date: Mon,  5 Dec 2016 18:47:04 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-11-28 at 01:42:26 UTC, Nicholas Piggin wrote:
> The boot wrapper performs its own relocations and does not require
> PT_INTERP segment.
> 
> Without this option, binutils 2.28 and newer tries to create a program
> header segment due to PT_INTERP, and the link fails because there is no
> space for it.
> 
>    A recent binutils commit:
>    https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=1a9ccd70f9a75dc6b48d340059f28ef3550c107b
>    has broken kernel builds:
> 
>      ld: arch/powerpc/boot/zImage.pseries: Not enough room for program headers, try linking with -N
>      ld: final link failed: Bad value
> 
> Reported-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ff45000fcb56b5b0f1a14a865d3541

cheers
