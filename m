Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yblFz4FnNzDqpl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 22:12:07 +1100 (AEDT)
In-Reply-To: <20171019071355.15324-1-oohall@gmail.com>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [1/2] powerpc/lib: Implement PMEM API
Message-Id: <3yblFz2kZ5z9t2W@ozlabs.org>
Date: Tue, 14 Nov 2017 22:12:07 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-10-19 at 07:13:54 UTC, Oliver O'Halloran wrote:
> Implement the architecture specific cache maintence functions that make
> up the "PMEM API". Currently the writeback and invalidate functions
> are the same since the function of the DCBST (data cache block store)
> instruction is typically interpreted as "writeback to the point of
> coherency" rather than to memory. As a result implementing the API
> requires a full cache flush rather than just a cache write back. This
> will probably change in the not-too-distant future.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/32ce3862af3c42a3890e99846a8d1a

cheers
