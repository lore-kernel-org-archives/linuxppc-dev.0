Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnL8Y6Z7jzDqY3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Sep 2017 20:55:25 +1000 (AEST)
In-Reply-To: <1504303424-28452-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: paulus@samba.org
Subject: Re: powerpc/sstep: Avoid used uninitialized error
Message-Id: <3xnL8X56dYz9sNc@ozlabs.org>
Date: Wed,  6 Sep 2017 20:55:24 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-09-01 at 22:03:44 UTC, Michael Ellerman wrote:
> Older compilers think val may be used uninitialized:
> 
>   arch/powerpc/lib/sstep.c: In function 'emulate_loadstore':
>   arch/powerpc/lib/sstep.c:2758:23: error: 'val' may be used uninitialized in this function
> 
> We know better, but initialise val to 0 to avoid breaking the build.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/3b79b26101936bbdb7a5c69161c69d

cheers
