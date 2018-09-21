Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GsbG3hWgzF3QF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 21:59:38 +1000 (AEST)
In-Reply-To: <20180911053805.5345-1-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [kernel] powerpc/powernv/ioda2: Reduce upper limit for DMA window
 size (retry)
Message-Id: <42GsbG2KQHz9sCV@ozlabs.org>
Date: Fri, 21 Sep 2018 21:59:38 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-09-11 at 05:38:05 UTC, Alexey Kardashevskiy wrote:
> We use PHB in mode1 which uses bit 59 to select a correct DMA window.
> However there is mode2 which uses bits 59:55 and allows up to 32 DMA
> windows per a PE.
> 
> Even though documentation does not clearly specify that, it seems that
> the actual hardware does not support bits 59:55 even in mode1, in other
> words we can create a window as big as 1<<58 but DMA simply won't work.
> 
> This reduces the upper limit from 59 to 55 bits to let the userspace know
> about the hardware limits.
> 
> Fixes: ce57c6610cc2 "Merge branch 'topic/ppc-kvm' into next"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/7233b8cab39014620ac9534da11f0f

cheers
